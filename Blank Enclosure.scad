// Test Enclosure

include <lib_enclosure.scad>

function fillet_z()         = 0;
function tolerance()        = 0.2;
function device_x()         = 50;
function device_y()         = 40;
function pcb_z()            = 1.5;
function spacing()          = 10;
function riser_z()          = 2;
function riser_thickness()  = 1;
function wall_thickness()   = 2;
function bottom_thickness() = 1;
function top_thickness()    = 1;
function device_z()         = 20;
function friction()         = 3;
function split()            = 0.5;

//finished_enclosure();
enclosure();

module left_cutouts() {}
module right_cutouts() {}
module front_cutouts() {}
module back_cutouts() {}
module top_cutouts() {}
module bottom_cutouts() {}
module cutouts() {}
module attachments() {}
module stand_offs() {}
module final_attachments() {}
