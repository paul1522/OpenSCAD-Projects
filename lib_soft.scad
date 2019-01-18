/** 
 * An OpenSCAD library for creating shapes with rounded edges
 *
 * @author Paul Generes <paul.generes@gmail.com>
 * @example soft_example.scad
 */
 
module soft_cube(size=[1, 1, 1], center=false, cr=1) {
	tr = [cr, cr, cr];

    translate(tr) {
        minkowski() {
            sphere(cr);
            cube([size[0]-2*cr, size[1]-2*cr, size[2]-2*cr], center);
        }
    }
}

module softxyz_cube(size=1, center=false, cr=[1, 1, 1]) {
	tr = cr;

    translate(tr) {
        minkowski() {
			scale(cr) {
				sphere(1);
			}
            cube([size[0]-2*cr[0], size[1]-2*cr[1], size[2]-2*cr[2]], center);
        }
    }
}

module softz_cube(size=1, center=false, cr=1) {
	tr = [cr, cr, 0];

    translate(tr) {
        minkowski() {
			cylinder(h=0.00001, r=cr);
			cube([size[0]-2*cr, size[1]-2*cr, size[2]-0.00001], center);
        }
    }
}
