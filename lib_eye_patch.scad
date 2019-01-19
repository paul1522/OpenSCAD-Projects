/*
$fn = 360;
r1 = 120 ; // radius
z1 = 45 ; // lens height
y1 = 59 ; // lens width at the top
y2 = 46 ; // lens width at the bottom
t1 = 1.2 ; // thickness
offset = 0 ;
h=6.00;
*/

module eye_cover(r1, z1, y1, y2, t1, offset, h) {
	intersection() {
		difference() {
			sphere(r1);
			sphere(r1-t1);

			// cut off corners
			translate([0, y2/2+offset, (z1-14.14)/2]) {
				rotate([45, 0, 0]) {
					cube([r1+20, 10, 10]);
				}
			}
			translate([0, -y1/2+offset, (z1-14.14)/2]) {
				rotate([45, 0, 0]) {
					cube([r1+20, 10, 10]);
				}
			}
			translate([0, y1/2+offset, (-z1-7.07)/2]) {
				rotate([45, 0, 0]) {
					cube([r1+20, 5, 5]);
				}
			}
			translate([0, -y1/2+offset, (-z1-7.07)/2]) {
				rotate([45, 0, 0]) {
					cube([r1+20, 5, 5]);
				}
			}
		}
		
		translate([0, -y1/2+offset, -z1/2]) {
			cube([r1+100, y2, z1]);
			polyhedron(
				[[     0, y2, 0], [     0, y1, 0], [     0, y2, z1], 
				[r1+100, y2, 0], [r1+100, y1, 0], [r1+100, y2, z1]], 
				faces=[[0, 1, 2], 
				[3, 0, 5], [5, 0, 2], 
				[1, 0, 3], [3, 4, 1],
				[2, 1, 4], [4, 5, 2],
				[5, 4, 3]]
			);
		}
	}
}

module eye_patch(r1, z1, y1, y2, t1, offset, h) {
	q=2.5;
	translate([-r1, 0, 0]) {
		eye_cover(r1, z1, y1, y2, t1, offset, h);
		// Horizontal part of hooks
		intersection() {
			difference() {
				sphere(r1+h);
				sphere(r1-t1);
			}
			union() {
				translate([0, -y1/2+offset+(y1/4)-2.5, -z1/2]) {
					cube([r1+100, h, t1]);
				}
				translate([0, -y1/2+offset+(3*y1/4)-2.5, -z1/2]) {
					cube([r1+100, h, t1]);
				}
			}
		}

		// Vertical part of hooks
		intersection() {
			translate([0, 0, 0]) {
				difference() {
					sphere(r1+h+t1);
					sphere(r1+h);
					//cylinder(z1, r1+6+t1-q, r1+6+t1-q);
					//cylinder(z1, r1+6-q, r1+6-q);
				}
			}
			union() {
				translate([0, -y1/2+offset+(y1/4)-2.5, -z1/2]) {
					cube([r1+100, h, h+t1]);
				}
				translate([0, -y1/2+offset+(3*y1/4)-2.5, -z1/2]) {
					cube([r1+100, h, h+t1]);
				}
			}
		}
	}
}
