use <lib_boxes3.scad>
use <lib_cutouts.scad>

//$fn = 30.00;

x1 = 200;
y1 = 200;
z1 = 12;
r1 = 10.00;
d1 = 1.20;
ro = 25.00;
ri = 22.00;
fn = 30.00;


difference() {
	open_box(x1, y1, z1, r1, d1);

	linear_extrude(d1) {
		translate([r1/2, r1/2, 0]) {
			honeycomb(x1-r1, y1-r1, ro, ri, fn);
		}
	}
}
