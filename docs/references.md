# References

Every number the library takes from outside is recorded here with its source. A value in the code
that is not in this file is a choice, not a citation.

## DIN 168-1:1998-04 (primary)

DIN 168-1:1998-04, _Rundgewinde – Teil 1: für Glasbehältnisse; Gewindemaße_ (Knuckle thread – Part
1: Especially for glass containers; Thread sizes). It replaces the 1979-12 edition and adds GL 50 to
GL 125. It is two pages: Bild 1 (the profile) and Tabelle 1 (the sizes). Read 2026-09-26.

### Tabelle 1

All values in mm. Bolt is the external thread on the glass; nut is the internal thread in the cap.
The standard gives each diameter as a nominal value with an allowance: the bolt's d and d1 run from
nominal down by the allowance (`0 / –a`), the nut's D and D1 from nominal up (`+a / 0`). Every
thread is single-start (n = 1).

| Size       | P   | d   | d1     | D     | D1    | Bolt allowance | Nut allowance | R1 ≈ | R2 max | k     |
| ---------- | --- | --- | ------ | ----- | ----- | -------------- | ------------- | ---- | ------ | ----- |
| GL 8       | 2   | 8   | 6.6    | 8.1   | 6.7   | –0.35          | +0.2          | 0.51 | 0.3    | 0.7   |
| GL 10      | 2   | 10  | 8.6    | 10.1  | 8.7   | –0.35          | +0.2          | 0.51 | 0.3    | 0.7   |
| GL 12      | 2   | 12  | 10.6   | 12.1  | 10.7  | –0.35          | +0.2          | 0.51 | 0.3    | 0.7   |
| GL 14      | 2.5 | 14  | 12.32  | 14.1  | 12.42 | –0.4           | +0.25         | 0.62 | 0.4    | 0.675 |
| GL 16      | 2.5 | 16  | 14.32  | 16.1  | 14.42 | –0.4           | +0.25         | 0.62 | 0.4    | 0.675 |
| GL 18      | 3   | 18  | 15.98  | 18.1  | 16.08 | –0.5           | +0.3          | 0.74 | 0.5    | 0.675 |
| GL 20      | 3   | 20  | 17.98  | 20.1  | 18.08 | –0.5           | +0.3          | 0.74 | 0.5    | 0.675 |
| GL 22      | 3   | 22  | 19.98  | 22.1  | 20.08 | –0.5           | +0.3          | 0.74 | 0.5    | 0.675 |
| GL 25      | 3   | 25  | 22.98  | 25.1  | 23.08 | –0.5           | +0.3          | 0.74 | 0.5    | 0.675 |
| GL 25      | 3.5 | 25  | 22.64  | 25.1  | 22.74 | –0.5           | +0.3          | 0.86 | 0.5    | 0.675 |
| GL 28      | 3   | 28  | 25.98  | 28.1  | 26.08 | –0.5           | +0.3          | 0.74 | 0.5    | 0.675 |
| GL 32      | 4   | 32  | 29.30  | 32.15 | 29.45 | –0.7           | +0.4          | 0.99 | 0.6    | 0.675 |
| GL 36      | 4   | 36  | 33.30  | 36.15 | 33.45 | –0.7           | +0.4          | 0.99 | 0.6    | 0.675 |
| GL 40      | 4   | 40  | 37.30  | 40.15 | 37.45 | –0.7           | +0.4          | 0.99 | 0.6    | 0.675 |
| GL 45      | 4   | 45  | 42.30  | 45.15 | 42.45 | –0.7           | +0.4          | 0.99 | 0.6    | 0.675 |
| GL 50      | 4   | 50  | 47.30  | 50.3  | 47.6  | –0.8           | +0.5          | 0.99 | 0.6    | 0.675 |
| GL 56      | 4   | 56  | 53.30  | 56.3  | 53.6  | –0.8           | +0.5          | 0.99 | 0.6    | 0.675 |
| GL 63      | 5   | 63  | 60     | 63.4  | 60.4  | –1.0           | +0.6          | 1.1  | 0.8    | 0.6   |
| GL 70      | 5   | 70  | 67     | 70.4  | 67.4  | –1.0           | +0.6          | 1.1  | 0.8    | 0.6   |
| GL 80      | 5   | 80  | 77     | 80.4  | 77.4  | –1.0           | +0.6          | 1.1  | 0.8    | 0.6   |
| GL 90      | 5   | 90  | 87     | 90.4  | 87.4  | –1.0           | +0.6          | 1.1  | 0.8    | 0.6   |
| GL 100     | 5   | 100 | 97     | 100.4 | 97.4  | –1.2           | +0.6          | 1.1  | 0.8    | 0.6   |
| GL 112     | 5   | 112 | 109    | 112.4 | 109.4 | –1.2           | +0.6          | 1.1  | 0.8    | 0.6   |
| GL 125     | 5   | 125 | 122    | 125.4 | 122.4 | –1.2           | +0.6          | 1.1  | 0.8    | 0.6   |

