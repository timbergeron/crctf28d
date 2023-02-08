/* teamplay.qc

   From
        The Complete Enhanced Teamplay

   John Spickes -- jspickes@eng.umd.edu

	$Id: teamplay.qc 1.17 1996/08/17 16:52:45 jspickes Exp $

	$Log: teamplay.qc $
	Revision 1.17  1996/08/17 16:52:45  jspickes
	Fixed a problem with displaying the current team settings that could cause
	the wrong output when teamplay was negative.  Also added code to indicate
	when ID's silly teamplay code is being used.

	Revision 1.16  1996/08/17 00:41:52  jspickes
	Turned off strict coop by default.
	Fixed a bug that could have caused strange behavior if TEAM_COLOR* was
	set to -2.

	Revision 1.15  1996/08/17 00:34:17  jspickes
	Added instructions on drop-item use in current settings output.
	Fixed a problem that would allow you to drop lots of backpacks with
	nothing in them.

*/

/** Defs **/

/** MODIFIABLE CONSTANTS **/

float TEAM_DEFAULT_PENALTY =    1;      // Default frag penalty
float TEAM_STRICT_COOP =	0;	// Strict Coop

// Allowed team colors
// -1 indicates no color

// JKB changed from 2.2i+
// IMPORTANT NOTE: The code assumes the following values!  Do not change!
// JKB end 2.2i+
float TEAM_COLOR1       =       4;
float TEAM_COLOR2       =       13;
float TEAM_COLOR3       =       -1;
float TEAM_COLOR4       =       -1;

/** End of MODIFIABLE CONSTANTS **/

// Globals

entity team1_lastspawn;
entity team2_lastspawn;
float	nextteamupdtime;	// time until next team update
float last_flag_capture;	// time of last capture
float last_capture_team;	// last team that captured
float TEAM_CAPTURE_CAPTURE_BONUS = 5; // what you get for capture  // modified 5/12/98 SO 2.8j add 10 to flag carrier with the rest of his team...
float TEAM_CAPTURE_TEAM_BONUS = 10; // what your team gets for capture
float TEAM_CAPTURE_RECOVERY_BONUS = 1; // what you get for recovery
float TEAM_CAPTURE_FLAG_BONUS = 0; // what you get for picking up enemy flag
float TEAM_CAPTURE_FRAG_CARRIER_BONUS = 2; // what you get for fragging
	//enemy flag carrier
float TEAM_CAPTURE_FLAG_RETURN_TIME = 40; // seconds until auto return

// XXX EXPERT CTF Additional scoring system

// bonuses

float TEAM_CAPTURE_CARRIER_DANGER_PROTECT_BONUS = 2; // bonus for fraggin someone
// who has recently hurt your flag carrier
float TEAM_CAPTURE_CARRIER_PROTECT_BONUS = 1; // bonus for fraggin someone while
// either you or your target are near your flag carrier
float TEAM_CAPTURE_FLAG_DEFENSE_BONUS = 1; // bonus for fraggin someone while
// either you or your target are near your flag
float TEAM_CAPTURE_RETURN_FLAG_ASSIST_BONUS = 1; // awarded for returning a flag that causes a
// capture to happen almost immediately
float TEAM_CAPTURE_FRAG_CARRIER_ASSIST_BONUS = 2; // award for fragging a flag carrier if a
// capture happens almost immediately

// radii

float TEAM_CAPTURE_TARGET_PROTECT_RADIUS = 550; // the radius around an object being
// defended where a target will be worth extra frags
float TEAM_CAPTURE_ATTACKER_PROTECT_RADIUS = 550; // the radius around an object being
// defended where an attacker will get extra frags when making kills

// timeouts

float TEAM_CAPTURE_CARRIER_DANGER_PROTECT_TIMEOUT = 4;
float TEAM_CAPTURE_CARRIER_FLAG_SINCE_TIMEOUT = 2;
float TEAM_CAPTURE_FRAG_CARRIER_ASSIST_TIMEOUT = 6;
float TEAM_CAPTURE_RETURN_FLAG_ASSIST_TIMEOUT = 4;

float TEAM_CAPTURE_UPDATE_TIME = 120;

// END EXPERT CTF

// flag status used in cnt field of flag
float FLAG_AT_BASE = 0;
float FLAG_CARRIED = 1;
float FLAG_DROPPED = 2;


// Prototypes
float() W_BestWeapon;
void() W_SetCurrentAmmo;
void() bound_other_ammo;
void(float o, float n) Deathmatch_Weapon;
void() BackpackTouch;
void(entity who, string s) TeamPlayerUpdate;
// JKB add
// void(entity c, float score, float kill_enemy, float kill_friend) UpdateFrags; // SO 2.8f no longer need this here
// JKB end
void(entity c, float score, float capture, float recovery, float get_flag, float frag_carrier) UpdateFlags;
void(entity c, float score, float carrier_danger_protect, float carrier_protect, float flag_defence) UpdateProtects;
void(entity c, float score, float flag_assist, float carrier_assist) UpdateAssists;

// Return a name for the color of a team
// JKB changed from 2.2i+
// Don't need this in CTF
/*
string(float Team) GetTeamColor =
{
	if(Team == 0) return("Blue");
	else if(Team == 1) return("Steel blue");
	else if(Team == 2) return("Brown");
	else if(Team == 3) return("Baby blue");
	else if(Team == 4) return("Green");
	else if(Team == 5) return("Red");
	else if(Team == 6) return("Olive");
	else if(Team == 7) return("Orange");
	else if(Team == 8) return("Peech");
	else if(Team == 9) return("Purple");
	else if(Team == 10) return("Majenta");
	else if(Team == 11) return("Grey");
	else if(Team == 12) return("Aqua");
	else if(Team == 13) return("Yellow");
	else if(Team == 14) return("Blue");
	return "Unknown";
};
*/
// JKB end 2.2i+

