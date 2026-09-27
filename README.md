# din168-thread-scad

DIN 168 round threads (the GL threads on laboratory glassware) in OpenSCAD: a size table, the
internal and external thread, and a screw cap.

```openscad
use <din168-thread-scad/din168.scad>

gl = din168_by_name("GL45");
din168_cap(gl, ribs=36);              // a cap, mouth at z = 0
din168_nut(gl, length=12);            // the cap's thread alone, as a tube
din168_bolt(gl, length=12, bore=30);  // the glass side, for a gauge
```

- **Sizes:** every size in DIN 168-1:1998-04, GL8 to GL125, including GL25 in both its pitches
  (`din168_by_name("GL25", pitch=3.5)` for the second). Every figure in the table is recorded with
  its source in [docs/references.md](docs/references.md).
- **Profile:** Bild 1 of the standard: flanks at 60° on the glass and 30° in the cap, crests rounded
  to R1 and roots to R2, the glass tooth `b = P·k` wide at its core. The standard gives no width for
  the cap tooth; it follows from the cap's crest radius and flank angle (see `din168.scad`).
- **Fit:** the cap is cut at the loose end of its tolerance and the printed glass side (`din168_bolt`)
  at the tight end, then each is shrunk by `clearance` (default 0.2 mm) on every face. Against the
  largest glass the standard allows, the default cap leaves 0.28 mm (P = 2) to 0.70 mm (P = 5) at
  the closest point.
- **Rendering:** the thread is one polyhedron swept along a true helix. The GL45 example (a cap and a
  gauge) took 89 s to render on OpenSCAD 2021.01 (CGAL); preview is quick.

Planned: examples for the other sizes beside the GL45 one.
