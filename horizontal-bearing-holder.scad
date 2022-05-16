// Height of Z axis top part where bearing holder will be inserted
height_z_axis_top = 5;
// Extra height for the bearing holder. It will exceed the bottom of the Z axis top part
height_insert_extra = 4;
height_insert = height_z_axis_top + height_insert_extra;

// Internal bearing diameter
bearing_in_dia = 10;
// External bearing diameter
bearing_out_dia = 26;
// Bearing thickness
bearing_thickness = 8;

// Thickness of the walls 
bearing_wall_thickness = 4;
// External diameter of the bearing holder
bearing_holder_dia = bearing_out_dia + bearing_wall_thickness;
clearance = 0.1;


// Check dimesions
assert (bearing_holder_dia > bearing_out_dia, "Bearing holder diameter is smaller than bearing outer diameter");

union() {
    translate([0, 0, -height_insert]) {
        cylinder(h = height_insert, r=8-clearance, $fn=6);
    }
    
    translate([0, 0, 0]){
        difference() {
            linear_extrude(bearing_thickness + bearing_wall_thickness) {
                circle(d=bearing_holder_dia + clearance, $fn=360);
            }
            translate([0, 0, bearing_wall_thickness]) {
                linear_extrude(bearing_thickness + 1) {
                    circle(d = bearing_out_dia, $fn=360);
                }
            }
        }
    }
}