// *XXX* EXPERT CTF
// Just a quickie to return the ASCII-ized team names for CTF
string(float Team) GetCTFTeam =
{

	if (Team == (TEAM_COLOR1 + 1)) return "“≈ƒ";
	if (Team == (TEAM_COLOR2 + 1)) return "¬Ã’≈";
	return "";

};

/*
================
TeamArmorDam

Return TRUE if the target's armor can take damage from this attacker.
================
*/

float(entity targ, entity inflictor, entity attacker, float damage) TeamArmorDam =
{
	if (gamestart) return TRUE;

// JKB changed from 2.2l
        if( (samelevel & TEAM_ARMOR_PROTECT) && 
// JKB end 2.2l
			(attacker.lastteam == targ.lastteam) && 
			(attacker != targ) && (targ.lastteam > 0) )
        {
                // Armor is protected
                return FALSE;
        }
        return TRUE;
};

/*
================
TeamHealthDam

Return TRUE if the target can take health damage from this attacker.
================
*/
float(entity targ, entity inflictor, entity attacker, float damage) TeamHealthDam =
{
// JKB changed from 2.2i+
	if (gamestart) return TRUE;
// JKB end 2.2i+
        if( (attacker.lastteam == targ.lastteam) && 
			(attacker != targ) && (targ.lastteam > 0) )
        {
                // Attacker and target are on the same team.
// JKB changed from 2.2l
                if(samelevel & TEAM_HEALTH_PROTECT )
// JKB end 2.2l
                {
                        // Health is protected
                        return FALSE;
                }
        }
        return TRUE;
};

/*
==================
TeamColorIsLegal

Return TRUE if the indicated color is legal
==================
*/
float(float color) TeamColorIsLegal =
{
        if( (color == TEAM_COLOR1) && (TEAM_COLOR1 >= 0) )
                return TRUE;
        if( (color == TEAM_COLOR2) && (TEAM_COLOR2 >= 0) )
                return TRUE;
};

/*
==================
TeamCheckTeam

Check if the team self is on is legal, and put self in a legal team if not.
==================
*/
void() TeamCheckTeam =
{
	local float TEAM1;
	local float TEAM2;

	local float newcolor;
	local float t;

	local entity p;

	local string n; 

	if( self.lastteam >= 0 )
	{
			if(TeamColorIsLegal(self.team - 1)) {
				self.lastteam = self.team;
				return;
			}
	}

	// Assign the player to a team.

	// Sum the players on all the teams.

	TEAM1 = 0;
	TEAM2 = 0;

	p = find (world, classname, "player");

	while(p)
	{
		if (p != self) {
			if( (TEAM_COLOR1 >= 0) && (p.team == (TEAM_COLOR1 +1)) )
					TEAM1 = TEAM1 + 1;
			if( (TEAM_COLOR2 >= 0) && (p.team == (TEAM_COLOR2 +1)) )
					TEAM2 = TEAM2 + 1;
		}
		p = find(p, classname, "player");
	}

	// Find the team with the least players.
	newcolor = TEAM_COLOR1;
	t = TEAM1;

	if ( (TEAM_COLOR2 >= 0) && (TEAM2 < t) ) {
			newcolor = TEAM_COLOR2;
			t = TEAM2;
	}

	// Put the player on a the new team.

	n = ftos(newcolor);
	stuffcmd(self, "color ");
	stuffcmd(self, n);
	stuffcmd(self, "\n");

// JKB changed from 2.2i+
/*
	sprint(self, "You have been assigned color ");
	sprint(self, n);
	sprint(self, "\nLegal colors are:");
	if(TEAM_COLOR1 >= 0)
	{
			n = ftos(TEAM_COLOR1);
			sprint(self, " ");
			sprint(self, n);
	}
	if(TEAM_COLOR2 >= 0)
	{
			n = ftos(TEAM_COLOR2);
			sprint(self, " ");
			sprint(self, n);
	}
	sprint(self, "\n");
*/
// JKB end 2.2i+

	self.lastteam = newcolor + 1;      // Remember what team we're on
	self.team = newcolor + 1;
			self.player_flag = self.player_flag | TEAM_STUFF_COLOR;
		if (teamplay & TEAM_CAPTURE_CUSTOM) {
			if (self.lastteam == TEAM_COLOR1 + 1)
				self.skin = 1;
			else
				self.skin = 3;
			self.player_flag = self.player_flag - (self.player_flag & 65280);
			self.player_flag = self.player_flag | (self.skin * 256);
		}
};

/*
===============
TeamCheckLock

Check for team changing and perform whatever actions are neccessary.
===============
*/
void() TeamCheckLock =
{
        local   float   n;
        local   string  s;
// JKB changed from 2.2l
//	local	float samelevel;
// JKB end 2.2l

// JKB changed from 2.2k
// SomeOne Add
	if (gamestart) {
		if (self.team != 1)
			stuffcmd(self, "color 0\n");
		self.lastteam = 1;
		return;
	}
// JKB end 2.2k

		if (self.player_flag & TEAM_STUFF_COLOR) {
			self.player_flag = self.player_flag - TEAM_STUFF_COLOR;
			stuffcmd(self, "color ");
			n = self.lastteam - 1;
			s = ftos(n);
			stuffcmd(self, s);
			stuffcmd(self, "\n");
			if (self.team == 5) centerprint(self,"You are “≈ƒ team");
			else if (self.team == 14) centerprint(self,"You are ¬Ã’≈ team");
			return;
		}

        if ( !TeamColorIsLegal(self.team - 1) && (self.team == self.lastteam)) {
			self.lastteam = -1;
		}
        // Check to see if the player has changed colors
        if (self.team != self.lastteam)
        {
                // Player has changed colors

                // If teams are static and we've been on some team already,
                // put us back on the team we were on.

		// JKB change
// JKB changed from 2.2l
//		samelevel = cvar("samelevel");
// JKB end 2.2l             // && matchgoing
                if (((crmode) || ((samelevel & TEAM_STATIC_TEAMS) && (!crmode))) && (self.lastteam >= 0))
                {
		// JKB end
                        if ( TeamColorIsLegal(self.lastteam - 1) )
                        {
								// changing teams sucks, kill him

								// if he has tried to change teams several
								// times, kick him off the server.
								if (self.suicide_count > 99) {
									sprint(self, "You were told you can't change teams.\nGo play color games somewhere else.\n");
									stuffcmd(self, "disconnect\n");
									bprint(self.netname);
									bprint(" has bad color sense\n");
								}
								// case base respawn
								//if (self.killed != 1) // commented out by SO 2.8E.. what thsi for? Was causing the cheat bug at matchstart. (switch to invalid color and be spawned outside base)
								//	self.killed = 2; 
								T_Damage(self,self,self,1000);  // Kill the player
								// trying to change teams counts as a suicide
								self.suicide_count = self.suicide_count + 1;
								// JKB add
								// UpdateFrags(self, -1, 0, 1); // SO 2.8f commented out because i don't like it there.
								// JKB end

                               // sprint(self, "You cannot change teams.\n");
                                stuffcmd(self, "color ");
                                n = self.lastteam - 1;
                                s = ftos(n);
                                stuffcmd(self, s);
                                stuffcmd(self, "\n");
					  self.team = self.lastteam;
                                return;
                        }
                        else {
                                // If we're on an illegal team, force a change.
                                self.lastteam = -50;
						}
                }
		// JKB change
// JKB changed from 2.2l
                if (((crmode && matchgoing) || (!crmode)) && (self.lastteam > 0)) {
// JKB end 2.2l
                        // case base respawn
                        if (self.killed != 1)
                                self.killed = 2;
                        T_Damage(self,self,self,1000);  // Kill the player
                }
                self.frags = 0;                 // Zero out frags
                TeamCheckTeam();
		// JKB end
        }
};

