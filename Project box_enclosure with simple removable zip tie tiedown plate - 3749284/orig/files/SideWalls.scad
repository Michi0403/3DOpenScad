//
// Copyright (C) 2019 by Luke Hutchison
//
// Permission to use, copy, modify, and/or distribute this software for any purpose with or without
// fee is hereby granted.
// 
// THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS
// SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
// THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
// WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
// NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
// OF THIS SOFTWARE.
//

include <Constants.scad>;
use <Modules.scad>;

// Create the side walls of the box.
// Printed upside down to eliminate the need for support material.
module sideWalls(cable_cutouts) {
    sides_height = dim_z - tiedown_layer_thickness - lid_height * 2;
    difference() {
        // Add the box
        translate([0, 0, dim_z / 2 - lid_height])
            boxBody(dim_x, dim_y, dim_z,
                    wall_thickness, outer_bevel_width, inner_bevel_width,
                    corner_radius, screw_hole_diam, screw_post_wall_thickness);
        
        // Remove top and bottom of the box
        translate([0, 0, -dim_z / 2])
            cube([dim_x + 1, dim_y + 1, dim_z], center = true);
        translate([0, 0, dim_z / 2 + sides_height])
            cube([dim_x + 1, dim_y + 1, dim_z], center = true);
        
        // Remove cable cutouts
        for (cable_cutout = cable_cutouts) {
            face = cable_cutout[0];
            idx = cable_cutout[1];
            diam = cable_cutout[2];
            sgn = face == 2 || face == 3 ? -1 : 1; 
            cx = sgn * (face == 1 || face == 3
                        ? (dim_x - wall_thickness) / 2
                        : idx * tiedown_hole_spacing);
            cy = sgn * (face == 1 || face == 3
                        ? -idx * tiedown_hole_spacing
                        : (dim_y - wall_thickness) / 2);
            rot = face == 0 || face == 2 ? 0 : 90;
            translate([cx, cy, sides_height - diam / 2]) {
                rotate([0, 0, rot]) rotate([270, 0, 0]) {
                    cylinder(r = diam / 2, h = wall_thickness + .2, $fn = 30, center = true);
                    translate([0, -diam / 4, 0]) {
                        cube([diam, diam / 2 + .01, wall_thickness + .2], center = true);
                    }
                }
            }
        }
    }
}

sideWalls(cable_cutouts);
