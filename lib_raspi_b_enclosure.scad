// Raspberry Pi Model B Enclosure Library

/*
Board: 85 x 54 x 1.5
Right:
	RJ45: 15.9 x 13.6 @ 2, 1.5
	USB: 13.3 x 15.4 @ 20, 1.5
Left:
	SD Card Slot:  28.3 x 4, @ 12, -4
	Micro USB: 8.1 x 3.2 @ 42.7 , 1.5
Front:
	HDMI: 15.1 x 5.9 @ 36.8, 1.5
Back:
	Audio Jack: 6.6 @ 20.6, 8.5
	Composite Video: 8.4 @ 38, 7
*/


include <lib_enclosure.scad>

// variables
function fillet_z()         = 0;
function tolerance()        = 0.25;
function device_x()         = 85.6;
function device_y()         = 54.0;
function pcb_z()            = 1.4;
function spacing()          = 10.0;
function riser_z()          = 4.0;
function riser_thickness()  = 1.2;
function wall_thickness()   = 2;
function bottom_thickness() = 1;
function top_thickness()    = 1;
function device_z()         = pcb_z() + 15.3;
function friction()         = wall_thickness();
function split()            = outer_z() / 2;

module right_cutouts(is_bottom) {
	square_cutout([2.0+15.9/2,       pcb_z()+13.6/2], [15.9, 13.6]); // rj45 (15.9x13 @ 2x1.4)
	square_cutout([20+13.3/2, pcb_z()+15.4/2], [13.3, 15.4]); // usb

	extra_right_cutouts(is_bottom);
}

module left_cutouts(is_bottom) {
	square_cutout([12+28.3/2,  -4/2],        [28.3,     4]);   // sd card
	square_cutout([42.7+8.1/2, pcb_z()+3.2/2], [8.1,   3.2]); // power

	extra_left_cutouts(is_bottom);
}

module front_cutouts(is_bottom) {
	square_cutout([36.8+15.1/2, pcb_z()+5.9/2], [15.1, 5.9]); // hdmi

	if (is_bottom) {
		square_cutout([36.8+15.1/2, pcb_z()+device_z()/2], [15.1, device_z()]); // hdmi
	}

	extra_front_cutouts(is_bottom);
}

module back_cutouts(is_bottom) {
	circle_cutout([20.6, pcb_z()+8.5], 6.6/2); // audio
	circle_cutout([38, pcb_z()+7],     8.4/2); // video
	//circle_cutout([85.0-40.6-9.8/2-1.0, pcb_z()+6.5],       8.3/2+1); // video (is this for the older b?)
	//translate([50.80,          4], [33.20,          20.00]); // gpio header
	//translate([46.00,          4], [            50.00,          20.00]); // gpio ribbon
	//translate([50.80,          4], [ 33.2, 10]); // little gpio ribbon

	if (is_bottom) {
		//square_cutout([14.0+12.0/2,         pcb_z()+3.0+6.7/2+device_z()/2+0.5], [6.7+2, device_z()]); // audio
		//square_cutout([85.0-40.6-9.8/2-1.0, pcb_z()+4.0+8.3/2+device_z()/2],     [8.3+2, device_z()]); // video
		//square_cutout([85.0-40.6-9.8/2-1.0, pcb_z()+6.5-8.3/2], [8.3+2, 8.3+2]); // video (is this for the older b?)
	} else {
		//square_cutout([14.0+12.0/2,         pcb_z()+3.0+6.7/2+0.5-device_z()/2], [6.7+2, device_z()]); // audio
		//square_cutout([85.0-40.6-9.8/2-1.0, pcb_z()+4.0+8.3/2-device_z()/2],     [8.3+2, device_z()]); // video
		//square_cutout([85.0-40.6-9.8/2-1.0, pcb_z()+6.5-8.3/2], [8.3+2, 8.3+2]); // video (is this for the older b?)
	}

	extra_back_cutouts(is_bottom);
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

	extra_top_cutouts();
}

module bottom_cutouts() {
	extra_bottom_cutouts();
}

module cutouts(is_bottom) {
	// Cut away the riser adjacent to the SD card bracket.
	translate([wall_thickness(), wall_thickness()+riser_thickness(), bottom_thickness()])
	    cube([riser_thickness()+0.0001, inner_y()-2*riser_thickness(), triser_z()+0.001]);

	extra_cutouts(is_bottom);
}

module feet(pos) {
	bottom_face() {
		translate([pos,            pos, 0])            cylinder(h=0.8, r=3.6);
		translate([pos,            device_y()-pos, 0]) cylinder(h=0.8, r=3.6);
		translate([device_x()-pos, pos, 0])            cylinder(h=0.8, r=3.6);
		translate([device_x()-pos, device_y()-pos, 0]) cylinder(h=0.8, r=3.6);
	}
}

module stand_offs() {
	stand_off([25.5,            18.0],             3.2, 1.6);
	stand_off([device_x()-4.90, device_y()-12.60], 3.2, 1.6);
}

module stand_ons() {
	stand_on([25.5,            18.0],             3.2, 1.6);
	stand_on([device_x()-4.90, device_y()-12.60], 3.2, 1.6);
}

module led_window() {
	square_cutout([ 1.0+12.0/2,         pcb_z()+1.6/2],         [12.00, 1.6]);
}

module attachments() {}
module final_attachments() {}

module extra_front_cutouts(){}
module extra_back_cutouts(){}
module extra_left_cutouts(){}
module extra_right_cutouts(){}
module extra_top_cutouts(){}
module extra_bottom_cutouts(){}
module extra_cutouts(){}
