/*
==============================================================================

			SOURCE FOR GLOBALVARS_T C STRUCTURE

==============================================================================
*/

//
// system globals
//
entity		self;
entity		other;
entity		world;
float		time;
float		frametime;

float		force_retouch;		// force all entities to touch triggers
								// next frame.  this is needed because
								// non-moving things don't normally scan
								// for triggers, and when a trigger is
								// created (like a teleport trigger), it
								// needs to catch everything.
								// decremented each frame, so set to 2
								// to guarantee everything is touched
string		mapname;

float		deathmatch;
float		coop;
float		teamplay;

float		serverflags;		// propagated from level to level, used to
								// keep track of completed episodes

float		total_secrets;
float		total_monsters;

float		found_secrets;		// number of secrets found
float		killed_monsters;	// number of monsters killed


// spawnparms are used to encode information about clients across server
// level changes
float		parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, parm9, parm10, parm11, parm12, parm13, parm14, parm15, parm16;

//
// global variables set by built in functions
//	
vector		v_forward, v_up, v_right;	// set by makevectors()
	
// set by traceline / tracebox
float		trace_allsolid;
float		trace_startsolid;
float		trace_fraction;
vector		trace_endpos;
vector		trace_plane_normal;
float		trace_plane_dist;
entity		trace_ent;
float		trace_inopen;
float		trace_inwater;

entity		msg_entity;				// destination of single entity writes

//
// required prog functions
//
void() 		main;						// only for testing

void()		StartFrame;

void() 		PlayerPreThink;
void() 		PlayerPostThink;
void()		ClientKill;
void()		ClientConnect;
void() 		PutClientInServer;		// call after setting the parm1... parms
void()		ClientDisconnect;

void()		SetNewParms;			// called when a client first connects to
									// a server. sets parms so they can be
									// saved off for restarts

void()		SetChangeParms;			// call to set parms for self so they can
									// be saved for a level transition


//================================================
void		end_sys_globals;		// flag for structure dumping
//================================================

/*
==============================================================================

			SOURCE FOR ENTVARS_T C STRUCTURE

==============================================================================
*/

//
// system fields (*** = do not set in prog code, maintained by C code)
//
.float		modelindex;		// *** model index in the precached list
.vector		absmin, absmax;	// *** origin + mins / maxs

.float		ltime;			// local time for entity
.float		movetype;
.float		solid;

.vector		origin;			// ***
.vector		oldorigin;		// ***
.vector		velocity;
.vector		angles;
.vector		avelocity;

.vector		punchangle;		// temp angle adjust from damage or recoil

.string		classname;		// spawn function
.string		model;
.float		frame;
.float		skin;
.float		effects;

.vector		mins, maxs;		// bounding box extents reletive to origin
.vector		size;			// maxs - mins

.void()		touch;
.void()		use;
.void()		think;
.void()		blocked;		// for doors or plats, called when can't push other

.float		nextthink;
.entity		groundentity;

// stats
.float		health;
.float		frags;
.float		weapon;			// one of the IT_SHOTGUN, etc flags
.string		weaponmodel;
.float		weaponframe;
.float		currentammo;
.float		ammo_shells, ammo_nails, ammo_rockets, ammo_cells;

.float		items;			// bit flags

.float		takedamage;
.entity		chain;
.float		deadflag;

.vector		view_ofs;			// add to origin to get eye point


.float		button0;		// fire
.float		button1;		// use
.float		button2;		// jump

.float		impulse;		// weapon changes

.float		fixangle;
.vector		v_angle;		// view / targeting angle for players
.float		idealpitch;		// calculated pitch angle for lookup up slopes


.string		netname;

.entity 	enemy;

.float		flags;

.float		colormap;
.float		team;

.float		max_health;		// players maximum health is stored here

.float		teleport_time;	// don't back up

.float		armortype;		// save this fraction of incoming damage
.float		armorvalue;

.float		waterlevel;		// 0 = not in, 1 = feet, 2 = wast, 3 = eyes
.float		watertype;		// a contents value

.float		ideal_yaw;
.float		yaw_speed;

