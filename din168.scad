/**
 * @file din168.scad
 * @brief DIN 168 round thread (GL laboratory glassware): size table, thread, and screw cap
 *
 * `use <din168-thread-scad/din168.scad>`. Draws nothing at top level; see examples/.
 *
 * Every dimension in the table below is transcribed from docs/references.md, which records its
 * source and the date it was read. Anything else - the tooth widths, the clearances, the cap
 * proportions - is a choice, and is named as one where it is made.
 *
 * The thread is swept as one polyhedron along a true helix, then trimmed to length, so it renders
 * in seconds on OpenSCAD 2021.01 as well as on the manifold backend.
 */

// ----- size table (docs/references.md) -----

// [name, pitch, [bolt outer min, max], [bolt core min, max], [nut outer min, max], [nut core min, max]]
// Bolt is the external thread on the glass; nut is the internal thread in the cap. mm.
din168_gl25 = ["GL25", 3.0, [24.50, 25.00], [22.48, 22.98], [25.10, 25.40], [23.08, 23.38]];
din168_gl28 = ["GL28", 3.0, [27.50, 28.00], [25.48, 25.98], [28.10, 28.40], [26.08, 26.38]];
din168_gl32 = ["GL32", 4.0, [31.30, 32.00], [28.60, 29.30], [32.15, 32.55], [29.45, 29.85]];
din168_gl45 = ["GL45", 4.0, [44.30, 45.00], [41.60, 42.30], [45.15, 45.55], [42.45, 42.85]];

din168_sizes = [din168_gl25, din168_gl28, din168_gl32, din168_gl45];

function din168_by_name(name) = [for (s = din168_sizes) if (s[0] == name) s][0];

function din168_name(size) = size[0];
function din168_pitch(size) = size[1];
function din168_bolt_outer(size) = size[2]; // [min, max]
function din168_bolt_core(size) = size[3];
function din168_nut_outer(size) = size[4];
function din168_nut_core(size) = size[5];

// ----- profile -----

// Included flank angles, docs/references.md: 60 degrees on the glass, 30 in the cap.
din168_bolt_flank_angle = 60;
din168_nut_flank_angle = 30;

// No source gives the tooth widths. CHOICE: the glass tooth is half the pitch wide at mid-depth,
// and the cap tooth is cut to fit the widest glass tooth that is still in tolerance.

// Width of the glass tooth at radius r, for the largest in-tolerance glass.
function din168_bolt_tooth_width(size, r) =
  let (
    r_mid = (din168_bolt_outer(size)[1] + din168_bolt_core(size)[1]) / 4
  ) din168_pitch(size) / 2 + 2 * (r_mid - r) * tan(din168_bolt_flank_angle / 2);

// Nut radii and half-widths for a given clearance: [crest r, root r, crest half-width, root half-width].
// The crest is cut at the nut's largest in-tolerance core, the root at its largest outer, both
// opened by the clearance; the crest is as wide as the glass groove it sits in, less the clearance
// on each flank.
function din168_nut_profile(size, clearance) =
  let (
    r_crest = din168_nut_core(size)[1] / 2 + clearance,
    r_root = din168_nut_outer(size)[1] / 2 + clearance,
    a_crest = (din168_pitch(size) - din168_bolt_tooth_width(size, r_crest)) / 2 - clearance,
    a_root = a_crest + (r_root - r_crest) * tan(din168_nut_flank_angle / 2)
  ) [r_crest, r_root, a_crest, a_root];

// Bolt radii and half-widths, the mirror of the nut: [crest r, root r, crest half-width, root half-width].
// Cut at the smallest in-tolerance glass, shrunk by the clearance, for a printed gauge or neck.
function din168_bolt_profile(size, clearance) =
  let (
    r_crest = din168_bolt_outer(size)[0] / 2 - clearance,
    r_root = din168_bolt_core(size)[0] / 2 - clearance,
    a_crest = din168_bolt_tooth_width(size, r_crest) / 2 - clearance,
    a_root = din168_bolt_tooth_width(size, r_root) / 2 - clearance
  ) [r_crest, r_root, a_crest, a_root];

// ----- helix -----

// How far a tooth runs on into the wall it stands on, so the two overlap instead of touching.
din168_root_overlap = 0.3;

// Steps per turn of the helix.
function din168_steps_per_turn() = $preview ? 60 : 180;

/**
 * One tooth swept along a helix: `turns` turns from z = 0, rising by the pitch per turn.
 * profile is [crest r, root r, crest half-width, root half-width]; the root is extended by
 * din168_root_overlap away from the crest.
 */
module din168_helix(pitch, profile, turns) {
  _rc = profile[0];
  _rr = profile[1];
  _ac = profile[2];
  _ar = profile[3];
  _ext = _rr + din168_root_overlap * sign(_rr - _rc);

