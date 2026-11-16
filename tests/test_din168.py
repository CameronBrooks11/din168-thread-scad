"""Check din168.scad against its sources, and render its examples and caps.

usage: python3 tests/test_din168.py [OPENSCAD]

- Every row of din168_sizes matches Tabelle 1 as docs/references.md records
  it, cell by cell, and GLS 80 is GL80's row with three starts.
- Every example evaluates and renders with --hardwarnings.
- Caps come out one solid, as tall as their parts add up to (top + liner
  space + thread, plus any ring band) and as wide as din168_cap_radius says.
- din168_by_name and din168_cap refuse bad input with their messages.
"""

import json
import os
import re
import struct
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LIB = os.path.join(ROOT, "din168.scad")
REFERENCES = os.path.join(ROOT, "docs", "references.md")


def openscad_run(openscad, source, out, tmp):
    path = os.path.join(tmp, "probe.scad")
    with open(path, "w") as f:
        f.write(source)
    cmd = [openscad, "--hardwarnings", "-o", out]
    if out.endswith(".stl"):
        cmd += ["--export-format", "binstl"]
    return subprocess.run(cmd + [path], capture_output=True, text=True)


def echoes(result):
    """The values of ECHO lines, parsed as JSON."""
    return [json.loads(l.split("ECHO: ", 1)[1]) for l in result.stderr.splitlines()
            if l.startswith("ECHO: ")]


def measure(path):
    data = open(path, "rb").read()
    (n,) = struct.unpack_from("<I", data, 80)
    parent = {}

    def find(v):
        while parent[v] != v:
            parent[v] = parent[parent[v]]
            v = parent[v]
        return v

    for i in range(n):
        v = struct.unpack_from("<9f", data, 84 + i * 50 + 12)
        corners = [v[0:3], v[3:6], v[6:9]]
        for c in corners:
            parent.setdefault(c, c)
        root = find(corners[0])
        for c in corners[1:]:
            parent[find(c)] = root
    solids = len({find(v) for v in parent})
    size = [max(p[i] for p in parent) - min(p[i] for p in parent) for i in range(3)]
    return solids, size


def table_from_references():
    """Tabelle 1 as docs/references.md records it, in the library's row form."""
    rows = []
    text = open(REFERENCES, encoding="utf-8").read()
    section = text.split("### Tabelle 1", 1)[1].split("\n#", 1)[0]
    for line in section.splitlines():
        m = re.match(r"\|\s*GL (\d+)\s*\|(.*)\|\s*$", line)
        if not m:
            continue
        cells = [c.strip().replace("–", "-") for c in m.group(2).split("|")]
        p, d, d1, D, D1, bolt_a, nut_a, r1, r2, k = (float(c) for c in cells)
        rows.append([f"GL{m.group(1)}", p, d, d1, D, D1, -bolt_a, nut_a, r1, r2, k])
    return rows


results = []


def check(label, ok, got):
    results.append(ok)
    print(f"{'ok  ' if ok else 'FAIL'} {label}: {got}")


