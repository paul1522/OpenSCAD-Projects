/** 
 * An OpenSCAD library for creating customized enclosures.
 *
 * @author Paul Generes <paul.generes@gmail.com>
 * @example enclosure3_example.scad
 */
 
include <lib_soft.scad>
include <lib_gadgets.scad>

// Global constants
function inner_x()         = device_x()+2*tolerance();
function inner_y()         = device_y()+2*tolerance();
function inner_z()         = device_z()+riser_z()+2*tolerance();
function outer_x()         = inner_x()+2*wall_thickness();
function outer_y()         = inner_y()+2*wall_thickness();
function outer_z()         = inner_z()+top_thickness()+bottom_thickness();
function bottom_z()        = (split()<=1) ? (outer_z()*split())    : (split());
function top_z()           = (split()<=1) ? (outer_z()-bottom_z()) : (outer_z()-split());
function gthickness()      = (wall_thickness()-tolerance())/2;
function triser_z()        = riser_z()+tolerance();
function twall_thickness() = wall_thickness()+tolerance();
function outer_r()         = fillet_z()+twall_thickness();


function tolerate(m) = 2*tolerance()+m;


echo("device_x()         =", device_x());
echo("device_y()         =", device_y());
echo("device_z()         =", device_z());
echo("wall_thickness()   =", wall_thickness());
echo("top_thickness()    =", top_thickness());
echo("bottom_thickness() =", bottom_thickness());
echo("split()            =", split());
echo("friction()         =", friction());
echo("spacing()          =", spacing());
echo("riser_z()          =", riser_z());
echo("riser_thickness()  =", riser_thickness());
echo("inner_x()          =", inner_x());
echo("inner_y()          =", inner_y());
echo("inner_z()          =", inner_z()); 
echo("outer_x()          =", outer_x()); 
echo("outer_y()          =", outer_y()); 
echo("outer_z()          =", outer_z()); 
echo("top_z()            =", top_z());
echo("bottom_z()         =", bottom_z());
echo("gthickness()       =", gthickness());


module _finished_enclosure(is_bottom) {
	difference() {
		union() {
			difference() {
				_enclosure();
				_cutouts(is_bottom);
			}
			attachments(is_bottom);
		}
		cutouts(is_bottom);
	}
}

module _enclosure() {
	difference() {
		softz_cube([outer_x(), outer_y(), outer_z()], cr=fillet_z()+twall_thickness());
		translate([wall_thickness(), wall_thickness(), bottom_thickness()]) {
			softz_cube([inner_x(), inner_y(), inner_z()], cr=fillet_z()+tolerance());
		}
	}
	_risers();
	_stand_offs();
}

module _cutouts(is_bottom) {
	_front_cutouts(is_bottom);
	_back_cutouts(is_bottom);
	_left_cutouts(is_bottom);
	_right_cutouts(is_bottom);
	_top_cutouts();
	_bottom_cutouts();
}

module _right_cutouts(is_bottom) {
	translate([0.001, 0, 0])
		right_face()
			linear_extrude(wall_thickness()+riser_thickness()+tolerance())
				right_cutouts(is_bottom);
}

module _left_cutouts(is_bottom) {
	translate([-0.001, 0, 0])
		left_face() 
			linear_extrude(wall_thickness()+riser_thickness()+tolerance()) 
				left_cutouts(is_bottom);
}

module _front_cutouts(is_bottom) {
	translate([0, -0.001, 0])
		front_face() 
			linear_extrude(wall_thickness()+riser_thickness()+tolerance()) 
				front_cutouts(is_bottom);
}

module _back_cutouts(is_bottom) {
	translate([0, 0.001, 0])
		back_face() 
			linear_extrude(wall_thickness()+riser_thickness()+tolerance())
				back_cutouts(is_bottom);
}

module _top_cutouts() {
	translate([0, 0, 0.001])
		top_face() 
			linear_extrude(wall_thickness()+tolerance())
				top_cutouts();
}

module _bottom_cutouts() {
	translate([0, 0, -0.001])
		bottom_face() 
			linear_extrude(wall_thickness()+triser_z()+tolerance()) 
				bottom_cutouts();
}

module _risers() {
	if (riser_z() > 0 && riser_thickness() > 0) {
		translate([wall_thickness(), wall_thickness(), 0]) {
			difference() {
				softz_cube([inner_x(), inner_y(), wall_thickness()+triser_z()], cr=fillet_z()+tolerance());
				translate([riser_thickness(), riser_thickness(), 0]) {
					cr2 = fillet_z()+tolerance() > riser_thickness() ? fillet_z()+tolerance()-riser_thickness() : 0;
					softz_cube([inner_x()-2*riser_thickness(), inner_y()-2*riser_thickness(), wall_thickness()+triser_z()+0.001], cr=cr2);
				}
			}
		}
	}
}

module _stand_offs() {
	translate([twall_thickness(), twall_thickness(), bottom_thickness()]) {
		stand_offs();
	}
}

module _top() {
	difference() {
		children();
		translate([-spacing(), -spacing(), 0])
			cube([outer_x()+2*spacing(), outer_y()+2*spacing(), bottom_z()-friction()]);
	}
}

