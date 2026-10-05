/**
 * @file din168.scad
 * @brief DIN 168 round thread (GL laboratory glassware): size table, thread, and screw cap; also
 *        DURAN's GLS 80, which is not a DIN 168 thread
 *
 * `use <din168-thread-scad/din168.scad>`. Draws nothing at top level; see examples/.
 *
 * Every dimension in the table below, and the profile, is from DIN 168-1:1998-04 as recorded in
 * docs/references.md. Anything else is marked CHOICE where it is made.
 *
 * The thread is swept as one polyhedron along a true helix, then trimmed to length.
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

// GLS 80, DURAN's wide-mouth thread. NOT DIN 168: three starts at 5 mm between crests, so it
// advances 15 mm per turn (DWK, b.safe; docs/references.md). Its diameters and pitch are GL80's,
// which a measured third-party GLS 80 cap agrees with; the tooth shape is GL80's. A row may carry a
// twelfth field, the number of starts; without it a thread has one.
din168_gls80 = ["GLS80", 5.0, 80, 77, 80.4, 77.4, 1.0, 0.6, 1.1, 0.8, 0.6, 3];

// In the standard's order, so the first GL25 is P = 3.
din168_sizes = [
  din168_gl8, din168_gl10, din168_gl12, din168_gl14, din168_gl16, din168_gl18, din168_gl20,
  din168_gl22, din168_gl25, din168_gl25x3_5, din168_gl28, din168_gl32, din168_gl36, din168_gl40,
  din168_gl45, din168_gl50, din168_gl56, din168_gl63, din168_gl70, din168_gl80, din168_gl90,
  din168_gl100, din168_gl112, din168_gl125,
];

// A size by name, e.g. "GL45", or "GLS80". GL25 comes in two pitches: pitch=3.5 picks the other one.
function din168_by_name(name, pitch = undef) =
  let (
    found = [for (s = concat(din168_sizes, [din168_gls80])) if (s[0] == name && (is_undef(pitch) || s[1] == pitch)) s]
  ) assert(len(found) > 0, str("din168_by_name: no size ", name, is_undef(pitch) ? "" : str(" x ", pitch)))
  found[0];

function din168_name(size) = size[0];
function din168_pitch(size) = size[1]; // between neighbouring crests
function din168_starts(size) = len(size) > 11 ? size[11] : 1;
function din168_lead(size) = din168_pitch(size) * din168_starts(size); // advance per turn
function din168_bolt_outer(size) = [size[2] - size[6], size[2]]; // d, [min, max]
function din168_bolt_core(size) = [size[3] - size[6], size[3]]; // d1
function din168_nut_outer(size) = [size[4], size[4] + size[7]]; // D
function din168_nut_core(size) = [size[5], size[5] + size[7]]; // D1
function din168_r1(size) = size[8]; // crest radius, both parts
function din168_r2(size) = size[9]; // root radius, maximum

// ----- profile -----

// Included flank angles, Bild 1: 60 degrees on the glass, 30 in the cap.
din168_bolt_flank_angle = 60;
din168_nut_flank_angle = 30;

// Bild 1 fixes each tooth by its height, flank angle and crest radius R1: the crest arc is tangent
// to both flanks and its top is the tooth's tip, so the flanks' width follows. On the glass that
// width is b = P*k at the core line, as the standard draws it. The cap tooth is built the same way
// from its own angle; the standard gives no width for it, and this is the width that follows.
// Both roots are rounded to R2. CHOICE: the standard's maximum.
//
// A tooth is [height, half flank angle, crest radius, root radius]. h is measured from the tooth's
// root line toward its tip, z along the axis from its centreline.

// Half-width of the sharp flanks at the root line.
function din168_tooth_w0(t) = (t[0] + t[2] / sin(t[1]) - t[2]) * tan(t[1]);

// Where the root radius meets the root line.
function din168_tooth_zf(t) = din168_tooth_w0(t) - t[3] * tan(t[1]) + t[3] / cos(t[1]);

// The tooth's outline in (h, z), from the root line at +z over the tip to the root line at -z.
// Segments per arc: the crest's and the root's.
function din168_tooth_outline(t, n_crest, n_root) =
  let (
    a = t[1], rc = t[2], rf = t[3], hc = t[0] - rc, zf = din168_tooth_zf(t),
    root = [for (i = [0:n_root]) let (p = 180 + (90 - a) * i / n_root) [rf + rf * cos(p), zf + rf * sin(p)]],
    crest = [for (i = [0:n_crest]) let (p = (90 - a) * (1 - 2 * i / n_crest)) [hc + rc * cos(p), rc * sin(p)]]
  ) concat(root, crest, [for (i = [n_root:-1:0]) [root[i][0], -root[i][1]]]);

// The standard's tooth for a flank angle, shrunk by the clearance on every face: an offset of the
// outline moves the root and tip lines by the clearance, and changes the radii by it. Glass and cap
// teeth are the same height, since the standard makes D - D1 equal d - d1.
function din168_tooth(size, flank_angle, clearance) =
  [(size[2] - size[3]) / 2, flank_angle / 2, din168_r1(size) - clearance, din168_r2(size) + clearance];

// A thread to cut: [tip r, root r, tooth]. The nut is cut at the loose end of its tolerance, the
// largest D and D1, and opened by the clearance, so it clears the largest in-tolerance glass.
function din168_nut_profile(size, clearance) =
  [
    din168_nut_core(size)[1] / 2 + clearance,
    din168_nut_outer(size)[1] / 2 + clearance,
    din168_tooth(size, din168_nut_flank_angle, clearance),
  ];

// The mirror of the nut: cut at the smallest in-tolerance glass, shrunk by the clearance, for a
// printed gauge or neck.
function din168_bolt_profile(size, clearance) =
  [
    din168_bolt_outer(size)[0] / 2 - clearance,
    din168_bolt_core(size)[0] / 2 - clearance,
    din168_tooth(size, din168_bolt_flank_angle, clearance),
  ];

// ----- helix -----

// How far a tooth runs on into the wall it stands on, so the two overlap instead of touching. CHOICE.
din168_root_overlap = 0.3;

// Steps per turn of the helix.
function din168_steps_per_turn() = $preview ? 60 : 180;

// The thread's root between turns is a cylinder, faceted like the helix. A polygon at the root radius
// would come in between its corners and fill the groove (0.13 mm on GL45 at the default $fa), so the
// cap's bore circumscribes the root and the glass's core inscribes it: both err toward clearance.
// Both stand off the root by din168_root_gap (CHOICE) and turn half a step from the helix's steps:
// corners lined up with the helix's left non-manifold edges.
din168_root_gap = 0.02;
module din168_root_cylinder(h, r, outside) {
  _n = din168_steps_per_turn();
  rotate([0, 0, 180 / _n])
    cylinder(h=h, r=outside ? (r + din168_root_gap) / cos(180 / _n) : r - din168_root_gap, $fn=_n);
}

// How far the cap's mouth is bevelled outside the thread's root, so the glass finds it. CHOICE.
din168_mouth_bevel = 0.5;

// Segments in the crest arc and in each root arc of the tooth's section.
function din168_crest_segments() = $preview ? 4 : 6;
function din168_root_segments() = $preview ? 2 : 3;

/**
 * The thread's teeth swept along a helix: `turns` turns from z = 0. One tooth per start, `pitch`
 * apart along the axis, each rising by pitch * starts per turn. profile is [tip r, root r, tooth]
 * (din168_nut_profile, din168_bolt_profile); the section is extended past the root by
 * din168_root_overlap, into the wall the tooth stands on.
 */
