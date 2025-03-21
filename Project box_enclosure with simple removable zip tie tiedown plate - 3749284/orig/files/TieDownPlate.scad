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

// Create a grid of support post cylinders between the tiedown holes.
module createReinforcement(dim_x, dim_y, dim_z, wall_thickness, tiedown_plate_thickness,
                           tiedown_reinforcement_thickness, tiedown_standoff_height,
                           corner_radius, tiedown_hole_diam, tiedown_hole_spacing,
                           tiedown_plate_reinforcement_spacing) {
    reinforcement_thickness = min(tiedown_reinforcement_thickness,
                                  tiedown_hole_spacing - tiedown_hole_diam);
    reinforcement_height = min(tiedown_reinforcement_thickness, tiedown_standoff_height);
    for (dx = [-1:2:1]) {
        for (dy = [-1:2:1]) {
            for (x = [0
                      : tiedown_hole_spacing * tiedown_plate_reinforcement_spacing
                      : dim_x / 2 - corner_radius * 2]) {
                translate([dx * x, 0, reinforcement_height / 2 + tiedown_plate_thickness])
                    cube([reinforcement_thickness, dim_y, reinforcement_height], center = true);
            }
            for (y = [0
                      : tiedown_hole_spacing * tiedown_plate_reinforcement_spacing
                      : dim_y / 2 - corner_radius * 2]) {
                translate([0, dy * y, reinforcement_height / 2 + tiedown_plate_thickness])
                    cube([dim_x, reinforcement_thickness, reinforcement_height], center = true);
            }
        }
    }
}

// Create the tiedown plate.
// Printed upside down to eliminate the need for support material.
module tieDownPlate() {
    difference() {
        union() {
            // Base plate
            hull() {
                for (dx = [-1:2:1]) {
                    for (dy = [-1:2:1]) {
                        translate([dx * (dim_x / 2 - corner_radius),
                                   dy * (dim_y / 2 - corner_radius),
                                   -.1])
                            cylinder(r = corner_radius,
                                     h = tiedown_plate_thickness + .1, $fn = 64);
                    }
                }
            }
            
            // Add box body (provides walls and screw posts)
            translate([0, 0, dim_z / 2 - wall_thickness - .1])
                boxBody(dim_x, dim_y, dim_z,
                        wall_thickness, outer_bevel_width, inner_bevel_width,
                        corner_radius, screw_hole_diam, screw_post_wall_thickness);
            
            // Add reinforcement
            createReinforcement(dim_x, dim_y, dim_z, wall_thickness, tiedown_plate_thickness,
                                tiedown_reinforcement_thickness, tiedown_standoff_height,
                                corner_radius, tiedown_hole_diam, tiedown_hole_spacing,
                                tiedown_plate_reinforcement_spacing);
        }
        
        // Remove screw holes
        for (dx = [-1:2:1]) {
            for (dy = [-1:2:1]) {
                translate([dx * (dim_x / 2 - corner_radius),
                           dy * (dim_y / 2 - corner_radius),
                           -dim_z / 2 - .1])
                    cylinder(r = screw_hole_diam / 2, h = dim_z + .2, $fn = 64);
            }
        }
        
        // Create tiedown holes
        createHolesOrSlots(dim_x, dim_y, dim_z, wall_thickness, corner_radius,
                           tiedown_hole_diam, tiedown_hole_spacing, 0);
        
        // Remove top and bottom of box
        translate([0, 0, -dim_z / 2])
            cube([dim_x + 1, dim_y + 1, dim_z], center = true);
        translate([0, 0, dim_z / 2 + tiedown_plate_thickness + tiedown_standoff_height])
            cube([dim_x + 1, dim_y + 1, dim_z], center = true);
    }
}

tieDownPlate();
