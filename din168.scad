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

// ----- size table (DIN 168-1:1998-04, Tabelle 1; docs/references.md) -----

// [name, P, d, d1, D, D1, bolt allowance, nut allowance, R1, R2 max, k], as the standard gives them.
// Bolt is the external thread on the glass (d, d1); nut is the internal thread in the cap (D, D1).
// The bolt's diameters run from nominal down by its allowance, the nut's from nominal up. mm.
din168_gl8 = ["GL8", 2.0, 8, 6.6, 8.1, 6.7, 0.35, 0.2, 0.51, 0.3, 0.7];
din168_gl10 = ["GL10", 2.0, 10, 8.6, 10.1, 8.7, 0.35, 0.2, 0.51, 0.3, 0.7];
din168_gl12 = ["GL12", 2.0, 12, 10.6, 12.1, 10.7, 0.35, 0.2, 0.51, 0.3, 0.7];
din168_gl14 = ["GL14", 2.5, 14, 12.32, 14.1, 12.42, 0.4, 0.25, 0.62, 0.4, 0.675];
din168_gl16 = ["GL16", 2.5, 16, 14.32, 16.1, 14.42, 0.4, 0.25, 0.62, 0.4, 0.675];
din168_gl18 = ["GL18", 3.0, 18, 15.98, 18.1, 16.08, 0.5, 0.3, 0.74, 0.5, 0.675];
din168_gl20 = ["GL20", 3.0, 20, 17.98, 20.1, 18.08, 0.5, 0.3, 0.74, 0.5, 0.675];
din168_gl22 = ["GL22", 3.0, 22, 19.98, 22.1, 20.08, 0.5, 0.3, 0.74, 0.5, 0.675];
din168_gl25 = ["GL25", 3.0, 25, 22.98, 25.1, 23.08, 0.5, 0.3, 0.74, 0.5, 0.675];
din168_gl25x3_5 = ["GL25", 3.5, 25, 22.64, 25.1, 22.74, 0.5, 0.3, 0.86, 0.5, 0.675];
din168_gl28 = ["GL28", 3.0, 28, 25.98, 28.1, 26.08, 0.5, 0.3, 0.74, 0.5, 0.675];
din168_gl32 = ["GL32", 4.0, 32, 29.30, 32.15, 29.45, 0.7, 0.4, 0.99, 0.6, 0.675];
din168_gl36 = ["GL36", 4.0, 36, 33.30, 36.15, 33.45, 0.7, 0.4, 0.99, 0.6, 0.675];
din168_gl40 = ["GL40", 4.0, 40, 37.30, 40.15, 37.45, 0.7, 0.4, 0.99, 0.6, 0.675];
din168_gl45 = ["GL45", 4.0, 45, 42.30, 45.15, 42.45, 0.7, 0.4, 0.99, 0.6, 0.675];
din168_gl50 = ["GL50", 4.0, 50, 47.30, 50.3, 47.6, 0.8, 0.5, 0.99, 0.6, 0.675];
din168_gl56 = ["GL56", 4.0, 56, 53.30, 56.3, 53.6, 0.8, 0.5, 0.99, 0.6, 0.675];
din168_gl63 = ["GL63", 5.0, 63, 60, 63.4, 60.4, 1.0, 0.6, 1.1, 0.8, 0.6];
din168_gl70 = ["GL70", 5.0, 70, 67, 70.4, 67.4, 1.0, 0.6, 1.1, 0.8, 0.6];
din168_gl80 = ["GL80", 5.0, 80, 77, 80.4, 77.4, 1.0, 0.6, 1.1, 0.8, 0.6];
din168_gl90 = ["GL90", 5.0, 90, 87, 90.4, 87.4, 1.0, 0.6, 1.1, 0.8, 0.6];
din168_gl100 = ["GL100", 5.0, 100, 97, 100.4, 97.4, 1.2, 0.6, 1.1, 0.8, 0.6];
din168_gl112 = ["GL112", 5.0, 112, 109, 112.4, 109.4, 1.2, 0.6, 1.1, 0.8, 0.6];
din168_gl125 = ["GL125", 5.0, 125, 122, 125.4, 122.4, 1.2, 0.6, 1.1, 0.8, 0.6];

