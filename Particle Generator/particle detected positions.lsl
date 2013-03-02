integer IMAGE_WIDTH = 1024;  //pixel width of original image applied to prim face
integer IMAGE_HEIGHT = 512; //pixel height of original image applied to prim face

// LINK MESSAGES
integer PARTICLE_PRESET = 100;
integer PARTICLE_SCRIPT_GENERATE = 200;
integer RESET_PARTICLE = 300;
integer PARTICLE_START_COLOR_PLUS = 400;
integer PARTICLE_START_COLOR_MINUS = 500;
integer PARTICLE_END_COLOR_PLUS = 600;
integer PARTICLE_END_COLOR_MINUS = 700;
integer PARTICLE_COLOR_WHITE = 800;
integer PARTICLE_COLOR_BLACK = 900;
integer PARTICLE_ALPHA_START = 1000;
integer PARTICLE_ALPHA_END = 1100;
integer PARTICLE_ALPHA_STATE = 1200;
integer PARTICLE_START_SCALE_PLUS = 1300;
integer PARTICLE_START_SCALE_MINUS = 1400;
integer PARTICLE_END_SCALE_PLUS = 1500;
integer PARTICLE_END_SCALE_MINUS = 1600;
integer PARTICLE_EMITTER_TYPE = 1700;
integer PARTICLE_EMITTER_RANGE = 1800;
integer PARTICLE_MOTION_SPEED = 1900;
integer PARTICLE_MOTION_PUSH = 2000;
integer PARTICLE_MOTION_ROTATION = 2100;
integer PARTICLE_MOTION_RADIUS = 2200;
integer PARTICLE_FOLLOW_SOURCE = 2300;
integer PARTICLE_FOLLOW_VELOCITY = 2400;
integer PARTICLE_BOUNCE = 2500;
integer PARTICLE_FOLLOW_WIND = 2600;
integer PARTICLE_SYSTEM_LIFE = 2700;
integer PARTICLE_QUANTITY_RATE = 2800;
integer PARTICLE_QUANTITY_BURST = 2900;
integer PARTICLE_QUANTITY_LIFE = 3000;
integer PARTICLE_CONTROLS_RANGE = 3100;
integer PARTICLE_SCRIPT_MODE = 3200;
integer GENERATE_PARTICLE = 3300;
integer PARTICLE_SCRIPT_VARIABLES = 3400;

//
// Determine if coordinate is within the given bounding rectangle.
//
// input: uv - vector returned from llDetectedTouchUV
//           - (0, 0) is bottom left
//           - range is 0.0 to 1.0
// input: minx - leftmost pixel coord of rectangle (0 = leftmost)
//             - range is 0 to IMAGE_WIDTH
//             - must be less than maxx
// input: miny - uppermost pixel coord of rectangle (0 = uppermost)
//             - range is 0 to IMAGE_HEIGHT
//             - must be less than maxy
// input: maxx - rightmost pixel coord of rectangle (0 = leftmost)
//             - range is 0 to IMAGE_WIDTH
//             - must be greater than minx
// input: maxy - lowermost pixel coord of rectangle (0 = uppermost)
//             - range is 0 to IMAGE_HEIGHT
//             - must be greater than miny
//
// output: TRUE if UV within (uplef, lowrt), FALSE otherwise
//
integer CheckRect(vector uv, integer minx, integer miny, integer maxx, integer maxy)
{
    integer checkX = (integer)(uv.x * IMAGE_WIDTH);
    integer checkY = (integer)((1.0 - uv.y) * IMAGE_HEIGHT);

    if ((checkX >= minx) && (checkX <= maxx) && (checkY >= miny) && (checkY <= maxy))
    {
        return TRUE;
    }
    return FALSE;
}

//
// Determine if coordinate is within the given bounding circle.
//
// input: uv - vector returned from llDetectedTouchUV
//           - (0, 0) is bottom left
//           - range is 0.0 to 1.0
// input: centerx - pixel coord of center of circle (0 = leftmost)
//                - range is 0 to IMAGE_WIDTH
// input: centery - pixel coord of center of circle (0 = uppermost)
//                - range is 0 to IMAGE_HEIGHT
// input: radius - distance from the center (in pixels) to check
//
// output: TRUE if UV within (uplef, lowrt), FALSE otherwise
//
integer CheckCircle(vector uv, integer centerx, integer centery, integer radius)
{
    integer checkX = (integer)(uv.x * IMAGE_WIDTH);
    integer checkY = (integer)((1.0 - uv.y) * IMAGE_HEIGHT);

    integer dist = (integer)llSqrt(((checkX - centerx) * (checkX - centerx)) +
        ((checkY - centery) * (checkY - centery)));

    if (dist <= radius)
    {
        return TRUE;
    }
    return FALSE;
}

