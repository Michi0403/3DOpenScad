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
use <LidWithoutVentilationHoles.scad>;
use <LidWithVentilationHoles.scad>;
use <SideWalls.scad>;
use <TieDownPlate.scad>;

spacing = 20;

lidWithoutVentilationHoles();

translate([0, 0, lid_height + spacing + tiedown_layer_thickness])
    rotate([0, 180, 0])
        tieDownPlate();

// Printed upside down to eliminate the need for support material
translate([0, 0, dim_z + spacing * 3 - lid_height - spacing])
    rotate([0, 180, 0])
        sideWalls(cable_cutouts);

// Printed upside down to eliminate the need for support material
translate([0, 0, dim_z + spacing * 3])
    rotate([0, 180, 0])
        lidWithVentilationHoles(ventilation_hole_diam, ventilation_hole_spacing,
                                ventilation_slot_width);

// Show assembly lines through screw holes
dx = dim_x / 2 - corner_radius;
dy = dim_y / 2 - corner_radius;
r = 0.3;
translate([-dx, -dy, -spacing * 2]) cylinder(r = r, h = dim_z + spacing * 7, $fn=12);
translate([-dx, dy, -spacing * 2]) cylinder(r = r, h = dim_z + spacing * 7, $fn=12);
translate([dx, -dy, -spacing * 2]) cylinder(r = r, h = dim_z + spacing * 7, $fn=12);
translate([dx, dy, -spacing * 2]) cylinder(r = r, h = dim_z + spacing * 7, $fn=12);
