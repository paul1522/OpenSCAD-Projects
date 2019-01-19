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
			rounded_rectangle(x1-2*d1, y1-2*d1, z1, r1-d1);
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
	z3 = z1+z2;
	r3 = max(r1-x2,0);
	d3 = d1/2-d2/2;
	
	open_box(x1, y1, z1, r1, d1);
	translate([x2, y2, 0]) {
		open_box(x3, y3, z3, r3, d3);
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
*/
module box_bottom_sliding(x1, y1, z1, r1, d1, z2, d2) {
	difference() {
		box_bottom(x1, y1, z1, r1, d1, z2, d2);
		translate([d1-(d1-d2)/2-0.0001, 0, 0]) {
			tongues(x1-d1-d2+0.0002, y1, z1+z2/2+d2/2, (d1-d2)/2);
		}
	}
	hull() {
		translate([x1*4/9, y1-d1+(d1-d2)/4, z1+z2]) sphere((d1-d2)/4);
		translate([x1*5/9, y1-d1+(d1-d2)/4, z1+z2]) sphere((d1-d2)/4);
	}
	hull() {
		translate([x1*4/9, d1-(d1-d2)/4, z1+z2]) sphere((d1-d2)/4);
		translate([x1*5/9, d1-(d1-d2)/4, z1+z2]) sphere((d1-d2)/4);
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
*/
module box_bottom_dimpled(x1, y1, z1, r1, d1, z2, d2) {
	difference() {
		box_bottom(x1, y1, z1, r1, d1, z2, d2);
		translate([d1-(d1-d2)/2-0.0001, 0, 0]) {
			pimples(x1-d1-d2+0.0002, y1/2, z1+z2/2, d1/2);
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
	z3 = z1+z2;
	r3 = max(r1-x2, 0);
	d3 = d1/2-d2/2;
	open_box(x1, y1, z1, r1, d1);
	open_box(x1, y1, z3, r1, d3);
}

module fingers(x1, y1, z1, r1, d1, z2, d2) {
    translate([0, y1/2, (z1+z2)]) {
		rotate([0, 90, 0]) {
			translate([0, 0, -1]) {
				cylinder(x1+2, 7.5, 7.5);
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
*/
module box_top_sliding(x1, y1, z1, r1, d1, z2, d2) {
	difference() {
		box_top(x1, y1, z1, r1, d1, z2, d2);
		translate([(d1-d2)/2, y1-max(d1, r1), z1]) {
			cube([x1-d1+d2, max(d1, r1), z2]);
		}
	}
	translate([(d1-d2)/2-0.01, max(d1, r1), 0]) {
		tongues(x1-d1+d2+0.02, y1-2*max(d1, r1), z1+z2/2+d2/2, (d1-d2)/2);
	}
	hull() {
		translate([x1*4/9, y1-(d1-d2)/4, z1]) sphere((d1-d2)/4);
		translate([x1*5/9, y1-(d1-d2)/4, z1]) sphere((d1-d2)/4);
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
*/
module box_top_pimpled(x1, y1, z1, r1, d1, z2, d2) {
	difference() {
		box_top(x1, y1, z1, r1, d1, z2, d2);
	}
	translate([(d1-d2)/2-0.01, 0, 0]) {
		pimples(x1-d1+d2+0.02, y1/2, z1+z2/2, d1/2);
	}
}

/**
x1 = x
y1 = y
z1 = z
d1 = diameter
*/
module pimples(x1, y1, z1, d1) {
	translate([0, y1, z1]) {
		sphere(d1/2);
		translate([x1, 0, 0]) {
			sphere(d1/2);
		}
	}
}

/**
x1 = x
y1 = length
z1 = z
d1 = size
*/
module tongues(x1, y1, z1, d1) {
	translate([0, 0, z1]) {
		tongue(y1, d1, 1);
		translate([x1, 0, 0]) {
			tongue(y1, d1, -1);
		}
	}
}

/**
y1 = length
d1 = size
h1 = 1=left;-1=right
*/
module tongue(y1, d1, h1) {
	x1 = sqrt(2*pow(d1,2));
	translate([-x1/2, 0, 0]) {
		difference() {
			rotate([0, 45, 0]) {
				cube([d1, y1, d1]);
			}
			translate([-x1/2*h1, 0, -x1/2]) {
				cube([x1, y1, x1]);
			}
		}
	}
}

module lips(x1, y1, z1, d1, r1) {
	translate([0, y1, z1]) {
		lip(d1, r1);
		translate([x1-d1, 0, 0]) {
			lip(d1, r1);
		}
	}
}

module lip(d1, r1) {
	rotate([0, 90, 0]) {
		cylinder(d1, r1, r1);
	}
}

module dividers(x1, y1, z1, d1, rows, columns) {
	row_size = x1 / rows - (d1/2);
	column_size = y1 / columns - (d1/2);
	translate([0, 0, 0]) {
		if (rows > 1) {
			for (row = [1 : rows-1]) {
				translate([row_size * row, 0, 0])
					cube([d1, y1, z1]);
			}
		}
		if (columns > 1) {
			for (column = [1 : columns-1]) {
				translate([0, column_size * column, 0])
					cube([x1, d1, z1]);
			}
		}
	}
}