The standard designates a thread as `Gewinde DIN 168 – GL 25 × 3`: size and pitch. The library's
`din168_by_name("GL25", pitch=3.5)` follows it.

### Bild 1 (profile)

- **Glass (Außengewinde):** 60° included flank angle. The tooth is `b = P·k` wide where its flanks
  meet the core line d1, `c = b/2` high, and its crest is rounded to `R1 = 0.366·b`, tangent to both
  flanks. (A 60° tooth of base b is 0.866·b high to its sharp apex; a tangent crest radius of 0.366·b
  takes 0.366·b off it, leaving b/2.)
- **Cap (Innengewinde):** 30° included flank angle, crest also R1, same depth: `D – D1 = d – d1`.
- **R2** is the root radius on both parts, given as a maximum.
- **Flank diameter:** `d2 = d – P·[√3/2 + k·(1 – √3)]`, the diameter at which the glass tooth is
  P/2 wide.
- "Nicht angegebene Einzelheiten sind zweckentsprechend zu wählen": details not given are to be
  chosen to suit.

## Secondary tables

Two web tables reproduce Tabelle 1. They were the library's source before the standard was read,
and they agree with each other cell for cell, typos included. Both
accessed 2026-09-24 and re-read from their HTML 2026-09-26:

- gewinde-normen.de, _Knuckle Thread DIN 168_:
  <https://www.gewinde-normen.de/en/knuckle-thread-din-168.html>
- gewindebohrer.de, _Round Thread DIN 168_:
  <https://www.gewindebohrer.de/en/service/thread-standards/round-thread-din-168>

They list minimum and maximum diameters rather than nominal and allowance. Against the standard,
three of their cells are wrong; everything else matches:

| Size   | Cell            | Web table | DIN 168-1 |
| ------ | --------------- | --------- | --------- |
| GL 56  | bolt core min   | 52.60     | 52.50     |
| GL 100 | bolt outer min  | 89.80     | 98.80     |
| GL 112 | bolt core min   | 108.80    | 107.80    |

The web tables give no profile: no R1, R2 or k.

## DURAN caps and pouring rings (DWK Life Sciences)

DWK's order sheets, read 2026-10-03:

- _DURAN® Bottle Caps & Connections & Accessories_:
  <https://www.duran-bottle-system.com/files/Downloads/order_info_caps_closure/DURAN_BottleCaps-Connections-Accessories_EN.pdf>
- _DURAN® GLS 80® Bottle Caps & Connections & Accessories_:
  <https://www.duran-bottle-system.com/files/Downloads/order_info_caps_closure/DURAN_GLS80_BottleCaps-Connections-Accessories_EN.pdf>

Screw cap heights h, mm, with outside diameter d in brackets:

| Cap                                  | GL14   | GL18   | GL25   | GL32   | GL45   | GLS 80   |
| ------------------------------------ | ------ | ------ | ------ | ------ | ------ | -------- |
| Original GL screw cap, PP, lip seal  |        |        | 19 (33)| 24 (40)| 25 (54)|          |
| Red high-temperature screw cap, PBT  | 17 (20)| 20 (23)| 23 (33)| 26 (41)| 28 (54)|          |
| GLS 80 quick-release screw cap, PP   |        |        |        |        |        | 40 (87)  |
| GLS 80 high-temperature cap, PSU     |        |        |        |        |        | 40 (88.5)|

