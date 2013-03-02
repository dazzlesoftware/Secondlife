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

default
{
    state_entry()
    {
        //llSay(0, "Hello, Avatar!");
    }
    
    link_message(integer source, integer num, string str, key id)
    {
        list PARTICLE_VALUES = llParseString2List(str,["#"],[]);
        if(num == PARTICLE_SCRIPT_VARIABLES)
        { 
            //string PARTICLE_EMITTER = llList2String(PARTICLE_VALUES,0);
            integer PARTICLE_SCRIPT_TYPE = (integer)llList2String(PARTICLE_VALUES,0);
            integer PARTICLE_PART_FLAGS = (integer)llList2String(PARTICLE_VALUES,1);
            float PARTICLE_SRC_MAX_AGE = (float)llList2String(PARTICLE_VALUES,2);
            float PARTICLE_PART_MAX_AGE = (float)llList2String(PARTICLE_VALUES,3);
            float PARTICLE_SRC_BURST_RATE = (float)llList2String(PARTICLE_VALUES,4);
            integer PARTICLE_SRC_BURST_PART_COUNT = (integer)llList2String(PARTICLE_VALUES,5);
            float PARTICLE_SRC_BURST_RADIUS = (float)llList2String(PARTICLE_VALUES,6);
            float PARTICLE_SRC_BURST_SPEED_MAX = (float)llList2String(PARTICLE_VALUES,7);
            float PARTICLE_SRC_BURST_SPEED_MIN = (float)llList2String(PARTICLE_VALUES,8);
            float PARTICLE_START_ALPHA = (float)llList2String(PARTICLE_VALUES,9);
            float PARTICLE_END_ALPHA = (float)llList2String(PARTICLE_VALUES,10);
            float PARTICLE_SRC_ANGLE_BEGIN = (float)llList2String(PARTICLE_VALUES,11);
            float PARTICLE_SRC_ANGLE_END = (float)llList2String(PARTICLE_VALUES,12);
            vector PARTICLE_START_COLOR = (vector)llList2String(PARTICLE_VALUES,13);
            vector PARTICLE_END_COLOR = (vector)llList2String(PARTICLE_VALUES,14);
            vector PARTICLE_START_SCALE = (vector)llList2String(PARTICLE_VALUES,15);
            vector PARTICLE_END_SCALE = (vector)llList2String(PARTICLE_VALUES,16);
            vector PARTICLE_SRC_ACCEL = (vector)llList2String(PARTICLE_VALUES,17);
            vector PARTICLE_SRC_OMEGA = (vector)llList2String(PARTICLE_VALUES,18);
            integer PARTICLE_SRC_PATTERN = (integer)llList2String(PARTICLE_VALUES,19);
            string PARTICLE_SRC_TEXTURE = llList2String(PARTICLE_VALUES,20);
            key PARTICLE_SRC_TARGET_KEY = (key)llList2String(PARTICLE_VALUES,21);
            
            if(PARTICLE_SRC_TEXTURE == "00000000-0000-0000-0000-000000000000")
            {
                PARTICLE_SRC_TEXTURE = "";
            }
            if(PARTICLE_SRC_TARGET_KEY == "00000000-0000-0000-0000-000000000000")
            {
                PARTICLE_SRC_TARGET_KEY = "";
            }
            if(PARTICLE_SCRIPT_TYPE == 0)
            {
                 string PARTICLE_DATA1 = "Copy/paste that script in to and empty script document";
                 PARTICLE_DATA1 += "\ndefault{state_entry(){llParticleSystem([";
                 PARTICLE_DATA1 += "PSYS_PART_FLAGS," + (string)PARTICLE_PART_FLAGS + ",";
                 PARTICLE_DATA1 += "PSYS_PART_START_SCALE," + (string)PARTICLE_START_SCALE + ",";
                 PARTICLE_DATA1 += "PSYS_PART_END_SCALE," + (string)PARTICLE_END_SCALE + ",";
                 PARTICLE_DATA1 += "PSYS_PART_START_COLOR," + (string)PARTICLE_START_COLOR + ",";
                 PARTICLE_DATA1 += "PSYS_PART_END_COLOR," + (string)PARTICLE_END_COLOR + ",";
                 PARTICLE_DATA1 += "PSYS_PART_START_ALPHA," + (string)PARTICLE_START_ALPHA + ",";
                 PARTICLE_DATA1 += "PSYS_PART_END_ALPHA," + (string)PARTICLE_END_ALPHA + ",";
                 PARTICLE_DATA1 += "PSYS_SRC_PATTERN," + (string)PARTICLE_SRC_PATTERN + ",";
                 PARTICLE_DATA1 += "PSYS_SRC_BURST_RATE," + (string)PARTICLE_SRC_BURST_RATE + ",";
                 PARTICLE_DATA1 += "PSYS_SRC_BURST_PART_COUNT," + (string)PARTICLE_SRC_BURST_PART_COUNT + ",";
                 PARTICLE_DATA1 += "PSYS_SRC_BURST_RADIUS," + (string)PARTICLE_SRC_BURST_RADIUS + ",";
                 PARTICLE_DATA1 += "PSYS_SRC_BURST_SPEED_MIN," + (string)PARTICLE_SRC_BURST_SPEED_MIN + ",";
                 PARTICLE_DATA1 += "PSYS_SRC_BURST_SPEED_MAX," + (string)PARTICLE_SRC_BURST_SPEED_MAX + ",";
                 PARTICLE_DATA1 += "PSYS_SRC_ANGLE_BEGIN," + (string)PARTICLE_SRC_ANGLE_BEGIN + ",";
                 PARTICLE_DATA1 += "PSYS_SRC_ANGLE_END," + (string)PARTICLE_SRC_ANGLE_END + ",";
                 PARTICLE_DATA1 += "PSYS_SRC_OMEGA," + (string)PARTICLE_SRC_OMEGA + ",";
                 PARTICLE_DATA1 += "PSYS_SRC_ACCEL," + (string)PARTICLE_SRC_ACCEL + ",";
                 PARTICLE_DATA1 += "PSYS_PART_MAX_AGE," + (string)PARTICLE_PART_MAX_AGE + ",";
                 PARTICLE_DATA1 += "PSYS_SRC_MAX_AGE," + (string)PARTICLE_SRC_MAX_AGE + ",";
                 PARTICLE_DATA1 += "PSYS_SRC_TEXTURE,\"" + (string)PARTICLE_SRC_TEXTURE + "\",";
                 PARTICLE_DATA1 += "PSYS_SRC_TARGET_KEY,(key) \"" + (string)PARTICLE_SRC_TARGET_KEY + "\"]);}}";
                 llSay(0, PARTICLE_DATA1); 
            }
            if(PARTICLE_SCRIPT_TYPE == 1)
            {
                 string PARTICLE_DATA2 = "PSYS_PART_FLAGS|" + (string)PARTICLE_PART_FLAGS + "\n";
                 PARTICLE_DATA2 += "PSYS_PART_START_SCALE|" + (string)PARTICLE_START_SCALE + "\n";
                 PARTICLE_DATA2 += "PSYS_PART_END_SCALE|" + (string)PARTICLE_END_SCALE + "\n";
                 PARTICLE_DATA2 += "PSYS_PART_START_COLOR|" + (string)PARTICLE_START_COLOR + "\n";
                 PARTICLE_DATA2 += "PSYS_PART_END_COLOR|" + (string)PARTICLE_END_COLOR + "\n";
                 PARTICLE_DATA2 += "PSYS_PART_START_ALPHA|" + (string)PARTICLE_START_ALPHA + "\n";
                 PARTICLE_DATA2 += "PSYS_PART_END_ALPHA|" + (string)PARTICLE_END_ALPHA + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_PATTERN|" + (string)PARTICLE_SRC_PATTERN + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_BURST_RATE|" + (string)PARTICLE_SRC_BURST_RATE + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_BURST_PART_COUNT|" + (string)PARTICLE_SRC_BURST_PART_COUNT + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_BURST_RADIUS|" + (string)PARTICLE_SRC_BURST_RADIUS + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_BURST_SPEED_MIN|" + (string)PARTICLE_SRC_BURST_SPEED_MIN + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_BURST_SPEED_MAX|" + (string)PARTICLE_SRC_BURST_SPEED_MAX + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_ANGLE_BEGIN|" + (string)PARTICLE_SRC_ANGLE_BEGIN + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_ANGLE_END|" + (string)PARTICLE_SRC_ANGLE_END + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_OMEGA|" + (string)PARTICLE_SRC_OMEGA + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_ACCEL|" + (string)PARTICLE_SRC_ACCEL + "\n";
                 PARTICLE_DATA2 += "PSYS_PART_MAX_AGE|" + (string)PARTICLE_PART_MAX_AGE + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_MAX_AGE|" + (string)PARTICLE_SRC_MAX_AGE + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_TEXTURE|" + (string)PARTICLE_SRC_TEXTURE + "\n";
                 PARTICLE_DATA2 += "PSYS_SRC_TARGET_KEY|" + (string)PARTICLE_SRC_TARGET_KEY + "\n";
                 llSay(0, PARTICLE_DATA2);
            }            
            if(PARTICLE_SCRIPT_TYPE == 2)
            {
                 string PARTICLE_DATA4 = "Copy/paste that script in to and empty script document\n";
                 PARTICLE_DATA4 += "llParticleSystem([";
                 PARTICLE_DATA4 += "PSYS_PART_FLAGS," + (string)PARTICLE_PART_FLAGS + ",";
                 PARTICLE_DATA4 += "PSYS_PART_START_SCALE," + (string)PARTICLE_START_SCALE + ",";
                 PARTICLE_DATA4 += "PSYS_PART_END_SCALE," + (string)PARTICLE_END_SCALE + ",";
                 PARTICLE_DATA4 += "PSYS_PART_START_COLOR," + (string)PARTICLE_START_COLOR + ",";
                 PARTICLE_DATA4 += "PSYS_PART_END_COLOR," + (string)PARTICLE_END_COLOR + ",";
                 PARTICLE_DATA4 += "PSYS_PART_START_ALPHA," + (string)PARTICLE_START_ALPHA + ",";
                 PARTICLE_DATA4 += "PSYS_PART_END_ALPHA," + (string)PARTICLE_END_ALPHA + ",";
                 PARTICLE_DATA4 += "PSYS_SRC_PATTERN," + (string)PARTICLE_SRC_PATTERN + ",";
                 PARTICLE_DATA4 += "PSYS_SRC_BURST_RATE," + (string)PARTICLE_SRC_BURST_RATE + ",";
                 PARTICLE_DATA4 += "PSYS_SRC_BURST_PART_COUNT," + (string)PARTICLE_SRC_BURST_PART_COUNT + ",";
                 PARTICLE_DATA4 += "PSYS_SRC_BURST_RADIUS," + (string)PARTICLE_SRC_BURST_RADIUS + ",";
                 PARTICLE_DATA4 += "PSYS_SRC_BURST_SPEED_MIN," + (string)PARTICLE_SRC_BURST_SPEED_MIN + ",";
                 PARTICLE_DATA4 += "PSYS_SRC_BURST_SPEED_MAX," + (string)PARTICLE_SRC_BURST_SPEED_MAX + ",";
                 PARTICLE_DATA4 += "PSYS_SRC_ANGLE_BEGIN," + (string)PARTICLE_SRC_ANGLE_BEGIN + ",";
                 PARTICLE_DATA4 += "PSYS_SRC_ANGLE_END," + (string)PARTICLE_SRC_ANGLE_END + ",";
                 PARTICLE_DATA4 += "PSYS_SRC_OMEGA," + (string)PARTICLE_SRC_OMEGA + ",";
                 PARTICLE_DATA4 += "PSYS_SRC_ACCEL," + (string)PARTICLE_SRC_ACCEL + ",";
                 PARTICLE_DATA4 += "PSYS_PART_MAX_AGE," + (string)PARTICLE_PART_MAX_AGE + ",";
                 PARTICLE_DATA4 += "PSYS_SRC_MAX_AGE," + (string)PARTICLE_SRC_MAX_AGE + ",";
                 PARTICLE_DATA4 += "PSYS_SRC_TEXTURE,\"" + (string)PARTICLE_SRC_TEXTURE + "\",";
                 PARTICLE_DATA4 += "PSYS_SRC_TARGET_KEY,(key) \"" + (string)PARTICLE_SRC_TARGET_KEY + "\"]);";
                 llSay(0, PARTICLE_DATA4);
            }
            if(PARTICLE_SCRIPT_TYPE == 3)
            {
                 string PARTICLE_DATA5 = "Copy/paste that script in to and empty script document";
                 PARTICLE_DATA5 += "\np(){llParticleSystem([";
                 PARTICLE_DATA5 += "PSYS_PART_FLAGS," + (string)PARTICLE_PART_FLAGS + ",";
                 PARTICLE_DATA5 += "PSYS_PART_START_SCALE," + (string)PARTICLE_START_SCALE + ",";
                 PARTICLE_DATA5 += "PSYS_PART_END_SCALE," + (string)PARTICLE_END_SCALE + ",";
                 PARTICLE_DATA5 += "PSYS_PART_START_COLOR," + (string)PARTICLE_START_COLOR + ",";
                 PARTICLE_DATA5 += "PSYS_PART_END_COLOR," + (string)PARTICLE_END_COLOR + ",";
                 PARTICLE_DATA5 += "PSYS_PART_START_ALPHA," + (string)PARTICLE_START_ALPHA + ",";
                 PARTICLE_DATA5 += "PSYS_PART_END_ALPHA," + (string)PARTICLE_END_ALPHA + ",";
                 PARTICLE_DATA5 += "PSYS_SRC_PATTERN," + (string)PARTICLE_SRC_PATTERN + ",";
                 PARTICLE_DATA5 += "PSYS_SRC_BURST_RATE," + (string)PARTICLE_SRC_BURST_RATE + ",";
                 PARTICLE_DATA5 += "PSYS_SRC_BURST_PART_COUNT," + (string)PARTICLE_SRC_BURST_PART_COUNT + ",";
                 PARTICLE_DATA5 += "PSYS_SRC_BURST_RADIUS," + (string)PARTICLE_SRC_BURST_RADIUS + ",";
                 PARTICLE_DATA5 += "PSYS_SRC_BURST_SPEED_MIN," + (string)PARTICLE_SRC_BURST_SPEED_MIN + ",";
                 PARTICLE_DATA5 += "PSYS_SRC_BURST_SPEED_MAX," + (string)PARTICLE_SRC_BURST_SPEED_MAX + ",";
                 PARTICLE_DATA5 += "PSYS_SRC_ANGLE_BEGIN," + (string)PARTICLE_SRC_ANGLE_BEGIN + ",";
                 PARTICLE_DATA5 += "PSYS_SRC_ANGLE_END," + (string)PARTICLE_SRC_ANGLE_END + ",";
                 PARTICLE_DATA5 += "PSYS_SRC_OMEGA," + (string)PARTICLE_SRC_OMEGA + ",";
                 PARTICLE_DATA5 += "PSYS_SRC_ACCEL," + (string)PARTICLE_SRC_ACCEL + ",";
                 PARTICLE_DATA5 += "PSYS_PART_MAX_AGE," + (string)PARTICLE_PART_MAX_AGE + ",";
                 PARTICLE_DATA5 += "PSYS_SRC_MAX_AGE," + (string)PARTICLE_SRC_MAX_AGE + ",";
                 PARTICLE_DATA5 += "PSYS_SRC_TEXTURE,\"" + (string)PARTICLE_SRC_TEXTURE + "\",";
                 PARTICLE_DATA5 += "PSYS_SRC_TARGET_KEY,(key) \"" + (string)PARTICLE_SRC_TARGET_KEY + "\"]);}";
                 PARTICLE_DATA5 += "integer HANDLE;";
                 PARTICLE_DATA5 += "\ndefault{state_entry(){";
                 PARTICLE_DATA5 += "HANDLE=llListen(1, \"\", \"NULL_KEY\", \"on\");}";
                 PARTICLE_DATA5 += "\non_rez(integer s){HANDLE=llListen(1, \"\", \"NULL_KEY\", \"on\");";
                 PARTICLE_DATA5 += "p();}";
                 PARTICLE_DATA5 += "listen( integer c, string n, key i, string m ){p();}";
                 PARTICLE_DATA5 += "changed( integer c ) {";
                 PARTICLE_DATA5 += "if(c & CHANGED_TELEPORT) p();}}";              
                 llSay(0, PARTICLE_DATA5);
            }
            if(PARTICLE_SCRIPT_TYPE == 4)
            {
                 string PARTICLE_DATA6 = "Copy/paste that script in to and empty script document\n";
                 PARTICLE_DATA6 += "vector PARTICLE_START_COLOR = " + (string)PARTICLE_START_COLOR + ";";
                 PARTICLE_DATA6 += "vector PARTICLE_END_COLOR = " + (string)PARTICLE_END_COLOR + ";";
                 PARTICLE_DATA6 += "string PARTICLE_COLOR_RGB_INPUT;";
                 PARTICLE_DATA6 += "vector PARTICLE_COLOR_RGB_OUTPUT;";
                 PARTICLE_DATA6 += "\npc(){llParticleSystem([ ]);}";
                 PARTICLE_DATA6 += "\np(){llParticleSystem([";
                 PARTICLE_DATA6 += (string)PSYS_PART_FLAGS + "," + (string)PARTICLE_PART_FLAGS + ",";
                 PARTICLE_DATA6 += (string)PSYS_PART_START_SCALE +"," + (string)PARTICLE_START_SCALE + ",";
                 PARTICLE_DATA6 += (string)PSYS_PART_END_SCALE + "," + (string)PARTICLE_END_SCALE + ",";
                 PARTICLE_DATA6 += (string)PSYS_PART_START_COLOR + "," + "PARTICLE_START_COLOR" + ",";
                 PARTICLE_DATA6 += (string)PSYS_PART_END_COLOR + "," + "PARTICLE_END_COLOR" + ",";
                 PARTICLE_DATA6 += (string)PSYS_PART_START_ALPHA + "," + (string)PARTICLE_START_ALPHA + ",";
                 PARTICLE_DATA6 += (string)PSYS_PART_END_ALPHA + "," + (string)PARTICLE_END_ALPHA + ",";
                 PARTICLE_DATA6 += (string)PSYS_SRC_PATTERN + "," + (string)PARTICLE_SRC_PATTERN + ",";
                 PARTICLE_DATA6 += (string)PSYS_SRC_BURST_RATE + "," + (string)PARTICLE_SRC_BURST_RATE + ",";
                 PARTICLE_DATA6 += (string)PSYS_SRC_BURST_PART_COUNT + "," + (string)PARTICLE_SRC_BURST_PART_COUNT + ",";
                 PARTICLE_DATA6 += (string)PSYS_SRC_BURST_RADIUS + "," + (string)PARTICLE_SRC_BURST_RADIUS + ",";
                 PARTICLE_DATA6 += (string)PSYS_SRC_BURST_SPEED_MIN + "," + (string)PARTICLE_SRC_BURST_SPEED_MIN + ",";
                 PARTICLE_DATA6 += (string)PSYS_SRC_BURST_SPEED_MAX + "," + (string)PARTICLE_SRC_BURST_SPEED_MAX + ",";
                 PARTICLE_DATA6 += (string)PSYS_SRC_ANGLE_BEGIN + "," + (string)PARTICLE_SRC_ANGLE_BEGIN + ",";
                 PARTICLE_DATA6 += (string)PSYS_SRC_ANGLE_END + "," + (string)PARTICLE_SRC_ANGLE_END + ",";
                 PARTICLE_DATA6 += (string)PSYS_SRC_OMEGA + "," + (string)PARTICLE_SRC_OMEGA + ",";
                 PARTICLE_DATA6 += (string)PSYS_SRC_ACCEL + "," + (string)PARTICLE_SRC_ACCEL + ",";
                 PARTICLE_DATA6 += (string)PSYS_PART_MAX_AGE + "," + (string)PARTICLE_PART_MAX_AGE + ",";
                 PARTICLE_DATA6 += (string)PSYS_SRC_MAX_AGE + "," + (string)PARTICLE_SRC_MAX_AGE + ",";
                 if(PARTICLE_SRC_TEXTURE != "") PARTICLE_DATA6 += (string)PSYS_SRC_TEXTURE + ",\"" + (string)PARTICLE_SRC_TEXTURE + "\",";
                 if(PARTICLE_SRC_TARGET_KEY != "") PARTICLE_DATA6 += (string)PSYS_SRC_TARGET_KEY + ",(key) \"" + (string)PARTICLE_SRC_TARGET_KEY + "\"]);}";
                 PARTICLE_DATA6 += "\ndefault{state_entry(){";
                 PARTICLE_DATA6 += "llListen(0, \"\", llGetOwner(), \"\");";
                 PARTICLE_DATA6 += "}";
                 llSay(0, PARTICLE_DATA6);
                 string PARTICLE_DATA7 = "listen(integer c, string n, key i, string m) {";
                 PARTICLE_DATA7 += "list PARTICLE_COMMAND = llParseString2List(m,[\" \"],[]);";
                 PARTICLE_DATA7 += "if(m == \"on\") p();";
                 PARTICLE_DATA7 += "if(m == \"off\") pc();";
                 PARTICLE_DATA7 += "if(llList2String(PARTICLE_COMMAND, 0) == llToLower(\"SRGB\")){";
                 PARTICLE_DATA7 += "PARTICLE_COLOR_RGB_INPUT =  \"<\" +  llList2String(PARTICLE_COMMAND, 1) + \",\" + llList2String(PARTICLE_COMMAND, 2) + \",\" + llList2String(PARTICLE_COMMAND, 3) + \">\";";
                 PARTICLE_DATA7 += "PARTICLE_COLOR_RGB_OUTPUT = (vector)PARTICLE_COLOR_RGB_INPUT / 255.0;";
                 PARTICLE_DATA7 += "PARTICLE_START_COLOR = PARTICLE_COLOR_RGB_OUTPUT;}";
                 PARTICLE_DATA7 += "if(llList2String(PARTICLE_COMMAND, 0) == llToLower(\"ERGB\")){";
                 PARTICLE_DATA7 += "PARTICLE_COLOR_RGB_INPUT =  \"<\" +  llList2String(PARTICLE_COMMAND, 1) + \",\" + llList2String(PARTICLE_COMMAND, 2) + \",\" + llList2String(PARTICLE_COMMAND, 3) + \">\";";
                 PARTICLE_DATA7 += "PARTICLE_COLOR_RGB_OUTPUT = (vector)PARTICLE_COLOR_RGB_INPUT / 255.0;";
                 PARTICLE_DATA7 += "PARTICLE_END_COLOR = PARTICLE_COLOR_RGB_OUTPUT;}";                   
                 PARTICLE_DATA7 += "}";
                 PARTICLE_DATA7 += "}}";              
                 llSay(0, PARTICLE_DATA7);
            }
            if(PARTICLE_SCRIPT_TYPE == 5)
            {
                 string PARTICLE_DATA8 = "Copy/paste that script in to and empty script document\n";
                 PARTICLE_DATA8 += "vector PARTICLE_START_COLOR = " + (string)PARTICLE_START_COLOR + ";";
                 PARTICLE_DATA8 += "vector PARTICLE_END_COLOR = " + (string)PARTICLE_END_COLOR + ";";
                 PARTICLE_DATA8 += "string PARTICLE_COLOR_RGB_INPUT;";
                 PARTICLE_DATA8 += "vector PARTICLE_COLOR_RGB_OUTPUT;";
                 PARTICLE_DATA8 += "\np(){llParticleSystem([";
                 PARTICLE_DATA8 += (string)PSYS_PART_FLAGS + "," + (string)PARTICLE_PART_FLAGS + ",";
                 PARTICLE_DATA8 += (string)PSYS_PART_START_SCALE +"," + (string)PARTICLE_START_SCALE + ",";
                 PARTICLE_DATA8 += (string)PSYS_PART_END_SCALE + "," + (string)PARTICLE_END_SCALE + ",";
                 PARTICLE_DATA8 += (string)PSYS_PART_START_COLOR + "," + "PARTICLE_START_COLOR" + ",";
                 PARTICLE_DATA8 += (string)PSYS_PART_END_COLOR + "," + "PARTICLE_END_COLOR" + ",";
                 PARTICLE_DATA8 += (string)PSYS_PART_START_ALPHA + "," + (string)PARTICLE_START_ALPHA + ",";
                 PARTICLE_DATA8 += (string)PSYS_PART_END_ALPHA + "," + (string)PARTICLE_END_ALPHA + ",";
                 PARTICLE_DATA8 += (string)PSYS_SRC_PATTERN + "," + (string)PARTICLE_SRC_PATTERN + ",";
                 PARTICLE_DATA8 += (string)PSYS_SRC_BURST_RATE + "," + (string)PARTICLE_SRC_BURST_RATE + ",";
                 PARTICLE_DATA8 += (string)PSYS_SRC_BURST_PART_COUNT + "," + (string)PARTICLE_SRC_BURST_PART_COUNT + ",";
                 PARTICLE_DATA8 += (string)PSYS_SRC_BURST_RADIUS + "," + (string)PARTICLE_SRC_BURST_RADIUS + ",";
                 PARTICLE_DATA8 += (string)PSYS_SRC_BURST_SPEED_MIN + "," + (string)PARTICLE_SRC_BURST_SPEED_MIN + ",";
                 PARTICLE_DATA8 += (string)PSYS_SRC_BURST_SPEED_MAX + "," + (string)PARTICLE_SRC_BURST_SPEED_MAX + ",";
                 PARTICLE_DATA8 += (string)PSYS_SRC_ANGLE_BEGIN + "," + (string)PARTICLE_SRC_ANGLE_BEGIN + ",";
                 PARTICLE_DATA8 += (string)PSYS_SRC_ANGLE_END + "," + (string)PARTICLE_SRC_ANGLE_END + ",";
                 PARTICLE_DATA8 += (string)PSYS_SRC_OMEGA + "," + (string)PARTICLE_SRC_OMEGA + ",";
                 PARTICLE_DATA8 += (string)PSYS_SRC_ACCEL + "," + (string)PARTICLE_SRC_ACCEL + ",";
                 PARTICLE_DATA8 += (string)PSYS_PART_MAX_AGE + "," + (string)PARTICLE_PART_MAX_AGE + ",";
                 PARTICLE_DATA8 += (string)PSYS_SRC_MAX_AGE + "," + (string)PARTICLE_SRC_MAX_AGE + ",";
                 if(PARTICLE_SRC_TEXTURE != "") PARTICLE_DATA8 += (string)PSYS_SRC_TEXTURE + ",\"" + (string)PARTICLE_SRC_TEXTURE + "\",";
                 if(PARTICLE_SRC_TARGET_KEY != "") PARTICLE_DATA8 += (string)PSYS_SRC_TARGET_KEY + ",(key) \"" + (string)PARTICLE_SRC_TARGET_KEY + "\"]);}";
                 PARTICLE_DATA8 += "\ndefault{state_entry(){";
                 PARTICLE_DATA8 += "llListen(0, \"\", llGetOwner(), \"\");";
                 PARTICLE_DATA8 += "}";
                 llSay(0, PARTICLE_DATA8);
                 string PARTICLE_DATA9 = "listen(integer c, string n, key i, string m) {";
                 PARTICLE_DATA9 += "list PARTICLE_COMMAND = llParseString2List(m,[\" \"],[]);";
                 PARTICLE_DATA9 += "if(llList2String(PARTICLE_COMMAND, 0) == llToLower(\"SRGB\")){";
                 PARTICLE_DATA9 += "PARTICLE_COLOR_RGB_INPUT =  \"<\" +  llList2String(PARTICLE_COMMAND, 1) + \",\" + llList2String(PARTICLE_COMMAND, 2) + \",\" + llList2String(PARTICLE_COMMAND, 3) + \">\";";
                 PARTICLE_DATA9 += "PARTICLE_COLOR_RGB_OUTPUT = (vector)PARTICLE_COLOR_RGB_INPUT / 255.0;";
                 PARTICLE_DATA9 += "PARTICLE_START_COLOR = PARTICLE_COLOR_RGB_OUTPUT;}";
                 PARTICLE_DATA9 += "if(llList2String(PARTICLE_COMMAND, 0) == llToLower(\"ERGB\")){";
                 PARTICLE_DATA9 += "PARTICLE_COLOR_RGB_INPUT =  \"<\" +  llList2String(PARTICLE_COMMAND, 1) + \",\" + llList2String(PARTICLE_COMMAND, 2) + \",\" + llList2String(PARTICLE_COMMAND, 3) + \">\";";
                 PARTICLE_DATA9 += "PARTICLE_COLOR_RGB_OUTPUT = (vector)PARTICLE_COLOR_RGB_INPUT / 255.0;";
                 PARTICLE_DATA9 += "PARTICLE_END_COLOR = PARTICLE_COLOR_RGB_OUTPUT;}";                   
                 PARTICLE_DATA9 += "}";
                 PARTICLE_DATA9 += "}}";              
                 llSay(0, PARTICLE_DATA9);
            }
            if(PARTICLE_SCRIPT_TYPE == 6)
            {
                 string PARTICLE_DATA10 = "Copy/paste that script in to and empty script document";
                 PARTICLE_DATA10 += "\np(){llParticleSystem([";
                 PARTICLE_DATA10 += "PSYS_PART_FLAGS," + (string)PARTICLE_PART_FLAGS + ",";
                 PARTICLE_DATA10 += "PSYS_PART_START_SCALE," + (string)PARTICLE_START_SCALE + ",";
                 PARTICLE_DATA10 += "PSYS_PART_END_SCALE," + (string)PARTICLE_END_SCALE + ",";
                 PARTICLE_DATA10 += "PSYS_PART_START_COLOR," + (string)PARTICLE_START_COLOR + ",";
                 PARTICLE_DATA10 += "PSYS_PART_END_COLOR," + (string)PARTICLE_END_COLOR + ",";
                 PARTICLE_DATA10 += "PSYS_PART_START_ALPHA," + (string)PARTICLE_START_ALPHA + ",";
                 PARTICLE_DATA10 += "PSYS_PART_END_ALPHA," + (string)PARTICLE_END_ALPHA + ",";
                 PARTICLE_DATA10 += "PSYS_SRC_PATTERN," + (string)PARTICLE_SRC_PATTERN + ",";
                 PARTICLE_DATA10 += "PSYS_SRC_BURST_RATE," + (string)PARTICLE_SRC_BURST_RATE + ",";
                 PARTICLE_DATA10 += "PSYS_SRC_BURST_PART_COUNT," + (string)PARTICLE_SRC_BURST_PART_COUNT + ",";
                 PARTICLE_DATA10 += "PSYS_SRC_BURST_RADIUS," + (string)PARTICLE_SRC_BURST_RADIUS + ",";
                 PARTICLE_DATA10 += "PSYS_SRC_BURST_SPEED_MIN," + (string)PARTICLE_SRC_BURST_SPEED_MIN + ",";
                 PARTICLE_DATA10 += "PSYS_SRC_BURST_SPEED_MAX," + (string)PARTICLE_SRC_BURST_SPEED_MAX + ",";
                 PARTICLE_DATA10 += "PSYS_SRC_ANGLE_BEGIN," + (string)PARTICLE_SRC_ANGLE_BEGIN + ",";
                 PARTICLE_DATA10 += "PSYS_SRC_ANGLE_END," + (string)PARTICLE_SRC_ANGLE_END + ",";
                 PARTICLE_DATA10 += "PSYS_SRC_OMEGA," + (string)PARTICLE_SRC_OMEGA + ",";
                 PARTICLE_DATA10 += "PSYS_SRC_ACCEL," + (string)PARTICLE_SRC_ACCEL + ",";
                 PARTICLE_DATA10 += "PSYS_PART_MAX_AGE," + (string)PARTICLE_PART_MAX_AGE + ",";
                 PARTICLE_DATA10 += "PSYS_SRC_MAX_AGE," + (string)PARTICLE_SRC_MAX_AGE + ",";
                 PARTICLE_DATA10 += "PSYS_SRC_TEXTURE,\"" + (string)PARTICLE_SRC_TEXTURE + "\",";
                 PARTICLE_DATA10 += "PSYS_SRC_TARGET_KEY,(key) \"" + (string)PARTICLE_SRC_TARGET_KEY + "\"]);}";
                 PARTICLE_DATA10 += "\npc(){llParticleSystem([ ]);}";
                 PARTICLE_DATA10 += "integer PARTICLE_TOGGLE = FALSE;";
                 PARTICLE_DATA10 += "\ndefault{state_entry(){";
                 PARTICLE_DATA10 += "}";
                 PARTICLE_DATA10 += "touch_start( integer num ) {";
                 PARTICLE_DATA10 += "PARTICLE_TOGGLE = !PARTICLE_TOGGLE;";
                 PARTICLE_DATA10 += "if(TRUE == PARTICLE_TOGGLE) {p();}else{pc();}}}";              
                 llSay(0, PARTICLE_DATA10);
            }
            if(PARTICLE_SCRIPT_TYPE == 7)
            {
                 string PARTICLE_DATA11 = "Copy/paste that script in to and empty script document";
                 PARTICLE_DATA11 += "\np(){llParticleSystem([";
                 PARTICLE_DATA11 += "PSYS_PART_FLAGS," + (string)PARTICLE_PART_FLAGS + ",";
                 PARTICLE_DATA11 += "PSYS_PART_START_SCALE," + (string)PARTICLE_START_SCALE + ",";
                 PARTICLE_DATA11 += "PSYS_PART_END_SCALE," + (string)PARTICLE_END_SCALE + ",";
                 PARTICLE_DATA11 += "PSYS_PART_START_COLOR," + (string)PARTICLE_START_COLOR + ",";
                 PARTICLE_DATA11 += "PSYS_PART_END_COLOR," + (string)PARTICLE_END_COLOR + ",";
                 PARTICLE_DATA11 += "PSYS_PART_START_ALPHA," + (string)PARTICLE_START_ALPHA + ",";
                 PARTICLE_DATA11 += "PSYS_PART_END_ALPHA," + (string)PARTICLE_END_ALPHA + ",";
                 PARTICLE_DATA11 += "PSYS_SRC_PATTERN," + (string)PARTICLE_SRC_PATTERN + ",";
                 PARTICLE_DATA11 += "PSYS_SRC_BURST_RATE," + (string)PARTICLE_SRC_BURST_RATE + ",";
                 PARTICLE_DATA11 += "PSYS_SRC_BURST_PART_COUNT," + (string)PARTICLE_SRC_BURST_PART_COUNT + ",";
                 PARTICLE_DATA11 += "PSYS_SRC_BURST_RADIUS," + (string)PARTICLE_SRC_BURST_RADIUS + ",";
                 PARTICLE_DATA11 += "PSYS_SRC_BURST_SPEED_MIN," + (string)PARTICLE_SRC_BURST_SPEED_MIN + ",";
                 PARTICLE_DATA11 += "PSYS_SRC_BURST_SPEED_MAX," + (string)PARTICLE_SRC_BURST_SPEED_MAX + ",";
                 PARTICLE_DATA11 += "PSYS_SRC_ANGLE_BEGIN," + (string)PARTICLE_SRC_ANGLE_BEGIN + ",";
                 PARTICLE_DATA11 += "PSYS_SRC_ANGLE_END," + (string)PARTICLE_SRC_ANGLE_END + ",";
                 PARTICLE_DATA11 += "PSYS_SRC_OMEGA," + (string)PARTICLE_SRC_OMEGA + ",";
                 PARTICLE_DATA11 += "PSYS_SRC_ACCEL," + (string)PARTICLE_SRC_ACCEL + ",";
                 PARTICLE_DATA11 += "PSYS_PART_MAX_AGE," + (string)PARTICLE_PART_MAX_AGE + ",";
                 PARTICLE_DATA11 += "PSYS_SRC_MAX_AGE," + (string)PARTICLE_SRC_MAX_AGE + ",";
                 PARTICLE_DATA11 += "PSYS_SRC_TEXTURE,\"" + (string)PARTICLE_SRC_TEXTURE + "\",";
                 PARTICLE_DATA11 += "PSYS_SRC_TARGET_KEY,(key) \"" + (string)PARTICLE_SRC_TARGET_KEY + "\"]);}";
                 PARTICLE_DATA11 += "integer HANDLE;";
                 PARTICLE_DATA11 += "\ndefault{state_entry(){";
                 PARTICLE_DATA11 += "HANDLE=llListen(1, \"\", \"llGetOwner()\", \"on\");}";
                 PARTICLE_DATA11 += "\non_rez(integer s){HANDLE=llListen(1, \"\", \"\", \"on\");";
                 PARTICLE_DATA11 += "p();}";
                 PARTICLE_DATA11 += "listen( integer c, string n, key i, string m ){p();}";
                 PARTICLE_DATA11 += "changed( integer c ) {";
                 PARTICLE_DATA11 += "if(c & CHANGED_TELEPORT) p();}}";              
                 llSay(0, PARTICLE_DATA11);
            }                                         
        }
    }
}