/*
=======================
TossBackPack

Original idea by Vhold
Rewritten by John Spickes

Toss out a backpack containing some ammo from your current weapon,
and any weapons you don't have.
=======================
*/
void() TossBackpack =
{
	local entity 	item;

	// If we don't have any ammo, return
	if(self.currentammo <= 0)
		return;

	item = spawn();

	// See if you have the Shotgun or Super Shotgun on
        if ( (self.weapon == IT_SHOTGUN) || (self.weapon == IT_SUPER_SHOTGUN)) {
		if( self.ammo_shells >= 20 ) {
			item.ammo_shells = 20;
			self.ammo_shells = self.ammo_shells - 20;
		}
		else
		{
			item.ammo_shells = self.ammo_shells;
			self.ammo_shells = 0;
		}
	}		
	
	// See if you have neither the Shotgun or Super Shotgun
        if ( !(self.items & IT_SHOTGUN) && !(self.items & IT_SUPER_SHOTGUN)) {
		if( self.ammo_shells >= 20 ) {
			item.ammo_shells = 20;
			self.ammo_shells = self.ammo_shells - 20;
		}
		else
		{
			item.ammo_shells = self.ammo_shells;
			self.ammo_shells = 0;
		}
	}		
	
	// See if we are using a nailgun
        if ( (self.weapon == IT_NAILGUN) || (self.weapon == IT_SUPER_NAILGUN) )
	{
		if( self.ammo_nails >= 20 )
		{
			item.ammo_nails = 20;
			self.ammo_nails = self.ammo_nails - 20;
		}
		else
		{
			item.ammo_nails = self.ammo_nails;
			self.ammo_nails = 0;
		}
	}	
	// Check to see if we have neither nailgun
        if ( !(self.items & IT_NAILGUN) && !(self.items & IT_SUPER_NAILGUN) )
	{
		if( self.ammo_nails >= 20 )
		{
			item.ammo_nails = 20;
			self.ammo_nails = self.ammo_nails - 20;
		}
		else
		{
			item.ammo_nails = self.ammo_nails;
			self.ammo_nails = 0;
		}
	}	
	
	// See if we are using a grenade or rocket launcher
        if ( (self.weapon == IT_GRENADE_LAUNCHER) || (self.weapon == IT_ROCKET_LAUNCHER) )
	{
		if( self.ammo_rockets >= 10 )
		{
			item.ammo_rockets = 10;
			self.ammo_rockets = self.ammo_rockets - 10;
		}
		else
		{
			item.ammo_rockets = self.ammo_rockets;
			self.ammo_rockets = 0;
		}
	}
	// See if we have neither the Grenade or rocket launcher
        if ( !(self.items & IT_GRENADE_LAUNCHER) && !(self.items & IT_ROCKET_LAUNCHER) )
	{
		if( self.ammo_rockets >= 10 )
		{
			item.ammo_rockets = 10;
			self.ammo_rockets = self.ammo_rockets - 10;
		}
		else
		{
			item.ammo_rockets = self.ammo_rockets;
			self.ammo_rockets = 0;
		}
	}

	// See if we're using the lightning gun
	if ( self.weapon == IT_LIGHTNING )
	{	
		if( self.ammo_cells >= 20 )
		{
			item.ammo_cells = 20;
			self.ammo_cells = self.ammo_cells - 20;
		}
		else
		{
			item.ammo_cells = self.ammo_cells;
			self.ammo_cells = 0;
		}
	}
	// see if we don't have the lightning gun
        if ( !(self.items & IT_LIGHTNING) )
	{	
		if( self.ammo_cells >= 20 )
		{
			item.ammo_cells = 20;
			self.ammo_cells = self.ammo_cells - 20;
		}
		else
		{
			item.ammo_cells = self.ammo_cells;
			self.ammo_cells = 0;
		}
	}
	 
	item.owner = self;
	makevectors(self.v_angle);

	setorigin(item, self.origin + '0 0 16');
	item.velocity = aim(self, 1000);
	item.velocity = item.velocity * 500;
	item.flags = FL_ITEM;
	item.solid = SOLID_TRIGGER;
	item.movetype = MOVETYPE_BOUNCE;

	setmodel (item, "progs/backpack.mdl");
	setsize(item, '-16 -16 0', '16 16 56');
	item.touch = BackpackTouch;
	item.nextthink = time + 120;	// remove after 2 minutes
	item.think = SUB_Remove;

	W_SetCurrentAmmo();

};

