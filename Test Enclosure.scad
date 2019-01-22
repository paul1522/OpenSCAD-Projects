// Test Enclosure

include <lib_enclosure.scad>

function fillet_z()         = 0;
function tolerance()        = 1;
function device_x()         = 50;
function device_y()         = 40;
function pcb_z()            = 1;
function spacing()          = 10;
function riser_z()          = 0;
function riser_thickness()  = 0;
function wall_thickness()   = 3;
function bottom_thickness() = 1;
function top_thickness()    = 1;
function device_z()         = 20;
function friction()         = 3;
function split()            = 0.5;

//finished_enclosure();
enclosure();

module left_cutouts() {
    //square_cutout([device_y()/2, device_z()/2], [device_z(), device_z()]);
    square_cutout([0, 0], [device_z(), device_z()], false, false);
}
module right_cutouts() {}
module front_cutouts() {
    circle_cutout([device_x()/2, device_z()/2], device_z()/2);
}
module back_cutouts() {
    circle_cutout([device_x()/2, device_z()/2], device_z()/2);
}
module top_cutouts() {}
module bottom_cutouts() {}
module cutouts() {}
module attachments() {}
module stand_offs() {}
module final_attachments() {}
