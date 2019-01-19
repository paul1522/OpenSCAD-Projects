// boxes5_text.scad

use <lib_boxes5.scad>

$fn = 60.00;
//x = 42.00-2*1.2;    // inner length
//y = 42.00-2*1.2;    // inner depth
//z = (85.00-1.2)/2;    // inner height
//r = 15.00-4.70-1.20;     // inner corner radius
f = 10.00;       // friction
t = 0.40;     // tolerance
d = 0.40*4+t; // wall thickness

xc = 40-2*1.2;
yc = 40-2*1.2;
zb = 40-d;
zt = 10+d;
rc = 15-4.7-2-1.2;


box_bottom(xc, yc, zb, rc, d, f, t);
translate([xc+10, 0, 0]) {
	difference() {
		box_top(xc, yc, zt, rc, d, f, t);
		fingers(xc, yc, zt, rc, d, f, t, f*2/3);
	}
}
