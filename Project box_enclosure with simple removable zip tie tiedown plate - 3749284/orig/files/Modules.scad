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

// Create a 45-degree beveled rounded box
module beveledRoundedBox(size_x, size_y, size_z, bevel_width, corner_radius) {
    hull() {
        minkowski() {
            cube([size_x - corner_radius * 2,
                  size_y - corner_radius * 2,
                  size_z - bevel_width * 2 - 0.1],
                 center = true);
            cylinder(r = corner_radius, h = 0.1, center = true, $fn = 64);
        }
        minkowski() {
            cube([size_x - corner_radius * 2,
                  size_y - corner_radius * 2,
                  size_z - 0.1],
                center = true);
            cylinder(r = corner_radius - bevel_width, h = 0.1, center = true, $fn = 64);
        }
    }
}

// Create body of box
module boxBody(dim_x, dim_y, dim_z, wall_thickness, outer_bevel_width, inner_bevel_width, corner_radius, screw_hole_diam, screw_post_wall_thickness) {
    difference() {
        // Outer box
        beveledRoundedBox(dim_x, dim_y, dim_z, outer_bevel_width, corner_radius);
        
        // Remove inner negative space from box
        difference() {
            // Inner negative box
            beveledRoundedBox(dim_x - wall_thickness * 2,
                              dim_y - wall_thickness * 2,
                              dim_z - wall_thickness * 2,
                              inner_bevel_width,
                              corner_radius - wall_thickness);
            
            // Add screw posts (by subtracting from inner negative box)
            screw_post_r = screw_post_wall_thickness + screw_hole_diam / 2;
            for (dx = [-1:2:1]) {
                for (dy = [-1:2:1]) {
                    hull() {
                        translate([dx * (dim_x / 2 - corner_radius),
                                   dy * (dim_y / 2 - corner_radius),
                                   -(dim_z / 2 - wall_thickness)])
                            cylinder(r = screw_post_r, h = dim_z - wall_thickness * 2, $fn = 64);
                        translate([dx * (dim_x / 2 - (corner_radius - screw_post_r)),
                                   dy * (dim_y / 2 - (corner_radius - screw_post_r)),
                                   -(dim_z / 2 - wall_thickness)])
                            cylinder(r = screw_post_r, h = dim_z - wall_thickness * 2, $fn = 64);
                    }
                }
            }
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
    }
}

function hypot(dx, dy) = sqrt(dx * dx + dy * dy);

module roundedSquare(dim, h, r) {
    w = dim / 2 - r;
    hull() {
        translate([-w, -w, 0]) cylinder(r = r, h = h, $fn = 16); 
        translate([-w, w, 0]) cylinder(r = r, h = h, $fn = 16); 
        translate([w, -w, 0]) cylinder(r = r, h = h, $fn = 16); 
        translate([w, w, 0]) cylinder(r = r, h = h, $fn = 16); 
    }
}

// Create a grid of holes (if slotWidth == 0) or slots (if slotWidth > 0)
module createHolesOrSlots(dim_x, dim_y, dim_z, wall_thickness, corner_radius, tiedown_hole_diam,
                          tiedown_hole_spacing, slotWidth) {
    for (x = [0.5 * tiedown_hole_spacing
              : tiedown_hole_spacing
              : dim_x / 2 - wall_thickness - tiedown_hole_diam]) {
        // For this x val, find all y vals that are not too close to corner holes
        y_vals = [for (y = [0.5 * tiedown_hole_spacing
                            : tiedown_hole_spacing
                            : dim_y / 2 - wall_thickness - tiedown_hole_diam])
            if (hypot(dim_x / 2 - corner_radius - x, dim_y / 2 - corner_radius - y)
                > corner_radius + tiedown_hole_diam / 2) 
                    y];
        // Create holes (if slotWidth == 0) or slots (if slotWidth > 0)
        for (yi = [0 : slotWidth + 1 : len(y_vals) - 1]) {
            y0 = y_vals[yi];
            y1 = y_vals[min(yi + slotWidth, len(y_vals) - 1)];
            for (dx = [-1:2:1]) {
                for (dy = [-1:2:1]) {
                    hull() {
                        translate([dx * x, dy * y0, -.1])
                            roundedSquare(dim = tiedown_hole_diam, h = dim_z + .2, r = .5); 
                        translate([dx * x, dy * y1, -.1])
                            roundedSquare(dim = tiedown_hole_diam, h = dim_z + .2, r = .5); 
                    }
                }
            }
        }
    }
}

