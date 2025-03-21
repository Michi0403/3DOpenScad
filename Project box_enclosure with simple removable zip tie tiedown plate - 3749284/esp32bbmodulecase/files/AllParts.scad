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

spacing_y = 10;
spacing_x = 10;

translate([-dim_x / 2 - spacing_x / 2, dim_y / 2 + spacing_y / 2, 0])
    lidWithoutVentilationHoles();

// Printed upside down to eliminate the need for support material
translate([dim_x / 2 + spacing_x / 2, dim_y / 2 + spacing_y / 2, 0])
    tieDownPlate();

// Printed upside down to eliminate the need for support material
translate([-dim_x / 2 - spacing_x / 2, -dim_y / 2 - spacing_y / 2, 0])
    sideWalls(cable_cutouts);

translate([dim_x / 2 + spacing_x / 2, -dim_y / 2 - spacing_y / 2, 0])
    lidWithVentilationHoles(ventilation_hole_diam, ventilation_hole_spacing, ventilation_slot_width);
