/*
Raspberry Pi Model B Enclosure Library

Board: 85 x 56 x 1.5
Right:
	RJ45: 15.9 x 13.6 @ 2, 1.5
	USB: 13.3 x 15.4 @ 23.9, 1.5
Left:
	SD Card Slot:  27.8 x 4, @ 11.5, -4
	Micro USB: 8.1 x 3.2 @ 42.7 , 1.5
Front:
	HDMI: 15.1 x 6.2 @ 37.5, 1.5
Back:
	Audio Jack: 6.6 @ 20, 8.5
	Composite Video: 8.4 @ 38, 7
*/


include <lib_enclosure.scad>

// variables
function tolerance()        = 0.8;
function device_x()         = 85;
function device_y()         = 56;
function pcb_z()            = 1.5;
function fillet_z()         = 0;
function spacing()          = 10.0;
function riser_z()          = 4.0;
function riser_thickness()  = 0;
function wall_thickness()   = 2.4;
function bottom_thickness() = 1;
function top_thickness()    = 1;
function device_z()         = pcb_z() + 15.4; // The thickness of the pcb + height of the tallest component (USB Port)
function friction()         = wall_thickness();
function split()            = 0.55;

module right_cutouts(is_bottom) {
	square_cutout([2.0+15.9/2, pcb_z()+13.6/2], [15.9, 13.6]); // rj45 (15.9x13 @ 2x1.4)
	square_cutout([23.9+13.3/2, pcb_z()+15.4/2], [13.3, 15.4]); // usb

	extra_right_cutouts(is_bottom);
}

module left_cutouts(is_bottom) {
	square_cutout([13.5+25.3/2,  -4/2], [25.3, 4]);   // sd card
	square_cutout([44.7+8.1/2, pcb_z()+3.2/2], [8.1, 3.2]); // power

	extra_left_cutouts(is_bottom);
}

module front_cutouts(is_bottom) {
	square_cutout([36.8+15.1/2, pcb_z()+5.9/2], [15.1, 5.9]); // hdmi

	extra_front_cutouts(is_bottom);
}

module back_cutouts(is_bottom) {
	circle_cutout([20, pcb_z()+7.5], 6.6/2); // audio
	circle_cutout([39, pcb_z()+9], 8.4/2); // video

	if (!is_bottom) {
		square_cutout([20, pcb_z()+7.5-6.6/2], [6.6, 6.6]); // audio
		square_cutout([39, pcb_z()+9-8.4/2], [8.4, 8.4]); // video
	}

	extra_back_cutouts(is_bottom);
}

module top_cutouts() {
	extra_top_cutouts();
}

module bottom_cutouts() {
	extra_bottom_cutouts();
}

module cutouts(is_bottom) {
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
