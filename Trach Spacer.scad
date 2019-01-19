use <Torus.scad>

r1 = 15;
r2 = 12 / 2;
h1 = 15;


difference() {
    union() {
        cylinder(r=r1, h=h1-(r1-r2)/2);
        translate([0, 0, h1-(r1-r2)/2])
        Torus((r1-r2)/2, r1);
    }
    cylinder(r=r2, h=2*h1);
    translate([0, -r2, 0]) cube([r1, 2*r2, 2*h1]);
    //translate([0, 0, h1]) translate([-2*r1, -2*r1, 0]) cube([4*r1, 4*r1, 4*h1]);
}
