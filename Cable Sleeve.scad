module sleeve(x, y, z, d) {
    translate([0, (y-x)/-2, 0]) {
        difference() {
            hull() {
                cylinder(h=z, d=2*d+x);
                translate([0, y-x, 0]) cylinder(h=z, d=2*d+x);    
            }
            hull() {
                cylinder(h=z, d=x);
                translate([0, y-x, 0]) cylinder(h=z, d=x);
            }
        }
    }
}

sleeve(15, 20, 20, 1.2);
sleeve(25, 30, 20, 1.2);
translate([-12.5, -1, 0]) cube([25, 2, 0.8]);
translate([-1, -15, 0]) cube([2, 30, 0.8]);

translate([40, 0, 0]) {
    sleeve(20, 25, 20, 1.2);
    sleeve(30, 35, 20, 1.2);
    translate([-15, -1, 0]) cube([30, 2, 0.8]);
    translate([-1, -17.5, 0]) cube([2, 35, 0.8]);
}
