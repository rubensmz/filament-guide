include <Chamfers-for-OpenSCAD/Chamfer.scad>;

// Internal bearing diameter
bearing_in_dia = 10;
// External bearing diameter
bearing_out_dia = 26 ;
// Bearing thickness
bearing_thickness = 8;

wall_thickness = 5;

arc_tangent_degree = 60;

clearance = 0.1;

outer_dia = 1.5 * bearing_out_dia;
inner_dia = 0.546 * bearing_out_dia;

mid_dia = (outer_dia + inner_dia)/2;

inner_hold_length = 2;

show_bearing = 0;
show_base = 1;

connector_dia = 3;
connector_offset_degree = 15;

half_number = 0;

if (half_number == 0) {
    half(half_number);
}
else {
    mirror([0, 0, -1]) {
        half(half_number);
    }
}

module half(half_number) {
    union () {
        
        // Bearing holder base
        if (show_base) {
            rotate([0, 0, 90 - arc_tangent_degree]) {
                union() {
                    translate([-(outer_dia - bearing_out_dia/2), 0, 0]){
                        linear_extrude(wall_thickness){
                            arc(outer_dia - 1, inner_dia, 0, arc_tangent_degree);
                        }
                    }

                    cylinder(h = wall_thickness, r = bearing_out_dia/2 - 1, $fn = 100);
                }
            }
        }
 
        // Inner half-cylinder for holding the bearing
        // Big cylinder
        translate([0, 0, -(bearing_thickness - inner_hold_length - clearance) ]) {
            rotate([0, 0, half_number == 0 ? 180 : 0]) {
                half_cylinder(r = bearing_in_dia/2 - clearance, h = bearing_thickness - inner_hold_length);
            }
        }
        // Small cylinder
        translate([0, 0, -(inner_hold_length-clearance) ]) {
            rotate([0, 0, half_number == 0 ? 0 : 180]) {
                half_cylinder(r = bearing_in_dia/2 - clearance, h = inner_hold_length);
            }
        }

        // Bearing. For reference
        if (show_bearing) {
            scale([0, 0, -1]) { 
                bearing(bearing_out_dia, bearing_in_dia, bearing_thickness);
            }
        }
        
        union() {
            difference() {
                rotate([0, 0, 90- arc_tangent_degree]) {
                    translate([-(outer_dia - bearing_out_dia/2), 0, -(bearing_thickness/2)]){
                        linear_extrude(bearing_thickness/2){
                            arc(outer_dia-1, inner_dia, 0, arc_tangent_degree);
                        }

                    }
                }
                translate([0, 0, -(bearing_thickness/2 + 0.5)]){
                    union() {
                        cylinder(h = bearing_thickness/2 +1, d = bearing_out_dia + clearance, $fn = 100);
                        translate([-bearing_out_dia/4, 0, 0]) {
                            cube(bearing_out_dia);
                        }
                    }
                }

                if (half_number == 0) {
                    connector(mid_dia/4);
                    connector(-mid_dia/4);
                }
                   
            }
            if (half_number == 1) {
                translate([0, 0, -bearing_thickness/2 + 2*clearance]) {
                    connector(mid_dia/4);
                    connector(-mid_dia/4);
                }
                
            }
        }

        // Filament guide
        /*translate([bearing_out_dia ]) {
            cube([1, 2, 1]);
        }*/

    }
}

module arc(r1, r2, a1, a2) {
  difference() {
    difference() {
      polygon([[0,0], [cos(a1) * (r1 + 50), sin(a1) * (r1 + 50)], [cos(a2) * (r1 + 50), sin(a2) * (r1 + 50)]]);
      circle(r = r2, $fn=360);
    }
    difference() {
      circle(r=r1 + 100, $fn=360);
      circle(r=r1, $fn=360);
    }
  }
}

module half_cylinder(r, h) {
    difference() {
        chamferCylinder(h=h-clearance, r=r, r2=r, ch = 0.5, ch2 = 0);
        translate([h < 5 ? clearance : -clearance, -r, -1]) {
            cube([r+clearance, 2*r, h+1]);
        }
    }
}

module bearing(out_dia, in_dia, thickness) {
    difference() {
        cylinder(h = thickness, d = out_dia, $fn = 200);
        translate([0, 0, -0.5]) {
            cylinder(h = thickness  + 1, d = in_dia, $fn=200);
        }
    }
}

module connector(r) {
    translate([0, r, 0]) {
        translate([-(outer_dia + inner_dia)/2 * sin(arc_tangent_degree), -(outer_dia + inner_dia)/2 * cos(arc_tangent_degree), -bearing_thickness/2]) {
            rotate([0, 0, arc_tangent_degree-connector_offset_degree]) {
                translate([mid_dia * sin(arc_tangent_degree), mid_dia * cos(arc_tangent_degree), 0]) {
                    chamferCylinder(
                        h = half_number == 0 ? bearing_thickness/2  : wall_thickness - 2*clearance, 
                        r = half_number == 0 ? connector_dia/2 + clearance : connector_dia/2, 
                        ch= half_number == 0 ? -1 : 0.5,
                        ch2=0,
                        $fn=360);
                }
            }
        
        }
    }
}