.entity		aiment;

.entity 	goalentity;		// a movetarget or an enemy

.float		spawnflags;

.string		target;
.string		targetname;

// damage is accumulated through a frame. and sent as one single
// message, so the super shotgun doesn't generate huge messages
.float		dmg_take;
.float		dmg_save;
.entity		dmg_inflictor;

.entity		owner;		// who launched a missile
.vector		movedir;	// mostly for doors, but also used for waterjump

.string		message;		// trigger messages

.float		sounds;		// either a cd track number or sound number

.string		noise, noise1, noise2, noise3;	// contains names of wavs to play

//================================================
void		end_sys_fields;			// flag for structure dumping
//================================================

/*
==============================================================================

				VARS NOT REFERENCED BY C CODE

==============================================================================
*/


//
// constants
//

float	FALSE					= 0;
float 	TRUE					= 1;

// edict.flags
float	FL_FLY				= 1;
float	FL_SWIM				= 2;
float	FL_CLIENT				= 8;	// set for all client edicts
float	FL_INWATER				= 16;	// for enter / leave water splash
float	FL_MONSTER				= 32;
float	FL_GODMODE				= 64;	// player cheat
float	FL_NOTARGET				= 128;	// player cheat
float	FL_ITEM				= 256;	// extra wide size for bonus items
float	FL_ONGROUND				= 512;	// standing on something
float	FL_PARTIALGROUND			= 1024;	// not all corners are valid
float	FL_WATERJUMP			= 2048;	// player jumping out of water
float	FL_JUMPRELEASED			= 4096;	// for jump debouncing
float FL_NOAUTOWEAPON			= 8192;
// JKB changed from 2.2i+
float FL_NOTSMARTAUTOWEAPON		= 16384;
// JKB end 2.2i+

.float quaketv; 


// edict.movetype values
float	MOVETYPE_NONE			= 0;	// never moves
//float	MOVETYPE_ANGLENOCLIP	= 1;
//float	MOVETYPE_ANGLECLIP		= 2;
float	MOVETYPE_WALK			= 3;	// players only
float	MOVETYPE_STEP			= 4;	// discrete, not real time unless fall
float	MOVETYPE_FLY			= 5;
float	MOVETYPE_TOSS			= 6;	// gravity
float	MOVETYPE_PUSH			= 7;	// no clip to world, push and crush
float	MOVETYPE_NOCLIP			= 8;
float	MOVETYPE_FLYMISSILE		= 9;	// fly with extra size against monsters
float	MOVETYPE_BOUNCE			= 10;
float	MOVETYPE_BOUNCEMISSILE	= 11;	// bounce with extra size

// edict.solid values
float	SOLID_NOT				= 0;	// no interaction with other objects
float	SOLID_TRIGGER			= 1;	// touch on edge, but not blocking
float	SOLID_BBOX				= 2;	// touch on edge, block
float	SOLID_SLIDEBOX			= 3;	// touch on edge, but not an onground
float	SOLID_BSP				= 4;	// bsp clip, touch on edge, block

// range values
float	RANGE_MELEE				= 0;
float	RANGE_NEAR				= 1;
float	RANGE_MID				= 2;
float	RANGE_FAR				= 3;

// deadflag values

float	DEAD_NO					= 0;
float	DEAD_DYING				= 1;
float	DEAD_DEAD				= 2;
float	DEAD_RESPAWNABLE		= 3;

// takedamage values

float	DAMAGE_NO				= 0;
float	DAMAGE_YES				= 1;
float	DAMAGE_AIM				= 2;

// items
float	IT_AXE					= 4096;
float	IT_SHOTGUN				= 1;
float	IT_SUPER_SHOTGUN		= 2;
float	IT_NAILGUN				= 4;
float	IT_SUPER_NAILGUN		= 8;
float	IT_GRENADE_LAUNCHER		= 16;
float	IT_ROCKET_LAUNCHER		= 32;
float	IT_LIGHTNING			= 64;
float	IT_EXTRA_WEAPON			= 128;