module _bottom() {
	difference() {
		children();
		translate([-spacing(), -spacing(), bottom_z()]) {
			cube([outer_x()+2*spacing(), outer_y()+2*spacing(), top_z()+1]);
		}
	}
}

module _male() {
	difference() {
		children();
		translate([-spacing(), -spacing(), bottom_z()-friction()-0.0001]) {
			difference() {
				cube([outer_x()+2*spacing(), outer_y()+2*spacing(), friction()+0.0001]);
				translate([spacing()+gthickness()+tolerance(), spacing()+gthickness()+tolerance(), 0]) {
					softz_cube([inner_x()+2*gthickness(), inner_y()+2*gthickness(), friction()+0.0002], cr=fillet_z()+gthickness());
				}
			}
		}
	}
}

module _female() {
	difference() {
		children();
		translate([gthickness(), gthickness(), bottom_z()-friction()]) {
			softz_cube([outer_x()-2*gthickness(), outer_y()-2*gthickness(), friction()+0.001], cr=fillet_z()+gthickness()+tolerance());
		}
	}
}

module enclosure(x=0, y=0, z=0) {
	translate([x, y, z]) {
		enclosure_bottom();
		translate([0, outer_y() + spacing(), 0]) {
			enclosure_top();
		}
	}
}

module enclosure_top(x=0, y=0, z=0) {
	translate([x, y, z]) {
		translate([0, outer_y(), outer_z()]) {
			rotate([180, 0, 0]) {
				_male() {
					_top() {
						_finished_enclosure(false);
					}
				}
				final_attachments(false);
			}
		}
	}
}

module enclosure_bottom(x=0, y=0, z=0) {
	translate([x, y, z]) {
		_female() {
			_bottom() {
				_finished_enclosure(true);
			}
		}
		final_attachments(true);
	}
}

module finished_enclosure() {
	intersection() {
		_finished_enclosure(false);
		_finished_enclosure(true);
	}
	final_attachments(false);
	final_attachments(true);
}

module right_face() {
	translate([outer_x(), twall_thickness(), bottom_thickness()+triser_z()])
		rotate([-90, 0, 0])
			rotate([0, -90, 0])
				mirror([0, 1, 0])
					children();
}

module left_face() {
	translate([0, outer_y()-twall_thickness(), bottom_thickness()+triser_z()])
		rotate([0, 0, -90])
			rotate([-90, 0, 0])
				mirror([0, 1, 0])
					children();
}

module front_face() {
	translate([twall_thickness(), 0, bottom_thickness()+triser_z()])
		mirror([0, 0, 1])
			rotate([-90, 0, 0])
				children();
}

module back_face() {
	translate([outer_x()-twall_thickness(), outer_y(), bottom_thickness()+triser_z()])
		mirror([0, 1, 0])
			rotate([90, 0, 180])
				children();
}

module top_face() {
	translate([twall_thickness(), twall_thickness(), outer_z()])
		mirror([0, 0, 1])
			children();
}

module bottom_face() {
	translate([twall_thickness(), twall_thickness(), 0])
		children();
}

module stand_off(pos, outer_r, inner_r=0) {
	spacer(pos, outer_r, inner_r, triser_z());
}

module post(pos, outer_r, inner_r=0) {
	spacer(pos, outer_r, inner_r, triser_z());
	spacer(pos, inner_r, 0, triser_z()+pcb_z());
}

module stand_on(pos, outer_r, inner_r=0) {
	top_face() {
		translate([0, 0, top_thickness()])
		spacer(pos, outer_r, inner_r, inner_z()-triser_z()-pcb_z());
	}
}

module square_cutout(pos, size, center=true) {
	if (center == true) {
		translate([pos[0]-size[0]/2-tolerance(), pos[1]-size[1]/2-tolerance(), 0]) 
			square([size[0]+2*tolerance(), size[1]+2*tolerance()]);
	} else {
		translate([pos[0]-tolerance(), pos[1]-tolerance(), 0]) 
			square([size[0]+2*tolerance(), size[1]+2*tolerance()]);
	}
}

module circle_cutout(pos, size) {
	translate([pos[0], pos[1], 0]) circle(size+tolerance());
}

module rubber_band_x(w, t, y) {
	translate([                0, y, outer_z()-t-0.001]) cube([outer_x(), w, t+0.002]);
	translate([                0, y,            -0.001]) cube([outer_x(), w, t+0.002]);
	translate([           -0.001, y,                 0]) cube([t+0.002,   w, outer_z()]);
	translate([outer_x()-t-0.001, y,                 0]) cube([t+0.002,   w, outer_z()]);
}

module rubber_band_y(w, t, x) {
	translate([x, 0,                 outer_z()-t-0.001]) cube([w, outer_y(), t+0.002]);
	translate([x, 0,                 -0.001])            cube([w, outer_y(), t+0.002]);
	translate([x, -0.001,            0])                 cube([w, t+0.002,   outer_z()]);
	translate([x, outer_y()-t-0.001, 0])                 cube([w, t+0.002,   outer_z()]);
}

module vent(pos, size, width) {
	n = floor(size[1]/4/width);
	square_cutout(pos, [size[0], width]);

	for ( i = [1 : n] ) {
		square_cutout([pos[0], pos[1]-2*i*width], [size[0], width]);
		square_cutout([pos[0], pos[1]+2*i*width], [size[0], width]);
	}
}
