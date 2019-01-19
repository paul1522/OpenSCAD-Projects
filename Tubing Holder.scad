d1 = 24;
t1 = 2;
h1 = 30;

difference() {
    union() {
        cylinder(d=d1+2*t1, h=h1);
        
    }
    union() {
        cylinder(d=d1, h=h1);
        translate([(d1+2*t1)/4, -((d1+2*t1)/2), 0]) cube([d1+2*t1, d1+2*t1, h1]);
    }
}

translate([0, d1/2, 0]) cube([2*d1, t1, h1]);