// In the standard's order, so the first GL25 is P = 3.
din168_sizes = [
  din168_gl8, din168_gl10, din168_gl12, din168_gl14, din168_gl16, din168_gl18, din168_gl20,
  din168_gl22, din168_gl25, din168_gl25x3_5, din168_gl28, din168_gl32, din168_gl36, din168_gl40,
  din168_gl45, din168_gl50, din168_gl56, din168_gl63, din168_gl70, din168_gl80, din168_gl90,
  din168_gl100, din168_gl112, din168_gl125,
];

// A size by name, e.g. "GL45". GL25 comes in two pitches: pitch=3.5 picks the other one.
function din168_by_name(name, pitch = undef) =
  let (
    found = [for (s = din168_sizes) if (s[0] == name && (is_undef(pitch) || s[1] == pitch)) s]
  ) assert(len(found) > 0, str("din168_by_name: no DIN 168 size ", name, is_undef(pitch) ? "" : str(" x ", pitch)))
  found[0];

function din168_name(size) = size[0];
function din168_pitch(size) = size[1];
function din168_bolt_outer(size) = [size[2] - size[6], size[2]]; // d, [min, max]
function din168_bolt_core(size) = [size[3] - size[6], size[3]]; // d1
function din168_nut_outer(size) = [size[4], size[4] + size[7]]; // D
function din168_nut_core(size) = [size[5], size[5] + size[7]]; // D1
function din168_r1(size) = size[8]; // crest radius, both parts
function din168_r2(size) = size[9]; // root radius, maximum
function din168_k(size) = size[10];

// Profile width b and depth c (Bild 1): the glass tooth is b wide at the core, c high.
function din168_profile_width(size) = din168_pitch(size) * din168_k(size);
function din168_profile_depth(size) = din168_profile_width(size) / 2;

// Flank diameter d2 of the largest in-tolerance glass (Bild 1).
function din168_flank_diameter(size) =
  size[2] - din168_pitch(size) * (sqrt(3) / 2 + din168_k(size) * (1 - sqrt(3)));

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

// The thread's root between turns is a cylinder, faceted like the helix. A polygon at the root radius
// would come in between its corners and fill the groove (0.13 mm on GL45 at the default $fa), so the
// cap's bore circumscribes the root and the glass's core inscribes it: both err toward clearance.
// Both stand off the root by din168_root_gap, and turn half a step so their corners fall between the
// helix's steps: where the two meet edge to edge or face to face they leave non-manifold edges.
din168_root_gap = 0.02;
module din168_root_cylinder(h, r, outside) {
  _n = din168_steps_per_turn();
  rotate([0, 0, 180 / _n])
    cylinder(h=h, r=outside ? (r + din168_root_gap) / cos(180 / _n) : r - din168_root_gap, $fn=_n);
}

// How far the cap's mouth is bevelled outside the thread's root, so the glass finds it. CHOICE.
din168_mouth_bevel = 0.5;

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
        translate([0, 0, -1]) din168_root_cylinder(length + 2, _prof[1], outside=true);
      }
      intersection() {
        translate([0, 0, -_p]) din168_helix(_p, _prof, (length + 2 * _p) / _p);
        cylinder(h=length, r=_r_out);
      }
    }
    // 45 degree lead-in: a bevel on the mouth's inner edge, din168_mouth_bevel wide, down past the
    // crest. It starts a millimetre outside the part and ends inside the bore, so it crosses every
    // face it cuts rather than meeting one at an edge, and it is faceted like the root cylinder.
    _n = din168_steps_per_turn();
    _r0 = _prof[1] + din168_mouth_bevel + 1;
    _r1 = _prof[0] - 0.1;
    translate([0, 0, -1]) rotate([0, 0, 180 / _n]) cylinder(h=_r0 - _r1, r1=_r0, r2=_r1, $fn=_n);
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
      din168_root_cylinder(length, _prof[1], outside=false);
      intersection() {
        translate([0, 0, -_p]) din168_helix(_p, _prof, (length + 2 * _p) / _p);
        // Past the crest: this only trims the ends, and a faceted cylinder at the crest would cut it
        cylinder(h=length, r=_prof[0] + 1);
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
      translate([0, 0, -1]) din168_root_cylinder(liner_space + 1.01, _prof[1], outside=true);
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