float	IT_SHELLS				= 256;
float	IT_NAILS				= 512;
float	IT_ROCKETS				= 1024;
float	IT_CELLS				= 2048;

float	IT_ARMOR1				= 8192;
float	IT_ARMOR2				= 16384;
float	IT_ARMOR3				= 32768;
float	IT_SUPERHEALTH			= 65536;

float	IT_KEY1					= 131072;
float	IT_KEY2					= 262144;

float	IT_INVISIBILITY			= 524288;
float	IT_INVULNERABILITY		= 1048576;
float	IT_SUIT					= 2097152;
float	IT_QUAD					= 4194304;
float	IT_HOOK					= 8388608;

// point content values

float	CONTENT_EMPTY			= -1;
float	CONTENT_SOLID			= -2;
float	CONTENT_WATER			= -3;
float	CONTENT_SLIME			= -4;
float	CONTENT_LAVA			= -5;
float	CONTENT_SKY				= -6;

float	STATE_TOP		= 0;
float	STATE_BOTTOM	= 1;
float	STATE_UP		= 2;
float	STATE_DOWN		= 3;

vector	VEC_ORIGIN = '0 0 0';
vector	VEC_HULL_MIN = '-16 -16 -24';
vector	VEC_HULL_MAX = '16 16 32';

vector	VEC_HULL2_MIN = '-32 -32 -24';
vector	VEC_HULL2_MAX = '32 32 64';

// protocol bytes
float	SVC_TEMPENTITY		= 23;
float	SVC_KILLEDMONSTER	= 27;
float	SVC_FOUNDSECRET		= 28;
float	SVC_INTERMISSION	= 30;
float	SVC_FINALE			= 31;
float	SVC_CDTRACK			= 32;
float	SVC_SELLSCREEN		= 33;
float   SVC_SETVIEWANGLES  = 10;


float	TE_SPIKE		= 0;
float	TE_SUPERSPIKE	= 1;
float	TE_GUNSHOT		= 2;
float	TE_EXPLOSION	= 3;
float	TE_TAREXPLOSION	= 4;
float	TE_LIGHTNING1	= 5;
float	TE_LIGHTNING2	= 6;
float	TE_WIZSPIKE		= 7;
float	TE_KNIGHTSPIKE	= 8;
float	TE_LIGHTNING3	= 9;
float	TE_LAVASPLASH	= 10;
float	TE_TELEPORT		= 11;

// sound channels
// channel 0 never willingly overrides
// other channels (1-7) allways override a playing sound on that channel
float	CHAN_AUTO		= 0;
float	CHAN_WEAPON		= 1;
float	CHAN_VOICE		= 2;
float	CHAN_ITEM		= 3;
float	CHAN_BODY		= 4;

float	ATTN_NONE		= 0;
float	ATTN_NORM		= 1;
float	ATTN_IDLE		= 2;
float	ATTN_STATIC		= 3;

// update types

float	UPDATE_GENERAL	= 0;
float	UPDATE_STATIC	= 1;
float	UPDATE_BINARY	= 2;
float	UPDATE_TEMP		= 3;

// entity effects

float	EF_BRIGHTFIELD	= 1;
float	EF_MUZZLEFLASH 	= 2;
float	EF_BRIGHTLIGHT 	= 4;
float	EF_DIMLIGHT 	= 8;


// messages
float	MSG_BROADCAST	= 0;		// unreliable to all
float	MSG_ONE			= 1;		// reliable to one (msg_entity)
float	MSG_ALL			= 2;		// reliable to all
float	MSG_INIT		= 3;		// write to the init string

//================================================

//
// globals
//

float	movedist;
float	gameover;		// set when a rule exits

string	string_null;	// null string, nothing should be held here
float	empty_float;

entity	newmis;			// launch_spike sets this after spawning it

entity	activator;		// the entity that activated a trigger or brush

entity	damage_attacker;	// set by T_Damage
float	framecount;

float		skill;

entity	runespawn;
float	gamestart;		// at start
float	runespawned;
// JKB PATCH on 2.2m
float		samelevel;
float		crmode;
// JKB end 2.2m
float	capturespawned;
float	teamscored;		// non-zero if teams scored
//================================================

