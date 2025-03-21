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

// Create a lid without ventilation holes.
module lidWithoutVentilationHoles() {
    translate([0, 0, dim_z / 2]) {
        difference() {
            boxBody(dim_x, dim_y, dim_z, wall_thickness, outer_bevel_width, inner_bevel_width,
                    corner_radius, screw_hole_diam, screw_post_wall_thickness);
            
            // Chop off non-lid part of box
            translate([0, 0, lid_height])
                cube([dim_x + .1, dim_y + .1, dim_z], center = true);
        }
    }
}

lidWithoutVentilationHoles();
