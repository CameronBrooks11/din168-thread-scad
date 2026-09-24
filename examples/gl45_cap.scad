// A GL45 screw cap, plain, and a short GL45 gauge to try it on without a bottle.
use <../din168.scad>

gl = din168_by_name("GL45");

din168_cap(gl, ribs=36);
translate([70, 0, 0]) din168_bolt(gl, length=12, bore=30);
