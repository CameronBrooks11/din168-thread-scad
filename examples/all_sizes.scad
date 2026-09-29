// Every DIN 168 size: a cap in a row, each labelled with its designation. Preview (F5) is quick;
// a full render of all of them takes a while on OpenSCAD 2021.01.
include <../din168.scad> // for din168_sizes; the library draws nothing at top level

gap = 10;

// x of each cap's centre: the running sum of the diameters before it
function x_at(i) = i == 0 ? 0 : x_at(i - 1) + din168_cap_radius(din168_sizes[i - 1]) + gap + din168_cap_radius(din168_sizes[i]);

for (i = [0:len(din168_sizes) - 1]) {
  s = din168_sizes[i];
  translate([x_at(i), 0, 0]) {
    translate([0, 0, din168_cap_height(s)]) rotate([180, 0, 0]) din168_cap(s); // mouth up, as printed
    translate([0, -din168_cap_radius(s) - 4, 0])
      linear_extrude(1)
        text(str(din168_name(s), " x ", din168_pitch(s)), size=4, halign="center", valign="top");
  }
}
