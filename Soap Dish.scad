use <lib/boxes3.scad>
// $fn = 16;

x = 5.5*25.4 ;
y = 3.5*25.4 ;
z = 15 ;
r = 10 ;
d = 2.0 ;
//rp = (z-d)/2 ;
rp = 3;



difference() {
    union() {
        open_box(x, y, z, r, d);
        intersection() {
            rounded_rectangle(x, y, z, r);
            union() {
                for (x1 = [0 : 3*rp+1 : x]) {
                    for (y1 = [0 : 3*rp+1 : y]) {
                        translate([x1, y1, d]) {
                            sphere(rp);
                        }
                    }
                }
            }
        }
    }
    *translate([10.2, 10.2, -1]) cylinder(r=4, h=z);
    #translate([x-10.2, 10.2,-1]) cylinder(r=4, h=z);
    *translate([10.2, y-10.2, -1]) cylinder(r=4, h=z);
    #translate([x-10.2, y-10.2, -1]) cylinder(r=4, h=z);
}

*translate([x/2, y+25/2, 0]) {
    intersection() {
        difference() {
            cylinder(d=25+6.8, h=30);
            cylinder(d=25, h=30);
        }
        translate([-20, -40+6, 0]) {
            cube([40, 40, 40]);
        }
    }
}
