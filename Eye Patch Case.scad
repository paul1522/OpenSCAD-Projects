// boxes5_text.scad

use <lib_boxes6.scad>

//$fn = 60.00;
x = 60.00;     // inner length
y = 70.00;     // inner depth
z = 17.00;     // inner height
r = 5.00;      // inner corner radius
f = z/2;       // friction
t = 0.1;      // tolerance
d1 = 0.40*4+t; // wall thickness
d2 = 1.5;
d3 = 1.5;

xc = x+2*d1;
yc = y+2*d1;
zb = z+d2;
zt = f+d3;
rc = r+d1;


//x1 = inner width
//y1 = inner depth
//z1 = inner height
//d1 = thickness
//r1 = radius of inner corners
//z2 = inner height of lid
//d2 = gap
//r2 = radius of finger cutouts
//f1 = sleeve the bottom


box_bottom(xc, yc, zb, rc, d1, f, t, d2);
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
