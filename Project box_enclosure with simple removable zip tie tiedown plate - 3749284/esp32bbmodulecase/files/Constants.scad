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

// Outer dimensions of box
dim_x = 120;
dim_y = 90;
dim_z = 80;

// Wall thickness
wall_thickness = 2;

// Outer bevel width
outer_bevel_width = 2;

// Inner bevel width
inner_bevel_width = outer_bevel_width / 2;

// Lid height
lid_height = wall_thickness + inner_bevel_width;

// Rounded corner radius
corner_radius = 6;

// Screw hole diameter (Add 0.6mm for tolerance)
screw_hole_diam = 3 + 0.6;

// Screw post wall thickness
screw_post_wall_thickness = 1.5;

// Tiedown plate standoff height, plate thickness, hole diameter, hole spacing
tiedown_standoff_height = 2;
tiedown_plate_thickness = 1;
tiedown_reinforcement_thickness = 1;
tiedown_hole_diam = 3;
tiedown_hole_spacing = 4;

// Total tiedown layer thickness
tiedown_layer_thickness = tiedown_standoff_height + tiedown_plate_thickness;

// Tiedown support plate reinforcement spacing
tiedown_plate_reinforcement_spacing = 4;

// Ventilation hole/slot sizes
ventilation_hole_diam = 2.5;
ventilation_hole_spacing = 5;

// The number of adjacent ventilation holes to connect together into a ventilation slot
// (0 => crate holes; 1 or more => use slots)
ventilation_slot_width = 3;

// Cable cutouts, of the form [[face, idx, diam], ...], or an empty list for no cable cutouts.
// Cable cutouts are removed from one edge of the box, with `face` taking a value between 0 and
// 3 inclusive to indicate the side of the box to cut out from (top, right, bottom, left);
// `idx` indicating the index of the tiedown holes to cut out the cable between (idx == 0
// implies the center of the sidewall, idx == +/- 1 for the position between the next pair of
// cutout holes, etc.); and `diam` specifying the diameter of the hole.
cable_cutouts = [[0, 0, 6.75], [1, -1, 5], [1, 1, 5]];
