// Raspberry Pi Model B+ / 2B

// Variables
$fn = 30;
fillet_z = 3.0;
wall_thickness = 2.0;
tolerance = 0.4; 
device_x = 85.0;
device_y = 56.0;
pcb_z = 1.5;
device_z = 15.8+pcb_z;
//device_z = 11.0+pcb_z;
friction = wall_thickness;
spacing = 10.0;
riser_z = 2.4;
riser_thickness = 0;
split = 0.50;

include <lib_enclosure3.scad>

// Right Side
rj45 = [[10.3, pcb_z+(13.5/2)], [16.0, 13.5], 21.5-2.0];
usb1 = [[29.0, pcb_z+(15.8/2)], [15.2, 15.8], 17.1-2.0];
usb2 = [[47.0, pcb_z+(15.8/2)], [15.2, 15.8], 17.1-2.0];

// Left Side
leds   = [[ 9.6,                       pcb_z], [ 6.8,                      1.5]];
sdcard = [[28.0, (wall_thickness+riser_z)/-2], [13.0, twall_thickness+triser_z]];

// Front Side
power = [[10.6, pcb_z-0.5+(3.6)/2], [8.0, 3.6]];
hdmi  = [[32.0, pcb_z+1.0+(5.6)/2], [15.0, 5.6]];
av    = [[53.5, pcb_z+3.0], 3.0];

// Top Side
dsi   = [[ 3.5, 28.0], [ 0.8, 17.0]];
csi   = [[45.0, 11.5], [ 0.8, 17.0]];
gpio  = [[32.5, 52.5], [58.0,  7.0]];

enclosure();

module right_cutouts() {
	square_cutout(rj45[0], rj45[1]); // rj45
	square_cutout(usb1[0], usb1[1]); // usb-1
	square_cutout(usb2[0], usb2[1]); // usb-2
}

module left_cutouts() {
	square_cutout(leds[0],   leds[1]); // pwr & act leds
	square_cutout(sdcard[0], sdcard[1]); // micro sd card
}

module front_cutouts(is_bottom) {
	square_cutout(power[0], power[1]); // power
	square_cutout(hdmi[0],  hdmi[1]); // hdmi
	circle_cutout(av[0],    av[1]); // a/v

	if (!is_bottom) {
		square_cutout([av[0][0], av[0][1]-av[1]], [av[1]*2, av[1]*2]); // fixup a/v 
	}
}

module back_cutouts() {
	//square_cutout([device_x-gpio[0][0], (device_z+twall_thickness)/2], [gpio[1][0], device_z+twall_thickness]); // gpio
}

module top_cutouts() {
	//square_cutout(dsi[0],  dsi[1]); //dsi
	//square_cutout(csi[0],  dsi[1]); //csi
	//square_cutout(gpio[0], gpio[1]); //gpio
    
    //square_cutout([device_x-rj45[2]/2, rj45[0][0]], [rj45[2], rj45[1][0]]); // rj45 (for short enclosures)
    //square_cutout([device_x-usb1[2]/2, usb1[0][0]], [usb1[2], usb1[1][0]]); // usb-1 (for short enclosures)
    //square_cutout([device_x-usb2[2]/2, usb2[0][0]], [usb2[2], usb2[1][0]]); // usb-2 (for short enclosures)
}

module bottom_cutouts() {
	//vents([device_x/2, device_y/2], [device_x-15, device_y-15], 3.5);
}

module cutouts() {
	//rubber_band_grooves();
	//rubber_feet(3.5);
	//flat_head_screws(1.6+wall_thickness);
	pan_head_screws(3.2);
	//nuts(3.2);
	//engraving();
	//port_labels();
}

module rubber_band_grooves() {
	//rubber_band_y(3.0, 0.8,             3.0);
	//rubber_band_y(3.0, 0.8, outer_x-3.0-3.0);
	rubber_band_y(3.0, 0.8,             20.0);
	rubber_band_y(3.0, 0.8, outer_x-20.0-3.0);
	//rubber_band_y(3.0, 0.8, outer_x-25.0-3.0); // for short enclosures
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
		translate([ 3.5,  3.5, 0]) cylinder(h=wall_thickness, r1=radius, r2=radius-wall_thickness);
		translate([61.5,  3.5, 0]) cylinder(h=wall_thickness, r1=radius, r2=radius-wall_thickness);
		translate([ 3.5, 52.5, 0]) cylinder(h=wall_thickness, r1=radius, r2=radius-wall_thickness);
		translate([61.5, 52.5, 0]) cylinder(h=wall_thickness, r1=radius, r2=radius-wall_thickness);
	}
}

