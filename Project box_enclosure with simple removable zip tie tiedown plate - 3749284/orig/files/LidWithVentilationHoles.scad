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
use <LidWithoutVentilationHoles.scad>;

// Create a lid with ventilation holes. The ventilation holes align with the tiedown holes,
// so that the support posts on the tiedown plate contact the bottom lid, even if it has
// ventilation holes.
module lidWithVentilationHoles(ventilation_hole_diam, ventilation_hole_spacing, ventilation_slot_width) {
    difference() {
        lidWithoutVentilationHoles();
        createHolesOrSlots(dim_x, dim_y, dim_z, wall_thickness, corner_radius,
                           ventilation_hole_diam, ventilation_hole_spacing, ventilation_slot_width);
    }
}

lidWithVentilationHoles(ventilation_hole_diam, ventilation_hole_spacing, ventilation_slot_width);