//
// world fields (FIXME: make globals)
//
.string		wad;
.string 	map;
.float		worldtype;	// 0=medieval 1=metal 2=base

//================================================

.string		killtarget;

//
// quakeed fields
//
.float		light_lev;		// not used by game, but parsed by light util
.float		style;


//
// monster ai
//
.void()		th_stand;
.void()		th_walk;
.void()		th_run;
.void()		th_missile;
.void()		th_melee;
.void(entity attacker, float damage)		th_pain;
.void()		th_die;

.entity		oldenemy;		// mad at this player before taking damage

.float		speed;

.float	lefty;

.float	search_time;
.float	attack_state;

float	AS_STRAIGHT		= 1;
float	AS_SLIDING		= 2;
float	AS_MELEE		= 3;
float	AS_MISSILE		= 4;

//
// player only fields
//

// *TEAMPLAY*

.float          lastteam;       // The last team this player was a member of.

// *XXX* EXPERT CTF ALTERNATE SCORING

// time values

.float 		flag_since; 		// how long a player has had the flag
.float		last_returned_flag; 	// last time player returned his own flag
.float		last_fragged_carrier; 	// last time player fragged a flag carrier
.float		last_hurt_carrier; 	// last time player hurt the flag carrier

// *XXX* end 

.float		walkframe;

.float 		attack_finished;
.float		pain_finished;
.float		hook_out;

.float		invincible_finished;
.float		invisible_finished;
.float		super_damage_finished;
.float		radsuit_finished;

.float		invincible_time, invincible_sound;
.float		invisible_time, invisible_sound;
.float		super_time, super_sound;
.float		regeneration_sound;//RUNE: Elder Magic
.float		haste_sound;//RUNE: Hell Magic
.float		rad_time;
.float		fly_sound;

.float		axhitme;

.float		show_hostile;	// set to time+0.2 whenever a client fires a
							// weapon or takes damage.  Used to alert
							// monsters that otherwise would let the player go
.float		jump_flag;		// player jump flag
.float		swim_flag;		// player swimming sound flag
.float		air_finished;	// when time > air_finished, start drowning
.float		bubble_count;	// keeps track of the number of bubbles
.string		deathtype;		// keeps track of how the player died
.float 		player_flag;	// misc flags (skins, etc.)
.float		staydeadtime;	// how long we should stay dead
.float		regen_time;		// time to next regen
.float		rune_notice_time;	// last time we notified about multi-runes
.float		voted;			// non-zero if voted
// ZOID: Runes
float		ITEM_RUNE1_FLAG		= 1;
float		ITEM_RUNE2_FLAG		= 2;
float		ITEM_RUNE3_FLAG		= 4;
float		ITEM_RUNE4_FLAG		= 8;
float		ITEM_RUNE_MASK		= 15;

// ZOID: Capture the flag
float		ITEM_ENEMY_FLAG		= 16;
// TEAMPLAY
float		TEAM_STUFF_COLOR	= 32;

// .float		motd_time;
// .float		motd_count;

.float		suicide_count;
.float		killed;			// have we been killed yet

//McBain: PreviousWeaponCommand
.float		previous_weapon;	// one of the IT_SHOTGUN, etc flags


//
// object stuff
//
.string		mdl;
.vector		mangle;			// angle at start

.vector		oldorigin;		// only used by secret door

.float		t_length, t_width;


//
// doors, etc
//
.vector		dest, dest1, dest2;
.float		wait;			// time from firing to restarting
.float		delay;			// time from activation to firing
.entity		trigger_field;	// door's trigger entity
.string		noise4;

//
// monsters
//
.float 		pausetime;
.entity 	movetarget;


//
// doors
//
.float		aflag;
.float		dmg;			// damage done by door when hit
	
//
// misc
//
.float		cnt; 			// misc flag

	
//
// subs
//
.void()		think1;
.vector		finaldest, finalangle;

//
// triggers
//
.float		count;			// for counting triggers


