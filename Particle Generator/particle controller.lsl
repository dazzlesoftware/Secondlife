integer PARTICLE_CHANNEL = 35;

// Inventory Index
integer INDEX;

// Particle System Variables
string PARTICLE_NOTECARD;
string PARTICLE_PREFIX = "psys_";
key NOTECARD_QUERY;

integer PARTICLE_TOGGLE_SOURCE = FALSE;
integer PARTICLE_TOGGLE_VELOCITY = FALSE;
integer PARTICLE_TOGGLE_ZBOUNCE = FALSE;
integer PARTICLE_TOGGLE_WIND = FALSE;

integer PARTICLE_HANDLE;

float counter = 2.0;

// 0.1 FINE CONTROL
// 0.5 MEDIUM CONTROL
// 1.0 COARSE CONTROL
float PARTICLE_CONTROLS = 0.1;
// 1 FINE CONTROL
// 5 MEDIUM CONTROL
// 10 COARSE CONTROL
integer PARTICLE_CONTROLS_INT = 1;

// 0 = PLAIN SCRIPT
// 1 = PRIMITIZER
// 2 = llParticleSystem
// 3 = Poofer
// 4 Listen On / Off
// 5 Listen Color
// 6 Touch
// 7 Everyone
integer PARTICLE_SCRIPT_TYPE = 0;

string PARTICLE_EMITTER = "emitter";
string PARTICLE_PROPERTIES_1 = "Particle Properties 1";
string PARTICLE_PROPERTIES_2 = "Particle Properties 2";
string PARTICLE_NEW_START_SCALE;
string PARTICLE_NEW_END_SCALE;

string PARTICLE_NEW_MOTION_PUSH;
string PARTICLE_NEW_MOTION_OMEGA;

float PARTICLE_X_MOTION_PUSH = 0.00000;
float PARTICLE_Y_MOTION_PUSH = 0.00000;
float PARTICLE_Z_MOTION_PUSH = 0.00000;

float PARTICLE_X_MOTION_OMEGA = 0.00000;
float PARTICLE_Y_MOTION_OMEGA = 0.00000;
float PARTICLE_Z_MOTION_OMEGA = 0.00000;

float PARTICLE_X_START_SCALE = 0.40000;
float PARTICLE_Y_START_SCALE = 0.40000;
float PARTICLE_Z_START_SCALE = 0.00000;

float PARTICLE_X_END_SCALE = 0.10000;
float PARTICLE_Y_END_SCALE = 0.10000;
float PARTICLE_Z_END_SCALE = 0.00000;

integer PARTICLE_R_START_COLOR = 255;
integer PARTICLE_G_START_COLOR = 0;
integer PARTICLE_B_START_COLOR = 0;

integer PARTICLE_R_END_COLOR = 255;
integer PARTICLE_G_END_COLOR = 255;
integer PARTICLE_B_END_COLOR = 0;

string PARTICLE_COLOR_RGB_INPUT;
vector PARTICLE_COLOR_RGB_OUTPUT;

integer R;
integer G;
integer B;

integer PARTICLE_DEG_ANGLE_BEGIN = 180;
integer PARTICLE_DEG_ANGLE_END = 360;                
// Particle System
list PARTICLE_VALUES;
integer PARTICLE_PART_FLAGS = 259;
key PARTICLE_SRC_TARGET_KEY = "00000000-0000-0000-0000-000000000000";
string PARTICLE_SRC_TEXTURE = "00000000-0000-0000-0000-000000000000";
float PARTICLE_SRC_MAX_AGE = 0.000000;
float PARTICLE_PART_MAX_AGE = 1.600000;
float PARTICLE_SRC_BURST_RATE = 0.001000;
integer PARTICLE_SRC_BURST_PART_COUNT = 1;
float PARTICLE_SRC_BURST_RADIUS = 0.000000;
float PARTICLE_SRC_BURST_SPEED_MAX = 0.200000;
float PARTICLE_SRC_BURST_SPEED_MIN = 0.100000;
float PARTICLE_START_ALPHA = 1.000000;
float PARTICLE_END_ALPHA = 1.000000;
float PARTICLE_SRC_ANGLE_BEGIN = 3.141593;
float PARTICLE_SRC_ANGLE_END = 6.283185;
vector PARTICLE_START_COLOR = <1.000000,0.000000,0.000000>;
vector PARTICLE_END_COLOR = <1.000000,1.000000,0.000000>;
vector PARTICLE_START_SCALE = <0.40000, 0.40000, 0.00000>;
vector PARTICLE_END_SCALE = <0.10000, 0.10000, 0.00000>;
vector PARTICLE_SRC_ACCEL = <0.00000, 0.00000, 0.00000>;
vector PARTICLE_SRC_OMEGA = <0.00000, 0.00000, 0.00000>;
integer PARTICLE_SRC_PATTERN = 2;

// New Order
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

vector Vector2RGB( vector color )
{
    color *= 255;                //Scale the SL color up by 255
    return <(integer)color.x, (integer)color.y, (integer)color.z>;    //Make each part of it a whole number
}

