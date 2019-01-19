use <lib_boxes5.scad>
use <lib_soft.scad>

//wi = 140.0;
th = 10.0;  // thickness


x1 = 230;
y1 = 230;
d1 = 120;


bd2 = 16; // bolt hole
bd1 = 35; // arm hole
bx1 = bd2*2;
by1 = bd1+4*bd2;
bz1 = 72;

intersection() {
    //cube([250, 250, 0.65]);
    difference() {
        
        union () {
            softz_cube([x1, y1, th], cr=10);
            translate([0, 110, th]) cube([x1, th, th]);
        }
        
        translate([bd2*2, 0, 0]) {
            softz_cube([x1-4*bd2, 110, th], cr=10);
            cube([x1-4*bd2, 10, th]);
        }
        
        translate([bx1 / 2, bd2, 0]) {
            cylinder(d=bd2, h=bz1);
        }
        translate([bx1 / 2, by1 - bd2, 0]) {
            cylinder(d=bd2, h=bz1);
        }
        translate([x1 - bx1 / 2, bd2, 0]) {
            cylinder(d=bd2, h=bz1);
        }
        translate([x1 - bx1 / 2, by1 - bd2, 0]) {
            cylinder(d=bd2, h=bz1);
        }
    }
}
