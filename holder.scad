include <BOSL/transforms.scad>

function inchToMillimeter(x) = x*25.4;

// EDIT THIS ACCORDING TO YOUR PRINTER
// slop for the film to fit in the hole
slop = 0.15;
// holder can be longer if you have a larger print bed
printBedDepth=230;

// EDIT THIS TO ADJUST HOLDER THICKNESS
height = 4;

// EDIT THIS TO ADJUST ELEVATION OF FILM ABOVE GLASS
filmHeight = 1;

// printer parameters

// page size
width = inchToMillimeter(7.5);
depth = min(inchToMillimeter(11),printBedDepth);

// location of film hole
// left offset 
holeOffsetX = inchToMillimeter(2.375);
// bottom offset
// holeOffsetY = inchToMillimeter(3.875); - original size 
holeOffsetY = inchToMillimeter(3.0);
// film hole size, as per the template 
holeWidth = inchToMillimeter(3.75);
holeDepth = inchToMillimeter(4.75);

// now we want to make an inset to hold the film well
// in millimeters, the hole has size 95.25 x 120.65
// actual film size is:
filmWidth = 100 + 2*slop;
filmDepth = 125 + 2*slop;

// so we have extra 4.75mm for width and 4.35mm for depth 
// that we can use to hold the film above the glass
insetOffsetX = holeOffsetX-(filmWidth - holeWidth)/2;
insetOffsetY = holeOffsetY-(filmDepth - holeDepth)/2;

module arrow() {
    linear_extrude(height+1)
        polygon([[10,0],[0,20],[20,20]]);
    }
module page() {
    // main body
    shape = [
        [0,0],[width,0],[width,depth],[0,depth]
    ];
    linear_extrude(height) 
        round2d(5)
        polygon(shape);
    // indicator arrows
    translate([width/5,10,0]) arrow();
    translate([width*4/5,10,0]) arrow();
    } 
module hole() {
    translate([holeOffsetX, holeOffsetY,-1]) 
        cube([holeWidth,holeDepth,height+1]);
    }
    
module inset() {
    translate([insetOffsetX,insetOffsetY,filmHeight])
    cube([filmWidth,filmDepth,height]);
    }

difference() {
    page(); 
    hole(); 
    inset();
  }
    