//
// plats / doors / buttons
//
.float		lip;
.float		state;
.vector		pos1, pos2;		// top and bottom positions
.float		height;

//
// sounds
//
.float		waitmin, waitmax;
.float		distance;
.float		volume;




//===========================================================================
	

//
// builtin functions
//

void(vector ang)	makevectors		= #1;		// sets v_forward, etc globals
void(entity e, vector o) setorigin	= #2;
void(entity e, string m) setmodel	= #3;		// set movetype and solid first
void(entity e, vector min, vector max) setsize = #4;
// #5 was removed
void() break						= #6;
float() random						= #7;		// returns 0 - 1
void(entity e, float chan, string samp, float vol, float atten) sound = #8;
vector(vector v) normalize			= #9;
void(string e) error				= #10;
void(string e) objerror				= #11;
float(vector v) vlen				= #12;
float(vector v) vectoyaw			= #13;
entity() spawn					= #14;
void(entity e) remove				= #15;

// sets trace_* globals
// nomonsters can be:
// An entity will also be ignored for testing if forent == test,
// forent->owner == test, or test->owner == forent
// a forent of world is ignored
void(vector v1, vector v2, float nomonsters, entity forent) traceline = #16;	

entity() checkclient				= #17;	// returns a client to look for
entity(entity start, .string fld, string match) find = #18;
string(string s) precache_sound		= #19;
string(string s) precache_model		= #20;
void(entity client, string s)stuffcmd = #21;
entity(vector org, float rad) findradius = #22;
void(string s) bprint				= #23;
void(entity client, string s) sprint = #24;
void(string s) dprint				= #25;
string(float f) ftos				= #26;
string(vector v) vtos				= #27;
void() coredump						= #28;		// prints all edicts
void() traceon						= #29;		// turns statment trace on
void() traceoff						= #30;
void(entity e) eprint				= #31;		// prints an entire edict
float(float yaw, float dist) walkmove	= #32;	// returns TRUE or FALSE
// #33 was removed
float(float yaw, float dist) droptofloor= #34;	// TRUE if landed on floor
void(float style, string value) lightstyle = #35;
float(float v) rint					= #36;		// round to nearest int
float(float v) floor				= #37;		// largest integer <= v
float(float v) ceil					= #38;		// smallest integer >= v
// #39 was removed
float(entity e) checkbottom			= #40;		// true if self is on ground
float(vector v) pointcontents		= #41;		// returns a CONTENT_*
// #42 was removed
float(float f) fabs = #43;
vector(entity e, float speed) aim = #44;		// returns the shooting vector
float(string s) cvar = #45;						// return cvar.value
void(string s) localcmd = #46;					// put string into local que
entity(entity e) nextent = #47;					// for looping through all ents
void(vector o, vector d, float color, float count) particle = #48;// start a particle effect
void() ChangeYaw = #49;						// turn towards self.ideal_yaw
											// at self.yaw_speed
// #50 was removed
vector(vector v) vectoangles			= #51;

//
// direct client message generation
//
void(float to, float f) WriteByte		= #52;
void(float to, float f) WriteChar		= #53;
void(float to, float f) WriteShort		= #54;
void(float to, float f) WriteLong		= #55;
void(float to, float f) WriteCoord		= #56;
void(float to, float f) WriteAngle		= #57;
void(float to, string s) WriteString	= #58;
void(float to, entity s) WriteEntity	= #59;

//
// broadcast client message generation
//

// void(float f) bWriteByte		= #59;
// void(float f) bWriteChar		= #60;
// void(float f) bWriteShort		= #61;
// void(float f) bWriteLong		= #62;
// void(float f) bWriteCoord		= #63;
// void(float f) bWriteAngle		= #64;
// void(string s) bWriteString	= #65;
// void(entity e) bWriteEntity = #66;

void(float step) movetogoal				= #67;

string(string s) precache_file		= #68;	// no effect except for -copy
void(entity e) makestatic		= #69;
void(string s) changelevel = #70;

//#71 was removed

void(string var, string val) cvar_set = #72;	// sets cvar.value

