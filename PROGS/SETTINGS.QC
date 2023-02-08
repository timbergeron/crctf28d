
// Adjustable settings
// Note:  fresh_spawn was removed because it was redundant.  CTF always starts out fresh
float admin_code_real = 0000; // Change to your admin code
float LOCKOUT = 0; // Default Value for lockout
float LOCK_NUM = 16; // Default Value for lockmax
float DEBUGGING = 0; // DO NOT TURN THIS ON UNLESS TESTING, REMOVES ALL SECURITY FROM SERVER
float OVERRIDE_VOTES = 0.6; // percentage of players needed to override match start
float TEAM_CAPTURE_CUSTOM = 1; // If custom CTF stuff should be used 1 for yes, 0 for no
float OBSERVER_ENTRY = 1; // If all players should enter as observers 1 for yes, 0 for no
float AUTO_RESPAWN = 90; // If everyone should be automatically, how long, in seconds
float LOCK_LEVEL = 0; // Locks the server to a given level
float TM_SV_AIM = 0; // If autoaim should be used in teamplay, 1 for yes, 0 for no
float USE_PLS = 0;  //1 if the PLS (see below) should be used, 0 for CTF default. Skirmish mode 
float CORPSES = 1; //1 if you want the dead bodies around, 0 to have a clean floor
float NORUNES = 0; //1 for no runes, 0 for runes.
float EXPANDED_MAPS = 0; // 0 if you only have Threewave maps
			 // 1 if you only have Threewave + Expansion
			 // 2 if you have the complete All-Star set (recommended!)

// QSmack mod
float AUTO_PASSWD_0 = -1;
float AUTO_PASSWD_1 = -1;
float AUTO_PASSWD_2 = -1;
float AUTO_PASSWD_3 = -1;
float AUTO_PASSWD_4 = -1;
// QSmack mod end
/*
================
StringSet
================
*/
void() StringSet =
{

ctfstartmap = "ctfstart"; // This could also be "epstart" (if you have the
			  // expansion pack but not All-Star CTF) or "allstart"
			  // (if you have All-Star CTF).

// Below is the Server Greeting, this greeting MUST contain "Running Clanring CTF Server v2.8e".


server_greeting_clanring = "Running Clanring CTF Server v2.8i\n";

server_greeting_red = "Running Clanring CTF Server v2.8i\n\nYou are “≈ƒ team";

server_greeting_blue = "Running Clanring CTF Server v2.8i\n\nYou are ¬Ã’≈ team";

server_greeting_observer_cr = "Running Clanring CTF Server v2.8i\n\nYou are an œ‚ÛÂÚˆÂÚ";
server_greeting_observer_sk = "Running Clanring CTF Server v2.8i\n\nYou are an œ‚ÛÂÚˆÂÚ\nPress 1 for “≈ƒ team\nPress 2 for ¬Ã’≈ team\nOr Press 3 for automatic team";


// Set these variables to the mapnames that you want to cycle thru
// in the order that you want them to go, if you don't have 50 maps to cycle
// thru, put "none" for the remaining slots. Heh I added some more maps for the pls, you can mix //and match them however you 
// want.  I went for an even 50, btw the only levels left out were e1m8 and e1m7 (yech).

// When specifying the name of the map, be case-sensitive!
// Some OSs don't care, but some do.  And if the map is in
// a PAK file, case ALWAYS matters.

	level_1 = "ctf2m1";
	level_2 = "ctf2m2";
	level_3 = "ctf2m3";
	level_4 = "ctf2m4";
	level_5 = "ctf2m5";
	level_6 = "ctf2m6";                                     
	level_7 = "ctf2m7";
	level_8 = "ctf2m8";
	level_7 = "e1m1";
	level_8 = "e1m2";
	level_9 = "e1m3";
	level_10 = "e1m4";
	level_11 = "e1m5";
	level_12 = "e1m6";
	level_13 = "e2m1";
	level_14 = "e2m2";
	level_15 = "e2m3";
	level_16 = "e2m4";
	level_17 = "e2m5";
	level_18 = "e2m6";
	level_19 = "e2m7";
	level_20 = "e3m1";
	level_21 = "e3m2";
	level_22 = "e3m2";
	level_23 = "e3m3";
	level_24 = "e3m4";
	level_25 = "e3m5";
	level_26 = "e3m6";
	level_27 = "e3m7";
	level_28 = "e4m1";
	level_29 = "e4m2";
	level_30 = "e4m3";
	level_31 = "e4m4";
	level_32 = "e4m5";
	level_33 = "e4m6";
	level_34 = "e4m7";
	level_35 = "e4m8";
	level_36 = "dm1";
	level_37 = "dm2";
	level_38 = "dm3";
	level_39 = "dm4";
	level_40 = "dm5";
	level_41 = "dm6";
	level_42 = "ctf1";
	level_43 = "ctf2";
	level_44 = "ctf3";
	level_45 = "ctf4";
	level_46 = "ctf5";
	level_47 = "ctf6";
	level_48 = "ctf7";
	level_49 = "ctf8";
	level_50 = "none";
	


// Set these variables to the custom mapnames that you want available
// If you don't have 8 custom maps to cycle thru, put "none" for unused slots
// you can also put these in the main pls above, but make sure your clients will have or know where to get you 
// custom maps.

// When specifying the name (not the description) of the map, be
// case-sensitive!  Some OSs don't care, but some do.  And if the
// map is in a PAK file, case ALWAYS matters.

	custom_1 = "none";
	custom_1_description = "N/A";
	custom_2 = "none";
	custom_2_description = "N/A";
	custom_3 = "none";
	custom_3_description = "N/A";
	custom_4 = "none";
	custom_4_description = "N/A";
	custom_5 = "none";
	custom_5_description = "N/A";
	custom_6 = "none";
	custom_6_description = "N/A";
	custom_7 = "none";
	custom_7_description = "N/A";
	custom_8 = "none";
	custom_8_description = "N/A";
	custom_9 = "none";
	custom_9_description = "N/A";
	custom_10= "none";
	custom_10_description= "N/A";
	custom_11= "none";
	custom_11_description= "N/A";
	custom_12= "none";
	custom_12_description= "N/A";


	// Don't mess with this!
	if (EXPANDED_MAPS == 0) {
		ctfstartmap = "ctfstart";
	}
	if (EXPANDED_MAPS == 1) {
		ctfstartmap = "epstart";
	}
	if (EXPANDED_MAPS == 2) {
		ctfstartmap = "allstart";
	}

};