def main():
    openscad = sys.argv[1] if len(sys.argv) > 1 else "openscad"
    with tempfile.TemporaryDirectory() as tmp:
        csg = os.path.join(tmp, "out.csg")
        stl = os.path.join(tmp, "out.stl")
        inc = f"include <{LIB}>\n"

        # The size table against its source.
        r = openscad_run(openscad, inc + "echo(din168_sizes);\necho(din168_gls80);\n", csg, tmp)
        sizes, gls80 = echoes(r)
        source = table_from_references()
        check("references.md lists Tabelle 1", len(source) == 24, f"{len(source)} rows")
        check("din168_sizes has a row for each", len(sizes) == len(source),
              f"{len(sizes)} rows against {len(source)}")
        for ours, theirs in zip(sizes, source):
            same = ours[0] == theirs[0] and all(abs(a - b) < 1e-9 for a, b in zip(ours[1:], theirs[1:]))
            label = f"{theirs[0]} x {theirs[1]:g}"
            check(f"{label} matches Tabelle 1", same,
                  "same" if same else f"{ours} against {theirs}")
        gl80 = next(s for s in sizes if s[0] == "GL80")
        check("GLS80 is GL80's row with three starts", gls80[1:11] == gl80[1:] and gls80[11] == 3,
              f"{gls80}")

        # Lookups.
        r = openscad_run(openscad, inc + 'echo(din168_pitch(din168_by_name("GL25")));\n'
                         'echo(din168_pitch(din168_by_name("GL25", pitch=3.5)));\n'
                         'echo(din168_lead(din168_by_name("GLS80")));\n', csg, tmp)
        got = echoes(r)
        check("GL25 is P = 3 unless asked for 3.5, GLS80 advances 15 a turn", got == [3, 3.5, 15],
              f"{got}")

        # Examples.
        for name in sorted(os.listdir(os.path.join(ROOT, "examples"))):
            if not name.endswith(".scad"):
                continue
            path = os.path.join(ROOT, "examples", name)
            r = subprocess.run([openscad, "--hardwarnings", "--export-format", "binstl", "-o", stl,
                                path], capture_output=True, text=True)
            bad = [l for l in r.stderr.splitlines() if "WARNING" in l or "ERROR" in l]
            check(f"examples/{name} renders", r.returncode == 0 and not bad,
                  bad[:1] or "clean")

        # Caps: one solid, height from its parts, width from din168_cap_radius.
        for name, args, height in [
            ("GL45", "", 3 + 2 + 5 * 4),  # 25 mm, DURAN's PP GL45 cap
            ("GL45", ", ring_band=5", 3 + 2 + 5 * 4 + 5),
            ("GL8", ", ribs=12", 3 + 2 + 5 * 2),
            ("GLS80", ", ring_band=8, ribs=48", 3 + 2 + 5 * 5 + 8),
            ("GL125", ", thread_length=12", 3 + 2 + 12),
        ]:
            r = openscad_run(openscad, inc + f's = din168_by_name("{name}");\n'
                             f'echo(din168_cap_radius(s));\ndin168_cap(s{args});\n', stl, tmp)
            if r.returncode != 0:
                check(f"{name} cap{args}", False, f"openscad exited {r.returncode}")
                continue
            (radius,) = echoes(r)
            ribbed = "ribs" in args
            solids, size = measure(stl)
            # Ribs are half-rounds of radius wall/2 = 1 standing proud of the wall.
            across = 2 * (radius + (1 if ribbed else 0))
            ring = "ring_band" in args
            ok = solids == 1 and abs(size[2] - height) <= 0.02 and (
                ring or abs(size[0] - across) <= 0.05)
            check(f"{name} cap{args}", ok,
                  f"{solids} solid(s), {size[0]:.2f} across, {size[2]:.2f} tall; "
                  f"expected 1, {across:.2f}{' or more' if ring else ''}, {height}")

        # Refusals.
        for label, source_text, message in [
            ("refuses an unknown size", 'echo(din168_by_name("GL46"));', "no size GL46"),
            ("refuses GL45 x 3.5", 'echo(din168_by_name("GL45", pitch=3.5));', "no size GL45 x 3.5"),
            ("refuses a negative ring band", 'din168_cap(din168_gl45, ring_band=-1);',
             "ring_band must be >= 0"),
        ]:
            r = openscad_run(openscad, inc + source_text + "\n", stl, tmp)
            errors = [l for l in r.stderr.splitlines() if "ERROR" in l]
            check(label, bool(r.returncode != 0 and errors and message in errors[0]),
                  errors[0] if errors else f"exit {r.returncode}, no error")

    print(f"{sum(results)} of {len(results)} checks passed")
    sys.exit(0 if all(results) else 1)


main()
