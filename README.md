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
- **Profile:** flanks at 60° on the glass and 30° in the cap, as the sources give. No source gives
  tooth widths or crest and root radii, so the profile is a trapezoid and the widths are a stated
  choice (see `din168.scad`).
- **Fit:** the cap is cut to clear the largest in-tolerance glass by `clearance` (default 0.2 mm)
  on each flank and radially.
- **Rendering:** the thread is one polyhedron swept along a true helix. The GL45 example renders in
  about 18 s on OpenSCAD 2021.01 and well under a second on the manifold backend.

Planned: examples for the other sizes beside the GL45 one.