void() Team_weapon_touch =
{
	local	float	hadammo, best, new, old;
	local entity stemp;

	if (!(other.flags & FL_CLIENT))
		return;
	// Don't let the owner pick up his own weapon for a second.
	if ( (other == self.owner) && ( (self.nextthink - time) > 119 ) )
		return;

// if the player was using his best weapon, change up to the new one if better		
	stemp = self;
	self = other;
	best = W_BestWeapon();
	self = stemp;

	if (self.classname == "weapon_nailgun")
	{
		hadammo = other.ammo_nails;			
		new = IT_NAILGUN;
	}
	else if (self.classname == "weapon_supernailgun")
	{
		hadammo = other.ammo_rockets;			
		new = IT_SUPER_NAILGUN;
	}
	else if (self.classname == "weapon_supershotgun")
	{
		hadammo = other.ammo_rockets;			
		new = IT_SUPER_SHOTGUN;
	}
	else if (self.classname == "weapon_rocketlauncher")
	{
		hadammo = other.ammo_rockets;			
		new = IT_ROCKET_LAUNCHER;
	}
	else if (self.classname == "weapon_grenadelauncher")
	{
		hadammo = other.ammo_rockets;			
		new = IT_GRENADE_LAUNCHER;
	}
	else if (self.classname == "weapon_lightning")
	{
		hadammo = other.ammo_rockets;			
		new = IT_LIGHTNING;
	}
	else
		objerror ("Team_weapon_touch: unknown classname");

	sprint (other, "You got the ");
	sprint (other, self.netname);
	sprint (other, "\n");
// weapon touch sound
	sound (other, CHAN_ITEM, "weapons/pkup.wav", 1, ATTN_NORM);
	stuffcmd (other, "bf\n");

	bound_other_ammo ();

// change to the weapon
	old = other.items;
	other.items = other.items | new;
	
	remove(self);
	self = other;

	if (!deathmatch)
		self.weapon = new;
	else
		Deathmatch_Weapon (old, new);

	W_SetCurrentAmmo();

	activator = other;
	SUB_UseTargets();				// fire all targets / killtargets
};
        
void() TossWeapon =
{
	local entity item;
	
	if (deathmatch != 1)
		return;  // only in deathmatch 1

	if((self.weapon == IT_AXE) || (self.weapon == IT_SHOTGUN) ||
		(self.weapon == IT_HOOK))
		return;
		
	item = spawn();
	item.owner = self;
	makevectors(self.v_angle);

	setorigin(item, self.origin + '0 0 16');
	item.velocity = aim(self, 1000);
	item.velocity = item.velocity * 500;
	item.flags = FL_ITEM;
	item.solid = SOLID_TRIGGER;
	item.movetype = MOVETYPE_BOUNCE;
	
	if(self.weapon == IT_SUPER_SHOTGUN)
	{
		setmodel (item, "progs/g_shot.mdl");
		item.weapon = IT_SUPER_SHOTGUN;
		item.netname = "Double-barrelled Shotgun";
		item.classname = "weapon_supershotgun";
		self.items = self.items - IT_SUPER_SHOTGUN;
	}

	if( self.weapon == IT_NAILGUN )
	{
		setmodel (item, "progs/g_nail.mdl");
		item.weapon = IT_NAILGUN;
		item.netname = "nailgun";
		item.classname = "weapon_nailgun";
		self.items = self.items - IT_NAILGUN;
	}
		
	if( self.weapon == IT_SUPER_NAILGUN)
	{
		setmodel (item, "progs/g_nail2.mdl");
		item.weapon = IT_SUPER_NAILGUN;
		item.netname = "Super Nailgun";
		item.classname = "weapon_supernailgun";
		self.items = self.items - IT_SUPER_NAILGUN;
	}
	
	if( self.weapon == IT_GRENADE_LAUNCHER)
	{
		setmodel (item, "progs/g_rock.mdl");
		item.weapon = 3;
		item.netname = "Grenade Launcher";
		item.classname = "weapon_grenadelauncher";
		self.items = self.items - IT_GRENADE_LAUNCHER;
	}
	
	if( self.weapon == IT_ROCKET_LAUNCHER )
	{
		setmodel (item, "progs/g_rock2.mdl");
		item.weapon = 3;
		item.netname = "Rocket Launcher";
		item.classname = "weapon_rocketlauncher";
		self.items = self.items - IT_ROCKET_LAUNCHER;
	}
	
	if( self.weapon == IT_LIGHTNING )
	{
		setmodel (item, "progs/g_light.mdl");
		item.weapon = 3;
		item.netname = "Thunderbolt";
		item.classname = "weapon_lightning";
		self.items = self.items - IT_LIGHTNING;
	}
	setsize(item, '-16 -16 0', '16 16 56');
	item.touch = Team_weapon_touch;
	item.think = SUB_Remove;
	item.nextthink = time + 120;
	
	self.weapon = W_BestWeapon();
	W_SetCurrentAmmo();
};

void(entity flg) RegenFlag =
{
	flg.movetype = MOVETYPE_TOSS;
	flg.solid = SOLID_TRIGGER;
	sound (flg, CHAN_VOICE, "items/itembk2.wav", 1, ATTN_NORM);	// play respawn sound
	setorigin(flg, flg.oldorigin);
	flg.angles = flg.mangle;
	flg.cnt = FLAG_AT_BASE; // it's at home base
	flg.owner = world;
};

void(entity flg) TeamCaptureReturnFlag =
{
	local entity p;
	RegenFlag(flg);

	p = find(world, classname, "player");
	while (p != world) {
// JKB changed from 2.2i+
		if ((p.quaketv & QTV_OBSERVER) && (flg.team == 5))
			centerprint(p, "RED flag has been returned to base!\n");
		else if ((p.quaketv & QTV_OBSERVER) && (flg.team == 14))
			centerprint(p, "BLUE flag has been returned to base!\n");
// JKB end 2.2i+
		else if (p.team != flg.team)
			centerprint(p, "Enemy flag has been returned to base!\n");
		else if (p.team == flg.team)
			centerprint(p, "Your flag has been returned to base!\n");
		p = find(p, classname, "player");
	}
};

