// xs_movement

// Version 0.33  2-13-2011
// modified the order of the globals for clarity


/////////////////////////////////////////////////////////////////////
// This code is licensed as Creative Commons Attribution/NonCommercial/Share Alike

// See http://creativecommons.org/licenses/by-nc-sa/3.0/
// Noncommercial -- You may not use this work for commercial purposes
// If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
// This means that you cannot sell this code but you may share this code.
// You must attribute authorship to me and leave this notice intact.
//
// Exception: I am allowing this script to be sold inside an original build.
// You are not selling the script, you are selling the build.
// Ferd Frederix


// Based on code from Xundra Snowpaw
// New BSD License: http://www.opensource.org/licenses/bsd-license.php
// Copyright (c) 2010, Xundra Snowpaw
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

//* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer
// in the documentationand/or other materials provided with the distribution.

// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
// BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
//  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////
// COPY FROM GLOBAL CONSTANTS FILE LOCATED IN Debug Folder
// INCLUDE THESE IN ALL SCRIPTS //
// This first section is general tuneable numbers that should be changed for any new pet

key YOUR_UUID = "";        // if you add a UUID for your avatar here, you can change it later
                              // and other alts or friends can change it too, and make these pets
                              // If you leave it blank, only the creator can work on these pets

string  SECRET_PASSWORD = "top secret string";    // must use a password unique to any animal with enctryption on
integer SECRET_NUMBER = 99999;             		  // any number thats a secret

string Animal = "Troubot";        // was 'Quail', must be the name of your animal
string Egg = "Nut and Bolt";      // was 'XS Egg', must be the name of your egg
string Crate = "Transport UFO";   // was XS-Cryocrate, must be the name of the crate
string HomeObject = "Home Flag"; // was "XS Home Object", must be the name of your Home Post
string sound = "robot_sound";	// a basic sound, one needed, You can also use xs_sound, a plugin for more sounds


// optional changeble numbers



// global prim animation linkmessages on channel 1
// these are the prim animations played for each type of possible animation, no need to change them unless you want to change names of the animations when you run the prim animator

string ANI_STAND = "stand";             // default standing animation
string  ANI_WALKL   = "left";           // triggers Left foot and righrt arm walk animation
string  ANI_WALKR   = "right";          // triggers Right foot and left arm walk animation
string  ANI_SLEEP  = "sleep";           // Sleeping
string  ANI_WAVE = "wave";              // Calling for sex, needs help with food, etc.

float GROWTH_AMOUNT = 0.10; 			// 10% size increase each day for MaxAge days
integer MaxAge = 7;              		// can get pregnant in 7 days
integer UNITS_OF_FOOD = 168;     		// food bowl food qty, used by food bowl only
float secs_to_grow = 86400;      		// grow daily = 86400
float   FOOD_BOWL_SCAN_INTERVAL = 1800.0;	// look for food every 3 hours
float fPregnancy = 172800.0; 			// how many seconds to lay an egg  = 2 days or 48 hours.
float fDaysToAdult = 7;     			// 7 days to become old enough to breed.
integer SECONDS_BETWEEN_FOOD_NORMAL = 14400;	// this number of seconds to get hungry
integer SECONDS_BETWEEN_FOOD_HUNGRY = 3600;		// this number of seconds before hunger count increases
integer MAXIMUM_HUNGER = 30;			// not used, just displayed





// Security - recommended that you leave this TRUE
integer ENCRYPT = TRUE;    // set to TRUE to encrypt all data, My Opensim prefers FALSE, TRUE is the most secure

// the following are global constants and do not need to be changed

float VERSION = 0.28;        // This is the Protocol version.  If you change this, then all pets older than this will not be compatible   

///// GLOBAL CONSTANTS extracted from original source //////
//
// if you change any of these constants, change it everywhere and in a list in XS_Debug so it can print them
//
integer FOOD_CHANNEL = -999191;
integer ANIMAL_CHANNEL = -999192;
integer EGG_CHANNEL = -999193;
integer HOME_CHANNEL = -999194;
integer BOX_CHANNEL = -999195;
integer ACC_CHANNEL = -999196;
integer UPDATE_CHANNEL = -999197;
integer API_CHANNEL = -999198;



