h1 = 50;
h2 = 20;
d1 = 7;
d2 = 5;
d3 = 12;

difference() {
    union() {
        translate([0, 0, h2]) cylinder(h=h1-h2-d3/2, d1=d3, d2=d3);
        translate([0, 0, h1-d3/2]) sphere(d=d3);
        cylinder(h=h2, d1=d1, d2=d3);
    }
    cylinder(h=100, d=d2);
}
