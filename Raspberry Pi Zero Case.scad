// Raspberry Pi Zero and Zero W

include <lib_enclosure3.scad>

// Variables
//$fn=30;
function fillet_z() = 3.0;
function wall_thickness() = 2.0;
function tolerance() = 0.6; 
function device_x() = 65.0;
function device_y() = 30.0;
function pcb_z() = 1.5;
function device_z() = 7;// 10.4;
function friction() = wall_thickness();
function spacing() = 10.0;
function riser_z() = 1;
function riser_thickness() = 0;
function split() = wall_thickness()+triser_z()+pcb_z()+3.0;



// Right Side
csi   = [
  [device_y()/2, pcb_z()], 
  [17.0, 1]
];

// Left Side
sdcard = [
  [30-16.9, pcb_z()+1.5], 
  [13.0, 3]
];

// Front Side
hdmi  = [
  [12.4, pcb_z()+(3.3)/2], 
  [15.0, 3.3]
];
usb = [
  [41.4, pcb_z()-0.5+(3.6)/2], 
  [8.0, 3.6]
];
power = [
  [54, pcb_z()-0.5+(3.6)/2], 
  [8.0, 3.6]
];



enclosure();

module right_cutouts() {
	square_cutout(csi[0], csi[1]); // camera
}

module left_cutouts() {
	//square_cutout(leds[0],   leds[1]); // pwr & act leds
	square_cutout(sdcard[0], sdcard[1]); // micro sd card
}

module front_cutouts(is_bottom) {
	square_cutout(hdmi[0],  hdmi[1]); // hdmi
    square_cutout(usb[0],  usb[1]); // usb1
    square_cutout(power[0],  power[1]); // usb2
}

module back_cutouts() {
}

module top_cutouts() {
}

module bottom_cutouts() {
	//vent([device_x()/2, device_y()/2], [device_x()-15, device_y()-15], 3.5);
}

module cutouts() {
	rubber_band_grooves();
	//rubber_feet(3.5);
	//flat_head_screws(1.6+wall_thickness());
	//pan_head_screws(3.2);
	//nuts(3.2);
	engraving();
	//port_labels();
}

module rubber_band_grooves() {
	rubber_band_y(3.0, 0.8, 30);
}

module rubber_feet(radius) {
	bottom_face() {
		translate([        10,         10, 0]) cylinder(h=0.8, r=radius);
		translate([        10, inner_y-10, 0]) cylinder(h=0.8, r=radius);
		translate([inner_x-10,         10, 0]) cylinder(h=0.8, r=radius);
		translate([inner_x-10, inner_y-10, 0]) cylinder(h=0.8, r=radius);
	}
}

module flat_head_screws(radius) {
	bottom_face() {
		translate([ 3.5,  3.5, 0]) cylinder(h=wall_thickness(), r1=radius, r2=radius-wall_thickness());
		translate([61.5,  3.5, 0]) cylinder(h=wall_thickness(), r1=radius, r2=radius-wall_thickness());
		translate([ 3.5, 26.5, 0]) cylinder(h=wall_thickness(), r1=radius, r2=radius-wall_thickness());
		translate([61.5, 26.5, 0]) cylinder(h=wall_thickness(), r1=radius, r2=radius-wall_thickness());
    }
}

module pan_head_screws(radius) {
	bottom_face() {
//		translate([ 3.5,  3.5, 0]) cylinder(h=wall_thickness()/2, r=radius);
//		translate([61.5,  3.5, 0]) cylinder(h=wall_thickness()/2, r=radius);
//		translate([ 3.5, 52.5, 0]) cylinder(h=wall_thickness()/2, r=radius);
//		translate([61.5, 52.5, 0]) cylinder(h=wall_thickness()/2, r=radius);
//		translate([ 3.5,  3.5, 0]) cylinder(h=wall_thickness(), r=1.6);
//		translate([61.5,  3.5, 0]) cylinder(h=wall_thickness(), r=1.6);
//		translate([ 3.5, 52.5, 0]) cylinder(h=wall_thickness(), r=1.6);
//		translate([61.5, 52.5, 0]) cylinder(h=wall_thickness(), r=1.6);
	}
}

module nuts(radius) {
	bottom_face() {
//		translate([ 3.5,  3.5, 0]) cylinder(h=wall_thickness()/2, r=radius, $fn=6);
//		translate([61.5,  3.5, 0]) cylinder(h=wall_thickness()/2, r=radius, $fn=6);
//		translate([ 3.5, 52.5, 0]) cylinder(h=wall_thickness()/2, r=radius, $fn=6);
//		translate([61.5, 52.5, 0]) cylinder(h=wall_thickness()/2, r=radius, $fn=6);
//		translate([ 3.5,  3.5, 0]) cylinder(h=wall_thickness(), r=1.6);
//		translate([61.5,  3.5, 0]) cylinder(h=wall_thickness(), r=1.6);
//		translate([ 3.5, 52.5, 0]) cylinder(h=wall_thickness(), r=1.6);
//		translate([61.5, 52.5, 0]) cylinder(h=wall_thickness(), r=1.6);
	}
}

module engraving() {
	*top_face() 
		translate([inner_x()/2, outer_y()/2, 0]) 
			linear_extrude(1) 
				rotate([0, 0, 0])
					text(text="Pi Zero", halign="center", valign="center");
}

module attachments() {
	// Put a thin (hopefully translucent) layer over the pwr & act leds.
	*left_face() 
        translate([leds[0][0]-leds[1][0]/2-0.5, leds[0][1]-leds[1][1]/2-0.5, 0])
            cube([leds[1][0]+1.0, leds[1][1]+1.0, 0.5]);
}

module stand_offs() {
	stand_off([ 3.5,  3.5], 3.2, 1.6);
	stand_off([61.5,  3.5], 3.2, 1.6);
	stand_off([ 3.5, 26.5], 3.2, 1.6);
	stand_off([61.5, 26.5], 3.2, 1.6);
}

module port_labels() {
	front_face() {
		translate([power[0][0], -riser_z(), 0]) 
			linear_extrude(0.8) 
				text(text="PWR", halign="center", valign="bottom", size=2.5);
		translate([hdmi[0][0], -riser_z(), 0]) 
			linear_extrude(0.8) 
				text(text="HDMI", halign="center", valign="bottom", size=2.5);
		translate([av[0][0], -riser_z(), 0]) 
			linear_extrude(0.8) 
				text(text="A/V", halign="center", valign="bottom", size=2.5);
	}	
	right_face() {
		translate([usb[0][0], -riser_z(), 0]) 
			linear_extrude(0.8) 
				text(text="USB", halign="center", valign="bottom", size=2.5);
	}
	bottom_face() {
		translate([2*wall_thickness(), sdcard[0][0], 0]) 
			linear_extrude(0.4) 
                rotate([0, 180, 90])
                    text(text="SD CARD", halign="center", valign="bottom", size=2.5);
	}
}

module final_attachments(is_bottom) {
	*if (!is_bottom) {
		stand_on([ 3.5,  3.5], 3.2, 1.6);
		stand_on([61.5,  3.5], 3.2, 1.6);
		stand_on([ 3.5, 26.5], 3.2, 1.6);
		stand_on([61.5, 26.5], 3.2, 1.6);
    }
}