module pan_head_screws(radius) {
	bottom_face() {
		translate([ 3.5,  3.5, 0]) cylinder(h=wall_thickness/2, r=radius);
		translate([61.5,  3.5, 0]) cylinder(h=wall_thickness/2, r=radius);
		translate([ 3.5, 52.5, 0]) cylinder(h=wall_thickness/2, r=radius);
		translate([61.5, 52.5, 0]) cylinder(h=wall_thickness/2, r=radius);
		translate([ 3.5,  3.5, 0]) cylinder(h=wall_thickness, r=1.6);
		translate([61.5,  3.5, 0]) cylinder(h=wall_thickness, r=1.6);
		translate([ 3.5, 52.5, 0]) cylinder(h=wall_thickness, r=1.6);
		translate([61.5, 52.5, 0]) cylinder(h=wall_thickness, r=1.6);
	}
}

module nuts(radius) {
	bottom_face() {
		translate([ 3.5,  3.5, 0]) cylinder(h=wall_thickness/2, r=radius, $fn=6);
		translate([61.5,  3.5, 0]) cylinder(h=wall_thickness/2, r=radius, $fn=6);
		translate([ 3.5, 52.5, 0]) cylinder(h=wall_thickness/2, r=radius, $fn=6);
		translate([61.5, 52.5, 0]) cylinder(h=wall_thickness/2, r=radius, $fn=6);
		translate([ 3.5,  3.5, 0]) cylinder(h=wall_thickness, r=1.6);
		translate([61.5,  3.5, 0]) cylinder(h=wall_thickness, r=1.6);
		translate([ 3.5, 52.5, 0]) cylinder(h=wall_thickness, r=1.6);
		translate([61.5, 52.5, 0]) cylinder(h=wall_thickness, r=1.6);
	}
}

module engraving() {
	top_face() 
		translate([inner_x/2, outer_y/2, 0]) 
			linear_extrude(0.4) 
				rotate([0, 0, 32])
					text(text="valar morghulis", halign="center", valign="center");
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
	stand_off([ 3.5, 52.5], 3.2, 1.6);
	stand_off([61.5, 52.5], 3.2, 1.6);
}

module port_labels() {
	front_face() {
		translate([power[0][0], -riser_z, 0]) 
			linear_extrude(0.8) 
				text(text="PWR", halign="center", valign="bottom", size=2.5);
		translate([hdmi[0][0], -riser_z, 0]) 
			linear_extrude(0.8) 
				text(text="HDMI", halign="center", valign="bottom", size=2.5);
		translate([av[0][0], -riser_z, 0]) 
			linear_extrude(0.8) 
				text(text="A/V", halign="center", valign="bottom", size=2.5);
	}	
	right_face() {
		translate([rj45[0][0], -riser_z, 0]) 
			linear_extrude(0.8) 
				text(text="NET", halign="center", valign="bottom", size=2.5);
		translate([usb1[0][0], -riser_z, 0]) 
			linear_extrude(0.8) 
				text(text="USB", halign="center", valign="bottom", size=2.5);
		translate([usb2[0][0], -riser_z, 0]) 
			linear_extrude(0.8) 
				text(text="USB", halign="center", valign="bottom", size=2.5);
	}	
	bottom_face() {
		translate([2*wall_thickness, sdcard[0][0], 0]) 
			linear_extrude(0.4) 
                rotate([0, 180, 90])
                    text(text="SD CARD", halign="center", valign="bottom", size=2.5);
	}	
}

module final_attachments(is_bottom) {
	if (!is_bottom) {
		stand_on([ 3.5,  3.5], 3.2, 1.6);
		stand_on([61.5,  3.5], 3.2, 1.6);
		stand_on([ 3.5, 52.5], 3.2, 1.6);
		stand_on([61.5, 52.5], 3.2, 1.6);
	}
}
