d1 = 30;
d2 = 12;
t1 = 5;
t2 = 5;
l1 = 225;

difference() {
    pos1();
    neg1();
}

module pos1() {
    cylinder(d=d1+2*t2, h=t1);
    translate([0, (d1+d2)/2+t2, 0]) cylinder(d=d2+2*t2, h=t1);
    translate([0, d1/2, 0]) cube([l1, t2, t1]);
    translate([l1, d1/2+t1/2, 0]) cylinder(d=20, h=t1);
}

module neg1() {
    cylinder(d=d1, h=t1);
    translate([0, (d1+d2)/2+t2, 0]) cylinder(d=d2, h=t1);
    translate([0, -(d1/2), 0]) cube([d1/2+t2, d1, t1]);
    translate([0, d1/2+t1, 0]) cube([d2/2+t2, d2, t1]);
    #translate([l1, d1/2+t1/2, 0]) cylinder(d=10, h=t1);
}