module din168_helix(pitch, profile, turns, starts = 1) {
  _rt = profile[0];
  _rr = profile[1];
  _t = profile[2];
  _s = sign(_rt - _rr);
  _zf = din168_tooth_zf(_t);

  assert(_t[2] > 0, "din168_helix: the clearance leaves the tooth no crest radius");
  assert(_t[3] * (1 - sin(_t[1])) <= _t[0] - _t[2] + _t[2] * sin(_t[1]), "din168_helix: the root radius runs into the crest");
  assert(2 * _zf < pitch, str("din168_helix: the tooth's root, ", 2 * _zf, " mm, is as wide as the pitch"));

  _outline = din168_tooth_outline(_t, din168_crest_segments(), din168_root_segments());
  _sec0 = concat(
    [[_rr - _s * din168_root_overlap, _zf]],
    [for (p = _outline) [_rr + _s * p[0], p[1]]],
    [[_rr - _s * din168_root_overlap, -_zf]]
  );

  // Section in (r, z), wound anticlockwise so the faces below face out: the nut's (tip inside the
  // root) already is, the bolt's is reversed.
  _sec = _s < 0 ? _sec0 : [for (i = [len(_sec0) - 1:-1:0]) _sec0[i]];
  _m = len(_sec);
  _n = ceil(turns * din168_steps_per_turn());
  _lead = pitch * starts;

  _pts = [
    for (i = [0:_n])
      let (a = i * 360 * turns / _n, dz = _lead * turns * i / _n)
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

  for (k = [0:starts - 1])
    rotate([0, 0, k * 360 / starts]) polyhedron(points=_pts, faces=_faces, convexity=4);
}

/**
 * Internal thread, as a tube: the cap's thread from z = 0 to z = length, in a wall of the given
 * thickness outside the thread's root. The mouth at z = 0 is chamfered so the glass finds it.
 */
module din168_nut(size, length, wall = 2, clearance = 0.2) {
  _p = din168_pitch(size);
  _l = din168_lead(size);
  _prof = din168_nut_profile(size, clearance);
  _r_out = _prof[1] + wall;

