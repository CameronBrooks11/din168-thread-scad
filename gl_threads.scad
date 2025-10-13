// DIN 168 External Thread
// Ref basis: https://modelscad.com/thread/thread-page26-eng

// ---------------------------------------------------------------
// Global tessellation 
// ---------------------------------------------------------------
$fn = 32;
epsilon = 1 / 128;

// ===============================================================
// Utilities
// ===============================================================

// Tangency point on circle from external point.
// side = +1 → left of vector(pt→center); side = -1 → right of vector(pt→center)
function tangent_point_on_circle(center = [0, 0], radius = 10, pt = [20, 20], side = 1) =
  let (
    v = center - pt,
    v_len = norm(v),
    sin_a = radius / v_len,
    ab = sqrt(v_len * v_len - radius * radius),
    cos_a = ab / v_len,
    rot = [
      [cos_a, -side * sin_a],
      [side * sin_a, cos_a],
    ]
  ) pt + rot * ab * (v / v_len);

// Build the 2D flank profile polygon and return [tip_center_x, points[]]
function gl168_profile_2d(major_diameter, thread_height, tip_radius, flank_angle_deg = 37.5) =
  let (
    tip_center_x = major_diameter / 2 - thread_height + tip_radius,
    up = tangent_point_on_circle(
      [tip_center_x, 0], tip_radius,
      [tip_center_x + tip_radius, tip_radius / tan(flank_angle_deg)], +1
    ),
    dn = tangent_point_on_circle(
      [tip_center_x, 0], tip_radius,
      [tip_center_x + tip_radius, -tip_radius / tan(flank_angle_deg)], -1
    ),
    pts = [
      [tip_center_x, 0],
      up,
      [tip_center_x + tip_radius, tip_radius / tan(flank_angle_deg)],
      [tip_center_x + tip_radius, -tip_radius / tan(flank_angle_deg)],
      dn,
    ]
  ) [tip_center_x, pts];

// ===============================================================
// Parametric thread slice (single azimuth step) and helix
// ===============================================================

// One swept slice at absolute azimuth `deg`
module gl168_thread_slice_deg(
  deg,
  pitch,
  major_diameter,
  wall_thickness,
  thread_height,
  tip_radius,
  groove_bottom_radius,
  segments_per_rev,
  flank_angle_deg = 37.5
) {
  prof = gl168_profile_2d(major_diameter, thread_height, tip_radius, flank_angle_deg);
  tip_cx = prof[0];
  flank_pts = prof[1];

  rotate([0, 0, deg])
    translate([0, 0, deg * pitch / 360])
      rotate_extrude(angle=360 / segments_per_rev + 0.2, convexity=10)
        difference() {
          // Rectangular band that contains the tooth + skin thickness
          translate([major_diameter / 2 - thread_height + (thread_height + wall_thickness) / 2, 0])
            square([thread_height + wall_thickness, pitch], center=true);

          // Tooth form: flank polygon + tip circle with rounded root via offset pair
          intersection() {
            offset(groove_bottom_radius) offset(-groove_bottom_radius)
                difference() {
                  square([major_diameter, 2 * pitch], center=true);
                  translate([tip_cx, 0]) circle(tip_radius);
                  polygon(flank_pts);
                }

            // Limit to current pitch band
            translate([major_diameter / 2, 0]) square([major_diameter, pitch + epsilon], center=true);
          }
        }
}

// Helical thread built by stitching neighboring slices
module gl168_thread_helix(
  revolutions,
  segments_per_rev,
  pitch,
  major_diameter,
  wall_thickness,
  thread_height,
  tip_radius,
  groove_bottom_radius,
  flank_angle_deg = 37.5
) {

  angles_deg = [for (i = [0:segments_per_rev * revolutions]) i * 360 / segments_per_rev];
  merge_slices = 5 * segments_per_rev / 100; // Merge last 5% of slices

  for (i = [0:len(angles_deg) - 2]) {
    merge_step_factor = (i < merge_slices) ? i / merge_slices : 1;

    current_thread_height = merge_step_factor * thread_height;
    gl168_thread_slice_deg(
      angles_deg[i],
      pitch, major_diameter, wall_thickness, current_thread_height,
      tip_radius, groove_bottom_radius, segments_per_rev, flank_angle_deg
    );
    gl168_thread_slice_deg(
      angles_deg[i + 1],
      pitch, major_diameter, wall_thickness, current_thread_height,
      tip_radius, groove_bottom_radius, segments_per_rev, flank_angle_deg
    );
  }
}

// Thin outer skin to close potential gaps
module gl168_outer_skin(
  revolutions,
  pitch,
  major_diameter,
  wall_thickness,
  segments_per_rev
) {
  translate([0, 0, -pitch / 2])
    difference() {
      cylinder(
        h=(revolutions + 1) * pitch,
        d=major_diameter + 2 * wall_thickness + epsilon,
        $fn=segments_per_rev
      );
      translate([0, 0, -epsilon])
        cylinder(
          h=(revolutions + 1) * pitch + 2 * epsilon,
          d=major_diameter,
          $fn=segments_per_rev
        );
    }
}

// Convenience wrapper: full threaded tube (thread + skin)
// thread_height_factor k converts to crest-to-root c = P*k/2
module gl168_threaded_tube(
  pitch,
  thread_height_factor,
  tip_radius,
  groove_bottom_radius,
  major_diameter,
  wall_thickness,
  revolutions,
  segments_per_rev = 360,
  flank_angle_deg = 37.5
) {
  thread_height = pitch * thread_height_factor / 2;
  union() {
    // Thread
    gl168_thread_helix(
      revolutions, segments_per_rev,
      pitch, major_diameter, wall_thickness,
      thread_height, tip_radius, groove_bottom_radius, flank_angle_deg
    );
    // Outer skin
    gl168_outer_skin(revolutions, pitch, major_diameter, wall_thickness, segments_per_rev);
  }
}

// ========================================
// Example: GL28 DIN 168 external thread 
// ========================================
pitch_ex = 3;
k_ex = 0.675; // thread height factor
tip_radius_ex = 0.74;
groove_bottom_radius_ex = 0.5;
major_diameter_ex = 28.1;
wall_thickness_ex = 1;
revolutions_ex = 3.0;
segments_per_rev_ex = 360; // for helix smoothness

gl168_threaded_tube(
  pitch=pitch_ex,
  thread_height_factor=k_ex,
  tip_radius=tip_radius_ex,
  groove_bottom_radius=groove_bottom_radius_ex,
  major_diameter=major_diameter_ex,
  wall_thickness=wall_thickness_ex,
  revolutions=revolutions_ex,
  segments_per_rev=segments_per_rev_ex
);
