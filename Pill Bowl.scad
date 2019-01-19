//$fn = 90;

r1 = 15.0;
d1 = 2.0;
r2 = 7;
x2 = 5;
y2 = 10;

difference() {
    hull() {
        sphere(r=r1);
        translate([r1+x2, y2/2, 0]) {
            sphere(r=r2);
        }
        translate([r1+x2, -y2/2, 0]) {
            sphere(r=r2);
        }
        translate([0, 0, -r1])
            cylinder(h=1, r=r1);
    }

    translate([-r1, -r1, 0]) cube([r1*2+x2+r2, r1*2, r1*2]);

    hull() {
        sphere(r=r1-d1);
        translate([r1+x2, y2/2, 0]) {
            sphere(r=r2-d1);
        }
        translate([r1+x2, -y2/2, 0]) {
            sphere(r=r2-d1);
        }
    }

    translate([r1+x2+r2-d1*2, -r1, -r1]) cube([d1*2, r1*2, r1*2]);
}