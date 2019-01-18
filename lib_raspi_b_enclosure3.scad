// example raspberry pi model b

include <lib_enclosure3.scad>

// variables
function fillet_z()        = 0;
function tolerance()       = 0.4;
function device_x()        = 85.0;
function device_y()        = 56.0;
function pcb_z()           = 1.6;
function spacing()         = 10.00;
function riser_z()         = 5.0;
function riser_thickness() = 1.2;

module right_cutouts(is_bottom) {
	square_cutout([2.0+15.4/2,       pcb_z()+13.5/2], [15.4+2, 13.5+2]); // rj45
	square_cutout([56.0-18.8-13.3/2, pcb_z()+16.3/2], [13.3+2, 16.3+2]); // usb

	x_right_cutouts(is_bottom);
}

module left_cutouts(is_bottom) {
	square_cutout([11.5+28.3/2,    -5.0/2],        [28.3,     5.0]);   // sd card
	square_cutout([56.0-3.6-7.6/2, pcb_z()+2.4/2], [ 7.6+2,   2.4+2]); // power

	x_left_cutouts(is_bottom);
}

module front_cutouts(is_bottom) {
	square_cutout([37.5+15.1/2, pcb_z()+6.2/2], [15.1, 6.2]); // hdmi

	if (is_bottom) {
		square_cutout([37.5+15.1/2, pcb_z()+device_z()/2], [15.1, device_z()]); // hdmi
	} else {
	}

	x_front_cutouts(is_bottom);
}

module back_cutouts(is_bottom) {
	square_cutout([ 1.0+12.0/2,         pcb_z()+1.6/2],         [12.00, 1.6]); // leds
	circle_cutout([14.0+12.0/2,         pcb_z()+3.0+6.7/2+0.5], 6.7/2+1); // audio 
	circle_cutout([85.0-40.6-9.8/2-1.0, pcb_z()+4.0+8.3/2],     8.3/2+1); // video
	//circle_cutout([85.0-40.6-9.8/2-1.0, pcb_z()+6.5],       8.3/2+1); // video (is this for the older b?)
	//translate([50.80,          4], [33.20,          20.00]); // gpio header
	//translate([46.00,          4], [            50.00,          20.00]); // gpio ribbon
	//translate([50.80,          4], [ 33.2, 10]); // little gpio ribbon
	
	if (is_bottom) {
		square_cutout([14.0+12.0/2,         pcb_z()+3.0+6.7/2+device_z()/2+0.5], [6.7+2, device_z()]); // audio
		square_cutout([85.0-40.6-9.8/2-1.0, pcb_z()+4.0+8.3/2+device_z()/2],     [8.3+2, device_z()]); // video
		//square_cutout([85.0-40.6-9.8/2-1.0, pcb_z()+6.5-8.3/2], [8.3+2, 8.3+2]); // video (is this for the older b?)
	} else {
		square_cutout([14.0+12.0/2,         pcb_z()+3.0+6.7/2+0.5-device_z()/2], [6.7+2, device_z()]); // audio
		square_cutout([85.0-40.6-9.8/2-1.0, pcb_z()+4.0+8.3/2-device_z()/2],     [8.3+2, device_z()]); // video
		//square_cutout([85.0-40.6-9.8/2-1.0, pcb_z()+6.5-8.3/2], [8.3+2, 8.3+2]); // video (is this for the older b?)
	}

	x_back_cutouts(is_bottom);
}

module top_cutouts() {
	//translate([                        19.00,           71.00], [              18.00,             1.50]); // dsi
	//translate([                         2.00,           25.00], [              18.00,             1.50]); // csi
	//translate([                  2,    -1], [   15.4, 21.2]); // rj45 (for super short enclosures)
	//square_cutout([device_y-18.8-13.25,  -7.7], [  13.25, 17.2]); // usb (for super short enclosures)
	//translate([      device_y-11.4,    14], [ 11.4+4,   12]); // audio (for super short enclosures)
	//translate([    device_y-2.1-10,    34], [ 10+2.1,   10]); // video (for super short enclosures)
	//translate([              49.00, 50.80], [5.5+1.5, 33.2]); // gpio header
	//translate([              49.00, 46.00], [5.5+1.5,               50]); // gpio ribbon

	x_top_cutouts();
}

module bottom_cutouts() {
	x_bottom_cutouts();
}

module cutouts(is_bottom) {
	// Cut away the riser adjacent to the SD card bracket.
	translate([wall_thickness(), wall_thickness()+riser_thickness(), wall_thickness()])
	    cube([riser_thickness()+0.0001, inner_y()-2*riser_thickness(), triser_z()+0.001]);

	x_cutouts(is_bottom);
}

module feet(pos) {
	bottom_face() {
		translate([pos,            pos, 0])            cylinder(h=0.8, r=3.6);
		translate([pos,            device_y()-pos, 0]) cylinder(h=0.8, r=3.6);
		translate([device_x()-pos, pos, 0])            cylinder(h=0.8, r=3.6);
		translate([device_x()-pos, device_y()-pos, 0]) cylinder(h=0.8, r=3.6);
	}
}

module grids(size) {
	left_face()   grid(size);
	right_face()  grid(size);
	front_face()  grid(size);
	back_face()   grid(size);
	top_face()    grid(size);
	bottom_face() grid(size);
}

module stand_offs() {
	stand_off([25.5,            18.0],             3.2, 1.6);
	stand_off([device_x()-4.90, device_y()-12.60], 3.2, 1.6);
}

module stand_ons() {
	stand_on([25.5,            18.0],             3.2, 1.6);
	stand_on([device_x()-4.90, device_y()-12.60], 3.2, 1.6);
}

module attachments() {}
module final_attachments() {}

module x_front_cutouts(){}
module x_back_cutouts(){}
module x_left_cutouts(){}
module x_right_cutouts(){}
module x_top_cutouts(){}
module x_bottom_cutouts(){}
module x_cutouts(){}
