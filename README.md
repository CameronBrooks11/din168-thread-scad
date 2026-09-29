# din168-thread-scad

DIN 168 round threads (the GL threads on laboratory glassware) in OpenSCAD: a size table, the
internal and external thread, and a screw cap.

```openscad
use <din168-thread-scad/din168.scad>

gl = din168_by_name("GL45");
din168_cap(gl, ribs=36);              // a cap, mouth at z = 0
din168_cap(gl, skirt=true);           // with a skirt below the thread; or skirt=<mm>
din168_nut(gl, length=12);            // the cap's thread alone, as a tube
din168_bolt(gl, length=12, bore=30);  // the glass side, for a gauge
```

- **Sizes:** every size in DIN 168-1:1998-04, GL8 to GL125, including GL25 in both its pitches
  (`din168_by_name("GL25", pitch=3.5)` for the second). Every figure in the table is recorded with
  its source in [docs/references.md](docs/references.md).
- **Profile:** Bild 1 of the standard: flanks at 60° on the glass and 30° in the cap, crests rounded
  to R1 and roots to R2, the glass tooth `b = P·k` wide at its core. The standard gives no width for
  the cap tooth; it follows from the cap's crest radius and flank angle (see `din168.scad`).
- **Fit:** the cap is cut to the largest cap the standard allows and the printed glass side
  (`din168_bolt`) to the smallest glass, then each is shrunk by `clearance` (default 0.2 mm) on
  every face. Centred on the largest glass the standard allows, the default cap leaves 0.28 mm
  (P = 2) to 0.70 mm (P = 5) at the closest point.
- **Cap height:** no standard sets it. DIN 168-1 gives only the thread, and ISO 4796-1 leaves the
  bottle's neck to the maker. The default cap is 17 mm: 12 mm of thread, 2 mm over the rim for a
  liner, a 3 mm top. Shop-bought caps are taller and carry a skirt, plain wall below the thread
  that covers the neck. `skirt=true` adds one pitch of it (4 mm on GL45), a choice;
  `skirt=<mm>` sets your own. `din168_cap_height` gives the total.
- **Rendering:** the thread is one polyhedron swept along a true helix. A full render of the GL45
  example takes over a minute on OpenSCAD 2021.01; preview is quick.

## Sizes

`din168_by_name("GL45")` returns a size; `din168_sizes` lists them all, in the standard's order.
Diameters are nominal, in mm; the full table with allowances and radii is in
[docs/references.md](docs/references.md).

| Size  | P   | d (glass) | D (cap) |     | Size   | P   | d (glass) | D (cap) |
| ----- | --- | --------- | ------- | --- | ------ | --- | --------- | ------- |
| GL8   | 2   | 8         | 8.1     |     | GL32   | 4   | 32        | 32.15   |
| GL10  | 2   | 10        | 10.1    |     | GL36   | 4   | 36        | 36.15   |
| GL12  | 2   | 12        | 12.1    |     | GL40   | 4   | 40        | 40.15   |
| GL14  | 2.5 | 14        | 14.1    |     | GL45   | 4   | 45        | 45.15   |
| GL16  | 2.5 | 16        | 16.1    |     | GL50   | 4   | 50        | 50.3    |
| GL18  | 3   | 18        | 18.1    |     | GL56   | 4   | 56        | 56.3    |
| GL20  | 3   | 20        | 20.1    |     | GL63   | 5   | 63        | 63.4    |
| GL22  | 3   | 22        | 22.1    |     | GL70   | 5   | 70        | 70.4    |
| GL25  | 3   | 25        | 25.1    |     | GL80   | 5   | 80        | 80.4    |
| GL25  | 3.5 | 25        | 25.1    |     | GL90   | 5   | 90        | 90.4    |
| GL28  | 3   | 28        | 28.1    |     | GL100  | 5   | 100       | 100.4   |
|       |     |           |         |     | GL112  | 5   | 112       | 112.4   |
|       |     |           |         |     | GL125  | 5   | 125       | 125.4   |

## Examples

- [examples/gl45_cap.scad](examples/gl45_cap.scad): a GL45 cap and a short gauge to try it on.
- [examples/gl80_cap.scad](examples/gl80_cap.scad): the same for GL80, ribbed.
- [examples/all_sizes.scad](examples/all_sizes.scad): a cap in every size, labelled.
