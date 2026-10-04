# Changelog

All notable changes to this project are recorded here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- Every size in DIN 168-1:1998-04: GL8 to GL125, 24 in all, including GL25 × 3.5.
- `din168_by_name(name, pitch)`: the optional `pitch` picks GL25 × 3.5.
- `din168_r1` and `din168_r2`: the standard's crest and root radii.
- `examples/gl80_cap.scad` and `examples/all_sizes.scad`.
- GLS 80, DURAN's wide-mouth thread, as `din168_by_name("GLS80")`: GL80's profile and diameters
  with three starts. It is not a DIN 168 thread. A size row may carry a twelfth field, its number
  of starts; `din168_starts` and `din168_lead` read it, and `din168_helix` takes `starts`.
- `din168_cap(ring_band)`: a band at the mouth, bored 2 mm outside the thread's root, to clear a
  pouring ring.
- `examples/gls80_cap.scad`.

### Changed

- The thread is cut to the standard's profile (Bild 1): crests rounded to R1, roots to R2, the
  glass tooth `P·k` wide at its core. It was a trapezoid with tooth widths the library chose. Caps
  and gauges change shape, and their clearance against the glass is now measured normal to every
  face.
- The size table is now DIN 168-1 itself, not the web tables it was built from. Three of their cells
  were wrong: GL56 bolt core min, GL100 bolt outer min and GL112 bolt core min.
- A size row holds the standard's own form, `[name, P, d, d1, D, D1, bolt allowance, nut allowance,
  R1, R2, k]`, in place of `[min, max]` pairs. Read it through the accessors, which return what they
  did.
- `din168_nut_profile` and `din168_bolt_profile` return `[tip r, root r, tooth]`; the last two
  elements were a trapezoid's half-widths. `din168_helix` takes the new form.
- `din168_by_name` asserts on a name it does not know, instead of returning `undef`.
- The mouth's 45° lead-in starts 0.5 mm outside the thread's root (`din168_mouth_bevel`).
- `din168_cap` puts z = 0 at the seal plane, where the glass's rim meets the inside of the top,
  not at the mouth. A cap translated to a bottle's rim height sits on it whatever its thread
  length, liner space or ring band. Callers that placed a cap by its mouth move it up by
  `thread_length + liner_space` plus any ring band.
- A cap's thread defaults to five pitches (`din168_default_thread_length`), not 12 mm, and runs to
  the mouth: 20 mm on GL45, 25 mm on GL80. With 12 mm the GL45 cap was 17 mm tall; DURAN's GL45
  caps are 25 and 28 mm.

### Removed

- `din168_bolt_tooth_width`, which measured the old trapezoid.

### Fixed

- The cap's groove root was cut by a cylinder at the default `$fa`, whose flats filled the groove by
  up to r·(1 − cos 6°): 0.13 mm on GL45, 0.22 mm on GL80.
- `din168_bolt` trimmed its ends with a cylinder at the crest radius, whose flats cut the crests by
  the same amount.
