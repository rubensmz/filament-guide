# Filament guide for PrusaMK3

This is a parametric model for OpenSCAD of a filament guide to be placed in the hex slot of the the top Z axis printed part. Is is a remix of the original [filament guide designed by Habony Norbert](https://www.printables.com/model/135950-filament-guide/files), which was designed only for 608 bearings.

## Parameters

### Vertical bearing holder

The parameters for the vertical bearing holder are:
```OpenSCAD
// Internal bearing diameter
bearing_in_dia = 10;
// External bearing diameter
bearing_out_dia = 26;
// Bearing thickness
bearing_thickness = 8;

// Thickness of the base walls
wall_thickness = 5;

// Angle of the arc between the bearing and the base
arc_tangent_degree = 60;

// Difference between the bearing diameter and the base diameter. 
// If set to anything greater than 0, some are of the bearing won't 
// be covered by plastic, which looks pretty cool.
bearing_out_offset = 4;

// Diameter of the base cylinder where the bearing is placed
base_out_dia = bearing_out_dia - bearing_out_offset;

// General clearance on junctions
clearance = 0.1;
// Clearance between the bearing and the curve base
clearance_bearing = 0.8;
// Clearance for the bottom bearing
clearance_bottom_bearing = 0.2;

// Diameters for the base arc. Computed to be tangent with the bearing base
outer_dia = 1.545 * base_out_dia;
inner_dia = 0.546 * base_out_dia;

// Middle radius between the outer and inner diameter 
mid_dia = (outer_dia + inner_dia)/2;

// Length small central pole where the top bearing is placed. Set to 0 to only have
// exactly one half on each side
inner_hold_length = 2;

// Diameter of the connector to joint the other half
connector_dia = 3;
// Angle of the arc at which place the connectors (from the bottom)
connector_offset_degree = 8;

// Tab in the filament guide to fit in the other half's side
tab_width = 1;

// Filament guide parameters
filament_guide_width = 5;
filament_guide_height = 11;
filament_guide_thickness = 6;
```

### Horizontal bearing holder
The parameters for the horizontal bearing holder are:
```OpenSCAD
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
```

## Dependencies

The vertical bearing model requires from the [Chamfers for OpenSCAD](https://github.com/SebiTimeWaster/Chamfers-for-OpenSCAD) from SebiTimeWaster to instantiate some primitives. Please refer to the installation instructions of its repo for further details.

![Vertical bearing holder](img/vertical_bearing_holder.png "Vertical bearing parts")
![Horizontal bearing holder](img/horizontal_bearing_holder.png "Horizontal bearing holder")
