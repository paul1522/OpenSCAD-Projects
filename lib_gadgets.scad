include <lib_machine_screws.scad>
include <lib_self_tapping_screws.scad>
include <lib_nuts.scad>

module stud(shaft, self_tapping=false)
{
	ds = self_tapping ? shaft[0]-0.4 : shaft[0];
	
	cylinder(h=shaft[1], d=ds);
}

module bolt(head, shaft, countersink=false, self_tapping=false) {
	ds = self_tapping ? shaft[0]-0.4 : shaft[0];
	
	cylinder(h=head[1], d=head[0]);
	cylinder(h=shaft[1]+head[1], d=ds);
	if (countersink == true) {
		translate([0, 0, head[1]]) {
			cylinder(h=head[0], d1=head[0], d2=0);
		}
	}
}

module nut(head, countersink=false) {
	cylinder(h=head[1], d=head[0], $fn=6);
	if (countersink == true) {
		translate([0, 0, head[1]]) {
			cylinder(h=head[0], d1=head[0], d2=0, $fn=6);
		}
	}
}

module post(pos, radius, height) {
	translate([pos[0], pos[1], 0]) { 
		cylinder(h=height, r=radius); 
	}
}

module spacer(pos, outer_r, inner_r, height) {
	translate([pos[0], pos[1], 0]) { 
		difference() {
			cylinder(h=height, r=outer_r); 
			if (inner_r > 0) {
				cylinder(h=height+0.0001, r=inner_r); 
			}
		}
	}
}

module grid(size, xx, yy) {
	if (size > 0) {
		for (x = [0 : size : xx] ) {
			translate([x, 0, 0]) cube([0.8, yy, 0.4]);
		}
		for (y = [0 : size : yy] ) {
			translate([0, y, 0]) cube([xx, 0.8, 0.4]);
		}
	}
}