void(entity client, string s) centerprint = #73;	// sprint, but in middle
void(entity client, string s, string s1) centerprint2 = #73;	// sprint, but in middle
void(entity client, string s, string s1, string s2) centerprint3 = #73;	// sprint, but in middle
void(entity client, string s, string s1, string s2, string s3) centerprint4 = #73;	// sprint, but in middle
void(entity client, string s, string s1, string s2, string s3, string s4) centerprint5 = #73;	// sprint, but in middle
void(entity client, string s, string s1, string s2, string s3, string s4, string s5) centerprint6 = #73;	// sprint, but in middle
void(entity client, string s, string s1, string s2, string s3, string s4, string s5, string s6) centerprint7 = #73;	// sprint, but in middle

void(vector pos, string samp, float vol, float atten) ambientsound = #74;

string(string s) precache_model2	= #75;		// registered version only
string(string s) precache_sound2	= #76;		// registered version only
string(string s) precache_file2		= #77;		// registered version only

void(entity e) setspawnparms		= #78;		// set parm1... to the
												// values at level start
												// for coop respawn

//============================================================================

//
// subs.qc
//
void(vector tdest, float tspeed, void() func) SUB_CalcMove;
void(entity ent, vector tdest, float tspeed, void() func) SUB_CalcMoveEnt;
void(vector destangle, float tspeed, void() func) SUB_CalcAngleMove;
void()  SUB_CalcMoveDone;
void() SUB_CalcAngleMoveDone;
void() SUB_Null;
void() SUB_UseTargets;
void() SUB_Remove;

//
//	combat.qc
//
void(entity targ, entity inflictor, entity attacker, float damage) T_Damage;


float (entity e, float healamount, float ignore) T_Heal; // health function

float(entity targ, entity inflictor) CanDamage;

// Don't muck with this stuff below

float   TIMER_RALLY             = 10;
float   TIMER_MATCH             = 20;

float           matchgoing;     // true if match is going
float           timeleft;
.float          cnt2;                   // misc flag 
        // server admin
        .float          indata;
        .float          kick;
        .entity         kicker;
//
//      observer.qc
//

.float observer_pos_num;
.float observer_status;

float OBSERVER_BECOME_OBSERVER = 1;
float OBSERVER_BUTTON0         = 2;
float OBSERVER_BUTTON1         = 4;
float OBSERVER_BUTTON2         = 8;
float OBSERVER_NEXTVIEW        = 16;
float OBSERVER_PREVVIEW        = 32;
float OBSERVER_RESPAWN         = 64;

void(entity player) ObserverInfo;
void(entity player) ObserverInit;
void(entity player) ObserverHelp;
void()              ObserverThink;
void(entity player) ObserverBecomeObserver;
float()             ObserverDeathThink;

.float clan_number, pant_color;
float observerless_mode, timer_exist;
.float ghostcode, ghostcode_stage;
.float clan_number, pant_color, shirt_color;
.float motd, s_switch, s_episode, vote, try, force, done_binding,force_observer;
float episode, level, match_ending, player_number;
.float admincode, admin_stage,targdist;
float timer_pause, timer_temp;
.float not_exist, deaths, friend_kill, enemy_kill;
.float		invincible_left;
.float		invisible_left;
.float		super_damage_left;
.float		radsuit_left;
.float	      next_jump_time;
.float	      bind_check,check_running,check_time;
.float dead_time, dead_time_total, motd_next, seen_motd;
.float camera_switch_time, camera_tracking_time, last_visible_time;
.float weight, number_players,kill,kills, force_tell, stat_dump;
.entity current_cam, besttarg;
.float total_damage_fired, total_damage_done;
.float captures, recoveries, get_flags, frag_carriers, carrier_danger_protects;
.float get_flags, frag_carriers, carrier_danger_protects, carrier_protects;
.float carrier_protects, flag_defences, flag_assists, carrier_assists;
//string what_score;
.float statstate;                     // is the status bar on?