  // Section in (r, z), wound one way whichever side the root is on, so the faces below face out.
  _sec0 = [[_rc, -_ac], [_rr, -_ar], [_ext, -_ar], [_ext, _ar], [_rr, _ar], [_rc, _ac]];
  _sec = _rr > _rc ? _sec0 : [for (i = [len(_sec0) - 1:-1:0]) _sec0[i]];
  _m = len(_sec);
  _n = ceil(turns * din168_steps_per_turn());

  _pts = [
    for (i = [0:_n])
      let (a = i * 360 * turns / _n, dz = pitch * turns * i / _n)
        for (p = _sec) [p[0] * cos(a), p[0] * sin(a), p[1] + dz],
  ];

  // Triangles, not quads: a quad on a helix is not planar, and CGAL refuses it.
  _faces = concat(
    [[for (j = [_m - 1:-1:0]) j]],
    [[for (j = [0:_m - 1]) _n * _m + j]],
    [
      for (i = [0:_n - 1], j = [0:_m - 1])
        let (j1 = (j + 1) % _m, a = i * _m + j, b = i * _m + j1, c = (i + 1) * _m + j1, d = (i + 1) * _m + j)
          each [[a, b, c], [a, c, d]],
    ]
  );

  polyhedron(points=_pts, faces=_faces, convexity=4);
}

/**
 * Internal thread, as a tube: the cap's thread from z = 0 to z = length, in a wall of the given
 * thickness outside the thread's root. The mouth at z = 0 is chamfered so the glass finds it.
 */
module din168_nut(size, length, wall = 2, clearance = 0.2) {
  _p = din168_pitch(size);
  _prof = din168_nut_profile(size, clearance);
  _r_out = _prof[1] + wall;

  assert(2 * _prof[3] < _p, str("din168_nut: the tooth's root, ", 2 * _prof[3], " mm, is as wide as the pitch"));
  assert(_prof[2] > 0, str("din168_nut: a clearance of ", clearance, " leaves the tooth no crest"));

  difference() {
    union() {
      difference() {
        cylinder(h=length, r=_r_out);
        translate([0, 0, -1]) cylinder(h=length + 2, r=_prof[1]);
      }
      intersection() {
        translate([0, 0, -_p]) din168_helix(_p, _prof, (length + 2 * _p) / _p);
        cylinder(h=length, r=_r_out);
      }
    }
    // 45 degree lead-in from the root down to the crest
    translate([0, 0, -0.01]) cylinder(h=_prof[1] - _prof[0] + 0.01, r1=_prof[1], r2=_prof[0]);
  }
}

/**
 * External thread, as a rod: the glass side, for a printed gauge or neck, z = 0 to length.
 * bore 0 for a solid rod.
 */
module din168_bolt(size, length, bore = 0, clearance = 0.2) {
  _p = din168_pitch(size);
  _prof = din168_bolt_profile(size, clearance);

  assert(_prof[2] > 0, str("din168_bolt: a clearance of ", clearance, " leaves the tooth no crest"));
  assert(bore / 2 < _prof[1] - 1, str("din168_bolt: a ", bore, " bore leaves under 1 mm under the thread"));

  difference() {
    union() {
      cylinder(h=length, r=_prof[1]);
      intersection() {
        translate([0, 0, -_p]) din168_helix(_p, _prof, (length + 2 * _p) / _p);
        cylinder(h=length, r=_prof[0]);
      }
    }
    if (bore > 0) translate([0, 0, -1]) cylinder(h=length + 2, d=bore);
  }
}

/**
 * A screw cap: the nut, closed by a top. z = 0 is the mouth; the inside of the top, where the
 * glass's rim seals against a liner, is at z = thread_length + liner_space. The outside is plain,
 * or ribbed for grip.
 *
 * CHOICE, not from the standard: thread length, wall, top and liner space are defaults to test
 * against a real bottle and change.
 */
module din168_cap(
  size,
  thread_length = 12,
  liner_space = 2,
  top = 3,
  wall = 2,
  clearance = 0.2,
  ribs = 0
) {
  _prof = din168_nut_profile(size, clearance);
  _r_out = _prof[1] + wall;
  _h_in = thread_length + liner_space;

  din168_nut(size, thread_length, wall, clearance);

  // Plain wall over the liner space, then the top
  translate([0, 0, thread_length - 0.01])
    difference() {
      cylinder(h=liner_space + top + 0.01, r=_r_out);
      translate([0, 0, -1]) cylinder(h=liner_space + 1.01, r=_prof[1]);
    }

  // Half-round ribs for grip
  if (ribs > 0)
    for (i = [0:ribs - 1])
      rotate([0, 0, i * 360 / ribs])
        translate([_r_out, 0, 0])
          cylinder(h=_h_in + top, r=wall / 2, $fn=8);
}

// Outside radius of a cap, so a caller can size what it puts on the top.
function din168_cap_radius(size, wall = 2, clearance = 0.2) = din168_nut_profile(size, clearance)[1] + wall;