void () TeamCaptureRegenFlags =
{
	local entity f;

	f = find(world, classname, "item_flag_team1");
	if (f != world)
		RegenFlag(f);
	f = find(world, classname, "item_flag_team2");
	if (f != world)
		RegenFlag(f);
};

void(entity flg) TeamDropFlag =
{
	local entity item, f, oself;
	local entity p;

	p = flg.owner;

	bprint(p.netname);
	if (p.lastteam == TEAM_COLOR1 + 1)
		bprint(" ÏÔÛÙ the ¬Ã’≈ flag!\n"); // blue
	else
		bprint(" ÏÔÛÙ the “≈ƒ flag!\n"); // red
//	LogMsg(p, "FLAG-DROP");

	flg.origin = p.origin - '0 0 24';
	flg.cnt = FLAG_DROPPED;
	//NOTE! We check lastteam here instead of team--this is because
	//in the mode where we change colors, we get killed
	flg.velocity_z = 300;
	flg.velocity_x = 0;
	flg.velocity_y = 0;
	flg.flags = FL_ITEM;
	flg.solid = SOLID_TRIGGER;
	flg.movetype = MOVETYPE_TOSS;
	if (teamplay & TEAM_CAPTURE_CUSTOM)
		setsize(self, '-16 -16 0', '16 16 74');
	else
		setsize(item, '-16 -16 -24', '16 16 32');
	// return it after so long
	flg.super_time = time + TEAM_CAPTURE_FLAG_RETURN_TIME;
};

void(entity player) TeamCaptureDropFlagOfPlayer =
{
	local string kn;
	local entity e;

	if (!(player.player_flag & ITEM_ENEMY_FLAG))
		return;
	if (player.lastteam == TEAM_COLOR1 + 1) 
		kn = "item_flag_team2";
	else
		kn = "item_flag_team1";
	player.player_flag = player.player_flag - ITEM_ENEMY_FLAG;
	e = find(world, classname, kn);
	if (e != world)
		TeamDropFlag(e);
};

void() TeamCaptureFlagTouch =
{
	local entity p, oself;

	if (other.classname != "player")
		return;
	if (other.health <= 0)
		return;
// JKB changed from 2.2l
        if (((matchgoing != 1) && crmode) || (other.flags & QTV_OBSERVER) )
// JKB end 2.2l
                return;

	if (other.team != other.lastteam)
		return; // something is fishy, somebody is playing with colors

	if (self.team == other.team) {
		// same team, if the flag is *not* at the base, return
		// it to base.  we overload the 'cnt' field for this
		if (self.cnt == FLAG_AT_BASE) {
			// the flag is at home base.  if the player has the enemy
			// flag, he's just won!

			if (other.player_flag & ITEM_ENEMY_FLAG) {
				bprint(other.netname);
				if (other.team == TEAM_COLOR1 + 1)
					bprint(" „·ÙıÚÂ‰ the ¬Ã’≈ flag!\n"); // blue
				else
					bprint(" „·ÙıÚÂ‰ the “≈ƒ flag!\n"); // red
//				LogMsg(other, "FLAG-CAPTURE");
				other.items = other.items - (other.items & (IT_KEY1 | IT_KEY2));
				
				last_flag_capture = time;
				last_capture_team = other.team;


				if (teamplay & TEAM_CAPTURE_CUSTOM)
					sound (other, CHAN_VOICE, "misc/flagcap.wav", 1, ATTN_NONE);
				else
					sound (other, CHAN_VOICE, "doors/meduse.wav", 1, ATTN_NONE);

				// other gets another 10 frag bonus
				other.frags = other.frags + TEAM_CAPTURE_CAPTURE_BONUS;
				UpdateFlags(other,TEAM_CAPTURE_CAPTURE_BONUS, 1, 0, 0, 0);
				other.captures = other.captures + 1;

				// Ok, let's do the player loop, hand out the bonuses
				p = find(world, classname, "player");
				while (p != world) {
					self = p;
					if (self.quaketv & QTV_OBSERVER) {
						if (other.team == (TEAM_COLOR1 + 1)) {
							centerprint(self, "RED TEAM captured the blue flag!\n");
						}
						else {
							centerprint(self, "BLUE TEAM captured the red flag!\n");
						}
					}
					else {

					self.killed = 0;
					if (self.team == other.team) {                // modified 5/12/98 SO 2.8j Add 10 to all on team, including flag carrier
						self.frags = self.frags + TEAM_CAPTURE_TEAM_BONUS;
						UpdateFlags(self,TEAM_CAPTURE_TEAM_BONUS, 0, 0, 0, 0);
					}
					if (self.team != other.team) {
						centerprint(self, "Your flag was captured!\n");
						// *XXX* EXPERT CTF
						// reset the last_hurt_carrier variable in all enemy players, so that you don't get
						// bonuses for defending the flag carrier if the flag carrier has already
						// completed a capture
						self.last_hurt_carrier = -5;
					} else if (self.team == other.team) {
						// done to all players on the capturing team
						centerprint(self, "Your team captured the flag!\n");

						// *XXX* EXPERT CTF
	
						// award extra points for capture assists
						if (self.last_returned_flag + TEAM_CAPTURE_RETURN_FLAG_ASSIST_TIMEOUT > time) {
							bprint(self.netname);
							bprint(" gets an assist for returning his flag!\n");
							self.frags = self.frags + TEAM_CAPTURE_RETURN_FLAG_ASSIST_BONUS;
							self.flag_assists = self.flag_assists + 1;
							UpdateAssists(self,TEAM_CAPTURE_RETURN_FLAG_ASSIST_BONUS, 1, 0);
						}
						if (self.last_fragged_carrier + TEAM_CAPTURE_FRAG_CARRIER_ASSIST_TIMEOUT > time) {
							bprint(self.netname);
							bprint(" gets an assist for fragging the flag carrier!\n");
							self.frags = self.frags + TEAM_CAPTURE_FRAG_CARRIER_ASSIST_BONUS;
							self.carrier_assists = self.carrier_assists + 1;
							UpdateAssists(self,TEAM_CAPTURE_FRAG_CARRIER_ASSIST_BONUS, 0, 1);
						}
					}
					self.player_flag = self.player_flag - (self.player_flag & ITEM_ENEMY_FLAG);
					
					}

					p = find(p, classname, "player");
				}
				// respawn flags
				TeamCaptureRegenFlags();
				return;
			}
			return; // its at home base already
		}	
		// hey, its not home.  return it by teleporting it back
		bprint(other.netname);
		if (other.team == TEAM_COLOR1 + 1)
			bprint(" ÚÂÙıÚÓÂ‰ the “≈ƒ flag!\n"); // red
		else
			bprint(" ÚÂÙıÚÓÂ‰ the ¬Ã’≈ flag!\n"); // blue
//		LogMsg(other, "FLAG-RECOVERY");
		other.frags = other.frags + TEAM_CAPTURE_RECOVERY_BONUS;
		other.recoveries = other.recoveries + 1;
		UpdateFlags(other,TEAM_CAPTURE_RECOVERY_BONUS, 0, 1, 0, 0);
		// *XXX* EXPERT CTF set time when player last returned his flag
		other.last_returned_flag = time;
		sound (other, CHAN_ITEM, self.noise1, 1, ATTN_NORM);
		TeamCaptureReturnFlag(self);
		return;
	}

	// hey, its not our flag, pick it up
	bprint(other.netname);
	if (other.team == TEAM_COLOR1 + 1)
		bprint(" ÁÔÙ the ¬Ã’≈ flag!\n"); // blue
	else
		bprint(" ÁÔÙ the “≈ƒ flag!\n"); // red
//	LogMsg(other, "FLAG-PICKUP");
	if (TEAM_CAPTURE_FLAG_BONUS)
		other.frags = other.frags + TEAM_CAPTURE_FLAG_BONUS;
	other.get_flags = other.get_flags + 1;
		UpdateFlags(other,TEAM_CAPTURE_FLAG_BONUS, 0, 0, 1, 0);
//	centerprint(other, "YOU GOT THE ENEMY FLAG!\n\nRETURN TO BASE!\n");
	centerprint(other, "Ÿœ’ «œ‘ ‘»≈ ≈Œ≈ÕŸ ∆Ã¡«\n\n“≈‘’“Œ ‘œ ¬¡”≈\n");
	sound (other, CHAN_ITEM, self.noise, 1, ATTN_NORM);

	other.player_flag = other.player_flag + ITEM_ENEMY_FLAG;
	other.items = other.items | self.items;

	// *XXX* EXPERT CTF set the time at which the carrier picked up the flag
	other.flag_since = time;

	// pick up the flag
	self.cnt = FLAG_CARRIED;
	self.movetype = MOVETYPE_NOCLIP;
	self.solid = SOLID_NOT;
	self.owner = other;

	p = find(world, classname, "player");
	while (p != world) {
		if (p != other) {
// JKB changed from 2.2i+
			if (p.quaketv & QTV_OBSERVER) {
// JKB end 2.2i+
				if (other.team == 5)
					centerprint(p, "RED TEAM has the Blue flag!\n");
				else if (other.team == 14)
					centerprint(p, "BLUE TEAM has the Red flag!\n");
			}
			else if (p.team != other.team)
				centerprint(p, "Your flag has been taken!\n");
			else if (p.team == other.team)
				centerprint(p, "Your team has the enemy flag!\n");
		}
		p = find(p, classname, "player");
	}
};

