# References

Every number the library takes from outside is recorded here with its source, so it can be checked
against that source rather than against memory. A value in the code that is not in this file is a
choice, not a citation.

## DIN 168-1 thread table (GL round thread)

The standard itself (DIN 168-1, _Rundgewinde für Glasbehälter_) has not been read for this. The
rows below come from two secondary tables that agree with each other. Both list a minimum and a
maximum for each diameter; the outer diameter's maximum is the GL number.

Accessed 2026-09-24:

- gewinde-normen.de, _Knuckle Thread DIN 168_:
  <https://www.gewinde-normen.de/en/knuckle-thread-din-168.html>
- gewindebohrer.de, _Round Thread DIN 168_:
  <https://www.gewindebohrer.de/en/service/thread-standards/round-thread-din-168>

All values are in mm. Bolt is the external thread on the glass; nut is the internal thread in the
cap.

| Size         | P    | Bolt outer (min / max) | Bolt core (min / max) | Nut outer (min / max) | Nut core (min / max) |
| ------------ | ---- | ---------------------- | --------------------- | --------------------- | -------------------- |
| GL 25        | 3.00 | 24.50 / 25.00          | 22.48 / 22.98         | 25.10 / 25.40         | 23.08 / 23.38        |
| GL 25 (P3.5) | 3.50 | 24.50 / 25.00          | 22.14 / 22.64         | 25.10 / 25.40         | 22.74 / 23.04        |
| GL 28        | 3.00 | 27.50 / 28.00          | 25.48 / 25.98         | 28.10 / 28.40         | 26.08 / 26.38        |
| GL 32        | 4.00 | 31.30 / 32.00          | 28.60 / 29.30         | 32.15 / 32.55         | 29.45 / 29.85        |
| GL 45        | 4.00 | 44.30 / 45.00          | 41.60 / 42.30         | 45.15 / 45.55         | 42.45 / 42.85        |

GL 45 and GL 28 were read from both sources and match. GL 25 and GL 32 were read from the first
source only. Both were read through a page-to-text summary, not a copy of the page, so each row
should be re-read against its page before it is relied on. The other GL sizes those pages list
have not been transcribed.

## Profile

- **Flank angle.** gewindebohrer.de (above): "the flank angles for internal and external threads
  differ significantly. The glass container has a flank angle of 60°, while the screw-on cap has
  only 30°." Neither page gives crest or root radii, or thread depth as a function of P.
- **Thread depth.** Not given by either source. The depth the library models is taken from the table
  instead: half the difference between the outer and core diameters of the same part.
- **modelscad.com.** `gl_threads.scad` gives
  <https://modelscad.com/thread/thread-page26-eng> as its basis. The host did not resolve on
  2026-09-24 (`getaddrinfo ENOTFOUND`), so none of its content is recorded here. The tip radius
  (0.74), root radius (0.5), height factor (0.675) and 37.5° flank in the example presumably came
  from it and are unverified.