default
{
    state_entry()
    {
        //llSay(0, "Hello, Avatar!");
    }

    touch_start(integer total_number)
    {
        vector UV = llDetectedTouchUV(0);
    
        if (CheckRect(UV, 846, 467, 1007, 507) == TRUE) llMessageLinked(LINK_SET, RESET_PARTICLE, "", NULL_KEY);
        if (CheckRect(UV, 668, 467, 830, 506) == TRUE) llGiveInventory(llDetectedKey(0),llGetInventoryName(INVENTORY_NOTECARD,0));
        if (CheckCircle(UV, 55, 97, 8) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_SCALE_PLUS, "sscalexu", NULL_KEY);
        if (CheckCircle(UV, 93, 97, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_SCALE_PLUS, "sscaleyu", NULL_KEY);
        if (CheckCircle(UV, 136, 97, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_SCALE_PLUS, "sscalexyu", NULL_KEY);
        if (CheckCircle(UV, 54, 163, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_SCALE_MINUS, "sscalexd", NULL_KEY);
        if (CheckCircle(UV, 94, 164, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_SCALE_MINUS, "sscaleyd", NULL_KEY);
        if (CheckCircle(UV, 137, 163, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_SCALE_MINUS, "sscalexyd", NULL_KEY);
        if (CheckCircle(UV, 55, 269, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_SCALE_PLUS, "escalexu", NULL_KEY);
        if (CheckCircle(UV, 92, 269, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_SCALE_PLUS, "escaleyu", NULL_KEY);
        if (CheckCircle(UV, 135, 269, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_SCALE_PLUS, "escalexyu", NULL_KEY);
        if (CheckCircle(UV, 54, 331, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_SCALE_MINUS, "escalexd", NULL_KEY);
        if (CheckCircle(UV, 93, 331, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_SCALE_MINUS, "escaleyd", NULL_KEY);
        if (CheckCircle(UV, 136, 331, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_SCALE_MINUS, "escalexyd", NULL_KEY);
        if (CheckCircle(UV, 196, 97, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_COLOR_PLUS, "V", NULL_KEY);
        if (CheckCircle(UV, 237, 97, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_COLOR_PLUS, "R", NULL_KEY);
        if (CheckCircle(UV, 277, 97, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_COLOR_PLUS, "G", NULL_KEY);
        if (CheckCircle(UV, 317, 97, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_COLOR_PLUS, "B", NULL_KEY);
        if (CheckCircle(UV, 196, 162, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_COLOR_MINUS, "V", NULL_KEY);
        if (CheckCircle(UV, 237, 162, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_COLOR_MINUS, "R", NULL_KEY);
        if (CheckCircle(UV, 277, 162, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_COLOR_MINUS, "G", NULL_KEY);
        if (CheckCircle(UV, 317, 162, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_START_COLOR_MINUS, "B", NULL_KEY);
        if (CheckCircle(UV, 195, 269, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_COLOR_PLUS, "V", NULL_KEY);
        if (CheckCircle(UV, 237, 269, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_COLOR_PLUS, "R", NULL_KEY);
        if (CheckCircle(UV, 277, 269, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_COLOR_PLUS, "G", NULL_KEY);
        if (CheckCircle(UV, 317, 269, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_COLOR_PLUS, "B", NULL_KEY);
        if (CheckCircle(UV, 196, 331, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_COLOR_MINUS, "V", NULL_KEY);
        if (CheckCircle(UV, 237, 331, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_COLOR_MINUS, "R", NULL_KEY);
        if (CheckCircle(UV, 277, 331, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_COLOR_MINUS, "G", NULL_KEY);
        if (CheckCircle(UV, 318, 331, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_END_COLOR_MINUS, "B", NULL_KEY);
        if (CheckCircle(UV, 236, 190, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_COLOR_WHITE, "START", NULL_KEY);
        if (CheckCircle(UV, 279, 191, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_COLOR_BLACK, "START", NULL_KEY);
        if (CheckCircle(UV, 238, 357, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_COLOR_WHITE, "END", NULL_KEY);
        if (CheckCircle(UV, 278, 357, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_COLOR_BLACK, "END", NULL_KEY);
        if (CheckCircle(UV, 394, 97, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_ALPHA_START, "salphau", NULL_KEY);
        if (CheckCircle(UV, 394, 161, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_ALPHA_START, "salphad", NULL_KEY);
        if (CheckCircle(UV, 394, 269, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_ALPHA_END, "ealphau", NULL_KEY);
        if (CheckCircle(UV, 393, 331, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_ALPHA_END, "ealphad", NULL_KEY);
        if (CheckCircle(UV, 376, 133, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_ALPHA_STATE, "salphaclear", NULL_KEY);
        if (CheckCircle(UV, 412, 133, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_ALPHA_STATE, "salphasolid", NULL_KEY);
        if (CheckCircle(UV, 376, 300, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_ALPHA_STATE, "ealphaclear", NULL_KEY);
        if (CheckCircle(UV, 413, 300, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_ALPHA_STATE, "ealphasolid", NULL_KEY);
        if (CheckRect(UV, 21, 411, 185, 438) == TRUE) llMessageLinked(LINK_SET, PARTICLE_EMITTER_TYPE, "explosion", NULL_KEY);
        if (CheckRect(UV, 21, 441, 185, 468) == TRUE) llMessageLinked(LINK_SET, PARTICLE_EMITTER_TYPE, "angle", NULL_KEY);
        if (CheckRect(UV, 21, 475, 186, 500) == TRUE) llMessageLinked(LINK_SET, PARTICLE_EMITTER_TYPE, "angle cone", NULL_KEY);
        if (CheckCircle(UV, 269, 433, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_EMITTER_RANGE, "emitter begin up", NULL_KEY);
        if (CheckCircle(UV, 393, 433, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_EMITTER_RANGE, "emitter end up", NULL_KEY);
        if (CheckCircle(UV, 268, 481, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_EMITTER_RANGE, "emitter begin down", NULL_KEY);
        if (CheckCircle(UV, 393, 481, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_EMITTER_RANGE, "emitter end down", NULL_KEY);
        if (CheckRect(UV, 296, 425, 365, 444) == TRUE) llMessageLinked(LINK_SET, PARTICLE_EMITTER_RANGE, "emitter max", NULL_KEY);
        if (CheckRect(UV, 296, 469, 365, 488) == TRUE) llMessageLinked(LINK_SET, PARTICLE_EMITTER_RANGE, "emitter min", NULL_KEY);
        if (CheckRect(UV, 493, 338, 597, 365) == TRUE) llMessageLinked(LINK_SET, PARTICLE_CONTROLS_RANGE, "fine", NULL_KEY);
        if (CheckRect(UV, 494, 368, 595, 395) == TRUE) llMessageLinked(LINK_SET, PARTICLE_CONTROLS_RANGE, "medium", NULL_KEY);
        if (CheckRect(UV, 494, 398, 595, 424) == TRUE) llMessageLinked(LINK_SET, PARTICLE_CONTROLS_RANGE, "coarse", NULL_KEY);
        if (CheckRect(UV, 484, 467, 647, 507) == TRUE) llMessageLinked(LINK_SET, PARTICLE_SCRIPT_GENERATE, "", NULL_KEY);
        if (CheckRect(UV, 475, 192, 658, 214) == TRUE) llMessageLinked(LINK_SET, PARTICLE_FOLLOW_SOURCE, "", NULL_KEY);
        if (CheckRect(UV, 475, 218, 658, 240) == TRUE) llMessageLinked(LINK_SET, PARTICLE_FOLLOW_VELOCITY, "", NULL_KEY);
        if (CheckRect(UV, 475, 247, 658, 270) == TRUE) llMessageLinked(LINK_SET, PARTICLE_BOUNCE, "", NULL_KEY);
        if (CheckRect(UV, 475, 275, 658, 298) == TRUE) llMessageLinked(LINK_SET, PARTICLE_FOLLOW_WIND, "", NULL_KEY);
        if (CheckRect(UV, 645, 335, 805, 356) == TRUE) llMessageLinked(LINK_SET, PARTICLE_SCRIPT_MODE, "plain", NULL_KEY);
        if (CheckRect(UV, 645, 360, 805, 382) == TRUE) llMessageLinked(LINK_SET, PARTICLE_SCRIPT_MODE, "primitizer", NULL_KEY);
        if (CheckRect(UV, 645, 387, 805, 406) == TRUE) llMessageLinked(LINK_SET, PARTICLE_SCRIPT_MODE, "linden", NULL_KEY);
        if (CheckRect(UV, 645, 411, 805, 432) == TRUE) llMessageLinked(LINK_SET, PARTICLE_SCRIPT_MODE, "poofer", NULL_KEY);
        if (CheckRect(UV, 848, 334, 1008, 355) == TRUE) llMessageLinked(LINK_SET, PARTICLE_SCRIPT_MODE, "listen toggle", NULL_KEY);
        if (CheckRect(UV, 848, 360, 1008, 380) == TRUE) llMessageLinked(LINK_SET, PARTICLE_SCRIPT_MODE, "listen color", NULL_KEY);
        if (CheckRect(UV, 848, 385, 1008, 407) == TRUE) llMessageLinked(LINK_SET, PARTICLE_SCRIPT_MODE, "touch", NULL_KEY);
        if (CheckRect(UV, 848, 412, 1008, 433) == TRUE) llMessageLinked(LINK_SET, PARTICLE_SCRIPT_MODE, "everyone", NULL_KEY);
        if (CheckCircle(UV, 751, 207, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_SYSTEM_LIFE, "UP", NULL_KEY);
        if (CheckCircle(UV, 750, 258, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_SYSTEM_LIFE, "DOWN", NULL_KEY);
        if (CheckRect(UV, 709, 277, 791, 296) == TRUE) llMessageLinked(LINK_SET, PARTICLE_SYSTEM_LIFE, "RESET", NULL_KEY);
        if (CheckCircle(UV, 858, 212, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_QUANTITY_RATE, "UP", NULL_KEY);
        if (CheckCircle(UV, 858, 258, 10) == TRUE) llMessageLinked(LINK_SET, PARTICLE_QUANTITY_RATE, "DOWN", NULL_KEY);
        if (CheckRect(UV, 820, 275, 900, 295) == TRUE) llMessageLinked(LINK_SET, PARTICLE_QUANTITY_RATE, "MAX", NULL_KEY);
        if (CheckCircle(UV, 925, 212, 8) == TRUE) llMessageLinked(LINK_SET, PARTICLE_QUANTITY_BURST, "UP", NULL_KEY);
        if (CheckCircle(UV, 925, 260, 8) == TRUE) llMessageLinked(LINK_SET, PARTICLE_QUANTITY_BURST, "DOWN", NULL_KEY);
        if (CheckCircle(UV, 985, 212, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_QUANTITY_LIFE, "UP", NULL_KEY);
        if (CheckCircle(UV, 985, 260, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_QUANTITY_LIFE, "DOWN", NULL_KEY);
        if (CheckCircle(UV, 514, 68, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_SPEED, "SPEEDMINUP", NULL_KEY);
        if (CheckCircle(UV, 514, 127, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_SPEED, "SPEEDMINDOWN", NULL_KEY);
        if (CheckCircle(UV, 558, 68, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_SPEED, "SPEEDMAXUP", NULL_KEY);
        if (CheckCircle(UV, 558, 127, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_SPEED, "SPEEDMAXDOWN", NULL_KEY);
        if (CheckCircle(UV, 630, 67, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_PUSH, "XUP", NULL_KEY);
        if (CheckCircle(UV, 630, 128, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_PUSH, "XDOWN", NULL_KEY);
        if (CheckCircle(UV, 668, 67, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_PUSH, "YUP", NULL_KEY);
        if (CheckCircle(UV, 668, 127, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_PUSH, "YDOWN", NULL_KEY);
        if (CheckCircle(UV, 709, 67, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_PUSH, "ZUP", NULL_KEY);
        if (CheckCircle(UV, 709, 127, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_PUSH, "ZDOWN", NULL_KEY);
        if (CheckRect(UV, 625, 139, 707, 160) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_PUSH, "RESET", NULL_KEY);
        if (CheckCircle(UV, 780, 67, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_ROTATION, "XUP", NULL_KEY);
        if (CheckCircle(UV, 780, 126, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_ROTATION, "XDOWN", NULL_KEY);
        if (CheckCircle(UV, 819, 67, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_ROTATION, "YUP", NULL_KEY);
        if (CheckCircle(UV, 819, 127, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_ROTATION, "YDOWN", NULL_KEY);
        if (CheckCircle(UV, 858, 68, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_ROTATION, "ZUP", NULL_KEY);
        if (CheckCircle(UV, 858, 127, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_ROTATION, "ZDOWN", NULL_KEY);
        if (CheckRect(UV, 780, 141, 862, 160) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_ROTATION, "RESET", NULL_KEY);
        if (CheckCircle(UV, 945, 68, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_RADIUS, "UP", NULL_KEY);
        if (CheckCircle(UV, 945, 128, 9) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_RADIUS, "DOWN", NULL_KEY);
        if (CheckRect(UV, 907, 140, 991, 160) == TRUE) llMessageLinked(LINK_SET, PARTICLE_MOTION_RADIUS, "RESET", NULL_KEY);       
    }
}