string newmap, level_1, level_2, level_3, level_4, level_5, level_6, level_7;
string level_8, level_9, level_10, level_11, level_12, level_13, level_14;
string level_15, level_16, level_17, level_18, level_19, level_20, level_21;
string level_22, level_23, level_24, level_25, level_26, level_27, level_28, level_29;
string level_30, level_31, level_32, level_33, level_34, level_35, level_36, level_37;
string level_38, level_39, level_40, level_41, level_42, level_43, level_44, level_45;
string level_46, level_47, level_48, level_49, level_50;
string custom, custom_1, custom_2, custom_3, custom_4, custom_5, custom_6, custom_7, custom_8, custom_9, custom_10, custom_11, custom_12;
string custom_1_description, custom_2_description, custom_3_description, custom_4_description, custom_5_description, custom_6_description, custom_7_description, custom_8_description, custom_9_description, custom_10_description, custom_11_description, custom_12_description;
string ctfstartmap;
string server_greeting_clanring;
string server_greeting_blue;
string server_greeting_red;
// JKB changed from 2.2i+
string server_greeting_observer_cr;
string server_greeting_observer_sk;
// JKB end 2.2i+
float vote_topic;
// Clanring Samelevel bitfield entries

float TEAM_HEALTH_PROTECT =     1;      // No health damage from friendly fire
float TEAM_ARMOR_PROTECT =      2;      // No armor damage from friendly fire
float TEAM_DROP_ITEMS = 	4;	// Allow players to drop packs and weapons
float CLANRING_MODE = 		8;	// Clanring competition mode
float TEAM_STATIC_TEAMS = 	16;	// Don't allow players to change teams
float FLIMIT_MODE = 		32;	// If in CR mode we end match by frags
float TLIMIT_MODE = 		64;	// If in CR mode we end match by time


// Don't muck with this stuff above

//PB definitions added by me.
.entity chasetarg; //PB field that holds the entity you are chasing
.float announce_chase_time; //PB time to announce who you are chasing
.float chase_switch_time; //PB time to check for a new player to chase
.float oldhealth; //PB used to tell if player has taken damage
//.float freelook;
//PB edict.quaketv

float QTV_OBSERVER 			= 1;
float QTV_CAMERA                    	= 2; 
float QTV_AUTOCAM		    	= 8;
float QTV_ADMIN				= 16;
float QTV_CHASE				= 32;
float QTV_AUTOCHASE			= 64; 
float QTV_SMOOTH			= 128;
float QTV_QUAKETV			= 256;
float QTV_FREELOOK			= 512;
float QTV_FOUNDTARG			= 1024; // SO 2.8c 

// Don't muck with this stuff above

// SomeOne add
.float admin_last_impulse;		// Last command used by admin (used for kick, playerlist, tlimit, flimit, Matchlength at //this point)
float ADMIN_KICK =  		75;	// Admin kick impulse
float ADMIN_LIST_PLAYERS =	254;	// Admin list players impulse (254 for now, will change prob cause not used really)
// float VKICK_TIME_LIMIT = 	90;	// Time's up!  (not used yet...)
.float 		init_vkick;                     // Hi. I initiated the vote! (boolean)
.float		init_vote;			// initiated any vote, not just vkick... somebody should rewrite this code to fix this :)
// I am using the current .vote variable instead	.float		vkick_voted;			// already voted flag (boolean)
.float		vkick_voted_for;		// been voted to be kicked (boolean)
.float		vkick_voted_for_count;    	// number of votes for kicking	
.float		vkick_voted_against_count;	// number of votes against kicking (not used)
void() VoteTimer; 
// float		vote_vkick_time;                // when to tally votes and reset (VKICK_TIME_LIMIT + time) (not used yet)
void(entity who, string s) TeamPlayerUpdate;
void() TeamCaptureResetUpdate;
void() execute_changelevel;
// SomeOne add : following is for my input routines                                        
.float input_point;                             
.float temp_f;

// End SomeOne add
// QSmack mod
.float    autoAdminLevel;
.float    autoAdminTryLevel;
float      status_isvalid;
// QSmack mod end

// SomeOne add 2.8f
float BotSpawned = 0; // refuse no-names
.float LastDamageInflicted; // The last time we inflicted damage
// SomeOne end add