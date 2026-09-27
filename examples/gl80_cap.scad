// A GL80 screw cap, ribbed, and a short GL80 gauge to try it on without a bottle.
use <../din168.scad>

gl = din168_by_name("GL80");

cap_height = 12 + 2 + 3; // din168_cap's defaults: thread_length + liner_space + top

// Shown as printed: top on the bed, mouth up. din168_cap draws it mouth down, from z = 0.
translate([0, 0, cap_height]) rotate([180, 0, 0]) din168_cap(gl, ribs=48);
translate([100, 0, 0]) din168_bolt(gl, length=12, bore=64);