void() TeamCaptureFlagThink =
{
	local entity e;
	local vector v;
	local float f;
	local string s;

	self.nextthink = time + 0.1;

	if (self.cnt == FLAG_AT_BASE)
		return; // just sitting around waiting to be picked up

	if (self.cnt == FLAG_DROPPED) {
		if (time - self.super_time > TEAM_CAPTURE_FLAG_RETURN_TIME)
			TeamCaptureReturnFlag(self);
		return;
	}

	if (self.cnt != FLAG_CARRIED)
		objerror("Flag in invalid state\n");

	e = self.owner;
	if ((e.classname != "player") || (e.deadflag) ||
		(!(e.player_flag & ITEM_ENEMY_FLAG))) {
		TeamDropFlag(self);
		return;
	}
	makevectors (e.angles);
	v = v_forward;
//dprint("fwd: ");
//s = vtos(v);
//dprint(s);
//dprint("\n");
//	if (v_z < 0) { 
//		v_z = (-1)*v_z; 
//		v = v + v * 1.2 * v_z; 
//	}
//dprint("adj: ");
//s = vtos(v);
//dprint(s);
//dprint("\n");
	v_z = (-1) * v_z; // reverse z component

	f = 14;
	if (self.owner.frame >= 29 && self.owner.frame <= 40) {
		if (self.owner.frame >= 29 && self.owner.frame <= 34) { //axpain
			if      (self.owner.frame == 29) f = f + 2; 
			else if (self.owner.frame == 30) f = f + 8;
			else if (self.owner.frame == 31) f = f + 12;
			else if (self.owner.frame == 32) f = f + 11;
			else if (self.owner.frame == 33) f = f + 10;
			else if (self.owner.frame == 34) f = f + 4;
		} else if (self.owner.frame >= 35 && self.owner.frame <= 40) { // pain
			if      (self.owner.frame == 35) f = f + 2; 
			else if (self.owner.frame == 36) f = f + 10;
			else if (self.owner.frame == 37) f = f + 10;
			else if (self.owner.frame == 38) f = f + 8;
			else if (self.owner.frame == 39) f = f + 4;
			else if (self.owner.frame == 40) f = f + 2;
		}
	} else if (self.owner.frame >= 103 && self.owner.frame <= 118) {
		if      (self.owner.frame >= 103 && self.owner.frame <= 104) f = f + 6;  //nailattack
		else if (self.owner.frame >= 105 && self.owner.frame <= 106) f = f + 6;  //light 
		else if (self.owner.frame >= 107 && self.owner.frame <= 112) f = f + 7;  //rocketattack
		else if (self.owner.frame >= 112 && self.owner.frame <= 118) f = f + 7;  //shotattack
	}
	self.origin = e.origin + '0 0 -16' - f*v + v_right * 22;
	self.angles = e.angles + '0 0 -45';
	setorigin (self, self.origin);
	self.nextthink = time + 0.01;
};

