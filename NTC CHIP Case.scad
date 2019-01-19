include <lib_enclosure4.scad>



function fillet_z()         = 0;
function device_x()         = 61; // without the official case;
function device_y()         = 41.5;
function device_z()         = 10.5;
function pcb_z()            = 1.75;

function wall_thickness()   = 2;
function bottom_thickness() = 1;
function top_thickness()    = 1;
function tolerance()        = 0.2;
function friction()         = 3;
function spacing()          = 10;
function split()            = 0.58;
function riser_z()          = 1.75;
function riser_thickness()  = 0;

usbotg    = [ [   4, pcb_z()+3.2/2],     [8, 3.2]    ];
headphone = [ [14.5, pcb_z()+4.5/4+1], 4.5/2       ];
usb       = [ [  27, pcb_z()+7.1/2+1],   [14.5, 7.1] ];



enclosure();

module right_cutouts(is_bottom) {
        square_cutout(usbotg[0], usbotg[1]);
        circle_cutout(headphone[0], headphone[1]);
        square_cutout(usb[0], usb[1]);
}

module left_cutouts(is_bottom) {
}

module front_cutouts(is_bottom) {
}

module back_cutouts(is_bottom) {
}

module top_cutouts() {
}

module bottom_cutouts() {
}

module cutouts(is_bottom) {
    //rubber_band_grooves();
    //engraving();
	//rubber_feet(3.5);
}

module attachments(is_bottom) {
}

module stand_offs(){
}

module final_attachments(is_bottom) {
}

module engraving() {
	top_face() {
		translate([inner_x()/2, outer_y()/2, 0]) {
			linear_extrude(0.4) {
				rotate([0, 0, 0]) {
					text(text="OCTOCHIP", halign="center", valign="center", size=6);
                }
            }
        }
    }
}

module rubber_band_grooves() {
	rubber_band_y(3.0, 0.4,             5.0);
	rubber_band_y(3.0, 0.4, outer_x()-3.0-5.0);
}

module rubber_feet(radius) {
	bottom_face() {
		translate([        10,         10, 0]) cylinder(h=0.95, r=radius);
		translate([        10, inner_y()-10, 0]) cylinder(h=0.95, r=radius);
		translate([inner_x()-10,         10, 0]) cylinder(h=0.95, r=radius);
		translate([inner_x()-10, inner_y()-10, 0]) cylinder(h=0.95, r=radius);
	}
}

module stand_offs() {
	stand_off([ 58,  3], 3, 0);
	stand_off([ 58,  37.5], 3, 0);
	stand_off([3.5,  27], 3, 0);
	//stand_off([ 3.5, 52.5], 3.2, 1.6);
	//stand_off([61.5, 52.5], 3.2, 1.6);
}