default
{
    state_entry()
    {
        // Activate the timer listener every 2 seconds
        llSetTimerEvent(counter);
        PARTICLE_HANDLE = llListen(PARTICLE_CHANNEL, "", NULL_KEY, "");
        PARTICLE_NOTECARD = llGetInventoryName(INVENTORY_NOTECARD, INDEX = 0);
        if( ~llGetInventoryType(  PARTICLE_PREFIX + PARTICLE_NOTECARD ) ) NOTECARD_QUERY = llGetNotecardLine(PARTICLE_PREFIX + PARTICLE_NOTECARD, INDEX);
    }

    listen(integer channel, string name, key id, string message)
    {
        list PARTICLE_COMMAND = llParseString2List(message,[" "],[]);
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("PRESET"))
        {
            PARTICLE_NOTECARD = llList2String(PARTICLE_COMMAND, 1);
            if( ~llGetInventoryType(  PARTICLE_PREFIX + PARTICLE_NOTECARD ) )  NOTECARD_QUERY = llGetNotecardLine(PARTICLE_PREFIX + PARTICLE_NOTECARD, INDEX = 0);
        }        
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("CHANNEL"))
        {
            llListenRemove(PARTICLE_HANDLE);
            PARTICLE_CHANNEL = llList2Integer(PARTICLE_COMMAND, 1);
            llListen(PARTICLE_CHANNEL, "", NULL_KEY, "");      
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("TEXTURE"))
        {
            PARTICLE_SRC_TEXTURE = llList2String(PARTICLE_COMMAND, 1);
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("TARGET"))
        {
            if(llList2String(PARTICLE_COMMAND, 1) == llToLower("SELF"))
            {
                integer PARTICLE_PART_FLAGS_COPY = PARTICLE_PART_FLAGS;
                PARTICLE_PART_FLAGS = PARTICLE_PART_FLAGS_COPY | PSYS_PART_TARGET_POS_MASK;
                        PARTICLE_SRC_TARGET_KEY = llGetKey();
            }
            if(llList2String(PARTICLE_COMMAND, 1) == llToLower("OWNER"))
            {
                
                integer PARTICLE_PART_FLAGS_COPY = PARTICLE_PART_FLAGS;
                PARTICLE_PART_FLAGS = PARTICLE_PART_FLAGS_COPY | PSYS_PART_TARGET_POS_MASK;
                PARTICLE_SRC_TARGET_KEY = llGetOwner();
                
            }
            else
            {
                integer PARTICLE_PART_FLAGS_COPY = PARTICLE_PART_FLAGS;
                PARTICLE_PART_FLAGS = PARTICLE_PART_FLAGS_COPY | PSYS_PART_TARGET_POS_MASK;                
                PARTICLE_SRC_TARGET_KEY = (key)llList2String(PARTICLE_COMMAND, 2);
            }
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("SSIZE"))
        {
               PARTICLE_X_START_SCALE = llList2Float(PARTICLE_COMMAND, 1);
               PARTICLE_Y_START_SCALE = llList2Float(PARTICLE_COMMAND, 2);
               PARTICLE_Z_START_SCALE = llList2Float(PARTICLE_COMMAND, 3);
               PARTICLE_START_SCALE = <PARTICLE_X_START_SCALE, PARTICLE_Y_START_SCALE, PARTICLE_Z_START_SCALE>;
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("ESIZE"))
        {
               PARTICLE_X_END_SCALE = llList2Float(PARTICLE_COMMAND, 1);
               PARTICLE_Y_END_SCALE = llList2Float(PARTICLE_COMMAND, 2);
               PARTICLE_Z_END_SCALE = llList2Float(PARTICLE_COMMAND, 3);
               PARTICLE_END_SCALE = <PARTICLE_X_END_SCALE, PARTICLE_Y_END_SCALE, PARTICLE_Z_END_SCALE>;
        }        
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("SRGB"))
        {
                PARTICLE_COLOR_RGB_INPUT =  "<" +  llList2String(PARTICLE_COMMAND, 1) + "," + llList2String(PARTICLE_COMMAND, 2) + "," + llList2String(PARTICLE_COMMAND, 3) + ">";
                PARTICLE_COLOR_RGB_OUTPUT = (vector)PARTICLE_COLOR_RGB_INPUT / 255.0;
                PARTICLE_START_COLOR = PARTICLE_COLOR_RGB_OUTPUT;    
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("ERGB"))
        {
                PARTICLE_COLOR_RGB_INPUT =  "<" +  llList2String(PARTICLE_COMMAND, 1) + "," + llList2String(PARTICLE_COMMAND, 2) + "," + llList2String(PARTICLE_COMMAND, 3) + ">";
                PARTICLE_COLOR_RGB_OUTPUT = (vector)PARTICLE_COLOR_RGB_INPUT / 255.0;
                PARTICLE_END_COLOR = PARTICLE_COLOR_RGB_OUTPUT;    
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("SALPHA"))
        {
            PARTICLE_START_ALPHA = llList2Float(PARTICLE_COMMAND, 1);
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("EALPHA"))
        {
            PARTICLE_END_ALPHA = llList2Float(PARTICLE_COMMAND, 1);
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("RADIUS"))
        {
            PARTICLE_SRC_BURST_RADIUS = llList2Float(PARTICLE_COMMAND, 1);
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("SPEED"))
        {
            PARTICLE_SRC_BURST_SPEED_MIN = llList2Float(PARTICLE_COMMAND, 1);
            PARTICLE_SRC_BURST_SPEED_MAX = llList2Float(PARTICLE_COMMAND, 2);
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("PUSH"))
        {
            if(llList2String(PARTICLE_COMMAND, 1) == llToLower("X"))
            {
                PARTICLE_X_MOTION_PUSH = llList2Float(PARTICLE_COMMAND, 2);
                if (PARTICLE_X_MOTION_PUSH > TWO_PI) PARTICLE_X_MOTION_PUSH = 0;
            }
            if(llList2String(PARTICLE_COMMAND, 1) == llToLower("Y"))
            {
               PARTICLE_Y_MOTION_PUSH = llList2Float(PARTICLE_COMMAND, 2);
               if (PARTICLE_Y_MOTION_PUSH > TWO_PI) PARTICLE_Y_MOTION_PUSH = 0;
            }
            if(llList2String(PARTICLE_COMMAND, 1) == llToLower("Z"))
            {
                PARTICLE_Z_MOTION_PUSH = llList2Float(PARTICLE_COMMAND, 2);
                if (PARTICLE_Z_MOTION_PUSH > TWO_PI) PARTICLE_Z_MOTION_PUSH = 0;
            }
            PARTICLE_SRC_ACCEL =  <PARTICLE_X_MOTION_PUSH, PARTICLE_Y_MOTION_PUSH, PARTICLE_Z_MOTION_PUSH>;
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("ROTATION"))
        {
            if(llList2String(PARTICLE_COMMAND, 1) == llToLower("X"))
            {
                PARTICLE_X_MOTION_OMEGA = llList2Float(PARTICLE_COMMAND, 2);
                if (PARTICLE_X_MOTION_OMEGA > TWO_PI) PARTICLE_X_MOTION_OMEGA = 0;
            }
            if(llList2String(PARTICLE_COMMAND, 1) == llToLower("Y"))
            {
                PARTICLE_Y_MOTION_OMEGA = llList2Float(PARTICLE_COMMAND, 2);
                if (PARTICLE_Y_MOTION_OMEGA > TWO_PI) PARTICLE_Y_MOTION_OMEGA = 0;
            }
            if(llList2String(PARTICLE_COMMAND, 1) == llToLower("Z"))
            {
                PARTICLE_Z_MOTION_OMEGA = llList2Float(PARTICLE_COMMAND, 2);
                if (PARTICLE_Z_MOTION_OMEGA > TWO_PI) PARTICLE_Z_MOTION_OMEGA = 0;
            }                        
            PARTICLE_SRC_OMEGA = <PARTICLE_X_MOTION_OMEGA, PARTICLE_Y_MOTION_OMEGA, PARTICLE_Z_MOTION_OMEGA>;
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("RATE"))
        {
            PARTICLE_SRC_BURST_RATE = llList2Float(PARTICLE_COMMAND, 1);
            if (PARTICLE_SRC_BURST_RATE > PI) PARTICLE_SRC_BURST_RATE = 0.0;
            if (PARTICLE_SRC_BURST_RATE < 0.0) PARTICLE_SRC_BURST_RATE = 0.0;       
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("BURST"))
        {
            PARTICLE_SRC_BURST_PART_COUNT = llList2Integer(PARTICLE_COMMAND, 1);
            if (PARTICLE_SRC_BURST_PART_COUNT < 0) PARTICLE_SRC_BURST_PART_COUNT = 0;  
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("LIFE"))
        {
            PARTICLE_PART_MAX_AGE =  llList2Float(PARTICLE_COMMAND, 1);
            if (PARTICLE_PART_MAX_AGE > 30.0) PARTICLE_PART_MAX_AGE = 30.0;
            if (PARTICLE_PART_MAX_AGE < 0.0) PARTICLE_PART_MAX_AGE = 0.0;   
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("BANGLE"))
        {
            PARTICLE_DEG_ANGLE_BEGIN = llList2Integer(PARTICLE_COMMAND, 1);
            PARTICLE_SRC_ANGLE_BEGIN = PARTICLE_DEG_ANGLE_BEGIN * DEG_TO_RAD;
            if (PARTICLE_DEG_ANGLE_BEGIN > 360) PARTICLE_DEG_ANGLE_BEGIN = 360;
            if (PARTICLE_DEG_ANGLE_BEGIN < 0) PARTICLE_DEG_ANGLE_BEGIN = 0;
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("EANGLE"))
        {
            PARTICLE_DEG_ANGLE_END = llList2Integer(PARTICLE_COMMAND, 1);
            PARTICLE_SRC_ANGLE_END = PARTICLE_DEG_ANGLE_END * DEG_TO_RAD;
            if (PARTICLE_SRC_ANGLE_END > 360) PARTICLE_SRC_ANGLE_END = 360;
            if (PARTICLE_SRC_ANGLE_END < 0) PARTICLE_SRC_ANGLE_END = 0;            
        }
        if(llList2String(PARTICLE_COMMAND, 0) == llToLower("SYSLIFE"))
        {
            PARTICLE_SRC_MAX_AGE = llList2Float(PARTICLE_COMMAND, 1);
            if (PARTICLE_SRC_MAX_AGE > PI) PARTICLE_SRC_MAX_AGE = 0.0;
            if (PARTICLE_SRC_MAX_AGE < 0.0) PARTICLE_SRC_MAX_AGE = 0.0;
        }                
    }
    
    link_message(integer sent,integer num,string message,key id)
    {     
        if(num == PARTICLE_PRESET)
        {
            //list conversions
            PARTICLE_VALUES = llParseString2List(message,["|"],[]);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_PART_FLAGS") PARTICLE_PART_FLAGS = (integer)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_PART_START_SCALE") PARTICLE_START_SCALE = (vector)llList2String(PARTICLE_VALUES,1);            
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_PART_END_SCALE") PARTICLE_END_SCALE = (vector)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_PART_START_COLOR") PARTICLE_START_COLOR = (vector)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_PART_END_COLOR") PARTICLE_END_COLOR = (vector)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_PART_START_ALPHA") PARTICLE_START_ALPHA = (float)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_PART_END_ALPHA") PARTICLE_END_ALPHA = (float)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_PATTERN") PARTICLE_SRC_PATTERN = (integer)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_BURST_RATE") PARTICLE_SRC_BURST_RATE = (float)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_BURST_PART_COUNT") PARTICLE_SRC_BURST_PART_COUNT = (integer)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_BURST_RADIUS") PARTICLE_SRC_BURST_RADIUS = (float)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_BURST_SPEED_MIN") PARTICLE_SRC_BURST_SPEED_MIN = (float)llList2String(PARTICLE_VALUES,1);            
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_BURST_SPEED_MAX") PARTICLE_SRC_BURST_SPEED_MAX = (float)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_ANGLE_BEGIN") PARTICLE_SRC_ANGLE_BEGIN = (float)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_ANGLE_END") PARTICLE_SRC_ANGLE_END = (float)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_OMEGA") PARTICLE_SRC_OMEGA = (vector)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_ACCEL") PARTICLE_SRC_ACCEL = (vector)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_PART_MAX_AGE") PARTICLE_PART_MAX_AGE = (float)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_MAX_AGE") PARTICLE_SRC_MAX_AGE = (float)llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_TEXTURE") PARTICLE_SRC_TEXTURE = llList2String(PARTICLE_VALUES,1);
            if(llList2String(PARTICLE_VALUES,0) == "PSYS_SRC_TARGET_KEY") PARTICLE_SRC_TARGET_KEY = (key)llList2String(PARTICLE_VALUES,1);
        }
        if(num == PARTICLE_SCRIPT_GENERATE)
        {
            string PARTICLE_DATA_SEND =   
                              (string)PARTICLE_SCRIPT_TYPE + "#" + (string)PARTICLE_PART_FLAGS + "#" +
                              (string)PARTICLE_SRC_MAX_AGE + "#" + (string)PARTICLE_PART_MAX_AGE + "#" +
                              (string)PARTICLE_SRC_BURST_RATE + "#" + (string)PARTICLE_SRC_BURST_PART_COUNT + "#" + 
                              (string)PARTICLE_SRC_BURST_RADIUS + "#" + (string)PARTICLE_SRC_BURST_SPEED_MAX + "#" + (string)PARTICLE_SRC_BURST_SPEED_MIN + "#" +
                              (string)PARTICLE_START_ALPHA + "#" + (string)PARTICLE_END_ALPHA + "#" +
                              (string)PARTICLE_SRC_ANGLE_BEGIN + "#" + (string)PARTICLE_SRC_ANGLE_END + "#" +
                              (string)PARTICLE_START_COLOR + "#" + (string)PARTICLE_END_COLOR + "#" +
                              (string)PARTICLE_START_SCALE + "#" + (string)PARTICLE_END_SCALE + "#" + (string)PARTICLE_SRC_ACCEL + "#" +
                              (string)PARTICLE_SRC_OMEGA + "#" +(string)PARTICLE_SRC_PATTERN + "#" +
                              (string)PARTICLE_SRC_TEXTURE + "#" + (string)PARTICLE_SRC_TARGET_KEY;
                              llSay(0, "Gen Script");              
            llMessageLinked(LINK_SET, PARTICLE_SCRIPT_VARIABLES, PARTICLE_DATA_SEND, NULL_KEY);          
        }
        if(num == RESET_PARTICLE)
        {
            llResetScript();
        } 
        if(num == PARTICLE_START_COLOR_PLUS )
        {
            string PARTICLE_CLEAN_START_COLOR_1 = llDumpList2String(llParseString2List((string)Vector2RGB(PARTICLE_START_COLOR), ["<"], []), " ");
            string PARTICLE_CLEAN_START_COLOR_2 = llDumpList2String(llParseString2List((string)PARTICLE_CLEAN_START_COLOR_1, [">"], []), " ");
            PARTICLE_VALUES = llParseString2List((string)PARTICLE_CLEAN_START_COLOR_2,[","],[]);
            R = llList2Integer(PARTICLE_VALUES,0);
            G = llList2Integer(PARTICLE_VALUES,1);
            B = llList2Integer(PARTICLE_VALUES,2);
            if(message == "V")
            {
                PARTICLE_R_START_COLOR = R + 1;
                PARTICLE_G_START_COLOR = G + 1;
                PARTICLE_B_START_COLOR = B + 1;
                if (PARTICLE_R_START_COLOR > 255) PARTICLE_R_START_COLOR = 255;
                if (PARTICLE_R_START_COLOR < 0) PARTICLE_R_START_COLOR = 0;
                if (PARTICLE_G_START_COLOR > 255) PARTICLE_G_START_COLOR = 255;
                if (PARTICLE_G_START_COLOR < 0) PARTICLE_G_START_COLOR = 0;
                if (PARTICLE_B_START_COLOR > 255) PARTICLE_B_START_COLOR = 255;
                if (PARTICLE_B_START_COLOR < 0) PARTICLE_B_START_COLOR = 0;                    
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)PARTICLE_R_START_COLOR + "," + (string)PARTICLE_G_START_COLOR + "," + (string)PARTICLE_B_START_COLOR + ">"; 
            }            
            if(message == "R")
            {
                PARTICLE_R_START_COLOR = R + 1;
                if (PARTICLE_R_START_COLOR > 255) PARTICLE_R_START_COLOR = 255;
                if (PARTICLE_R_START_COLOR < 0) PARTICLE_R_START_COLOR = 0;
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)PARTICLE_R_START_COLOR + "," + (string)G + "," + (string)B + ">";                
            }
            if(message == "G")
            {
                PARTICLE_G_START_COLOR = G + 1;
                if (PARTICLE_G_START_COLOR > 255) PARTICLE_G_START_COLOR = 255;
                if (PARTICLE_G_START_COLOR < 0) PARTICLE_G_START_COLOR = 0;
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)R + "," + (string)PARTICLE_G_START_COLOR + "," + (string)B + ">";
            }
            if(message == "B")
            {
                PARTICLE_B_START_COLOR = B + 1;
                if (PARTICLE_B_START_COLOR > 255) PARTICLE_B_START_COLOR = 255;
                if (PARTICLE_B_START_COLOR < 0) PARTICLE_B_START_COLOR = 0;
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)R + "," + (string)G + "," + (string)PARTICLE_B_START_COLOR + ">";
            }
            PARTICLE_COLOR_RGB_OUTPUT = (vector)PARTICLE_COLOR_RGB_INPUT / 255.0;
            PARTICLE_START_COLOR = PARTICLE_COLOR_RGB_OUTPUT;
        }
        if(num == PARTICLE_START_COLOR_MINUS )
        {
            string PARTICLE_CLEAN_START_COLOR_1 = llDumpList2String(llParseString2List((string)Vector2RGB(PARTICLE_START_COLOR), ["<"], []), " ");
            string PARTICLE_CLEAN_START_COLOR_2 = llDumpList2String(llParseString2List((string)PARTICLE_CLEAN_START_COLOR_1, [">"], []), " ");
            PARTICLE_VALUES = llParseString2List((string)PARTICLE_CLEAN_START_COLOR_2,[","],[]);
            R = llList2Integer(PARTICLE_VALUES,0);
            G = llList2Integer(PARTICLE_VALUES,1);
            B = llList2Integer(PARTICLE_VALUES,2);
            if(message == "V")
            {
                PARTICLE_R_START_COLOR = R - 1;
                PARTICLE_G_START_COLOR = G - 1;
                PARTICLE_B_START_COLOR = B - 1;
                if (PARTICLE_R_START_COLOR > 255) PARTICLE_R_START_COLOR = 255;
                if (PARTICLE_R_START_COLOR < 0) PARTICLE_R_START_COLOR = 0;
                if (PARTICLE_G_START_COLOR > 255) PARTICLE_G_START_COLOR = 255;
                if (PARTICLE_G_START_COLOR < 0) PARTICLE_G_START_COLOR = 0;
                if (PARTICLE_B_START_COLOR > 255) PARTICLE_B_START_COLOR = 255;
                if (PARTICLE_B_START_COLOR < 0) PARTICLE_B_START_COLOR = 0;                    
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)PARTICLE_R_START_COLOR + "," + (string)PARTICLE_G_START_COLOR + "," + (string)PARTICLE_B_START_COLOR + ">"; 
            }                            
            if(message == "R")
            {
                PARTICLE_R_START_COLOR = R - 1;
                if (PARTICLE_R_START_COLOR > 255) PARTICLE_R_START_COLOR = 255;
                if (PARTICLE_R_START_COLOR < 0) PARTICLE_R_START_COLOR = 0;
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)PARTICLE_R_START_COLOR + "," + (string)G + "," + (string)B + ">";                
            }
            if(message == "G")
            {
                PARTICLE_G_START_COLOR = G - 1;
                if (PARTICLE_G_START_COLOR > 255) PARTICLE_G_START_COLOR = 255;
                if (PARTICLE_G_START_COLOR < 0) PARTICLE_G_START_COLOR = 0;
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)R + "," + (string)PARTICLE_G_START_COLOR + "," + (string)B + ">";
            }
            if(message == "B")
            {
                PARTICLE_B_START_COLOR = B - 1;
                if (PARTICLE_B_START_COLOR > 255) PARTICLE_B_START_COLOR = 255;
                if (PARTICLE_B_START_COLOR < 0) PARTICLE_B_START_COLOR = 0;
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)R + "," + (string)G + "," + (string)PARTICLE_B_START_COLOR + ">";
            }
            PARTICLE_COLOR_RGB_OUTPUT = (vector)PARTICLE_COLOR_RGB_INPUT / 255.0;
            PARTICLE_START_COLOR = PARTICLE_COLOR_RGB_OUTPUT;
        }
        if(num == PARTICLE_END_COLOR_PLUS )
        {
            string PARTICLE_CLEAN_END_COLOR_1 = llDumpList2String(llParseString2List((string)Vector2RGB(PARTICLE_END_COLOR), ["<"], []), " ");
            string PARTICLE_CLEAN_END_COLOR_2 = llDumpList2String(llParseString2List((string)PARTICLE_CLEAN_END_COLOR_1, [">"], []), " ");
            PARTICLE_VALUES = llParseString2List((string)PARTICLE_CLEAN_END_COLOR_2,[","],[]);
            R = llList2Integer(PARTICLE_VALUES,0);
            G = llList2Integer(PARTICLE_VALUES,1);
            B = llList2Integer(PARTICLE_VALUES,2);
            if(message == "V")
            {
                PARTICLE_R_END_COLOR = R + 1;
                PARTICLE_G_END_COLOR = G + 1;
                PARTICLE_B_END_COLOR = B + 1;
                if (PARTICLE_R_END_COLOR > 255) PARTICLE_R_END_COLOR = 255;
                if (PARTICLE_R_END_COLOR < 0) PARTICLE_R_END_COLOR = 0;
                if (PARTICLE_G_END_COLOR > 255) PARTICLE_G_END_COLOR = 255;
                if (PARTICLE_G_END_COLOR < 0) PARTICLE_G_END_COLOR = 0;
                if (PARTICLE_B_END_COLOR > 255) PARTICLE_B_END_COLOR = 255;
                if (PARTICLE_B_END_COLOR < 0) PARTICLE_B_END_COLOR = 0;                    
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)PARTICLE_R_END_COLOR + "," + (string)PARTICLE_G_END_COLOR + "," + (string)PARTICLE_B_END_COLOR + ">"; 
            }                                          
            if(message == "R")
            {
                PARTICLE_R_END_COLOR = R + 1;
                if (PARTICLE_R_END_COLOR > 255) PARTICLE_R_END_COLOR = 255;
                if (PARTICLE_R_END_COLOR < 0) PARTICLE_R_END_COLOR = 0;
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)PARTICLE_R_END_COLOR + "," + (string)G + "," + (string)B + ">";                
            }
            if(message == "G")
            {
                PARTICLE_G_END_COLOR = G + 1;
                if (PARTICLE_G_END_COLOR > 255) PARTICLE_G_END_COLOR = 255;
                if (PARTICLE_G_END_COLOR < 0) PARTICLE_G_END_COLOR = 0;
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)R + "," + (string)PARTICLE_G_END_COLOR + "," + (string)B + ">";
            }
            if(message == "B")
            {
                PARTICLE_B_END_COLOR = B + 1;
                if (PARTICLE_B_END_COLOR > 255) PARTICLE_B_END_COLOR = 255;
                if (PARTICLE_B_END_COLOR < 0) PARTICLE_B_END_COLOR = 0;
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)R + "," + (string)G + "," + (string)PARTICLE_B_END_COLOR + ">";
            }
            PARTICLE_COLOR_RGB_OUTPUT = (vector)PARTICLE_COLOR_RGB_INPUT / 255.0;
            PARTICLE_END_COLOR = PARTICLE_COLOR_RGB_OUTPUT;
        }
        if(num == PARTICLE_END_COLOR_MINUS )
        {
            string PARTICLE_CLEAN_END_COLOR_1 = llDumpList2String(llParseString2List((string)Vector2RGB(PARTICLE_END_COLOR), ["<"], []), " ");
            string PARTICLE_CLEAN_END_COLOR_2 = llDumpList2String(llParseString2List((string)PARTICLE_CLEAN_END_COLOR_1, [">"], []), " ");
            PARTICLE_VALUES = llParseString2List((string)PARTICLE_CLEAN_END_COLOR_2,[","],[]);
            R = llList2Integer(PARTICLE_VALUES,0);
            G = llList2Integer(PARTICLE_VALUES,1);
            B = llList2Integer(PARTICLE_VALUES,2);
            if(message == "V")
            {
                PARTICLE_R_END_COLOR = R - 1;
                PARTICLE_G_END_COLOR = G - 1;
                PARTICLE_B_END_COLOR = B - 1;
                if (PARTICLE_R_END_COLOR > 255) PARTICLE_R_END_COLOR = 255;
                if (PARTICLE_R_END_COLOR < 0) PARTICLE_R_END_COLOR = 0;
                if (PARTICLE_G_END_COLOR > 255) PARTICLE_G_END_COLOR = 255;
                if (PARTICLE_G_END_COLOR < 0) PARTICLE_G_END_COLOR = 0;
                if (PARTICLE_B_END_COLOR > 255) PARTICLE_B_END_COLOR = 255;
                if (PARTICLE_B_END_COLOR < 0) PARTICLE_B_END_COLOR = 0;                    
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)PARTICLE_R_END_COLOR + "," + (string)PARTICLE_G_END_COLOR + "," + (string)PARTICLE_B_END_COLOR + ">"; 
            }                            
            if(message == "R")
            {
                PARTICLE_R_END_COLOR = R - 1;
                if (PARTICLE_R_END_COLOR > 255) PARTICLE_R_END_COLOR = 255;
                if (PARTICLE_R_END_COLOR < 0) PARTICLE_R_END_COLOR = 0;
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)PARTICLE_R_END_COLOR + "," + (string)G + "," + (string)B + ">";                
            }
            if(message == "G")
            {
                PARTICLE_G_END_COLOR = G - 1;
                if (PARTICLE_G_END_COLOR > 255) PARTICLE_G_END_COLOR = 255;
                if (PARTICLE_G_END_COLOR < 0) PARTICLE_G_END_COLOR = 0;
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)R + "," + (string)PARTICLE_G_END_COLOR + "," + (string)B + ">";
            }
            if(message == "B")
            {
                PARTICLE_B_END_COLOR = B - 1;
                if (PARTICLE_B_END_COLOR > 255) PARTICLE_B_END_COLOR = 255;
                if (PARTICLE_B_END_COLOR < 0) PARTICLE_B_END_COLOR = 0;
                PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)R + "," + (string)G + "," + (string)PARTICLE_B_END_COLOR + ">";
            }
            PARTICLE_COLOR_RGB_OUTPUT = (vector)PARTICLE_COLOR_RGB_INPUT / 255.0;
            PARTICLE_END_COLOR = PARTICLE_COLOR_RGB_OUTPUT;
        }
        
        if(num == PARTICLE_COLOR_WHITE )
        {
            R = 255;
            G = 255;
            B = 255;
            PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)R + "," + (string)G + "," + (string)B + ">";
            PARTICLE_COLOR_RGB_OUTPUT = (vector)PARTICLE_COLOR_RGB_INPUT / 255.0;
            if(message == "START")
            {
                PARTICLE_START_COLOR = PARTICLE_COLOR_RGB_OUTPUT;
            }
            if(message == "END")
            {
                PARTICLE_END_COLOR = PARTICLE_COLOR_RGB_OUTPUT;
            }
        }
        if(num == PARTICLE_COLOR_BLACK )
        {
            R = 0;
            G = 0;
            B = 0;
            PARTICLE_COLOR_RGB_INPUT =  "<" +  (string)R + "," + (string)G + "," + (string)B + ">";
            PARTICLE_COLOR_RGB_OUTPUT = (vector)PARTICLE_COLOR_RGB_INPUT / 255.0;
            if(message == "START")
            {
                PARTICLE_START_COLOR = PARTICLE_COLOR_RGB_OUTPUT;
            }
            if(message == "END")
            {
                PARTICLE_END_COLOR = PARTICLE_COLOR_RGB_OUTPUT;
            }
        }
        if(num == PARTICLE_ALPHA_START )
        {
            if(message == "salphau")
            {
                PARTICLE_START_ALPHA = PARTICLE_START_ALPHA + PARTICLE_CONTROLS;
                if (PARTICLE_START_ALPHA > 1.0) PARTICLE_START_ALPHA = 1.0;
                if (PARTICLE_START_ALPHA < 0.0) PARTICLE_START_ALPHA = 0;
            }
            if(message == "salphad")
            {
                PARTICLE_START_ALPHA = PARTICLE_START_ALPHA - PARTICLE_CONTROLS;
                if (PARTICLE_START_ALPHA > 1.0) PARTICLE_START_ALPHA = 1.0;
                if (PARTICLE_START_ALPHA < 0.0) PARTICLE_START_ALPHA = 0;
            }
        }
        if(num == PARTICLE_ALPHA_END )
        {
            if(message == "ealphau")
            {
                PARTICLE_END_ALPHA = PARTICLE_END_ALPHA + PARTICLE_CONTROLS;
                if (PARTICLE_END_ALPHA > 1.0) PARTICLE_END_ALPHA = 1.0;
                if (PARTICLE_END_ALPHA < 0.0) PARTICLE_END_ALPHA = 0;
            }
            if(message == "ealphad")
            {
                PARTICLE_END_ALPHA = PARTICLE_END_ALPHA - PARTICLE_CONTROLS;
                if (PARTICLE_END_ALPHA > 1.0) PARTICLE_END_ALPHA = 1.0;
                if (PARTICLE_END_ALPHA < 0.0) PARTICLE_END_ALPHA = 0;
            }
        }
        if(num == PARTICLE_ALPHA_STATE)
        {
            if(message == "salphaclear") PARTICLE_START_ALPHA = 0.0;
            if(message == "salphasolid") PARTICLE_START_ALPHA = 1.0;
            if(message == "ealphaclear") PARTICLE_END_ALPHA = 0.0;
            if(message == "ealphasolid") PARTICLE_END_ALPHA = 1.0;                        
        }
        if(num == PARTICLE_START_SCALE_PLUS )
        {   
            string PARTICLE_CLEAN_START_SCALE_1 = llDumpList2String(llParseString2List((string)PARTICLE_START_SCALE, ["<"], []), " ");
            string PARTICLE_CLEAN_START_SCALE_2 = llDumpList2String(llParseString2List((string)PARTICLE_CLEAN_START_SCALE_1, [">"], []), " ");
            PARTICLE_VALUES = llParseString2List((string)PARTICLE_CLEAN_START_SCALE_2,[","],[]);
            if(message == "sscalexu")
            {
               PARTICLE_X_START_SCALE = PARTICLE_X_START_SCALE + PARTICLE_CONTROLS;
               if (PARTICLE_X_START_SCALE > TWO_PI) PARTICLE_X_START_SCALE = 0;
               PARTICLE_NEW_START_SCALE =  "<" + (string)PARTICLE_X_START_SCALE + "," + llList2String(PARTICLE_VALUES,1) + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "sscaleyu")
            {
               PARTICLE_Y_START_SCALE = PARTICLE_Y_START_SCALE + PARTICLE_CONTROLS;
               if (PARTICLE_Y_START_SCALE > TWO_PI) PARTICLE_Y_START_SCALE = 0;
               PARTICLE_NEW_START_SCALE =  "<" + llList2String(PARTICLE_VALUES,0) + "," + (string)PARTICLE_Y_START_SCALE + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "sscalexyu")
            {
               PARTICLE_X_START_SCALE = PARTICLE_X_START_SCALE + PARTICLE_CONTROLS;
               if (PARTICLE_X_START_SCALE > TWO_PI) PARTICLE_X_START_SCALE = 0;
               PARTICLE_Y_START_SCALE = PARTICLE_Y_START_SCALE + PARTICLE_CONTROLS;
               if (PARTICLE_Y_START_SCALE > TWO_PI) PARTICLE_Y_START_SCALE = 0;            
               PARTICLE_NEW_START_SCALE =  "<" + (string)PARTICLE_X_START_SCALE + "," + (string)PARTICLE_Y_START_SCALE + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            PARTICLE_START_SCALE = (vector)PARTICLE_NEW_START_SCALE;
        }
        if(num == PARTICLE_START_SCALE_MINUS )
        {   
            string PARTICLE_CLEAN_START_SCALE_1 = llDumpList2String(llParseString2List((string)PARTICLE_START_SCALE, ["<"], []), " ");
            string PARTICLE_CLEAN_START_SCALE_2 = llDumpList2String(llParseString2List((string)PARTICLE_CLEAN_START_SCALE_1, [">"], []), " ");
            PARTICLE_VALUES = llParseString2List((string)PARTICLE_CLEAN_START_SCALE_2,[","],[]);
            if(message == "sscalexd")
            {
               PARTICLE_X_START_SCALE = PARTICLE_X_START_SCALE - PARTICLE_CONTROLS;
               if (PARTICLE_X_START_SCALE > TWO_PI) PARTICLE_X_START_SCALE = 0;
               PARTICLE_NEW_START_SCALE =  "<" + (string)PARTICLE_X_START_SCALE + "," + llList2String(PARTICLE_VALUES,1) + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "sscaleyd")
            {
               PARTICLE_Y_START_SCALE = PARTICLE_Y_START_SCALE - PARTICLE_CONTROLS;
               if (PARTICLE_Y_START_SCALE > TWO_PI) PARTICLE_Y_START_SCALE = 0;
               PARTICLE_NEW_START_SCALE =  "<" + llList2String(PARTICLE_VALUES,0) + "," + (string)PARTICLE_Y_START_SCALE + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "sscalexyd")
            {
               PARTICLE_X_START_SCALE = PARTICLE_X_START_SCALE - PARTICLE_CONTROLS;
               if (PARTICLE_X_START_SCALE > TWO_PI) PARTICLE_X_START_SCALE = 0;
               else if (PARTICLE_X_START_SCALE < 0.0) PARTICLE_X_START_SCALE = 0;
               PARTICLE_Y_START_SCALE = PARTICLE_Y_START_SCALE - PARTICLE_CONTROLS;
               if (PARTICLE_Y_START_SCALE > TWO_PI) PARTICLE_Y_START_SCALE = 0;
               else if (PARTICLE_Y_START_SCALE < 0.0) PARTICLE_Y_START_SCALE = 0;
               PARTICLE_NEW_START_SCALE =  "<" + (string)PARTICLE_X_START_SCALE + "," + (string)PARTICLE_Y_START_SCALE + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            PARTICLE_START_SCALE = (vector)PARTICLE_NEW_START_SCALE;
        }
        if(num == PARTICLE_END_SCALE_PLUS )
        {   
            string PARTICLE_CLEAN_END_SCALE_1 = llDumpList2String(llParseString2List((string)PARTICLE_END_SCALE, ["<"], []), " ");
            string PARTICLE_CLEAN_END_SCALE_2 = llDumpList2String(llParseString2List((string)PARTICLE_CLEAN_END_SCALE_1, [">"], []), " ");
            PARTICLE_VALUES = llParseString2List((string)PARTICLE_CLEAN_END_SCALE_2,[","],[]);
            if(message == "escalexu")
            {
               PARTICLE_X_END_SCALE = PARTICLE_X_END_SCALE + PARTICLE_CONTROLS;
               if (PARTICLE_X_END_SCALE > TWO_PI) PARTICLE_X_END_SCALE = 0;
               PARTICLE_NEW_END_SCALE =  "<" + (string)PARTICLE_X_END_SCALE + "," + llList2String(PARTICLE_VALUES,1) + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "escaleyu")
            {
               PARTICLE_Y_END_SCALE = PARTICLE_Y_END_SCALE + PARTICLE_CONTROLS;
               if (PARTICLE_Y_END_SCALE > TWO_PI) PARTICLE_Y_END_SCALE = 0;
               PARTICLE_NEW_END_SCALE =  "<" + llList2String(PARTICLE_VALUES,0) + "," + (string)PARTICLE_Y_END_SCALE + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "escalexyu")
            {
               PARTICLE_X_END_SCALE = PARTICLE_X_END_SCALE + PARTICLE_CONTROLS;
               if (PARTICLE_X_END_SCALE > TWO_PI) PARTICLE_X_END_SCALE = 0;
               PARTICLE_Y_END_SCALE = PARTICLE_Y_END_SCALE + PARTICLE_CONTROLS;
               if (PARTICLE_Y_END_SCALE > TWO_PI) PARTICLE_Y_END_SCALE = 0;            
               PARTICLE_NEW_END_SCALE =  "<" + (string)PARTICLE_X_END_SCALE + "," + (string)PARTICLE_Y_END_SCALE + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            PARTICLE_END_SCALE = (vector)PARTICLE_NEW_END_SCALE;
        }
        if(num == PARTICLE_END_SCALE_MINUS )
        {   
            string PARTICLE_CLEAN_END_SCALE_1 = llDumpList2String(llParseString2List((string)PARTICLE_END_SCALE, ["<"], []), " ");
            string PARTICLE_CLEAN_END_SCALE_2 = llDumpList2String(llParseString2List((string)PARTICLE_CLEAN_END_SCALE_1, [">"], []), " ");
            PARTICLE_VALUES = llParseString2List((string)PARTICLE_CLEAN_END_SCALE_2,[","],[]);
            if(message == "escalexd")
            {
               PARTICLE_X_END_SCALE = PARTICLE_X_END_SCALE - PARTICLE_CONTROLS;
               if (PARTICLE_X_END_SCALE > TWO_PI) PARTICLE_X_END_SCALE = 0;
               PARTICLE_NEW_END_SCALE =  "<" + (string)PARTICLE_X_END_SCALE + "," + llList2String(PARTICLE_VALUES,1) + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "escaleyd")
            {
               PARTICLE_Y_END_SCALE = PARTICLE_Y_END_SCALE - PARTICLE_CONTROLS;
               if (PARTICLE_Y_END_SCALE > TWO_PI) PARTICLE_Y_END_SCALE = 0;
               PARTICLE_NEW_END_SCALE =  "<" + llList2String(PARTICLE_VALUES,0) + "," + (string)PARTICLE_Y_END_SCALE + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "escalexyd")
            {
               PARTICLE_X_END_SCALE = PARTICLE_X_END_SCALE - PARTICLE_CONTROLS;
               if (PARTICLE_X_END_SCALE > TWO_PI) PARTICLE_X_END_SCALE = 0;
               else if (PARTICLE_X_END_SCALE < 0.0) PARTICLE_X_END_SCALE = 0;
               PARTICLE_Y_END_SCALE = PARTICLE_Y_END_SCALE - PARTICLE_CONTROLS;
               if (PARTICLE_Y_END_SCALE > TWO_PI) PARTICLE_Y_END_SCALE = 0;
               else if (PARTICLE_Y_END_SCALE < 0.0) PARTICLE_Y_END_SCALE = 0;
               PARTICLE_NEW_END_SCALE =  "<" + (string)PARTICLE_X_END_SCALE + "," + (string)PARTICLE_Y_END_SCALE + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            PARTICLE_END_SCALE = (vector)PARTICLE_NEW_END_SCALE;
        }

        if(num == PARTICLE_EMITTER_TYPE)
        {
            if(message == "explosion")
            {
                PARTICLE_SRC_PATTERN = PSYS_SRC_PATTERN_EXPLODE;
                llOwnerSay("Emitter Type Explosion Enabled");
            }
            if(message == "angle")
            {
                PARTICLE_SRC_PATTERN = PSYS_SRC_PATTERN_ANGLE;
                llOwnerSay("Emitter Type Angle Enabled");
            }
            if(message == "angle cone")
            {
                PARTICLE_SRC_PATTERN = PSYS_SRC_PATTERN_ANGLE_CONE;
                llOwnerSay("Emitter Type Angle Cone Enabled");
            }                        
        }

        if(num == PARTICLE_EMITTER_RANGE)
        {
            if(message == "emitter begin up")
            {
                 PARTICLE_DEG_ANGLE_BEGIN = PARTICLE_DEG_ANGLE_BEGIN + PARTICLE_CONTROLS_INT;
                 PARTICLE_SRC_ANGLE_BEGIN = PARTICLE_DEG_ANGLE_BEGIN * DEG_TO_RAD;
                 if (PARTICLE_DEG_ANGLE_BEGIN > 360) PARTICLE_DEG_ANGLE_BEGIN = 360;
                 if (PARTICLE_DEG_ANGLE_BEGIN < 0) PARTICLE_DEG_ANGLE_BEGIN = 0;
            }
            if(message == "emitter end up")
            {
                 PARTICLE_DEG_ANGLE_END = PARTICLE_DEG_ANGLE_END + PARTICLE_CONTROLS_INT;
                 PARTICLE_SRC_ANGLE_END = PARTICLE_DEG_ANGLE_END * DEG_TO_RAD;
                 if (PARTICLE_DEG_ANGLE_END > 360) PARTICLE_DEG_ANGLE_END = 360;
                 if (PARTICLE_DEG_ANGLE_END < 0) PARTICLE_DEG_ANGLE_END = 0;
            }
            if(message == "emitter begin down")
            {
                 PARTICLE_DEG_ANGLE_BEGIN = PARTICLE_DEG_ANGLE_BEGIN - PARTICLE_CONTROLS_INT;
                 PARTICLE_SRC_ANGLE_BEGIN = PARTICLE_DEG_ANGLE_BEGIN * DEG_TO_RAD;
                 if (PARTICLE_DEG_ANGLE_BEGIN > 360) PARTICLE_DEG_ANGLE_BEGIN = 360;
                 if (PARTICLE_DEG_ANGLE_BEGIN < 0) PARTICLE_DEG_ANGLE_BEGIN = 0;
            }
            if(message == "emitter end down")
            {
                 PARTICLE_DEG_ANGLE_END = PARTICLE_DEG_ANGLE_END - PARTICLE_CONTROLS_INT;
                 PARTICLE_SRC_ANGLE_END = PARTICLE_DEG_ANGLE_END * DEG_TO_RAD;
                 if (PARTICLE_DEG_ANGLE_END > 360) PARTICLE_DEG_ANGLE_END = 360;
                 if (PARTICLE_DEG_ANGLE_END < 0) PARTICLE_DEG_ANGLE_END = 0;
            }
            if(message == "emitter max")
            {
                 PARTICLE_SRC_ANGLE_BEGIN =  180 * DEG_TO_RAD;
                 PARTICLE_SRC_ANGLE_END =  360 * DEG_TO_RAD;
            } 
            if(message == "emitter min")
            {
                 PARTICLE_SRC_ANGLE_BEGIN =  0.0 * DEG_TO_RAD;
                 PARTICLE_SRC_ANGLE_END =  0.0 * DEG_TO_RAD;
            }                                                
        }
        
        if(num == PARTICLE_MOTION_SPEED)
        {
            if(message == "SPEEDMINUP")
            {
                PARTICLE_SRC_BURST_SPEED_MIN = PARTICLE_SRC_BURST_SPEED_MIN + PARTICLE_CONTROLS;
                if (PARTICLE_SRC_BURST_SPEED_MIN > PI) PARTICLE_SRC_BURST_SPEED_MIN = 0.0;
                if (PARTICLE_SRC_BURST_SPEED_MIN < 0.0) PARTICLE_SRC_BURST_SPEED_MIN = 0.0;
            }
            if(message == "SPEEDMINDOWN")
            {
                PARTICLE_SRC_BURST_SPEED_MIN = PARTICLE_SRC_BURST_SPEED_MIN - PARTICLE_CONTROLS;
                if (PARTICLE_SRC_BURST_SPEED_MIN > PI) PARTICLE_SRC_BURST_SPEED_MIN = 0.0;
                if (PARTICLE_SRC_BURST_SPEED_MIN < 0.0) PARTICLE_SRC_BURST_SPEED_MIN = 0.0;                
            }
            if(message == "SPEEDMAXUP")
            {
                PARTICLE_SRC_BURST_SPEED_MAX = PARTICLE_SRC_BURST_SPEED_MAX + PARTICLE_CONTROLS;
                if (PARTICLE_SRC_BURST_SPEED_MAX > PI) PARTICLE_SRC_BURST_SPEED_MAX = 0.0;
                if (PARTICLE_SRC_BURST_SPEED_MAX < 0.0) PARTICLE_SRC_BURST_SPEED_MAX = 0.0;
            }
            if(message == "SPEEDMAXDOWN")
            {
                PARTICLE_SRC_BURST_SPEED_MAX = PARTICLE_SRC_BURST_SPEED_MAX - PARTICLE_CONTROLS;
                if (PARTICLE_SRC_BURST_SPEED_MAX > PI) PARTICLE_SRC_BURST_SPEED_MAX = 0.0;
                if (PARTICLE_SRC_BURST_SPEED_MAX < 0.0) PARTICLE_SRC_BURST_SPEED_MAX = 0.0;
            }                        
        }
        if(num == PARTICLE_MOTION_PUSH)
        {
            string PARTICLE_CLEAN_START_MOTION_1 = llDumpList2String(llParseString2List((string)PARTICLE_SRC_ACCEL, ["<"], []), " ");
            string PARTICLE_CLEAN_START_MOTION_2 = llDumpList2String(llParseString2List((string)PARTICLE_CLEAN_START_MOTION_1, [">"], []), " ");
            PARTICLE_VALUES = llParseString2List((string)PARTICLE_CLEAN_START_MOTION_2,[","],[]);
                        
            if(message == "XUP")
            {
                PARTICLE_X_MOTION_PUSH = PARTICLE_X_MOTION_PUSH + PARTICLE_CONTROLS;
                if (PARTICLE_X_MOTION_PUSH > TWO_PI) PARTICLE_X_MOTION_PUSH = 0;
                PARTICLE_NEW_MOTION_PUSH =  "<" + (string)PARTICLE_X_MOTION_PUSH + "," + llList2String(PARTICLE_VALUES,1) + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "YUP")
            {
                PARTICLE_Y_MOTION_PUSH = PARTICLE_Y_MOTION_PUSH + PARTICLE_CONTROLS;
                if (PARTICLE_Y_MOTION_PUSH > TWO_PI) PARTICLE_Y_MOTION_PUSH = 0;
                PARTICLE_NEW_MOTION_PUSH =  "<" + llList2String(PARTICLE_VALUES,0) + "," + (string)PARTICLE_Y_MOTION_PUSH + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "ZUP")
            {
                PARTICLE_Z_MOTION_PUSH = PARTICLE_Z_MOTION_PUSH + PARTICLE_CONTROLS;
                if (PARTICLE_Z_MOTION_PUSH > TWO_PI) PARTICLE_Z_MOTION_PUSH = 0;
                PARTICLE_NEW_MOTION_PUSH =  "<" + llList2String(PARTICLE_VALUES,0) + "," + llList2String(PARTICLE_VALUES,1) + "," + (string)PARTICLE_Z_MOTION_PUSH + ">";
            }
            if(message == "XDOWN")
            {
                PARTICLE_X_MOTION_PUSH = PARTICLE_X_MOTION_PUSH - PARTICLE_CONTROLS;
                if (PARTICLE_X_MOTION_PUSH > TWO_PI) PARTICLE_X_MOTION_PUSH = 0;
                PARTICLE_NEW_MOTION_PUSH =  "<" + (string)PARTICLE_X_MOTION_PUSH + "," + llList2String(PARTICLE_VALUES,1) + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "YDOWN")
            {
                PARTICLE_Y_MOTION_PUSH = PARTICLE_Y_MOTION_PUSH - PARTICLE_CONTROLS;
                if (PARTICLE_Y_MOTION_PUSH > TWO_PI) PARTICLE_Y_MOTION_PUSH = 0;
                PARTICLE_NEW_MOTION_PUSH =  "<" + llList2String(PARTICLE_VALUES,0) + "," + (string)PARTICLE_Y_MOTION_PUSH + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "ZDOWN")
            {
                PARTICLE_Z_MOTION_PUSH = PARTICLE_Z_MOTION_PUSH - PARTICLE_CONTROLS;
                if (PARTICLE_Z_MOTION_PUSH > TWO_PI) PARTICLE_Z_MOTION_PUSH = 0;
                PARTICLE_NEW_MOTION_PUSH =  "<" + llList2String(PARTICLE_VALUES,0) + "," + llList2String(PARTICLE_VALUES,1) + "," + (string)PARTICLE_Z_MOTION_PUSH + ">";
            }
            if(message == "RESET")
            {
                PARTICLE_NEW_MOTION_PUSH = "<0.00000, 0.00000, 0.00000>";
            }
            PARTICLE_SRC_ACCEL = (vector)PARTICLE_NEW_MOTION_PUSH;                                
        }
        if(num == PARTICLE_MOTION_ROTATION)
        {
            string PARTICLE_CLEAN_START_OMEGA_1 = llDumpList2String(llParseString2List((string)PARTICLE_SRC_OMEGA, ["<"], []), " ");
            string PARTICLE_CLEAN_START_OMEGA_2 = llDumpList2String(llParseString2List((string)PARTICLE_CLEAN_START_OMEGA_1, [">"], []), " ");
            PARTICLE_VALUES = llParseString2List((string)PARTICLE_CLEAN_START_OMEGA_2,[","],[]);
            
            if(message == "XUP")
            {
                PARTICLE_X_MOTION_OMEGA = PARTICLE_X_MOTION_OMEGA + PARTICLE_CONTROLS;
                if (PARTICLE_X_MOTION_OMEGA > TWO_PI) PARTICLE_X_MOTION_OMEGA = 0;
                PARTICLE_NEW_MOTION_OMEGA =  "<" + (string)PARTICLE_X_MOTION_OMEGA + "," + llList2String(PARTICLE_VALUES,1) + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "YUP")
            {
                PARTICLE_Y_MOTION_OMEGA = PARTICLE_Y_MOTION_OMEGA + PARTICLE_CONTROLS;
                if (PARTICLE_Y_MOTION_OMEGA > TWO_PI) PARTICLE_Y_MOTION_OMEGA = 0;
                PARTICLE_NEW_MOTION_OMEGA =  "<" + llList2String(PARTICLE_VALUES,0) + "," + (string)PARTICLE_Y_MOTION_OMEGA + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "ZUP")
            {
                PARTICLE_Z_MOTION_OMEGA = PARTICLE_Z_MOTION_OMEGA + PARTICLE_CONTROLS;
                if (PARTICLE_Z_MOTION_OMEGA > TWO_PI) PARTICLE_Z_MOTION_OMEGA = 0;
                PARTICLE_NEW_MOTION_OMEGA =  "<" + llList2String(PARTICLE_VALUES,0) + "," + llList2String(PARTICLE_VALUES,1) + "," + (string)PARTICLE_Z_MOTION_OMEGA + ">";
            }
            if(message == "XDOWN")
            {
                PARTICLE_X_MOTION_OMEGA = PARTICLE_X_MOTION_OMEGA - PARTICLE_CONTROLS;
                if (PARTICLE_X_MOTION_OMEGA > TWO_PI) PARTICLE_X_MOTION_OMEGA = 0;
                PARTICLE_NEW_MOTION_OMEGA =  "<" + (string)PARTICLE_X_MOTION_OMEGA + "," + llList2String(PARTICLE_VALUES,1) + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "YDOWN")
            {
                PARTICLE_Y_MOTION_OMEGA = PARTICLE_Y_MOTION_OMEGA - PARTICLE_CONTROLS;
                if (PARTICLE_Y_MOTION_OMEGA > TWO_PI) PARTICLE_Y_MOTION_OMEGA = 0;
                PARTICLE_NEW_MOTION_OMEGA =  "<" + llList2String(PARTICLE_VALUES,0) + "," + (string)PARTICLE_Y_MOTION_OMEGA + "," + llList2String(PARTICLE_VALUES,2) + ">";
            }
            if(message == "ZDOWN")
            {
                PARTICLE_Z_MOTION_OMEGA = PARTICLE_Z_MOTION_OMEGA - PARTICLE_CONTROLS;
                if (PARTICLE_Z_MOTION_OMEGA > TWO_PI) PARTICLE_Z_MOTION_OMEGA = 0;
                PARTICLE_NEW_MOTION_OMEGA =  "<" + llList2String(PARTICLE_VALUES,0) + "," + llList2String(PARTICLE_VALUES,1) + "," + (string)PARTICLE_Z_MOTION_OMEGA + ">";
            }
            if(message == "RESET")
            {
                PARTICLE_NEW_MOTION_OMEGA = "<0.00000, 0.00000, 0.00000>";
            }
            PARTICLE_SRC_OMEGA = (vector)PARTICLE_NEW_MOTION_OMEGA;           
        }
        if(num == PARTICLE_MOTION_RADIUS)
        {
            if(message == "UP")
            {
                PARTICLE_SRC_BURST_RADIUS = PARTICLE_SRC_BURST_RADIUS + PARTICLE_CONTROLS;
            }
            if(message == "DOWN")
            {
                PARTICLE_SRC_BURST_RADIUS = PARTICLE_SRC_BURST_RADIUS - PARTICLE_CONTROLS;
            }
            if(message == "RESET")
            {
                PARTICLE_SRC_BURST_RADIUS = 0.000000;
            }
        }

        if(num == PARTICLE_FOLLOW_SOURCE)
        {
            PARTICLE_TOGGLE_SOURCE = !PARTICLE_TOGGLE_SOURCE;
            integer PARTICLE_FLAGS_COPY = PARTICLE_PART_FLAGS;
            if(TRUE == PARTICLE_TOGGLE_SOURCE)
            {
                
                PARTICLE_PART_FLAGS = PARTICLE_FLAGS_COPY | PSYS_PART_FOLLOW_SRC_MASK;
                llOwnerSay("Particle Follow Source Enabled");
            }
            else
            {
                PARTICLE_PART_FLAGS = PARTICLE_FLAGS_COPY;
                llOwnerSay("Particle Follow Source Disabled");
            }
        }
        if(num == PARTICLE_FOLLOW_VELOCITY)
        {
            PARTICLE_TOGGLE_VELOCITY = !PARTICLE_TOGGLE_VELOCITY;
            integer PARTICLE_PART_FLAGS_ORIGINAL = PARTICLE_PART_FLAGS;
            if(TRUE == PARTICLE_TOGGLE_VELOCITY)
            {
                PARTICLE_PART_FLAGS = PARTICLE_PART_FLAGS_ORIGINAL | PSYS_PART_FOLLOW_VELOCITY_MASK;
                llOwnerSay("Particle Follow Velocity Enabled");
            }
            else
            {
                PARTICLE_PART_FLAGS = PARTICLE_PART_FLAGS_ORIGINAL;
                llOwnerSay("Particle Follow Velocity Disabled");
            }
        }
        
        if(num == PARTICLE_BOUNCE)
        {
            PARTICLE_TOGGLE_ZBOUNCE = !PARTICLE_TOGGLE_ZBOUNCE;
            integer PARTICLE_PART_FLAGS_ORIGINAL = PARTICLE_PART_FLAGS;
            if(TRUE == PARTICLE_TOGGLE_ZBOUNCE)
            {
                PARTICLE_PART_FLAGS = PARTICLE_PART_FLAGS_ORIGINAL | PSYS_PART_BOUNCE_MASK;
                llOwnerSay("Particle Bounce Enabled");
            }
            else
            {
                PARTICLE_PART_FLAGS = PARTICLE_PART_FLAGS_ORIGINAL;
                llOwnerSay("Particle Bounce Disabled");
            }
        }
        if(num == PARTICLE_FOLLOW_WIND)
        {
            PARTICLE_TOGGLE_WIND = !PARTICLE_TOGGLE_WIND;
            integer PARTICLE_PART_FLAGS_ORIGINAL = PARTICLE_PART_FLAGS;
            if(TRUE == PARTICLE_TOGGLE_WIND)
            {
                
                PARTICLE_PART_FLAGS = PARTICLE_PART_FLAGS_ORIGINAL | PSYS_PART_WIND_MASK;
                llOwnerSay("Particle Follow Wind Enabled");
            }
            else
            {
                PARTICLE_PART_FLAGS = PARTICLE_PART_FLAGS_ORIGINAL;
                llOwnerSay("Particle Follow Wind Disabled");
            }
        }

        if(num == PARTICLE_SYSTEM_LIFE)
        {
            if(message == "UP")
            {
                 PARTICLE_SRC_MAX_AGE = PARTICLE_SRC_MAX_AGE + PARTICLE_CONTROLS;
                 if (PARTICLE_SRC_MAX_AGE > PI) PARTICLE_SRC_MAX_AGE = 0.0;
                 if (PARTICLE_SRC_MAX_AGE < 0.0) PARTICLE_SRC_MAX_AGE = 0.0;
            }
            if(message == "DOWN")
            {
                PARTICLE_SRC_MAX_AGE = PARTICLE_SRC_MAX_AGE - PARTICLE_CONTROLS;
                if (PARTICLE_SRC_MAX_AGE > PI) PARTICLE_SRC_MAX_AGE = 0.0;
                if (PARTICLE_SRC_MAX_AGE < 0.0) PARTICLE_SRC_MAX_AGE = 0.0;
            }
            if(message == "RESET")
            {
                PARTICLE_SRC_MAX_AGE = 0.0;
            }            
        }
                                 
        if(num == PARTICLE_QUANTITY_RATE)
        {
            if(message == "UP")
            {
                PARTICLE_SRC_BURST_RATE = PARTICLE_SRC_BURST_RATE + PARTICLE_CONTROLS;
                if (PARTICLE_SRC_BURST_RATE > PI) PARTICLE_SRC_BURST_RATE = 0.0;
                if (PARTICLE_SRC_BURST_RATE < 0.0) PARTICLE_SRC_BURST_RATE = 0.0;                
            }
            if(message == "DOWN")
            {
                PARTICLE_SRC_BURST_RATE = PARTICLE_SRC_BURST_RATE - PARTICLE_CONTROLS;
                if (PARTICLE_SRC_BURST_RATE > PI) PARTICLE_SRC_BURST_RATE = 0.0;
                if (PARTICLE_SRC_BURST_RATE < 0.0) PARTICLE_SRC_BURST_RATE = 0.0;    
            }
            if(message == "MAX")
            {
                PARTICLE_SRC_BURST_RATE = 0.001000;
            }
        }
        if(num == PARTICLE_QUANTITY_BURST)
        {
            if(message == "UP")
            {
                PARTICLE_SRC_BURST_PART_COUNT = PARTICLE_SRC_BURST_PART_COUNT + PARTICLE_CONTROLS_INT;
                if (PARTICLE_SRC_BURST_PART_COUNT < 0) PARTICLE_SRC_BURST_PART_COUNT = 0;                 
            }
            if(message == "DOWN")
            {
                PARTICLE_SRC_BURST_PART_COUNT = PARTICLE_SRC_BURST_PART_COUNT - PARTICLE_CONTROLS_INT;
                if (PARTICLE_SRC_BURST_PART_COUNT < 0.0) PARTICLE_SRC_BURST_PART_COUNT = 0;               
            }
        }
        if(num == PARTICLE_QUANTITY_LIFE)
        {
            if(message == "UP")
            {
                PARTICLE_PART_MAX_AGE = PARTICLE_PART_MAX_AGE + PARTICLE_CONTROLS;
                if (PARTICLE_PART_MAX_AGE > 30.0) PARTICLE_PART_MAX_AGE = 30.0;
                if (PARTICLE_PART_MAX_AGE < 0.0) PARTICLE_PART_MAX_AGE = 0.0;                 
            }
            if(message == "DOWN")
            {
                PARTICLE_PART_MAX_AGE = PARTICLE_PART_MAX_AGE - PARTICLE_CONTROLS;
                if (PARTICLE_PART_MAX_AGE > PI) PARTICLE_PART_MAX_AGE = 0.0;
                if (PARTICLE_PART_MAX_AGE < 0.0) PARTICLE_PART_MAX_AGE = 0.0;                
            }
        }
        if(num == PARTICLE_CONTROLS_RANGE)
        {
            if(message == "fine")
            {
                PARTICLE_CONTROLS = 0.1;
                PARTICLE_CONTROLS_INT = 1;
                llOwnerSay("Fine Controls Enabled");
            }
            if(message == "medium")
            {
                PARTICLE_CONTROLS = 0.5;
                PARTICLE_CONTROLS_INT = 5;
                llOwnerSay("Medium Controls Enabled");
            }
            if(message == "coarse")
            {
                PARTICLE_CONTROLS = 1.0;
                PARTICLE_CONTROLS_INT = 10;
                llOwnerSay("Coarse Controls Enabled");
            }            
        }
        if(num == PARTICLE_SCRIPT_MODE)
        {
            if(message == "plain")
            {
                PARTICLE_SCRIPT_TYPE = 0;
                llOwnerSay("Plain Script Enabled");
            }
            if(message == "primitizer")
            {
                PARTICLE_SCRIPT_TYPE = 1;
                llOwnerSay("Primitizer Script Enabled");
            }
            if(message == "linden")
            {
                PARTICLE_SCRIPT_TYPE = 2;
                llOwnerSay("llParticleSystem Script Enabled");
            }
            if(message == "poofer")
            {
                PARTICLE_SCRIPT_TYPE = 3;
                llOwnerSay("Poofer Script Enabled");
            }
            if(message == "listen toggle")
            {
                PARTICLE_SCRIPT_TYPE = 4;
                llOwnerSay("Listen On / Off Script Enabled");
            }
            if(message == "listen color")
            {
                PARTICLE_SCRIPT_TYPE = 5;
                llOwnerSay("Listen Color Script Enabled");
            }
            if(message == "touch")
            {
                PARTICLE_SCRIPT_TYPE = 6;
                llOwnerSay("Touch Script Enabled");
            }
            if(message == "everyone")
            {
                PARTICLE_SCRIPT_TYPE = 7;
                llOwnerSay("Everyone Script Enabled");
            }                                                                       
        }                                               
        if (num == GENERATE_PARTICLE)
        {
           integer i = llGetNumberOfPrims();
           for (; i >= 0; --i)
           {
              if (llGetLinkName(i) == PARTICLE_PROPERTIES_1)
              {   
                 string debug_message = "Start Size:" + " X: " + (string)PARTICLE_X_START_SCALE + " Y: " + (string)PARTICLE_Y_START_SCALE + 
                                        "\nEnd Size:" + " X: " + (string)PARTICLE_X_END_SCALE + " Y: " + (string)PARTICLE_Y_END_SCALE + 
                                        "\nStart Color:" + " R: " + (string)PARTICLE_R_START_COLOR + " G: " + (string)PARTICLE_G_START_COLOR + " B: " + (string)PARTICLE_B_START_COLOR +
                                        "\nEnd Color:" + " R: " + (string)PARTICLE_R_END_COLOR + " G: " + (string)PARTICLE_G_END_COLOR + " B: " + (string)PARTICLE_B_END_COLOR +
                                        "\nStart Alpha: " + (string)PARTICLE_START_ALPHA + 
                                        "\nEnd Alpha: " + (string)PARTICLE_END_ALPHA +
                                        "\nPush: " + (string)PARTICLE_SRC_ACCEL +
                                        "\nRotation: " + (string)PARTICLE_SRC_OMEGA;
                 llSetLinkPrimitiveParamsFast(i,[PRIM_TEXT,debug_message, <0,1,0>, 0.5]);
              }
              if (llGetLinkName(i) == PARTICLE_PROPERTIES_2)
              {   
                 string debug_message = "Speed:" + " Min: " + (string)PARTICLE_SRC_BURST_SPEED_MIN + " Max: " + (string)PARTICLE_SRC_BURST_SPEED_MAX + 
                                        "\nRadius: " + (string)PARTICLE_SRC_BURST_RADIUS +
                                        "\nRate: " + (string)PARTICLE_SRC_BURST_RATE +
                                        "\nBurst: " + (string)PARTICLE_SRC_BURST_PART_COUNT +
                                        "\nLife: " + (string)PARTICLE_PART_MAX_AGE +
                                        "\nSystem Life: " + (string)PARTICLE_SRC_MAX_AGE +
                                        "\nAngle Begin: " + (string)PARTICLE_DEG_ANGLE_BEGIN +
                                        "\nAngle End: " + (string)PARTICLE_DEG_ANGLE_END +
                                        "\nListen Channel: " + (string)PARTICLE_CHANNEL;
                 llSetLinkPrimitiveParamsFast(i,[PRIM_TEXT,debug_message, <0,1,0>, 0.5]);
              }              
              if (llGetLinkName(i) == PARTICLE_EMITTER)
              {
                 llLinkParticleSystem(i, [  
                             PSYS_PART_MAX_AGE, PARTICLE_PART_MAX_AGE,
                             PSYS_PART_FLAGS, PARTICLE_PART_FLAGS,
                             PSYS_PART_START_COLOR, PARTICLE_START_COLOR,
                             PSYS_PART_END_COLOR, PARTICLE_END_COLOR,
                             PSYS_PART_START_SCALE, PARTICLE_START_SCALE,
                             PSYS_PART_END_SCALE, PARTICLE_END_SCALE,
                             PSYS_SRC_PATTERN, PARTICLE_SRC_PATTERN,
                             PSYS_SRC_BURST_RATE,PARTICLE_SRC_BURST_RATE,
                             PSYS_SRC_ACCEL,PARTICLE_SRC_ACCEL,
                             PSYS_SRC_BURST_PART_COUNT,PARTICLE_SRC_BURST_PART_COUNT,
                             PSYS_SRC_BURST_RADIUS,PARTICLE_SRC_BURST_RADIUS,
                             PSYS_SRC_BURST_SPEED_MIN,PARTICLE_SRC_BURST_SPEED_MIN,
                             PSYS_SRC_BURST_SPEED_MAX,PARTICLE_SRC_BURST_SPEED_MAX,
                             PSYS_SRC_ANGLE_BEGIN,PARTICLE_SRC_ANGLE_BEGIN,
                             PSYS_SRC_ANGLE_END,PARTICLE_SRC_ANGLE_END,
                             PSYS_SRC_OMEGA,PARTICLE_SRC_OMEGA,
                             PSYS_SRC_MAX_AGE,PARTICLE_SRC_MAX_AGE,
                             PSYS_PART_START_ALPHA,PARTICLE_START_ALPHA,
                             PSYS_PART_END_ALPHA,PARTICLE_END_ALPHA,
                             PSYS_SRC_TEXTURE, PARTICLE_SRC_TEXTURE,
                             PSYS_SRC_TARGET_KEY,(key)PARTICLE_SRC_TARGET_KEY 
                               ]);
              }                        
           }            
        }
    }
                             
    timer()
    {
        llMessageLinked(LINK_SET, GENERATE_PARTICLE, "", NULL_KEY);
    }
    
    dataserver(key query_id, string data) 
    {
        if (query_id == NOTECARD_QUERY) 
        {
            if (data != EOF && PARTICLE_PREFIX == "psys_") 
            {
                llMessageLinked(LINK_SET,PARTICLE_PRESET,data,NULL_KEY);
                INDEX++;
                if( ~llGetInventoryType(  PARTICLE_PREFIX + PARTICLE_NOTECARD ) ) NOTECARD_QUERY = llGetNotecardLine(PARTICLE_PREFIX + PARTICLE_NOTECARD, INDEX);
            }
        }
    }                       
}