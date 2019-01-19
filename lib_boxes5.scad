// boxes5.scad

/**
x1 = width
y1 = depth
z1 = height
r1 = radius of corners
*/
module rounded_rectangle(x1, y1, z1, r1) {
    if (r1 > 0.00001) { // deal with rounding errors 
		translate([r1, r1, 0]) {
			minkowski () {
				cube([x1-2*r1, y1-2*r1, z1/2]);
				cylinder(z1/2, r1, r1);
			}
		}
	} else {
		cube([x1, y1, z1]);
	}
}

/**
x1 = width
y1 = depth
z1 = height
r1 = radius of corners
d1 = thickness
*/
module rounded_ring(x1, y1, z1, r1, d1) {
	difference () {
		rounded_rectangle(x1, y1, z1, r1);
		translate([d1, d1, 0]) {
			rounded_rectangle(x1-2*d1, y1-2*d1, z1+0.001, r1-d1);
		}
	}
}

/**
x1 = width
y1 = depth
z1 = height
r1 = radius of corners
d1 = thickness
*/
module open_box(x1, y1, z1, r1, d1) {
	rounded_rectangle(x1, y1, d1, r1);
	rounded_ring(x1, y1, z1, r1, d1);
}

/**
Bottom of a friction fit box
x1 = width
y1 = depth
z1 = height
r1 = radius of corners
d1 = thickness
z2 = friction
d2 = tolerance
*/
module box_bottom(x1, y1, z1, r1, d1, z2, d2) {
	x2 = d1/2+d2/2;
	y2 = d1/2+d2/2;
	x3 = x1-2*x2;
	y3 = y1-2*y2;
	r3 = max(r1-x2, 0);
	d3 = d1/2-d2/2;
	mm = floor(min(x1, y1)/10);

	difference() {
		union() {
			open_box(x1, y1, z1-z2, r1, d1);
			translate([x2, y2, 0]) {
				rounded_ring(x3, y3, z1-d2, r3, d3);
			}
		}
		*for (ii = [1 : mm]) {
			xx1 = 5*ii;
			xx2 = x1-10*ii;
			yy1 = 5*ii;
			yy2 = y1-10*ii;
			rr2 = r1-5*ii;
			translate([xx1, yy1, 0]) {
				rounded_ring(xx2, yy2, 0.65, rr2, 3);
			}
		}
	}
}

/**
Top of a friction fit box.
x1 = width
y1 = depth
z1 = height
r1 = radius of corners
d1 = thickness
z2 = friction
d2 = tolerance
*/
module box_top(x1, y1, z1, r1, d1, z2, d2) {
	x2 = d1/2+d2;
	y2 = d1/2+d2;
	x3 = x1-2*x2;
	y3 = y1-2*y2;
	z3 = z1+z2-d2;
	r3 = max(r1-x2, 0);
	d3 = d1/2-d2/2;
	mm = floor(min(x1, y1)/10);
	
	difference() {
		union() {
			open_box(x1, y1, z1-z2, r1, d1);
			rounded_ring(x1, y1, z1-d2, r1, d3);
		}

		*for (ii = [1 : mm]) {
			xx1 = 5*ii;
			xx2 = x1-10*ii;
			yy1 = 5*ii;
			yy2 = y1-10*ii;
			rr2 = r1-5*ii;
			translate([xx1, yy1, 0]) {
				rounded_ring(xx2, yy2, 0.65, rr2, 3);
			}
		}
	}
}

/**
x1 = width
y1 = depth
z1 = height
r1 = radius of corners
d1 = thickness
z2 = friction
d2 = tolerance
r2 = radius of fingers
*/
module fingers(x1, y1, z1, r1, d1, z2, d2, r2) {
	zz = max(z1, r2+d2);
    translate([0, y1/2, zz]) {
		rotate([0, 90, 0]) {
			translate([0, 0, -1]) {
				cylinder(x1+2, r2, r2);
			}
		}
	}
}

/**
x1 = width
y1 = depth
z1 = height
d1 = thickness
z2 = friction
d2 = tolerance
*/
module pimples(x1, y1, z1, d1, z2, d2) {
	translate([x1/2, (d1/2), z1-(z2/2)]) {
		sphere(d1/2);
	}
	translate([x1/2, y1-(d1/2), z1-(z2/2)]) {
		sphere(d1/2);
	}
}
