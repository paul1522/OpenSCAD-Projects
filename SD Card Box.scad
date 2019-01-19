// boxes5_text.scad

use <lib_boxes6.scad>

sdx = 25;
sdy = 2.2;
sdz = 33;




//$fn = 60.00;
x = sdx*2;       // inner length
y = sdx*3;       // inner depth
z = sdz;       // inner height
r = 0;        // inner corner radius
f = 9;       // friction
t = 0.4;       // tolerance
d1 = 0.8*2+t; // wall thickness
d2 = 1.5;
d3 = 1.5;

xc = x+2*d1;
yc = y+2*d1;
zb = 2*z/3+d2;
zt = f+d3+z/3;
rc = 0;//r+d1;


//x1 = inner width
//y1 = inner depth
//z1 = inner height
//d1 = thickness
//r1 = radius of inner corners
//z2 = inner height of lid
//d2 = gap
//r2 = radius of finger cutouts
//f1 = sleeve the bottom


difference() {
    box_bottom(xc, yc, zb, rc, d1, f, t, d2);
    translate([xc/4, yc/6, 0]) cylinder(h=d2, d = 15);
    translate([3*xc/4, yc/6, 0]) cylinder(h=d2, d = 15);
    translate([xc/4, 3*yc/6, 0]) cylinder(h=d2, d = 15);
    translate([3*xc/4, 3*yc/6, 0]) cylinder(h=d2, d = 15);
    translate([xc/4, 5*yc/6, 0]) cylinder(h=d2, d = 15);
    translate([3*xc/4, 5*yc/6, 0]) cylinder(h=d2, d = 15);
}
translate([xc/2-0.4, d1, 0]) cube([0.8, yc-2*d1, zt]);
translate([d1, yc/3-0.4, 0]) cube([xc-2*d1, 0.8, zt]);
translate([d1, 2*yc/3-0.4, 0]) cube([xc-2*d1, 0.8, zt]);


translate([xc+20, 0, 0]) {
	difference() {
		box_top(xc, yc, zt, rc, d1, f, t, d3);
		fingers(xc, yc, zt, rc, d1, f, t, f*2/3);
	}
}

*translate([30+d1/2, d1, 0]) {
    cube([d, y, z]);
}
*translate([d1, 30+d1/2, 0]) {
    cube([x, d1, z]);
}
