// A GLS 80 screw cap, ribbed, for DURAN's wide-mouth bottles, and a short GLS 80 gauge to try it
// on without a bottle. GLS 80 is not a DIN 168 thread; see din168.scad and docs/references.md.
use <../din168.scad>

gl = din168_by_name("GLS80");

// Shown as printed: top on the bed, mouth up. din168_cap draws it mouth down, its top from z = 0
// to z = top. For a bottle with its pouring ring fitted, add ring_band=8.
top = 3;
translate([0, 0, top]) rotate([180, 0, 0]) din168_cap(gl, top=top, ribs=48);
translate([100, 0, 0]) din168_bolt(gl, length=12, bore=64);
