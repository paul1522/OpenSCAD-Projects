// example raspberry pi model b

include <lib_raspi_b_enclosure.scad>

// variables
$fn=30;
function wall_thickness() = 2.0;
function bottom_thickness() = 1;
function top_thickness() = 1;
function device_z()       = pcb_z()+16.3;
function friction()       = 4.0;
function split()          = wall_thickness()+triser_z()+pcb_z()+6.2;

enclosure();

module extra_cutouts() {
	//rubber_band_grooves();
	//feet(4.0);
	//grids(5);
}

module rubber_band_grooves() {
	rubber_band_y(3.2, 0.8,               15.0);
	rubber_band_y(3.2, 0.8, outer_x()-3.2-15.0);
}

/*
module attachments() {
	back_face() {
		// Translucent layer over the led window
		translate([1.0-0.5, pcb_z()-0.5, 0]) cube([12.00, 2.6, 0.4]);
	}
	// SD Card guard
	translate([-10.0, 56.0+2*twall_thickness()-27.8-twall_thickness()-11.5, 0]) softz_cube([10.0+3.2, 27.8, wall_thickness()], cr=3.2);
}
*/

module final_attachments(is_bottom) {
	if (!is_bottom) {
		//stand_ons();
	}
}