// global link messages to control the animal 
integer LINK_AGE_START = 800;      // when quail is rezzed and secret_number, is sent by brain to breeder, eater and informatic get booted up
integer LINK_FOOD_CONSUME = 900;   // from movement to brain when close to food, brain then consumes a random amount up to 10000
integer LINK_FOODMINUS = 901;    // xs_brain  receives FOOD_CONSUME, decrement hunger (eat)
integer LINK_HUNGRY = 903;        // sent by eater (string)hunger_amount, checks each hour
integer LINK_HAMOUNT = 904;       // hunger_amount = (integer)str,m updates the hunger amount in scripts
integer LINK_SET_HOME = 910;      // loc ^ dist
integer LINK_MOVER = 911;         // tell mover to rest for str seconds
integer LINK_FOODIE_CLR = 920;    // clear all food_bowl_keys and contents
integer LINK_FOODIE = 921;        // send FOOD_LOCATION coordinates to movement
integer LINK_COLOR1 = 930;             // colour1
integer LINK_COLOR2 = 931;             // colour2
integer LINK_SEX = 932;                // sex
integer LINK_SHINE = 933;              // shine
integer LINK_GLOW = 934;               // glow
integer LINK_GEN = 935;                // generation
integer LINK_RESET_SIZE = 936;          // reset size to 1
integer LINK_MAGE = 940;                // xs_brain sends, xs_ager consumes, adds str to age, if older than 7 days, will grow the animal
integer LINK_DAYTIME = 941;             // xs_ager consumes, starts a timer of 86,400 seconds in xs_ager
integer LINK_GET_AGE = 942;             // get age from xs_ager and sent it on channel 943
integer LINK_PUT_AGE = 943;             // print age from xs_ager
integer LINK_PACKAGE = 950;             // look for a cryo_crate
integer LINK_SEEK_FEMALE = 960;         // MALE_BREED_CALL
integer LINK_MALE_BREED_CALL = 961;     // triggered by LINK_SEEK_FEMALE
integer LINK_SIGNAL_ELIGIBLE = 962;     // sent by female when hears LINK_MALE_BREED_CALL
integer LINK_FEMALE_ELIGIBLE = 963;     // sent when it hears in chat FEMALE_ELIGIBLE
integer LINK_CALL_MALE = 964;           // if LINK_FEMALE_ELIGIBLE && looking_for_female
integer LINK_MALE_ON_THE_WAY = 965;     // triggered by LINK_CALL_MALE
integer LINK_FEMALE_LOCATION = 966;     // female location, sends coordinates of a female
integer LINK_RQST_BREED  = 967;         // sent when close enough to male/female
integer LINK_CALL_MALE_INFO = 968;      // sent by xs_breeding, this line of code was in error in v.24 of xs_breeding see line 557 and 636 of xs_brain which make calls and also xs_breeding which receives LINK_MALE_INFO.
integer LINK_MALE_INFO = 969;
integer LINK_LAY_EGG = 970;             // llRezObject("XS Egg"
integer LINK_BREED_FAIL = 971;          // key = father, failed, timed out
integer LINK_PREGNANT = 972;            // chick is preggers
integer LINK_SOUND_OFF= 974;             // sound is off
integer LINK_SOUND_ON= 973;             // sound is on
integer LINK_SLEEPING = 990;            // close eyes 
integer LINK_UNSLEEPING = 991;          // open eyes
integer LINK_SOUND = 1001;              // plays a sound if enabled
integer LINK_SPECIAL = 1010;            // xs_special, is str = "Normal", removes script
integer LINK_PREGNANCY_TIME = 5000;    // in seconds as str
integer LINK_SLEEP = 7999;              // disable sleep by parameter
integer LINK_TIMER = 8000;              // scan for food bowl about every 1800 seconds
integer LINK_DIE = 9999;                // death


///////// end global Link constants ////////


///////////// END OF COPIED CODE ////////////






vector home_location;
float roam_distance;
list food_bowls;
list food_bowl_keys;
list food_bowl_time;

vector destination;

integer sex_dest = 0;
integer food_dest = 0;
float tolerance = 0.15;
float increment = 0.1;
integer rest;
integer age;
float zoffset;
integer sleep_last_check ;
integer sound_flag;
integer sleep_disabled;


face_target(vector lookat) {
	vector  fwd = llVecNorm(lookat-llGetPos());     //I assume you know the last and current position
	vector lft = llVecNorm(<0,0,1>%fwd);     //cross with <0,0,1> is parallel to ground
	rotation rot = llAxes2Rot(fwd,lft,fwd%lft);
	llMessageLinked(LINK_SET, 1, ANI_WALKL, "");
	llMessageLinked(LINK_SET, 1, ANI_WALKR, "");
	llSetRot(rot);
}

