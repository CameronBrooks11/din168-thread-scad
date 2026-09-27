# Changelog

All notable changes to this project are recorded here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- Every size in DIN 168-1:1998-04: GL8 to GL125, 24 in all, including GL25 × 3.5.
- `din168_by_name(name, pitch)`: the optional `pitch` picks GL25 × 3.5.
- `din168_r1`, `din168_r2`, `din168_k`, `din168_profile_width`, `din168_profile_depth` and
  `din168_flank_diameter`, from the standard.
- `examples/gl80_cap.scad` and `examples/all_sizes.scad`.

### Changed

- The thread is cut to the standard's profile (Bild 1): crests rounded to R1, roots to R2, the
  glass tooth `P·k` wide at its core. It was a trapezoid with tooth widths the library chose. Caps
  and gauges change shape, and their clearance against the glass is now measured normal to every
  face.
- The size table is now DIN 168-1 itself, not the web tables it was built from. Three of their cells
  were wrong: GL56 bolt core min, GL100 bolt outer min and GL112 bolt core min.
- `din168_nut_profile` and `din168_bolt_profile` return `[tip r, root r, tooth]`; the last two
  elements were a trapezoid's half-widths. `din168_helix` takes the new form.
- `din168_by_name` asserts on a name it does not know, instead of returning `undef`.
- The cap's mouth is bevelled 0.5 mm outside the thread's root (`din168_mouth_bevel`) before its
  45° lead-in to the crest.

### Fixed

- The cap's groove root was cut by a cylinder at the default `$fa`, whose flats filled the groove by
  up to r·(1 − cos 6°): 0.13 mm on GL45, 0.22 mm on GL80.
- `din168_bolt` trimmed its ends with a cylinder at the crest radius, whose flats cut the crests by
  the same amount.
