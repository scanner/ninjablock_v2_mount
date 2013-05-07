// a simple mount for a v2 ninja block
//
//
use <MCAD/regular_shapes.scad>;
use <MCAD/nuts_and_bolts.scad>;

njb_h = 114.25;
njb_w = 80;
njb_lip_w = 3;
njb_lip_d = 6.5;

thickness = 3;
plate_w = 40;
plate_l = njb_h + (thickness*2);
plate_h = thickness;

lip_h = njb_lip_w + 2;

padding = 0.01; // to preserve manifold

//////////////////////////////////////////////////////////////////////////////
//
module lip() {
    translate([0,0,lip_h / 2]) {
        cube( size = [plate_w, thickness, lip_h], center = true);
    }

    // we basically use an extended triangle to be the 'catch' that
    // holds the ninjblock v2 in place.
    //
    // translate([-plate_w/2,2-padding,lip_h-0.9]) {
    translate([plate_w/2,-2.2+padding,lip_h-1.3]) {
        rotate(a = [180,90,0]) {
            triangle_prism(plate_w,1.5);
        }
    }
}

//////////////////////////////////////////////////////////////////////////////
//
module screw_hole() {
    translate([0,0,2]) {
        rotate(a=[0,180,0]) {
            boltHole(size = 4,length = 5);
        }
    }
}

//////////////////////////////////////////////////////////////////////////////
//
module njb_v2_mount() {
    difference() {
        union() {
            // bottom plate that mounts against the wall/door/etc.
            //
            translate([0,0,(plate_h/2)]) {
                cube( size = [plate_w, plate_l, plate_h], center = true);
            }

            // The "lips" on the top and bottom which are what the ninja block
            // v2 will rest on.
            //
            translate([0, plate_l/2-(thickness/2), thickness-padding]) {
                lip();
            }
            translate([0, -plate_l/2 + (thickness/2), thickness-padding]) {
                rotate(a=[0,0,180]) {
                    lip();
                }
            }
        }

        // Holes for screws.
        //
        translate([0,-20,0]) {
            screw_hole();
        }
        translate([0,20,0]) {
            screw_hole();
        }

        // We cut some shaped cylinders out of the basic shape to make
        // it use less plastic and be less blockish.
        //
        translate([0,plate_l / 2,-padding]) {
            scale( v = [1,2.5,1] ) {
                cylinder(h = 20, r = 13, $fn = 40);
            }
        }
        translate([0,-plate_l / 2,-padding]) {
            scale( v = [1,2.5,1] ) {
                cylinder(h = 20, r = 13, $fn = 40);
            }
        }
        translate([plate_w/2+5,0,-padding]) {
            scale( v = [1,2,1] ) {
                cylinder(h = 20, r = 18, $fn = 40);
            }
        }
        translate([-plate_w/2-5,0,-padding]) {
            scale( v = [1,2,1] ) {
                cylinder(h = 20, r = 18, $fn = 40);
            }
        }
    }
}
$fn = 20;
njb_v2_mount();

