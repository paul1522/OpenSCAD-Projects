/// 76.2 x 11.1   Moto X Pure
/// 78.4 x 12.1   Moto X Pure with Cover
/// 155 x 9 Nexus 9

// Device Width
device_width = 155+1.0; // [1:200]

// Device Thickness
device_thickness = 9+0.5; // [1:50]

// Device Corner Radius
device_corner_radius = 3; // [0:10]

// Visor Thickness
visor_thickness = 30; // [1:50]

// Visor Height
visor_height = 190; // [1:300]

// Visor Corner Radius
visor_corner_radius = 14; // [0:10]

// Thickness
thickness = 5; // [1:10]

//$fn = 16;

include <lib_soft.scad>



// Visor
difference() {
	softz_cube([visor_height+2*thickness, visor_thickness+2*thickness, thickness], cr=visor_corner_radius+thickness);
	translate([thickness, thickness, 0]) {
		softz_cube([visor_height, visor_thickness, thickness], cr=visor_corner_radius);
	}
}


// Device
translate([0, thickness+visor_thickness, 0]) {
	difference() {
		softz_cube([device_width+2*thickness, device_thickness+2*thickness, thickness], cr=device_corner_radius+thickness);
		translate([thickness, thickness, 0]) {
			softz_cube([device_width, device_thickness, thickness], cr=device_corner_radius);
		}
		translate([thickness+device_corner_radius, thickness, 0]) {
			cube([device_width-2*device_corner_radius, device_thickness+thickness, thickness]);
		}
	}
}