// self is player
entity() TeamCaptureSpawn =
{
	if (self.team == TEAM_COLOR1 + 1) {
		team1_lastspawn = find(team1_lastspawn, classname, "info_player_team1");
		if (team1_lastspawn == world)
			team1_lastspawn = find(team1_lastspawn, classname, "info_player_team1");
		return team1_lastspawn;
	} else if (self.team == TEAM_COLOR2 + 1) {
		team2_lastspawn = find(team2_lastspawn, classname, "info_player_team2");
		if (team2_lastspawn == world)
			team2_lastspawn = find(team2_lastspawn, classname, "info_player_team2");
		return team2_lastspawn;
	}
	return world;
};

/*
	From byron@caseware.com Wed Oct 16 18:57:44 1996
	Date: Wed, 16 Oct 1996 21:22:37 -0400
	From: Byron Long <byron@caseware.com>
	To: zoid@mindlink.net
	Subject: Team Status Command (source code included) :-)

	A co-worker of mine wondered if it was possible to add a function to
	your capture the flag code that would give a status report on an
	impulse. I think he may have mailed you, but I wrote a quick version
	myself, which your welcome to use if you like the feature (it offsets
	some of the problems with the chat capabilities in Quake so it seems
	like a worthwhile feature). Feel free to change it
	as necessary.
*/

// *Capture The Flag - Status report by Wonko
void() TeamFlagStatusReport =
{
	local entity flag1, flag2, p;

// JKB changed from 2.2k
	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}
// JKB end 2.2k
	// Find the flags at home base
	flag1 = find (world,classname, "item_flag_team1");
	flag2 = find (world,classname, "item_flag_team2");

	// If on team 2 switch meanings of flags
	if (self.team != TEAM_COLOR1 + 1) {
		p = flag1;
		flag1 = flag2;
		flag2 = p;
	}

	if (flag1 != world && flag1.cnt == FLAG_CARRIED) {
		sprint(self, flag1.owner.netname);
// JKB changed from 2.2i+
		if (self.quaketv & QTV_OBSERVER) {
			sprint(self, " has the ¬Ã’≈ flag. ");
		}
		else {
			sprint(self, " has your flag. ");
		}
// JKB end 2.2i+
	} else {
// JKB changed from 2.2i+
		if (self.quaketv & QTV_OBSERVER) {
			sprint(self, "The ¬Ã’≈ flag is ");
		}
		else {
			sprint(self, "Your flag is ");
		}
		if (flag1 == world)
			sprint(self, "missing! ");
		if (flag1.cnt == FLAG_AT_BASE)
			sprint(self, "in base. ");
// JKB end 2.2i+
		else if (flag1.cnt == FLAG_DROPPED)
			sprint(self, "lying about. ");
		else
			sprint(self, " corrupt. ");
	}

	if (flag2 != world && flag2.cnt == FLAG_CARRIED) {
		if (self == flag2.owner) 
			sprint(self, "You have the enemy flag.\n");
		else {
			sprint(self, flag2.owner.netname);
			if (self.quaketv & QTV_OBSERVER) {
				sprint(self, " has the “≈ƒ flag.\n");
			}
			else {
				sprint(self, " has the enemy flag.\n");
			}
		}
	} else {
// JKB changed from 2.2i+
		if (self.quaketv & QTV_OBSERVER) {
			sprint(self, "The “≈ƒ flag is ");
		}
		else {
			sprint(self, "The enemy flag is ");
		}
		if (flag2 == world)
			sprint(self, "missing!\n");
		if (flag2.cnt == FLAG_AT_BASE)
			sprint(self, "in base.\n");
// JKB end 2.2i+
		else if (flag2.cnt == FLAG_DROPPED)
			sprint(self, "lying about.\n");
		else
			sprint(self, " corrupt.\n");
	}
};

/////////////////////////////////////////////////////////////////////////

$cd id1/models/flag
$base base
$skin skin

void() place_flag = {
	self.mdl = self.model;		// so it can be restored on respawn
	self.flags = FL_ITEM;		// make extra wide
	self.solid = SOLID_TRIGGER;
	self.movetype = MOVETYPE_TOSS;	
	self.velocity = '0 0 0';
	self.origin_z = self.origin_z + 6;
	self.think = TeamCaptureFlagThink;
	self.touch = TeamCaptureFlagTouch;
	self.nextthink = time + 0.1;
	self.cnt = FLAG_AT_BASE;
	self.mangle = self.angles;
	self.effects = self.effects | EF_DIMLIGHT;
	if (!droptofloor()) {
		dprint ("Flag fell out of level at ");
		dprint (vtos(self.origin));
		dprint ("\n");
		remove(self);
		return;
	}
	self.oldorigin = self.origin; // save for flag return
};

// ZOID Capture the flag
void() item_flag_team1 =
{
	self.team = TEAM_COLOR1 + 1;
	self.items = IT_KEY2;
	if (teamplay & TEAM_CAPTURE_CUSTOM) {
		precache_model ("progs/flag.mdl");
		setmodel (self, "progs/flag.mdl");
		self.skin = 0;
		precache_sound ("misc/flagtk.wav");			// flag taken
		precache_sound ("misc/flagcap.wav");			// flag capture
		precache_sound ("doors/runetry.wav");
		self.noise = "misc/flagtk.wav";
		self.noise1 = "doors/runetry.wav";
		setsize(self, '-16 -16 0', '16 16 74');
	} else {
		precache_model ("progs/w_g_key.mdl");
		setmodel (self, "progs/w_g_key.mdl");
		precache_sound ("misc/medkey.wav");
		precache_sound ("doors/meduse.wav");
		precache_sound ("doors/runetry.wav");
		self.noise = "misc/medkey.wav";
		self.noise1 = "doors/runetry.wav";
		setsize(self, '-16 -16 -24', '16 16 32');
	}
	self.nextthink = time + 0.2;	// items start after other solids
	self.think = place_flag;
};

