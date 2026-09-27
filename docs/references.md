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

## modelscad.com

An earlier GL thread model, `gl_threads.scad`, gives <https://modelscad.com/thread/thread-page26-eng>
as its basis. The host did not resolve on 2026-09-24 (`getaddrinfo ENOTFOUND`). Its tip radius
(0.74), root radius (0.5) and height factor (0.675) are the standard's R1, R2 and k for P = 3.