Pouring rings are 4 mm tall for GL32 and GL45, and 6.85 mm for GLS 80. The sheets give no ring
diameters. The GLS 80 sheet says the cap opens and closes "with only a three-quarter turn".

The cap's default thread length rests on the GL rows: less a 3 mm top, these caps are 5.25 to 6.67
pitches deep inside. Five pitches makes the GL45 cap 25 mm, the PP cap's height.

## GLS 80

No standard defines GLS 80, and no source found gives its profile. What is published:

- b.safe, _Flaschengewinde einfach bestimmen_ (bottle thread identification), read 2026-10-03:
  <https://www.bsafe.de/Technische-Informationen/Gewindearten-Bestimmung/Flaschengewinde/>. Its
  text gives "GL-Gewinde eingängig, GLS 80-Gewinde dreigängig" (GL single-start, GLS 80
  three-start), and its table gives GLS 80 an outside diameter of 80.0 mm and a Steigung (lead) of
  15.0 mm. Three starts at a 15 mm lead put the crests 5 mm apart, GL80's pitch.
- DWK, above: a three-quarter turn to open, and the caps' sizes.

For the rest, a third-party cap was measured: _Cap for Schott bottle with GLS 80 thread_ by
CAD-Guy, <https://www.printables.com/model/246479-cap-for-schott-bottle-with-gls-80-thread>,
CC BY-NC-SA 4.0. Its author's model, not a DWK drawing; measured 2026-10-04 by sectioning and
ray-casting `Verschluss-Schottflasche.stl` (366 040 triangles). Nothing from it is copied into
the library. Measured, mm:

| Quantity                                   | Reference cap      | Library's GLS 80 cap        |
| ------------------------------------------ | ------------------ | --------------------------- |
| starts, lead                               | 3, 15 (crests move 1.25 mm per 30°, pattern repeats every 120°) | 3, 15  |
| crest spacing                              | 5.0                | 5 (GL80's P)                |
| bore at the crests                         | 77.8               | 78.4 (GL80's D1 max + 2 × 0.2) |
| bore at the root                           | 80.8               | 81.4 (GL80's D max + 2 × 0.2)  |
| tooth                                      | arc, radius 1.25, 1.5 deep | GL80's cap tooth (Bild 1), 1.5 deep |
| threaded length                            | about 22, then 2 of run-out | 25 (five pitches)  |
| plain band between thread and top          | 2, bored 77.0      | 2 (liner space)             |
| band at the mouth                          | 8 deep, bored 84.8 | optional, `ring_band`, bored 2 outside the root |
| height over all                            | 40                 | 30 without a ring band      |

The reference's bore diameters fall inside DIN 168's GL80 cap limits (D1 77.4 to 78.0, D 80.4 to
81.0), so the library takes GL80's diameters and tooth for GLS 80 rather than the reference's
round tooth, which is the author's approximation. Its mouth band, 2 mm outside the root, is the
library's `din168_ring_band_gap`.

## Test prints

Caps printed from 7ea65c3 (the cap alone from `examples/gl45_cap.scad` and
`examples/gls80_cap.scad`, top on the bed) and tried on DURAN bottles, 2026-10-05:

| Cap                                         | Bottle       | Result                                              |
| ------------------------------------------- | ------------ | --------------------------------------------------- |
| GL45, 25 mm, 20 mm of thread                | DURAN GL45   | Threads on cleanly and seats fully, more cleanly than the 12 mm thread it replaced. |
| GLS 80, 30 mm, 25 mm of three-start thread  | DURAN GLS 80 | Fits. Without a gasket it is not watertight: it needs a seal in the liner space. |
| GL80 (DIN 168, single start), before GLS 80 | DURAN GLS 80 | Caught for a fraction of a turn and came off.       |

## modelscad.com

An earlier GL thread model, `gl_threads.scad`, gives <https://modelscad.com/thread/thread-page26-eng>
as its basis. The host did not resolve on 2026-09-24 (`getaddrinfo ENOTFOUND`). Its tip radius
(0.74), root radius (0.5) and height factor (0.675) are the standard's R1, R2 and k for P = 3.
