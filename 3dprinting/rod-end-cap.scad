// Simple SCAD model to generate a rounded, hollow cap for covering wires, etc.

module generate_cap(inset_radius, cap_thickness, cap_height, smoothness) {
    difference() {
        // Create outisde
        union() {
            translate([0,0,cap_height]) sphere(r=inset_radius+cap_thickness, $fn=smoothness);
            cylinder(r=inset_radius+cap_thickness, h=cap_height, $fn=smoothness);
        }
        // And the hollow inside
        union() {
            translate([0,0,cap_height]) sphere(r=inset_radius, $fn=smoothness);
            translate([0,0,-0.1]) cylinder(r=inset_radius, h=cap_height+0.1, $fn=smoothness);
        }
    }
}

generate_cap(1.5, 1.5, 6, 50);