  difference() {
    union() {
      difference() {
        cylinder(h=length, r=_r_out);
        translate([0, 0, -1]) din168_root_cylinder(length + 2, _prof[1], outside=true);
      }
      intersection() {
        translate([0, 0, -_l]) din168_helix(_p, _prof, (length + 2 * _l) / _l, din168_starts(size));
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
  _l = din168_lead(size);
  _prof = din168_bolt_profile(size, clearance);

  assert(bore / 2 < _prof[1] - 1, str("din168_bolt: a ", bore, " bore leaves under 1 mm under the thread"));

  difference() {
    union() {
      din168_root_cylinder(length, _prof[1], outside=false);
      intersection() {
        translate([0, 0, -_l]) din168_helix(_p, _prof, (length + 2 * _l) / _l, din168_starts(size));
        // Past the crest: this only trims the ends, and a faceted cylinder at the crest would cut it
        cylinder(h=length, r=_prof[0] + 1);
      }
    }
    if (bore > 0) translate([0, 0, -1]) cylinder(h=length + 2, d=bore);
  }
}

/**
 * A screw cap: the nut, closed by a top. z = 0 is the seal plane, where the glass's rim meets the
 * inside of the top, so a cap placed at a bottle's rim height sits on it whatever its arguments.
 * The top is above it, from z = 0 to z = top; the liner space and the thread hang below, the
 * thread running down to the mouth. The outside is plain, or ribbed for grip.
 *
 * thread_length defaults to din168_default_thread_length. ring_band, in mm, adds a band at the
 * mouth bored din168_ring_band_gap outside the thread's root, to clear a pouring ring on the neck;
 * the wall steps out over it. 0 for none.
 *
 * CHOICE, not from the standard: thread length, wall, top, liner space and the ring band are
 * defaults to test against a real bottle and change.
 */
module din168_cap(
  size,
  thread_length = undef,
  liner_space = 2,
  top = 3,
  wall = 2,
  clearance = 0.2,
  ribs = 0,
  ring_band = 0
) {
  _prof = din168_nut_profile(size, clearance);
  _r_out = _prof[1] + wall;
  _tl = is_undef(thread_length) ? din168_default_thread_length(size) : thread_length;
  _h_in = ring_band + _tl + liner_space;
  _r_band = _prof[1] + din168_ring_band_gap;

  assert(ring_band >= 0, str("din168_cap: ring_band must be >= 0, not ", ring_band));

  translate([0, 0, -_h_in]) {
    // A wall stepped out round the band, and bored clear of the ring. The bore stops 0.005 mm short
    // of the thread's wall and the band runs 0.01 mm into it, so the wall's end face lies inside
    // the band rather than level with the bore's, whose edge can share its radius.
    if (ring_band > 0)
      difference() {
        cylinder(h=ring_band + 0.01, r=_r_band + wall);
        translate([0, 0, -1]) cylinder(h=ring_band + 1 - 0.005, r=_r_band, $fn=din168_steps_per_turn());
        translate([0, 0, -0.5]) din168_root_cylinder(ring_band + 1.02, _prof[1], outside=true);
      }

    translate([0, 0, ring_band]) {
      din168_nut(size, _tl, wall, clearance);

      // Plain wall over the liner space, then the top
      translate([0, 0, _tl - 0.01])
        difference() {
          cylinder(h=liner_space + top + 0.01, r=_r_out);
          translate([0, 0, -1]) din168_root_cylinder(liner_space + 1.01, _prof[1], outside=true);
        }

      // Half-round ribs for grip, above the band. Over a band they start inside the band's overlap
      // with the thread's wall, clear of both its faces.
      _z_rib = ring_band > 0 ? 0.005 : 0;
      if (ribs > 0)
        for (i = [0:ribs - 1])
          rotate([0, 0, i * 360 / ribs])
            translate([_r_out, 0, _z_rib])
              cylinder(h=_tl + liner_space + top - _z_rib, r=wall / 2, $fn=8);
    }
  }
}

// Five pitches of thread. CHOICE: no standard gives a cap's thread length. DURAN's GL caps are 17
// to 28 mm tall (docs/references.md); less a 3 mm top, that is 5.25 to 6.67 pitches inside. The GL45
// cap this gives is 25 mm over all, DURAN's PP GL45 cap's height. On GLS 80 it is 25 mm.
function din168_default_thread_length(size) = 5 * din168_pitch(size);

// How far the ring band's bore stands outside the thread's root. CHOICE: what a measured
// third-party GLS 80 cap leaves (docs/references.md); DURAN gives its pouring rings' heights only.
din168_ring_band_gap = 2;

// Outside radius of a cap, so a caller can size what it puts on the top.
function din168_cap_radius(size, wall = 2, clearance = 0.2) = din168_nut_profile(size, clearance)[1] + wall;