void() item_flag_team2 =
{
	self.team = TEAM_COLOR2 + 1;
	self.items = IT_KEY1;
	if (teamplay & TEAM_CAPTURE_CUSTOM) {
		precache_model ("progs/flag.mdl");
		setmodel (self, "progs/flag.mdl");
		self.skin = 1;
		precache_sound ("misc/flagtk.wav");			// flag taken
		precache_sound ("misc/flagcap.wav");			// flag capture
		precache_sound ("doors/runetry.wav");
		self.noise = "misc/flagtk.wav";
		self.noise1 = "doors/runetry.wav";
		setsize(self, '-16 -16 0', '16 16 74');
	} else {
		precache_model ("progs/w_s_key.mdl");
		setmodel (self, "progs/w_s_key.mdl");
		precache_sound ("misc/medkey.wav");
		precache_sound ("doors/meduse.wav");
		precache_sound ("doors/runetry.wav");
		self.noise = "misc/medkey.wav";
		self.noise1 = "doors/runetry.wav";
		setsize(self, '-16 -16 -24', '16 16 32');
	}
	// make it glow
	self.nextthink = time + 0.2;	// items start after other solids
	self.think = place_flag;
};

void() TeamCaptureSetUpdate = 
{
	nextteamupdtime = time + TEAM_CAPTURE_UPDATE_TIME/2;
};

void() TeamCaptureCheckUpdate =
{
	local float total1, total2; //RaV's Mods
	local entity p, e;
	local string s, b;
	local string winner;
	local string loser;
	local float winner_num;
	local float loser_num;

	if (nextteamupdtime > time) return; 

	TeamCaptureSetUpdate();


// JKB changed from 2.2l
	if (crmode && (matchgoing != 1)) return;
// JKB end 2.2l

/*	if (what_score == "frags") {
	if (crmode) {
	total1 = total2 = 0;
	p = find(world, classname, "clan");
	while (p != world) {
		if (p.clan_number == 1)
			total1 = p.enemy_kill;
		else if (p.clan_number == 2)                            THE LEMUR STRIKES AGAIN!!!
			total2 = p.enemy_kill;
		p = find(p, classname, "clan");}
	}
	else {
		total1 = total2 = 0;
		p = find(world, classname, "player");
		while (p != world) {
			if (p.lastteam == TEAM_COLOR1 + 1)
				total1 = total1 + p.enemy_kill;
			else if (p.lastteam == TEAM_COLOR2 + 1)
				total2 = total2 + p.enemy_kill;
			p = find(p, classname, "player");
		}
	}

	if (total1 > total2) {
		winner = "“≈ƒ";
		winner_num = total1;
		loser = "¬Ã’≈";
		loser_num = total2; }
	else if (total1 < total2) {
		loser = "“≈ƒ";
		loser_num = total1;
		winner = "¬Ã’≈";
		winner_num = total2; }
	if (total1 == total2) {
		bprint("¬Ã’≈ and “≈ƒ team are dead even with ");
		s = ftos(total1);
		bprint(s);
		bprint(" frags each");
		} else
		
	if (winner_num/2 > loser_num) {
		bprint(winner);
		bprint(" team is butchering ");
		bprint(loser);
		bprint(" team");
	} else {
		bprint(winner);
		bprint(" team is narrowly beating ");
		bprint(loser);
		bprint(" team in frags");
	}
	if (crmode) {
		e = find(world,classname,"timer");
		b = ftos(e.items - e.cnt);
		bprint(" with ");
		bprint(b);
		bprint(" Minutes Remaining!\n");
	}
	else
	{
		bprint("!\n");
	}
	what_score = "ctf";
	}

	else {

*/
	
// JKB changed from 2.2l
if (crmode) {
// JKB end 2.2l
	total1 = total2 = 0;
	p = find(world, classname, "clan");
	while (p != world) {
		if (p.clan_number == 1)
			total1 = p.frags;
		else if (p.clan_number == 2)
			total2 = p.frags;
		p = find(p, classname, "clan");}
	}
	else {
		total1 = total2 = 0;
		p = find(world, classname, "player");
		while (p != world) {
			if (p.lastteam == TEAM_COLOR1 + 1)
				total1 = total1 + p.frags;
			else if (p.lastteam == TEAM_COLOR2 + 1)
				total2 = total2 + p.frags;
			p = find(p, classname, "player");
		}
	}

// JKB change from 2.2c
	p = find(world, classname, "player");
	while (p != world) {
		if (p.statstate == -1) {
			if (total1 > total2) {
				sprint(p, "“≈ƒ team is leading by ");
				s = ftos(total1 - total2);
				sprint(p, s);
				sprint(p, " points");
			} else if (total1 < total2) {
				sprint(p, "¬Ã’≈ team is leading by ");
				s = ftos(total2 - total1);
				sprint(p, s);
				sprint(p, " points");
			} else {
				sprint(p, "¬Ã’≈ and “≈ƒ team are tied with ");
				s = ftos(total1);
				sprint(p, s);
				sprint(p, " points");
			}
// JKB changed from 2.2l
			if (crmode) {
// JKB end 2.2l
				e = find(world,classname,"timer");
				b = ftos(e.items - e.cnt);
				sprint(p, " with ");
				sprint(p, b);
				sprint(p, " Minutes Remaining!\n");
			}
			else
			{
				sprint(p, "!\n");
			}
		}
		p = find(p, classname, "player");
	}
// JKB end
// JKB change from 2.2c
/*
	what_score = "frags";
	}
*/
// JKB end
};