integer sleeping()
{
	vector sun = llGetSunDirection();
	if (!sleep_disabled) {
		if (sun.z < 0) {
			if (sleep_last_check == 0) {
				// close eyes
				llMessageLinked(LINK_SET, 1, ANI_SLEEP, "");
				llMessageLinked(LINK_SET, LINK_SLEEPING, "", "");
			}
			sleep_last_check = 1;
		} else {
				if (sleep_last_check == 1) {
					// open eyes
					llMessageLinked(LINK_SET, 1, ANI_STAND, "");
					llMessageLinked(LINK_SET, LINK_UNSLEEPING, "", "");
				}
			sleep_last_check = 0;
		}
		return sleep_last_check;
	} else {
			if (sleep_last_check == 1) {
				llMessageLinked(LINK_SET, 1, ANI_STAND, "");
				llMessageLinked(LINK_SET, LINK_UNSLEEPING, "", "");
				sleep_last_check = 0;
			}
		return 0;
	}
}

default
{
	link_message(integer sender, integer num, string str, key id)
	{
		if (num == LINK_AGE_START) {
			state running;
		}
	}
}

state running
{
	state_entry()
	{
		//  llOwnerSay("Running");

		home_location = <0,0,0>;
		roam_distance = 0;
		destination = <0,0,0>;
		age = 0;
		sleep_last_check = 0;
		sound_flag = 1;
	}


	timer()
	{
		// llOwnerSay("tick");

		if (!sleeping()) {

			llMessageLinked(LINK_SET, LINK_SOUND, "", "");


			vector my_pos = llGetPos();

			if (llVecDist(<destination.x, destination.y, 0>, <my_pos.x, my_pos.y, 0>) <= tolerance || destination == <0,0,0>) {
				// if at food_destination send 900 msg
				if (food_dest > 0) {
					llMessageLinked(LINK_SET, LINK_FOOD_CONSUME, (string)food_dest, llList2Key(food_bowl_keys, 0));
				}

				if (sex_dest > 0) {
					llMessageLinked(LINK_SET, 1, ANI_STAND, "");
					llMessageLinked(LINK_SET, 1, ANI_WAVE, "");
					llMessageLinked(LINK_SET, 1, ANI_STAND, "");
					llMessageLinked(LINK_SET, LINK_RQST_BREED, "", "");

				}


				// pick a new destination
				sex_dest = 0;
				food_dest = 0;
				destination.x = (llFrand(roam_distance * 2) - roam_distance) + home_location.x;
				destination.y = (llFrand(roam_distance * 2) - roam_distance) + home_location.y;

				destination.z = home_location.z + zoffset;

				//llOwnerSay("Moving to " + (string)destination + " but first, a rest!");
				rest = (integer)llFrand(5.0);
				// face it
				face_target(destination);
			}
			if (rest == 0) {

				// llOwnerSay("move");
				// move towards destination
				vector position = llGetPos();
				float dis_x = llFabs(destination.x - position.x);
				float dis_y = llFabs(destination.y - position.y);

				float angle = llAtan2(dis_y, dis_x);

				float inc_x = llCos(angle) * increment;
				float inc_y = llSin(angle) * increment;

				if (inc_x > increment) {
					llOwnerSay("BUG: X" + (string)inc_x + " > " + (string)increment);
				}
				if (inc_y > increment) {
					llOwnerSay("BUG: Y" + (string)inc_y + " > " + (string)increment);
				}

				if (destination.x > position.x) {
					position.x += inc_x;
				} else {
						position.x -= inc_x;
				}

				if (destination.y > position.y) {
					position.y += inc_y;
				} else {
						position.y -= inc_y;
				}

				position.z = home_location.z + zoffset;

				llMessageLinked(LINK_SET, 1, ANI_WALKL, "");
				llMessageLinked(LINK_SET, 1, ANI_WALKR, "");
				llMessageLinked(LINK_SET, 1, ANI_STAND, "");

				llSetPos(position);
			} else {
					rest--;
			}
		}
	}

	link_message(integer sender, integer num, string str, key id)
	{
		if (num == LINK_HUNGRY) {
			if (sex_dest == 0) {
				// move to food bowl, then send 900
				if (llGetListLength(food_bowl_keys) > 0) {
					if (roam_distance == 0 || home_location == <0,0,0>) {
						llOwnerSay("I'm hungry, but I'm not homed so I can not move! Attempting to use Jedi Mind Powers to teleport food to my belly.");
						llMessageLinked(LINK_SET, LINK_FOOD_CONSUME, str, llList2Key(food_bowl_keys, 0));
						llMessageLinked(LINK_SET, 1, ANI_STAND, "");
						llMessageLinked(LINK_SET, 1, ANI_WAVE, "");
						llMessageLinked(LINK_SET, 1, ANI_STAND, "");
					} else {
							// find nearest food bowl
							integer i;
						destination = (vector)llList2String(food_bowls, 0);
						for (i=1;i<llGetListLength(food_bowls);i++) {
							if (llVecDist(destination, llGetPos()) > llVecDist((vector)llList2String(food_bowls, i), llGetPos())) {
								destination = (vector)llList2String(food_bowls, i);
							}
						}
						destination.z = home_location.z + zoffset;
						// set destination,
						// face it
						face_target(destination);
						food_dest = (integer)str;
						rest = 0;
						//llMessageLinked(LINK_SET, LINK_FOOD_CONSUME, str, llList2Key(food_bowl_keys, 0));
					}
				} else {
						llMessageLinked(LINK_SET, 1, ANI_STAND, "");
					llMessageLinked(LINK_SET, 1, ANI_WAVE, "");
					llMessageLinked(LINK_SET, 1, ANI_STAND, "");
					llOwnerSay("I'm hungry, but I can't seem to find any food bowls at present.");
				}
			}
		} else
		if (num == LINK_SET_HOME) {
			//  llOwnerSay("HOmey");
			list values = llParseString2List(str, ["^"], []);
			home_location = (vector)llList2String(values, 0);
			roam_distance = llList2Float(values, 1);
			vector current_loc = llGetPos();

			llMessageLinked(LINK_SET, 1, ANI_STAND, "");
			llMessageLinked(LINK_SET, 1, ANI_WAVE, "");
			llMessageLinked(LINK_SET, 1, ANI_STAND, "");

			food_bowls = [];
			food_bowl_keys = [];
			food_bowl_time = [];

			destination = <0,0,0>;
			food_dest = 0;

			llSetPos(<current_loc.x, current_loc.y, home_location.z + zoffset>);
			llSetTimerEvent(4.0);
		} else
		if (num == LINK_MOVER) {
			if (rest < (integer)str) {
				rest = (integer)str;
			}
		} else
		if (num == LINK_FOODIE_CLR) {
			food_bowls = [];
			food_bowl_keys = [];
			food_bowl_time = [];
		} else
		if (num == LINK_FOODIE) {
			vector food_loc = (vector)str;

			if (llVecDist(home_location, food_loc) <= roam_distance ) {
				if(llListFindList(food_bowls, (list)str) == -1) {
					integer id_pos = llListFindList(food_bowl_keys, (list)id);
					if (id_pos == -1) {
						food_bowls += str;
						food_bowl_keys += id;
						food_bowl_time += llGetUnixTime();
					} else {
							food_bowls = llListReplaceList(food_bowls, [str], id_pos, id_pos);
						food_bowl_time  = llListReplaceList(food_bowl_time, [llGetUnixTime()], id_pos, id_pos);
					}
				}

				integer iter;

				iter = 0;

				while(iter<llGetListLength(food_bowls)) {
					if (llGetUnixTime() - llList2Integer(food_bowl_time, iter) > 3600) {//3600
						food_bowls = llDeleteSubList(food_bowls, iter, iter);
						food_bowl_keys = llDeleteSubList(food_bowl_keys, iter, iter);
						food_bowl_time = llDeleteSubList(food_bowl_time, iter, iter);
					} else {
							iter++;
					}
				}

				if (llGetListLength(food_bowls) > 0) {
					llMessageLinked(LINK_SET, LINK_TIMER, "", "");
				}

			}
		} else
		if (num == LINK_FEMALE_LOCATION) {
			destination = (vector)str;
			face_target(destination);
			rest = 0;
			food_dest = 0;
			sex_dest = 1;
			llMessageLinked(LINK_SET, 1, ANI_STAND, "");
			llMessageLinked(LINK_SET, 1, ANI_WAVE, "");
			llMessageLinked(LINK_SET, 1, ANI_STAND, "");
		} else
		if (num == LINK_MAGE) {
			integer heightm;
			age += (integer)str;
			heightm = age;

			if (heightm > 7)
				heightm = 7;
			float new_scale = (GROWTH_AMOUNT * heightm) + 1.0;

			float legsz = 0.064 * new_scale;
			float legso = 0.052399 * new_scale;

			zoffset = legsz / 2 + legso;
		} else
		if (num == LINK_SLEEP) {
			sleep_disabled = (integer)str;
		}
	}
}
