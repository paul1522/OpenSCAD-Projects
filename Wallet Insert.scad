use <lib_boxes5.scad>
//$fn = 30;

wall_thickness = 1;
card_width = 89; // business cards are 89 mm wide
card_height = 54; // credit cards are 54 mm high
size = 15;
exposure = 10;
tolerance = 0.40;

box_x = 2*wall_thickness+2*tolerance+card_width;
box_y = 2*wall_thickness+2*tolerance+size;
box_z = wall_thickness+tolerance+card_height-exposure;

difference() {
	open_box(box_x, box_y, box_z, 0, wall_thickness);
	translate([box_x/2, box_y/2+0.001, box_z/2]) {
		rotate([90, 0, 0]) {
			hull() {
				cylinder(box_y/2+0.001, card_width/6, card_width/6);
				translate([0, box_z, 0]) {
					cylinder(box_y/2+0.001, card_width/6, card_width/6);
				}
			}
		}
	}
}

translate([(box_x-card_width)/2, box_y+1.6, 0]) {
	cube([card_width, 1.2, box_z]);
}

translate([(box_x-card_width)/2, box_y, box_z-5]) {
	cube([card_width, 1.6, 5]);
}
