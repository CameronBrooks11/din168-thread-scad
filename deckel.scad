//Deckelkappen
//20250111

$fn = 128;

Ri = 20;
Ra = 22;
Dh = 15;
Dhi = 10;
rif = 60; // anzahl riffelungen

translate([0, 0, 0])
  kappe_1();

translate([70, 0, 0])
  kappe_2();

translate([0, 70, 0])
  kappe_3();

translate([70, 70, 0])
  kappe_4();

module kappe_4() //round 1x1 aussenriffel
{
  translate([0, 0, Dh - 1.001])
    hull() atorus(Ra, 0.5);
  difference() {
    cylinder(Dh - 1, r=Ra);
    translate([0, 0, -0.001])
      cylinder(Dhi, r=Ri);
  }

  for (i = [0:360 / rif:360]) {
    x = sin(i) * Ra;
    y = cos(i) * Ra;
    translate([x, y, 0]) {

      translate([0, 0, Dh - 2])
        sphere(1);
      translate([0, 0, 1])
        sphere(1);
      translate([0, 0, 1])
        cylinder(Dh - 3, 1);
    }
  }
}

module kappe_3() //round 1x1
{
  translate([0, 0, Dh - 1.001])
    hull() atorus(Ra, 0.5);
  difference() {
    cylinder(Dh - 1, r=Ra);
    translate([0, 0, -0.001])
      cylinder(Dhi, r=Ri);
  }
}
module kappe_2() //fase 1x1
{
  translate([0, 0, Dh - 1.001])
    cylinder(1, r1=Ra, r2=Ra - 1);
  difference() {
    cylinder(Dh - 1, r=Ra);
    translate([0, 0, -0.001])
      cylinder(Dhi, r=Ri);
  }
}

module kappe_1() //einfach
{
  difference() {
    cylinder(Dh, r=Ra);
    translate([0, 0, -0.001])
      cylinder(Dhi, r=Ri);
  }
}

//====================================
// Torusmodule
//====================================
// Torus aussen d
module atorus(Major, Minor) {
  torus(Major - Minor, Minor);
}
module torus(Major, Minor) {
  rotate_extrude(convexity=10)
    translate([Major, 0, 0])
      circle(r=Minor);
}
