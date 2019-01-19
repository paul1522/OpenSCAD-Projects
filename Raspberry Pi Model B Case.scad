// example raspberry pi model b

include <lib_raspi_b_enclosure.scad>

enclosure();

module extra_cutouts() {
	rubber_band_grooves();
	feet(4.0);
}

module extra_back_cutouts() {
	led_window();
}

module rubber_band_grooves() {
	rubber_band_y(2, 0.5,               15.0);
	rubber_band_y(2, 0.5, outer_x()-3.2-15.0);
}

module attachments() {
	back_face() {
		// Translucent layer over the led window
		translate([0, 0, 0]) cube([14.00, 4, 0.5]);
	}
	// SD Card guard
	translate([-10.0, 56.0+2*twall_thickness()-27.8-twall_thickness()-11.5, 0]) softz_cube([10.0+3.2, 27.8, bottom_thickness()], cr=3.2);
}

module final_attachments(is_bottom) {
	if (!is_bottom) {
		stand_ons();
	}
}
