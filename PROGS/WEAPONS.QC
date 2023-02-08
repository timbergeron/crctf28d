// Miscellanous Obituary Fixes by : Jarlaxle (0212147@acad.nwmissouri.edu)
/*
*/
void (entity targ, entity inflictor, entity attacker, float damage) T_Damage;
void () player_run;
void(entity bomb, entity attacker, float rad, entity ignore) T_RadiusDamage;
void(vector org, vector vel, float damage) SpawnBlood;
void() SuperDamageSound;
void() HasteSound;
void () InitiateVKick;
// JKB changed from 2.2i+
void() Red;
void() Blue;
void() Ready;
// JKB end 2.2i+

// called by worldspawn
void() W_Precache =
{
	precache_sound ("weapons/r_exp3.wav");  // new rocket explosion
	precache_sound ("weapons/rocket1i.wav");        // spike gun
	precache_sound ("weapons/sgun1.wav");
	precache_sound ("weapons/guncock.wav"); // player shotgun
	precache_sound ("weapons/ric1.wav");    // ricochet (used in c code)
	precache_sound ("weapons/ric2.wav");    // ricochet (used in c code)
	precache_sound ("weapons/ric3.wav");    // ricochet (used in c code)
	precache_sound ("weapons/spike2.wav");  // super spikes
	precache_sound ("weapons/tink1.wav");   // spikes tink (used in c code)
	precache_sound ("weapons/grenade.wav"); // grenade launcher
	precache_sound ("weapons/bounce.wav");          // grenade bounce
	precache_sound ("weapons/shotgn2.wav"); // super shotgun
	precache_sound2 ("blob/land1.wav");     // chain go splorch!
	precache_sound2 ("hknight/hit.wav"); //
	
	if (teamplay & TEAM_CAPTURE_CUSTOM) {
		precache_sound ("weapons/chain1.wav");
		precache_sound ("weapons/chain2.wav");
		precache_sound ("weapons/chain3.wav");
		precache_sound ("weapons/bounce2.wav");
	}

	// ZOID:
	// normally the weapon models are precached in the individual item
	// creation routines.  But since we've added impulse 21 we can drop
	// weapons at any time.  Must precache all weapon models.
	precache_model ("progs/g_shot.mdl");
	precache_model ("progs/g_nail.mdl");
	precache_model ("progs/g_nail2.mdl");
	precache_model ("progs/g_rock.mdl");
	precache_model ("progs/g_rock2.mdl");
	precache_model ("progs/g_light.mdl");
	
};



void() Laser_Touch =
{
	local vector org;
	
	if (other == self.owner)
		return;         // don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	sound (self, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_STATIC);
	org = self.origin - 8*normalize(self.velocity);

	if (other.health)
	{
		SpawnBlood (org, self.velocity*0.2, 15);
		T_Damage (other, self, self.owner, 15);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST, org_x);
		WriteCoord (MSG_BROADCAST, org_y);
		WriteCoord (MSG_BROADCAST, org_z);
	}
	
	remove(self);   
};

void(vector org, vector vec) LaunchLaser =
{
	local   vector  vec;
		
	if (self.classname == "monster_enforcer")
		sound (self, CHAN_WEAPON, "enforcer/enfire.wav", 1, ATTN_NORM);

	vec = normalize(vec);
	
	newmis = spawn();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	newmis.effects = EF_DIMLIGHT;

	setmodel (newmis, "progs/laser.mdl");
	setsize (newmis, '0 0 0', '0 0 0');             

	setorigin (newmis, org);

	newmis.velocity = vec * 600;
	newmis.angles = vectoangles(newmis.velocity);

	newmis.nextthink = time + 5;
	newmis.think = SUB_Remove;
	newmis.touch = Laser_Touch;
};


float() crandom =
{
	return 2*(random() - 0.5);
};

/*
================
W_FireAxe
================
*/
void() W_FireAxe =
{
	local   vector  source;
	local   vector  org;

	UpdateWeapon(self, 20, 0);
	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*64, FALSE, self);
	if (trace_fraction == 1.0)
		return;
	
	org = trace_endpos - v_forward*4;

	if (trace_ent.takedamage)
	{
		trace_ent.axhitme = 1;
		SpawnBlood (org, '0 0 0', 20);
		T_Damage (trace_ent, self, self, 20);
	}
	else
	{       // hit wall
		sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST, org_x);
		WriteCoord (MSG_BROADCAST, org_y);
		WriteCoord (MSG_BROADCAST, org_z);
	}
};


//============================================================================


vector() wall_velocity =
{
	local vector    vel;
	
	vel = normalize (self.velocity);
	vel = normalize(vel + v_up*(random()- 0.5) + v_right*(random()- 0.5));
	vel = vel + 2*trace_plane_normal;
	vel = vel * 200;
	
	return vel;
};


/*
================
SpawnMeatSpray
================
*/
void(vector org, vector vel) SpawnMeatSpray =
{
	local   entity missile, mpuff;
	local   vector  org;

	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_NOT;

	makevectors (self.angles);

	missile.velocity = vel;
	missile.velocity_z = missile.velocity_z + 250 + 50*random();

	missile.avelocity = '3000 1000 2000';
	
// set missile duration
	missile.nextthink = time + 1;
	missile.think = SUB_Remove;

	setmodel (missile, "progs/zom_gib.mdl");
	setsize (missile, '0 0 0', '0 0 0');            
	setorigin (missile, org);
};

/*
================
SpawnBlood
================
*/
void(vector org, vector vel, float damage) SpawnBlood =
{
	particle (org, vel*0.1, 73, damage*2);
};

/*
================
spawn_touchblood
================
*/
void(float damage) spawn_touchblood =
{
	local vector    vel;

	vel = wall_velocity () * 0.2;
	SpawnBlood (self.origin + vel*0.01, vel, damage);
};


/*
================
SpawnChunk
================
*/
void(vector org, vector vel) SpawnChunk =
{
	particle (org, vel*0.02, 0, 10);
};

/*
==============================================================================

MULTI-DAMAGE

Collects multiple small damages into a single damage

==============================================================================
*/

entity  multi_ent;
float   multi_damage;

void() ClearMultiDamage =
{
	multi_ent = world;
	multi_damage = 0;
};

void() ApplyMultiDamage =
{
	if (!multi_ent)
		return;
	T_Damage (multi_ent, self, self, multi_damage);
};

void(entity hit, float damage) AddMultiDamage =
{
	if (!hit)
		return;
	
	if (hit != multi_ent)
	{
		ApplyMultiDamage ();
		multi_damage = damage;
		multi_ent = hit;
	}
	else
		multi_damage = multi_damage + damage;
};

/*
==============================================================================

BULLETS

==============================================================================
*/

/*
================
TraceAttack
================
*/
void(float damage, vector dir) TraceAttack =
{
	local   vector  vel, org;
	
	vel = normalize(dir + v_up*crandom() + v_right*crandom());
	vel = vel + 2*trace_plane_normal;
	vel = vel * 200;

	org = trace_endpos - dir*4;

	if (trace_ent.takedamage)
	{
		SpawnBlood (org, vel*0.2, damage);
		AddMultiDamage (trace_ent, damage);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST, org_x);
		WriteCoord (MSG_BROADCAST, org_y);
		WriteCoord (MSG_BROADCAST, org_z);
	}
};

/*
================
FireBullets

Used by shotgun, super shotgun, and enemy soldier firing
Go to the trouble of combining multiple pellets into a single damage call.
================
*/
void(float shotcount, vector dir, vector spread) FireBullets =
{
	local   vector direction;
	local   vector  src;
	
	makevectors(self.v_angle);

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;

	ClearMultiDamage ();
	while (shotcount > 0)
	{
		direction = dir + crandom()*spread_x*v_right + crandom()*spread_y*v_up;

		traceline (src, src + direction*2048, FALSE, self);
		if (trace_fraction != 1.0)
			TraceAttack (4, direction);

		shotcount = shotcount - 1;
	}
	ApplyMultiDamage ();
};

/*
================
W_FireShotgun
================
*/
void() W_FireShotgun =
{
	local vector dir;

	sound (self, CHAN_WEAPON, "weapons/guncock.wav", 1, ATTN_NORM); 

	self.punchangle_x = -2;
	
	self.currentammo = self.ammo_shells = self.ammo_shells - 1;
	dir = aim (self, 100000);
	FireBullets (6, dir, '0.04 0.04 0');
	UpdateWeapon(self, 24, 0);
};


/*
================
W_FireSuperShotgun
================
*/
void() W_FireSuperShotgun =
{
	local vector dir;

	if (self.currentammo == 1)
	{
		W_FireShotgun ();
		return;
	}
		
	sound (self ,CHAN_WEAPON, "weapons/shotgn2.wav", 1, ATTN_NORM); 

	self.punchangle_x = -4;
	
	self.currentammo = self.ammo_shells = self.ammo_shells - 2;
	dir = aim (self, 100000);
	FireBullets (14, dir, '0.14 0.08 0');
	UpdateWeapon(self, 56, 0);
};


/*
==============================================================================

ROCKETS

==============================================================================
*/

void()  s_explode1      =       [0,             s_explode2] {};
void()  s_explode2      =       [1,             s_explode3] {};
void()  s_explode3      =       [2,             s_explode4] {};
void()  s_explode4      =       [3,             s_explode5] {};
void()  s_explode5      =       [4,             s_explode6] {};
void()  s_explode6      =       [5,             SUB_Remove] {};

void() BecomeExplosion =
{
	self.movetype = MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
};

void() T_MissileTouch =
{
	local float     damg;

	if (other == self.owner)
		return;         // don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	damg = 100 + random()*20;
	
	if (other.health)
	{
		if (other.classname == "monster_shambler")
			damg = damg * 0.5;      // mostly immune
		T_Damage (other, self, self.owner, damg );
	}

	// don't do radius damage to the other, because all the damage
	// was done in the impact
	T_RadiusDamage (self, self.owner, 120, other);

//      sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	BecomeExplosion ();
};



/*
================
W_FireRocket
================
*/
void() W_FireRocket =
{
	local   entity missile, mpuff;
	
	self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
	
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = SOLID_BBOX;
	missile.classname = "missile";
		
// set missile speed    

	makevectors (self.v_angle);
	missile.velocity = aim(self, 1000);
	missile.velocity = missile.velocity * 1000;
	missile.angles = vectoangles(missile.velocity);
	
	missile.touch = T_MissileTouch;
	
// set missile duration
	missile.nextthink = time + 5;
	missile.think = SUB_Remove;

	setmodel (missile, "progs/missile.mdl");
	setsize (missile, '0 0 0', '0 0 0');            
	setorigin (missile, self.origin + v_forward*8 + '0 0 16');
	UpdateWeapon(self, 110, 0);
};

/*
===============================================================================

LIGHTNING

===============================================================================
*/

/*
=================
LightningDamage
=================
*/
void(vector p1, vector p2, entity from, float damage) LightningDamage =
{
	local entity            e1, e2;
	local vector            f;
	
	f = p2 - p1;
	normalize (f);
	f_x = 0 - f_y;
	f_y = f_x;
	f_z = 0;
	f = f*16;

	e1 = e2 = world;

	traceline (p1, p2, FALSE, self);
	if (trace_ent.takedamage)
	{
		particle (trace_endpos, '0 0 100', 225, damage*4);
		T_Damage (trace_ent, from, from, damage);
		if (self.classname == "player")
		{
			if (other.classname == "player")
				trace_ent.velocity_z = trace_ent.velocity_z + 400;
		}
	}
	e1 = trace_ent;

	traceline (p1 + f, p2 + f, FALSE, self);
	if (trace_ent != e1 && trace_ent.takedamage)
	{
		particle (trace_endpos, '0 0 100', 225, damage*4);
		T_Damage (trace_ent, from, from, damage);
	}
	e2 = trace_ent;

	traceline (p1 - f, p2 - f, FALSE, self);
	if (trace_ent != e1 && trace_ent != e2 && trace_ent.takedamage)
	{
		particle (trace_endpos, '0 0 100', 225, damage*4);
		T_Damage (trace_ent, from, from, damage);
	}
};


void() W_FireLightning =
{
	local   vector          org;
	local   float           cells;

	if (self.ammo_cells < 1)
	{
		self.weapon = W_BestWeapon ();
		W_SetCurrentAmmo ();
		return;
	}

// explode if under water
	if (self.waterlevel > 1)
	{
		cells = self.ammo_cells;
		self.ammo_cells = 0;
		W_SetCurrentAmmo ();
		T_RadiusDamage (self, self, 35*cells, world);
		return;
	}

	if (self.t_width < time)
	{
		sound (self, CHAN_WEAPON, "weapons/lhit.wav", 1, ATTN_NORM);
		self.t_width = time + 0.6;
	}
	self.punchangle_x = -2;

	self.currentammo = self.ammo_cells = self.ammo_cells - 1;

	org = self.origin + '0 0 16';
	
	traceline (org, org + v_forward*600, TRUE, self);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_LIGHTNING2);
	WriteEntity (MSG_BROADCAST, self);
	WriteCoord (MSG_BROADCAST, org_x);
	WriteCoord (MSG_BROADCAST, org_y);
	WriteCoord (MSG_BROADCAST, org_z);
	WriteCoord (MSG_BROADCAST, trace_endpos_x);
	WriteCoord (MSG_BROADCAST, trace_endpos_y);
	WriteCoord (MSG_BROADCAST, trace_endpos_z);

	LightningDamage (self.origin, trace_endpos + v_forward*4, self, 30);
	UpdateWeapon(self, 30, 0);
};


//=============================================================================


void() GrenadeExplode =
{
	T_RadiusDamage (self, self.owner, 120, world);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	BecomeExplosion ();
};

void() GrenadeTouch =
{
	if (other == self.owner)
		return;         // don't explode on owner
	if (other.takedamage == DAMAGE_AIM)
	{
		GrenadeExplode();
		return;
	}
	sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);  // bounce sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

/*
================
W_FireGrenade
================
*/
void() W_FireGrenade =
{
	local   entity missile, mpuff;
	
	self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
	
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;
	missile.classname = "grenade";
		
// set missile speed    

	makevectors (self.v_angle);

	if (self.v_angle_x)
		missile.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
	else
	{
		missile.velocity = aim(self, 10000);
		missile.velocity = missile.velocity * 600;
		missile.velocity_z = 200;
	}

	missile.avelocity = '300 300 300';

	missile.angles = vectoangles(missile.velocity);
	
	missile.touch = GrenadeTouch;
	
// set missile duration
	missile.nextthink = time + 2.5;
	missile.think = GrenadeExplode;

	setmodel (missile, "progs/grenade.mdl");
	setsize (missile, '0 0 0', '0 0 0');            
	setorigin (missile, self.origin);
	UpdateWeapon(self, 120, 0);
};


//=============================================================================

void() spike_touch;
void() superspike_touch;


/*
===============
launch_spike

Used for both the player and the ogre
===============
*/
void(vector org, vector dir, float spd) launch_spike =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;

	newmis.angles = vectoangles(dir);
	
	newmis.touch = spike_touch;
	newmis.classname = "spike";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
	setmodel (newmis, "progs/spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);               
	setorigin (newmis, org);

	newmis.velocity = dir * spd;
};

void() W_FireSuperSpikes =
{
	local vector    dir;
	local entity    old;
	
	sound (self, CHAN_WEAPON, "weapons/spike2.wav", 1, ATTN_NORM);
	self.attack_finished = time + 0.2;
	self.currentammo = self.ammo_nails = self.ammo_nails - 2;
	dir = aim (self, 1000);
	if (self.player_flag & ITEM_RUNE3_FLAG) {
		HasteSound();
		launch_spike (self.origin + '0 0 16', dir, 2000);
	} else
		launch_spike (self.origin + '0 0 16', dir, 1000);
	//launch_spike (self.origin + '0 0 16', dir);
	newmis.touch = superspike_touch;
	setmodel (newmis, "progs/s_spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);               
	self.punchangle_x = -2;
	UpdateWeapon(self, 18, 0);
};

void(float ox) W_FireSpikes =
{
	local vector    dir;
	local entity    old;
	
	makevectors (self.v_angle);
	
	if (self.ammo_nails >= 2 && self.weapon == IT_SUPER_NAILGUN)
	{
		W_FireSuperSpikes ();
		return;
	}

	if (self.ammo_nails < 1)
	{
		self.weapon = W_BestWeapon ();
		W_SetCurrentAmmo ();
		return;
	}

	sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);
	self.attack_finished = time + 0.2;
	self.currentammo = self.ammo_nails = self.ammo_nails - 1;
	dir = aim (self, 1000);
	launch_spike (self.origin + '0 0 16' + v_right*ox, dir, 1000);
	UpdateWeapon(self, 9, 0);

	self.punchangle_x = -2;
};



.float hit_z;
void() spike_touch =
{
local float rand;
	if (other == self.owner)
		return;

	if (other.solid == SOLID_TRIGGER)
		return; // trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
// hit something that bleeds
	if (other.takedamage)
	{
		spawn_touchblood (9);
		T_Damage (other, self, self.owner, 9);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		
		if (self.classname == "wizspike")
			WriteByte (MSG_BROADCAST, TE_WIZSPIKE);
		else if (self.classname == "knightspike")
			WriteByte (MSG_BROADCAST, TE_KNIGHTSPIKE);
		else
			WriteByte (MSG_BROADCAST, TE_SPIKE);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}

	remove(self);

};

void() superspike_touch =
{
local float rand;
	if (other == self.owner)
		return;

	if (other.solid == SOLID_TRIGGER)
		return; // trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
// hit something that bleeds
	if (other.takedamage)
	{
		spawn_touchblood (18);
		T_Damage (other, self, self.owner, 18);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_SUPERSPIKE);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}

	remove(self);

};


/*
===============================================================================

PLAYER WEAPON USE

===============================================================================
*/

void() W_SetCurrentAmmo =
{
	player_run ();          // get out of any weapon firing states

	self.items = self.items - ( self.items & (IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
	
	if (self.weapon == IT_AXE)
	{
		self.currentammo = 0;
		self.weaponmodel = "progs/v_axe.mdl";
		self.weaponframe = 0;
	}
	else if (self.weapon == IT_HOOK)
	{
		self.currentammo = 0;
		if (teamplay & TEAM_CAPTURE_CUSTOM) 
			self.weaponmodel = "progs/v_star.mdl";
		else
			self.weaponmodel = "progs/v_axe.mdl";
		self.weaponframe = 0;
	}
	else if (self.weapon == IT_SHOTGUN)
	{
		self.currentammo = self.ammo_shells;
		self.weaponmodel = "progs/v_shot.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_SHELLS;
	}
	else if (self.weapon == IT_SUPER_SHOTGUN)
	{
		self.currentammo = self.ammo_shells;
		self.weaponmodel = "progs/v_shot2.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_SHELLS;
	}
	else if (self.weapon == IT_NAILGUN)
	{
		self.currentammo = self.ammo_nails;
		self.weaponmodel = "progs/v_nail.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_NAILS;
	}
	else if (self.weapon == IT_SUPER_NAILGUN)
	{
		self.currentammo = self.ammo_nails;
		self.weaponmodel = "progs/v_nail2.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_NAILS;
	}
	else if (self.weapon == IT_GRENADE_LAUNCHER)
	{
		self.currentammo = self.ammo_rockets;
		self.weaponmodel = "progs/v_rock.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_ROCKETS;
	}
	else if (self.weapon == IT_ROCKET_LAUNCHER)
	{
		self.currentammo = self.ammo_rockets;
		self.weaponmodel = "progs/v_rock2.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_ROCKETS;
	}
	else if (self.weapon == IT_LIGHTNING)
	{
		self.currentammo = self.ammo_cells;
		self.weaponmodel = "progs/v_light.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_CELLS;
	}
	else
	{
		self.currentammo = 0;
		self.weaponmodel = "";
		self.weaponframe = 0;
	}

};

float() W_BestWeapon =
{
	local   float   it;

	it = self.items;

	if (self.waterlevel <= 1 && self.ammo_cells >= 1 && (it & IT_LIGHTNING) )
			return IT_LIGHTNING;
	if(self.ammo_nails >= 2 && (it & IT_SUPER_NAILGUN) )
		return IT_SUPER_NAILGUN;
	if(self.ammo_shells >= 2 && (it & IT_SUPER_SHOTGUN) )
		return IT_SUPER_SHOTGUN;
	if(self.ammo_nails >= 1 && (it & IT_NAILGUN) )
		return IT_NAILGUN;
	if(self.ammo_shells >= 1 && (it & IT_SHOTGUN) )
		return IT_SHOTGUN;
	return IT_AXE;
};

float() W_CheckNoAmmo =
{
	if (self.currentammo > 0)
		return TRUE;

	if (self.weapon == IT_AXE  || self.weapon == IT_HOOK)
		return TRUE;
	
	self.weapon = W_BestWeapon ();

	W_SetCurrentAmmo ();
	
// drop the weapon down
	return FALSE;
};

/*
============
W_Attack

An attack impulse can be triggered now
============
*/
void()  player_axe1;
void()  player_axeb1;
void()  player_axec1;
void()  player_axed1;
void()  player_shot1;
void()  player_nail1;
void()  player_light1;
void()  player_rocket1;
void()  player_chain1;
void()  player_chain3;

void() W_Attack =
{
	local   float   r;

	if (!W_CheckNoAmmo ())
		return;
	if (self.quaketv && QTV_OBSERVER) //SO 1-28-98 2.8b Added this for the new chasecam code.
		return; // chasecam code sets weapons and ammo for the CHASER, have to make it so he can't fire.
	if (self.movetype == MOVETYPE_NONE)
		return;


	makevectors     (self.v_angle);                 // calculate forward angle for velocity
	self.show_hostile = time + 1;   // wake monsters up

	if (self.weapon == IT_AXE)
	{
		sound (self, CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);
		r = random();
		if (r < 0.25)
			player_axe1 ();
		else if (r<0.5)
			player_axeb1 ();
		else if (r<0.75)
			player_axec1 ();
		else
			player_axed1 ();
		// RUNE: rune of hell magic
		if (self.player_flag & ITEM_RUNE3_FLAG) {
			self.attack_finished = time + 0.3;
			HasteSound();
		} else
		self.attack_finished = time + 0.5;
	}
	else if (self.weapon == IT_HOOK)
	{
		if (!self.hook_out)
			player_chain1();
		else
			player_chain3();
		self.attack_finished = time + 0.1;
	}
	else if (self.weapon == IT_SHOTGUN)
	{
		player_shot1 ();
		W_FireShotgun ();
		// RUNE: rune of hell magic
		if (self.player_flag & ITEM_RUNE3_FLAG) {
			self.attack_finished = time + 0.3;
			HasteSound();
		} else
		self.attack_finished = time + 0.5;
	}
	else if (self.weapon == IT_SUPER_SHOTGUN)
	{
		player_shot1 ();
		W_FireSuperShotgun ();
		// RUNE: rune of hell magic
		if (self.player_flag & ITEM_RUNE3_FLAG) {
			self.attack_finished = time + 0.4;
			HasteSound();
		} else
		self.attack_finished = time + 0.7;
	}
	else if (self.weapon == IT_NAILGUN)
	{
		player_nail1 ();
	}
	else if (self.weapon == IT_SUPER_NAILGUN)
	{
		player_nail1 ();
	}
	else if (self.weapon == IT_GRENADE_LAUNCHER)
	{
		player_rocket1();
		W_FireGrenade();
		// RUNE: rune of hell magic
		if (self.player_flag & ITEM_RUNE3_FLAG) {
			self.attack_finished = time + 0.3;
			HasteSound();
		} else
		self.attack_finished = time + 0.6;
	}
	else if (self.weapon == IT_ROCKET_LAUNCHER)
	{
		player_rocket1();
		W_FireRocket();
		// RUNE: rune of hell magic
		if (self.player_flag & ITEM_RUNE3_FLAG) {
			self.attack_finished = time + 0.4;
			HasteSound();
		} else
		self.attack_finished = time + 0.8;
	}
	else if (self.weapon == IT_LIGHTNING)
	{
		player_light1();
		self.attack_finished = time + 0.1;
		sound (self, CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
	}
};

void() NotifyWeapon =
{
	if (teamplay & TEAM_CAPTURE_CUSTOM) return;
	if (self.weapon == IT_AXE)
		sprint(self, "Axe selected.\n");
	else if (self.weapon == IT_HOOK)
		sprint(self, "Grappling hook selected.\n");
};

/*
============
W_ChangeWeapon

============
*/
void() W_ChangeWeapon =
{
	local   float   it, am, fl;
	
	it = self.items;
	am = 0;
	
	if (self.impulse == 1) {
		if (self.weapon == IT_AXE)
			fl = IT_HOOK;
		else
			fl = IT_AXE;
	} else if (self.impulse == 2) {
		fl = IT_SHOTGUN;
		if (self.ammo_shells < 1)
			am = 1;
	} else if (self.impulse == 3) {
		fl = IT_SUPER_SHOTGUN;
		if (self.ammo_shells < 2)
			am = 1;
	} else if (self.impulse == 4) {
		fl = IT_NAILGUN;
		if (self.ammo_nails < 1)
			am = 1;
	} else if (self.impulse == 5) {
		fl = IT_SUPER_NAILGUN;
		if (self.ammo_nails < 2)
			am = 1;
	} else if (self.impulse == 6) {
		fl = IT_GRENADE_LAUNCHER;
		if (self.ammo_rockets < 1)
			am = 1;
	} else if (self.impulse == 7) {
		fl = IT_ROCKET_LAUNCHER;
		if (self.ammo_rockets < 1)
			am = 1;
	} else if (self.impulse == 8) {
		fl = IT_LIGHTNING;
		if (self.ammo_cells < 1)
			am = 1;
	} else if (self.impulse == 22) {
		fl = IT_HOOK;
	}

	self.impulse = 0;
	
	if (!(self.items & fl))
	{       // don't have the weapon or the ammo
		sprint (self, "no weapon.\n");
		return;
	}
	
	if (am)
	{       // don't have the ammo
		sprint (self, "not enough ammo.\n");
		return;
	}

//McBain: save current weapon
// For explicite weapon selection, allow previous weapon and new weapon to be
// same except for IT_HOOK.
	if (self.weapon != IT_HOOK || fl != IT_HOOK)
		self.previous_weapon = self.weapon;

//
// set weapon, set ammo
//
	self.weapon = fl;               
	NotifyWeapon();
	W_SetCurrentAmmo ();
};

/*
============
CycleWeaponCommand

Go to the next weapon with ammo
============
*/
void() CycleWeaponCommand =
{
	local   float   it, am;
		if (self.quaketv & QTV_OBSERVER) return;  // Observer   
	it = self.items;
	self.impulse = 0;

//McBain: save current weapon
	self.previous_weapon = self.weapon;

	while (1)
	{
		am = 0;

		if (self.weapon == IT_LIGHTNING)
		{
			self.weapon = IT_AXE;
		}
		else if (self.weapon == IT_AXE)
		{
			self.weapon = IT_HOOK;
		}
		else if (self.weapon == IT_HOOK)
		{
			self.weapon = IT_SHOTGUN;
			if (self.ammo_shells < 1)
				am = 1;
		}
		else if (self.weapon == IT_SHOTGUN)
		{
			self.weapon = IT_SUPER_SHOTGUN;
			if (self.ammo_shells < 2)
				am = 1;
		}               
		else if (self.weapon == IT_SUPER_SHOTGUN)
		{
			self.weapon = IT_NAILGUN;
			if (self.ammo_nails < 1)
				am = 1;
		}
		else if (self.weapon == IT_NAILGUN)
		{
			self.weapon = IT_SUPER_NAILGUN;
			if (self.ammo_nails < 2)
				am = 1;
		}
		else if (self.weapon == IT_SUPER_NAILGUN)
		{
			self.weapon = IT_GRENADE_LAUNCHER;
			if (self.ammo_rockets < 1)
				am = 1;
		}
		else if (self.weapon == IT_GRENADE_LAUNCHER)
		{
			self.weapon = IT_ROCKET_LAUNCHER;
			if (self.ammo_rockets < 1)
				am = 1;
		}
		else if (self.weapon == IT_ROCKET_LAUNCHER)
		{
			self.weapon = IT_LIGHTNING;
			if (self.ammo_cells < 1)
				am = 1;
		}
	
		if ( (it & self.weapon) && am == 0)
		{
			W_SetCurrentAmmo ();
			NotifyWeapon();
			return;
		}
	}

};

/*
============
CycleWeaponReverseCommand

Go to the prev weapon with ammo
============
*/
void() CycleWeaponReverseCommand =
{
	local   float   it, am;
			if (self.quaketv & QTV_OBSERVER) return;  // Observer
	it = self.items;
	self.impulse = 0;

//McBain: save current weapon
	self.previous_weapon = self.weapon;

	while (1)
	{
		am = 0;

		if (self.weapon == IT_LIGHTNING)
		{
			self.weapon = IT_ROCKET_LAUNCHER;
			if (self.ammo_rockets < 1)
				am = 1;
		}
		else if (self.weapon == IT_ROCKET_LAUNCHER)
		{
			self.weapon = IT_GRENADE_LAUNCHER;
			if (self.ammo_rockets < 1)
				am = 1;
		}
		else if (self.weapon == IT_GRENADE_LAUNCHER)
		{
			self.weapon = IT_SUPER_NAILGUN;
			if (self.ammo_nails < 2)
				am = 1;
		}
		else if (self.weapon == IT_SUPER_NAILGUN)
		{
			self.weapon = IT_NAILGUN;
			if (self.ammo_nails < 1)
				am = 1;
		}
		else if (self.weapon == IT_NAILGUN)
		{
			self.weapon = IT_SUPER_SHOTGUN;
			if (self.ammo_shells < 2)
				am = 1;
		}               
		else if (self.weapon == IT_SUPER_SHOTGUN)
		{
			self.weapon = IT_SHOTGUN;
			if (self.ammo_shells < 1)
				am = 1;
		}
		else if (self.weapon == IT_SHOTGUN)
		{
			self.weapon = IT_HOOK;
		}
		else if (self.weapon == IT_HOOK)
		{
			self.weapon = IT_AXE;
		}
		else if (self.weapon == IT_AXE)
		{
			self.weapon = IT_LIGHTNING;
			if (self.ammo_cells < 1)
				am = 1;
		}
	
		if ( (it & self.weapon) && am == 0)
		{
			NotifyWeapon();
			W_SetCurrentAmmo ();
			return;
		}
	}

};

//McBain: Here's the beef...
/*
============
PreviousWeaponCommand
============
*/
void() PreviousWeaponCommand =
{
	if (self.quaketv & QTV_OBSERVER) return;
	

	local   float   fl, am;
	
	self.impulse = 0;
	am = 0;

	fl = self.weapon;
	self.weapon = self.previous_weapon;
	self.previous_weapon = fl;

	// this might not be the best method, but I'll be able to play sooner
	if (self.weapon == IT_SHOTGUN || self.weapon == IT_SUPER_SHOTGUN) {
		if (self.ammo_shells < 1)
			am = 1;
	}
	else if (self.weapon == IT_NAILGUN || self.weapon == IT_SUPER_NAILGUN) {
		if (self.ammo_nails < 1)
			am = 1;
	}
	else if (self.weapon == IT_GRENADE_LAUNCHER || self.weapon == IT_ROCKET_LAUNCHER) {
		if (self.ammo_rockets < 1)
			am = 1;
	}
	else if (self.weapon == IT_LIGHTNING) {
		if (self.ammo_cells < 1)
			am = 1;
	}
	// ignore AXE & HOOK -- no ammo needed

	if (am)
		self.weapon = W_BestWeapon ();

	W_SetCurrentAmmo ();
};

/*
============
ServerflagsCommand

Just for development
============
*/
void() ServerflagsCommand =
{
	serverflags = serverflags * 2 + 1;
};

void() QuadCheat =
{
	if (deathmatch || coop)
		return;
	self.super_time = 1;
	self.super_damage_finished = time + 30;
	self.items = self.items | IT_QUAD;
	dprint ("quad cheat\n");
};

void(entity printto) PrintCustomLevels =
{
	sprint(printto, "  (");
	sprint(printto, custom_1);
	sprint(printto, ") ");
	sprint(printto, custom_1_description);
	sprint(printto, "\n");
	sprint(printto, "  (");
	sprint(printto, custom_2);
	sprint(printto, ") ");
	sprint(printto, custom_2_description);
	sprint(printto, "\n");
	sprint(printto, "  (");
	sprint(printto, custom_3);
	sprint(printto, ") ");
	sprint(printto, custom_3_description);
	sprint(printto, "\n");
	sprint(printto, "  (");
	sprint(printto, custom_4);
	sprint(printto, ") ");
	sprint(printto, custom_4_description);
	sprint(printto, "\n");
	sprint(printto, "  (");
	sprint(printto, custom_5);
	sprint(printto, ") ");
	sprint(printto, custom_5_description);
	sprint(printto, "\n");
	sprint(printto, "  (");
	sprint(printto, custom_6);
	sprint(printto, ") ");
	sprint(printto, custom_6_description);
	sprint(printto, "\n");
	sprint(printto, "  (");
	sprint(printto, custom_7);
	sprint(printto, ") ");
	sprint(printto, custom_7_description);
	sprint(printto, "\n");
	sprint(printto, "  (");
	sprint(printto, custom_8);
	sprint(printto, ") ");
	sprint(printto, custom_8_description);
	sprint(printto, "\n");
	sprint(printto, "  (");
	sprint(printto, custom_9);
	sprint(printto, ") ");
	sprint(printto, custom_9_description);
	sprint(printto, "\n");
	sprint(printto, " (");
	sprint(printto, custom_10);
	sprint(printto, ") ");
	sprint(printto, custom_10_description);
	sprint(printto, "\n");
	sprint(printto, " (");
	sprint(printto, custom_11);
	sprint(printto, ") ");
	sprint(printto, custom_11_description);
	sprint(printto, "\n");
	sprint(printto, " (");
	sprint(printto, custom_12);
	sprint(printto, ") ");
	sprint(printto, custom_12_description);
	sprint(printto, "\n");
};

/*
============
ImpulseCommands

============
*/
void() ImpulseCommands =
{
	  // QSmack mod
	  local float didAdmin;
	  local string tempstr;
	  didAdmin = 0;
	  // QSmack mod end
	if ((self.s_switch == 1) && (self.impulse > 9) && (self.impulse != 14)) // Gimpy hack.. SO 2.8K
	{
		if (EXPANDED_MAPS >= 1) {
			if (self.impulse > 10) {
					if (EXPANDED_MAPS == 2) {
						if (self.impulse > 13) {
							self.s_switch = 0;
						}
					}
					else {
					self.s_switch = 0;
					}
			}
		}
		else {
			self.s_switch = 0;
		}
	}
	if ((self.admin_stage > 0) && (self.impulse > 10))
	{
		self.admin_stage = 0;
	}
	if ((self.ghostcode_stage > 0) && (self.impulse > 10))
	{
		self.ghostcode_stage = 0;
	}

	if ((self.s_switch == 1)  && (self.impulse == 6))
	{
		if (self.quaketv & QTV_ADMIN)
		{
			self.impulse = 0;
			self.s_switch = 0;
			changelevel("start");
			
		}
		else
		{
			episode = 6;
			level = 1;
			self.impulse = 0;
			self.s_switch = 0;
			InitiateLevel();
		}
	}
	if ((self.s_switch == 2) && (self.impulse > 12))
	{
		self.s_switch = 0;
	}

	// administration toggles
	if ((self.quaketv & QTV_ADMIN)&&(self.impulse != 0)) AdminCommands();

	if ((self.impulse >= 1 && self.impulse <= 14) || (self.impulse == 22))  
	{
		if (self.ghostcode_stage > 0) {
			GhostCode();
		}
		else if (self.admin_stage > 0) {
			AdminCode();
		}
		else if (self.s_switch == 1)
		{
			self.s_episode = self.impulse;
			sprint(self,"Enter destination Μεφεμ: \n"); 
			self.s_switch = 2;
			if (self.s_episode == 1) {
				sprint(self, "  (E1M1) the Slipgate Complex\n");
				sprint(self, "  (E1M2) Castle of the Damned\n");
				sprint(self, "  (E1M3) the Necropolis\n");
				sprint(self, "  (E1M4) the Grisly Grotto\n");
				sprint(self, "  (E1M5) Gloom Keep\n");
				sprint(self, "  (E1M6) The Door To Chthon\n");
				sprint(self, "  (E1M7) The House of Chthon\n");
				sprint(self, "  (E1M8) Ziggurat Vertigo\n");
			}
			else if (self.s_episode == 2) {
				sprint(self, "  (E2M1) the Installation\n");
				sprint(self, "  (E2M2) the Ogre Citadel\n");
				sprint(self, "  (E2M3) the Crypt of Decay\n");
				sprint(self, "  (E2M4) the Ebon Fortress\n");
				sprint(self, "  (E2M5) the Wizard's Manse\n");
				sprint(self, "  (E2M6) the Dismal Oubliette\n");
				sprint(self, "  (E2M7) the Underearth\n");
			}
			else if (self.s_episode == 3) {
				sprint(self, "  (E3M1) Termination Central\n");
				sprint(self, "  (E3M2) The Vaults of Zin\n");
				sprint(self, "  (E3M3) the Tomb of Terror\n");
				sprint(self, "  (E3M4) Satan's Dark Delight\n");
				sprint(self, "  (E3M5) the Wind Tunnels\n");
				sprint(self, "  (E3M6) Chambers of Torment\n");
				sprint(self, "  (E3M7) the Haunted Halls\n");
			}
			else if (self.s_episode == 4) {
				sprint(self, "  (E4M1) the Sewage System\n");
				sprint(self, "  (E4M2) The Tower of Despair\n");
				sprint(self, "  (E4M3) The Elder God Shrine\n");
				sprint(self, "  (E4M4) the Palace of Hate\n");
				sprint(self, "  (E4M5) Hell's Atrium\n");
				sprint(self, "  (E4M6) The Pain Maze\n");
				sprint(self, "  (E4M7) Azure Agony\n");
				sprint(self, "  (E4M8) the Nameless City\n");
			}
			else if (self.s_episode == 5) {
				sprint(self, "  (DM1) Place of Two Deaths\n");
				sprint(self, "  (DM2) Claustrophobopolis\n");
				sprint(self, "  (DM3) The Abandoned Base\n");
				sprint(self, "  (DM4) The Bad Place\n");
				sprint(self, "  (DM5) The Cistern\n");
				sprint(self, "  (DM6) The Dark Zone\n");
			}
			else if (self.s_episode == 7) {
				sprint(self, "  (CTF1) McKinley Base\n");
				sprint(self, "  (CTF2) The Kiln\n");
				sprint(self, "  (CTF3) DySpHoRiA\n");
				sprint(self, "  (CTF4) The Forgotten Mines\n");
				sprint(self, "  (CTF5) Da Ancient War Grounds\n");
				sprint(self, "  (CTF6) Vertigo\n");
				sprint(self, "  (CTF7) Tale of Two Cities\n");
				sprint(self, "  (CTF8) The Strongbox\n");
			}
			else if (self.s_episode == 8) {
				sprint(self, "  (CTF2M1) McKinley Station\n");
				sprint(self, "  (CTF2M2) The Warzone\n");
				sprint(self, "  (CTF2M3) Spill the Blood\n");
				sprint(self, "  (CTF2M4) The Ruins of NeoMinonk\n");
				sprint(self, "  (CTF2M5) Disciple War Grounds\n");
				sprint(self, "  (CTF2M6) The Two Towers\n");
				sprint(self, "  (CTF2M7) Gloom Castles\n");
				sprint(self, "  (CTF2M8) Capturephobopolis\n");
			}
			else if (self.s_episode == 9) {
					if (EXPANDED_MAPS >= 1) {
						sprint(self, "  (CTF1BSP1) Holy Warz\n");
						sprint(self, "  (CTF1BSP2) The Tormented Fortress\n");
						sprint(self, "  (CTF1BSP3) The BanZoia\n");
						sprint(self, "  (CTF1BSP4) Barbie's Domain\n");
						sprint(self, "  (CTF1BSP5) CapturE CastleS\n");
						sprint(self, "  (CTF1BSP6) Tickle-Me Shambler?\n");
						sprint(self, "  (CTF1BSP7) Never Mined\n");
						sprint(self, "  (CTF1BSP8) The Forgotten Outpost\n");
						sprint(self, "  (CTF1BSP9) Salvage The Weak\n");
						sprint(self, " (CTF1BSP0) Capturellamaphobopolis\n");
						sprint(self, " (CTF1BSPX) Towers: The Ascension\n");
					}
					else {
						PrintCustomLevels(self);
					}
			}
			else if (self.s_episode == 10) {
					if (EXPANDED_MAPS == 2) {
						sprint(self, "  (TWCTF1) The CHEAT Complex\n");
						sprint(self, "  (TWCTF2) WarZ\n");
						sprint(self, "  (TWCTF3) The Crown of Ares\n");
						sprint(self, "  (TWCTF4) Gadianton\n");
						sprint(self, "  (TWCTF5) Barbie's Domain TW\n");
						sprint(self, "  (TWCTF6) The Underworld\n");
						sprint(self, "  (TWCTF7) Tony CTF III Xpanded\n");
						sprint(self, "  (TWCTF8) washout\n");
						sprint(self, "  (TWCTF9) Critters\n");
				}
					else {
						PrintCustomLevels(self);
					}
				}
			else if (self.s_episode == 11) {
				sprint(self, "  (TWCTF2M1) Bi-Phase\n");
				sprint(self, "  (TWCTF2M2) TombstonE PassagE\n");
				sprint(self, "  (TWCTF2M3) Outpost\n");
				sprint(self, "  (TWCTF2M4) Pandemonium\n");
				sprint(self, "  (TWCTF2M5) The Final Ascent\n");
				sprint(self, "  (TWCTF2M6) The Realm of Cloy\n");
				sprint(self, "  (TWCTF2M7) Test For Echo\n");
				sprint(self, "  (TWCTF2M8) The Unknown Facility\n");
				sprint(self, "  (TWCTF2M9) Twin Keeps\n");
				sprint(self, " (TWCTF2MA) KiNg'S Of CaPtUrE\n");
				sprint(self, " (TWCTF2MB) a p100's revenge\n");
				sprint(self, " (TWCTF2MC) Fishface\n");
			}
			else if (self.s_episode == 12) {
				sprint(self, "  (XENO1)   MidEvil-CTF\n");
				sprint(self, "  (XENO2)   Sadness of Death\n");
				sprint(self, "  (XENO3)   Dunsinane\n");
				sprint(self, "  (XENO4)   Armageddon 3 CTF\n");
				sprint(self, "  (EXPCTF1) Nicole's Virtue\n");
				sprint(self, "  (XENO6)   Mayan Existence\n");
				sprint(self, "  (XENO7)   Remix\n");
				sprint(self, "  (XENO8)   Xeno Flag Academy\n");
				sprint(self, "  (EXPCTF2) Expert Base\n");
			}
			else if (self.s_episode == 14) {
				sprint(self, "  (CTF3M1)   Remix\n");
				sprint(self, "  (CTF3M2)   Red Alert\n");
				sprint(self, "  (CTF3M3)   Stop The Flow\n");
				sprint(self, "  (CTF3M4)   Nameless Mines\n");
				sprint(self, "  (CTF3M5)   Egyptian Pig Factory\n");
				sprint(self, "  (CTF3M6)   Terra Firma\n");
				sprint(self, "  (CTF3M7)   The Dark Age\n");
				sprint(self, "  (CTF3M8)   The Place of Two Bases\n");
				sprint(self, "  (CTF3M9)   The CHEAT Complex 2: Barkfalls\n");
			}				
			else if ((EXPANDED_MAPS == 2) && (self.s_episode == 13)) {
					PrintCustomLevels(self);
				}
		}
		else if (self.s_switch == 2)
		{
			if (self.quaketv & QTV_ADMIN)
			{
				level = self.impulse;
				if (self.s_episode == 1)
					W_WarpEpisode1 ();
				else if (self.s_episode == 2)
					W_WarpEpisode2 ();
				else if (self.s_episode == 3)
					W_WarpEpisode3 ();
				else if (self.s_episode == 4)
					W_WarpEpisode4 ();
				else if (self.s_episode == 5)
					W_WarpDeath ();
				else if (self.s_episode == 7)
					W_WarpCTF ();
				else if (self.s_episode == 8)
					W_WarpCTFEpisode2 ();
				else if (self.s_episode == 14)
					W_WarpLOCPak();
				else if (EXPANDED_MAPS >= 1) {
					if (self.s_episode == 9)
						W_WarpExpansion ();
					if (EXPANDED_MAPS == 2) {
						if (self.s_episode == 10)
							W_WarpTW ();
						if (self.s_episode == 11)
							W_WarpTWEpisode2 ();
						if (self.s_episode == 12)
							W_WarpXeno ();
						if (self.s_episode == 13) {
							if (SetCustomLevel()) {
								W_WarpCustom();
							}
							else {
								self.s_switch = 0;
								self.s_episode = 0;
								episode = 0;
								level = 0;
								return;
							}
						}
					}
					else {
						if (self.s_episode == 10) {
							if (SetCustomLevel()) {
								W_WarpCustom();
							}
							else {
								self.s_switch = 0;
								self.s_episode = 0;
								episode = 0;
								level = 0;
								return;
							}
						}
					}
				}
				else {
					if (self.s_episode == 9) {
						if (SetCustomLevel()) {
							W_WarpCustom();
						}
						else {
							self.s_switch = 0;
							self.s_episode = 0;
							episode = 0;
							level = 0;
							return;
						}
					}
				}
			}
			else
			{
				InitiateLevel();
			}
		}
// JKB changed from 2.2i+
		else if (self.quaketv & QTV_OBSERVER) {
			if(cvar("samelevel") & CLANRING_MODE) return;
			if (self.impulse == 1 || self.impulse == 2 || self.impulse == 3) {
				if (self.impulse == 1) {
					Red();
				}
				else if (self.impulse == 2) {
					Blue();
				}
				else if (self.impulse == 3) {
// JKB changed from 2.2l
					if (!crmode) {
// JKB end 2.2l
						self.team = 0;
						Ready();
					}
				}
			}
		}
// JKB changed from 2.2j
		else if (!self.deadflag) {
			if ((self.impulse != 10) && (self.impulse != 12)) {
				W_ChangeWeapon ();
// JKB changed from 2.2k
				return;
// JKB end 2.2k
			}
			else if (self.impulse == 10) {
				CycleWeaponCommand();
// JKB changed from 2.2k
				return;
// JKB end 2.2k
			}
			else {
				CycleWeaponReverseCommand();
				return;
			}
		}
// JKB end 2.2j
// JKB end 2.2i+
	}
// JKB changed from 2.2l
	if ((self.impulse == 130) && (!timer_exist) && (vote_topic != 2) && (!self.quaketv & QTV_ADMIN) && crmode)
// JKB end 2.2l
	{
		InitiateOverride();
	} else

	if (self.impulse == 40) Ready ();
// JKB changed from 2.2l
	if ((self.impulse == 41) && (!self.quaketv & QTV_OBSERVER) && crmode)
// JKB end 2.2l
		NotReady (); else
// JKB changed from 2.2l
	if ((self.impulse == 43) && crmode)
// JKB end 2.2l
		{
		Toggle_StatDump();      
		} else
// JKB changed from 2.2l
	if ((self.impulse == 44) && crmode)
// JKB end 2.2l
		{
		ViewRecord();   
		} else
	if ((self.impulse == 48) && (!matchgoing) && (!LOCK_LEVEL))
		{
			sprint(self, "\n");
			sprint(self, "\n");
		sprint(self, "\n");
		sprint(self, "Επισοδε   Dimension of the Doomed\n");   
		sprint(self, "Επισοδε   Realm of Black Magic\n");
			sprint(self, "Επισοδε   The Netherworld\n");
			sprint(self, "Επισοδε   The Elder World\n");
			sprint(self, "Επισοδε   The Deathmatch Arenas\n");
			sprint(self, "Επισοδε   The Start Map\n");
			sprint(self, "Επισοδε   Threewave Levels - One\n");
			sprint(self, "Επισοδε   Threewave Levels - Two\n");
		  if (EXPANDED_MAPS >= 1) {
			sprint(self, "Επισοδε   Expansion Levels\n");
				if (EXPANDED_MAPS == 2) {
				sprint(self, "Επισοδε  Thunderwalker Levels - One\n");
				sprint(self, "Επισοδε  Thunderwalker Levels - Two\n");
				sprint(self, "Επισοδε  Xeno Levels\n");
				sprint(self, "Επισοδε  Custom Levels\n");
				}
				else {
				sprint(self, "Επισοδε  Custom Levels\n");
				}
			}
		  else {
				sprint(self, "Επισοδε   Custom Levels\n");
		  }
			sprint(self, "Επισοδε  LOC Map Pak 1.0\n");
			sprint(self,"Enter destination Επισοδε: \n");
			self.s_switch = 1;
		} else
	  if (self.impulse == 49) Mod_Status(); else

// JKB changed from 2.2l
	if ((self.impulse == 50) && (self.quaketv & QTV_OBSERVER) && (!self.ghostcode) && crmode)
// JKB end 2.2l
		{
			self.ghostcode_stage = 1;
			sprint(self,"Enter first number of 3 digit code: \n");

		} else 
	if (self.impulse == 51)
	{
		if (!self.quaketv & QTV_ADMIN)
		{
			self.admin_stage = 1;
		  sprint(self,"Enter first number of 4 digit code: \n");
		}
		else
		{
			sprint(self,"Administration privileges disabled\n");
			self.quaketv = self.quaketv - (self.quaketv & QTV_ADMIN);
		}
	} else
	if ( ((self.impulse == 53) || (self.impulse == 54) || (self.impulse == 55) || (self.impulse == 56)) && (cvar("samelevel") & CLANRING_MODE) )
	{
		SettingOverride();
	} else
// JKB changed from 2.2i+
	if (self.impulse == 86)
// JKB end
	{
		DumpScoreToClient(self);
	} else
	if ((self.impulse == 99) && (!self.quaketv & QTV_ADMIN))
		{
		Commands_Player();
		} else
	if ((self.impulse == 121) && (!self.quaketv & QTV_ADMIN))
		Vote (); else
// JKB changed from 2.2l
	if ((self.impulse == 160) && crmode)
// JKB end 2.2l
		{
		ViewGhosts();   
		} else
	if (self.impulse == 253)
		sprint(self,"Clanring CTF Home Server v2.8I (unofficial)\n"); else
	if (self.impulse == 90)
		PlayerList(); else
// JKB changed from 2.2l
      if ((self.impulse == 91) && crmode)
// JKB end 2.2l
		PlayerStats(); else
// JKB changed from 2.2l
	if ((self.impulse == 82) && crmode)
// JKB end 2.2l
		ClanStats(); else
	//if (self.impulse == 83)
	//        WeaponStats(); else
	
	if (self.impulse == 84)
		Efficiency(); else
	if ((self.impulse == 173) && (self.quaketv & QTV_OBSERVER) )  // SO  // && (self.quaketv & QTV_CAMERA))
		    {
//                      MakeCameraMode(); // SO 2.8b
			AutoCamera(); 
		    }
			else
if ((self.impulse == 203) && (self.quaketv & QTV_OBSERVER))
		AutoChase(); else
if ((self.impulse == 201) && ((!matchgoing) || (self.quaketv & QTV_OBSERVER)))
		MakeChaseMode(); else
if ((self.impulse == 205) && (self.quaketv & QTV_SMOOTH))  //PB yes i used to different 
	{
		self.quaketv = self.quaketv - (self.quaketv & QTV_SMOOTH);
		sprint(self,"Camera Smoothing OFF\n");
	}
	else if ((self.impulse == 205) && (!(self.quaketv & QTV_SMOOTH)))
	{
		self.quaketv = self.quaketv | QTV_SMOOTH;
		sprint(self,"Camera Smoothing ON\n"); 
	} else
	if (self.impulse == 233)
		    Red(); else
	if (self.impulse == 234)
		Blue(); else
	if (self.impulse == 235)
		Warplist(); else
// JKB changed from 2.2i+
	if (self.impulse == 248) {
		if (self.flags & FL_NOAUTOWEAPON)
		{
			self.flags = self.flags - FL_NOAUTOWEAPON;
			self.flags = self.flags | FL_NOTSMARTAUTOWEAPON;
			sprint(self,"AutoWeapon Switching Enabled\n");
		}
		else if (self.flags & FL_NOTSMARTAUTOWEAPON)
		{
			self.flags = self.flags - FL_NOTSMARTAUTOWEAPON;
			sprint(self,"SMART AutoWeapon Switching Enabled\n");
		}
		else
		{
			self.flags = self.flags | FL_NOAUTOWEAPON;
			sprint(self,"AutoWeapon Switching Disabled\n");
		}
	}
// JKB end 2.2i+
		
      if (self.impulse == 141)
			identify_player(self, 1); else
	if (self.impulse == 70) {
		if (self.statstate < 0) {
			self.statstate = 0;
// JKB changed from 2.2l
			sprint(self, "Status bar on (impulse 71-81 set pos)\n");
// JKB end 2.2l
		} else {
			self.statstate = -1;
			sprint(self, "Status bar off.\n");
		}
		} else if (self.impulse >= 71 && self.impulse <= 81) {
		self.statstate = self.impulse - 71;
		sprint(self, "Status bar set\n");
      } else
	if (self.impulse == 240)
		{
		Check_Binding_Initiate();
		} 
	// VKick 
	if (self.impulse == 252) 
		InitiateVKick(); else
	if (self.init_vkick)
		StartVKick(); else
// end VKick


	if(!self.deadflag)
	{
// JKB changed from 2.2j
/*
	if (self.impulse == 10)
		CycleWeaponCommand (); else
*/
// JKB end 2.2j
//      if (self.impulse == 11)
//              ServerflagsCommand (); else
	if (self.impulse == 12)
		CycleWeaponReverseCommand (); else
	if (self.impulse == 69)
		PreviousWeaponCommand (); else
// *TEAMPLAY*
// If we're allowed to drop items, enable impulse 20 and 21
// JKB changed from 2.2i+
// JKB changed from 2.2l
	if ((samelevel & TEAM_DROP_ITEMS) && (!self.quaketv & QTV_OBSERVER) && self.impulse == 20)
		TossBackpack (); else

	if ((samelevel & TEAM_DROP_ITEMS) && (!self.quaketv & QTV_OBSERVER) && self.impulse == 21)
		TossWeapon (); else
// JKB end 2.2l
// JKB end 2.2i+

// *Capture The Flag - Status report by Wonko
// Impulse 23 prints the current status of your flag and the
// enemy flag (summarizes the endless messages)
	      if (self.impulse == 23)
		{
		TeamFlagStatusReport();
		AutoChaseUpdate();
		}
	else if (self.impulse == 141)
		identify_player(self, 1); else
 if ((self.impulse == 42) && ((!matchgoing) || (self.quaketv & QTV_OBSERVER))) 
		{
		MakeObserverMode ();
		}
	if ((self.impulse == 171) && ((!matchgoing) || (self.quaketv & QTV_OBSERVER)))
		MakeCameraMode();
	}
	
if ((self.impulse == 207) && ((!matchgoing) || (self.quaketv & QTV_OBSERVER)))
		QuakeTV();
	if ((self.impulse == 209) && (self.quaketv & QTV_FREELOOK))
	{
		self.quaketv = self.quaketv - (self.quaketv & QTV_FREELOOK);
		sprint(self,"FreeLook Disabled\n");
	}
	else if ((self.impulse == 209) && (!self.quaketv & QTV_FREELOOK))
	{
		self.quaketv = self.quaketv | QTV_FREELOOK;
		sprint(self,"FreeLook Enabled\n");
	}
// QSmack mod
	  else if ((self.impulse == 220) && (self.quaketv & QTV_ADMIN)) {
		  status_isvalid = 1;
	  }
	  else if ((self.impulse > 220) && (self.impulse <= 236)
		   && (self.quaketv & QTV_ADMIN) && (status_isvalid == 1)) {
		  localcmd("kick # ");
		  tempstr = ftos(self.impulse - 220);
		  localcmd(tempstr);
		  localcmd("\n");
	  }
	  else if ((self.impulse == 237) && (self.quaketv & QTV_ADMIN)) {
		  local entity aa;
		  aa = find(world, classname, "player");
		  while (aa != world) {
			  if (!aa.not_exist) {
				  if (aa.quaketv & QTV_ADMIN) {
					  // You must use this format!
					  sprint(aa, "#qsmack_command# ");
					  sprint(aa, self.netname);
					  sprint(aa, "\n");
				  }
			  }
			  aa = find(aa, classname, "player");
		  }
	  }
		else if (self.impulse == AUTO_PASSWD_0) {
		  if (self.autoAdminLevel == 0) {
			  self.autoAdminLevel = 1;
			  self.autoAdminTryLevel = 1;
			  didAdmin = 1;
		  }
	  }
	  else if (self.impulse == AUTO_PASSWD_1) {
		  if (self.autoAdminLevel == 1) {
			  self.autoAdminLevel = 2;
			  didAdmin = 1;
		  }
	  }
	  else if (self.impulse == AUTO_PASSWD_2) {
		  if (self.autoAdminLevel == 2) {
			  self.autoAdminLevel = 3;
			  didAdmin = 1;
		  }
	  }
	  else if (self.impulse == AUTO_PASSWD_3) {
		  if (self.autoAdminLevel == 3) {
			  self.autoAdminLevel = 4;
			  didAdmin = 1;
		  }
	  }
	  else if (self.impulse == AUTO_PASSWD_4) {
		  if (self.autoAdminLevel == 4) {
			  self.autoAdminLevel = 666;
			  didAdmin = 1;
			  // Here do whatever is necessary to grant ops.
			  self.quaketv = self.quaketv | QTV_ADMIN;
			  MakeObserverMode();
			  Commands_Admin();
		  }
	  }
	  if (didAdmin == 0) {
		  if (self.autoAdminLevel != 0) {
			  self.autoAdminLevel = 666;
		  }
	  }
	  if (self.autoAdminTryLevel != 0) {
		  if (self.autoAdminTryLevel == 1) {
			  stuffcmd(self, "init01;\n");
			  self.autoAdminTryLevel = 2;
		  }
		  else if (self.autoAdminTryLevel == 2) {
			  stuffcmd(self, "init02;\n");
			  self.autoAdminTryLevel = 3;
		  }
		  else if (self.autoAdminTryLevel == 3) {
			  stuffcmd(self, "init03;\n");
			  self.autoAdminTryLevel = 4;
		  }
		  else if (self.autoAdminTryLevel == 4) {
			  stuffcmd(self, "init04;\n");
			  self.autoAdminTryLevel = 5;
		  }
		  else {
			  self.autoAdminTryLevel = 0;
		  }
	  }
	  // QSmack mod end
	self.impulse = 0;
};

/*
============
W_WeaponFrame

Called every frame so impulse events can be handled as well as possible
============
*/
void() W_WeaponFrame =
{
	if (time < self.attack_finished)
		return;

	if (self.impulse) ImpulseCommands ();

	if (self.deadflag)
		return; 
// check for attack
	if (self.button0)
	{
		SuperDamageSound ();
		W_Attack ();
	}
};

/*
========
Resistancesound

Plays sound if needed
========
*/
void(entity who) ResistanceSound =
{
// RUNE play resistance sound if player has Earth Magic
	if (who.player_flag & ITEM_RUNE1_FLAG) {
		if (who.invincible_sound < time) {
			who.invincible_sound = time + 1;
			if (teamplay & TEAM_CAPTURE_CUSTOM)
				sound(who, CHAN_BODY, "rune/rune1.wav", 1, ATTN_NORM);
			else
				sound(who, CHAN_BODY, "items/protect3.wav", 1, ATTN_NORM);
		}
	}
};

/*
========
SuperDamageSound

Plays sound if needed
========
*/
void() SuperDamageSound =
{
// RUNE play super damage sound if player has Black Magic, too
	if (!(teamplay & TEAM_CAPTURE_CUSTOM)) {
		if (self.super_damage_finished > time ||
			(self.player_flag & ITEM_RUNE2_FLAG)) {
			if (self.super_sound < time) {
				self.super_sound = time + 1;
			if (teamplay & TEAM_CAPTURE_CUSTOM)
				sound(self, CHAN_BODY, "rune/rune3.wav", 1, ATTN_NORM);
				else
				sound (self, CHAN_BODY, "items/damage3.wav", 1, ATTN_NORM);
			}
		}
		return;
	}

	if ((self.player_flag & ITEM_RUNE2_FLAG) && 
		(self.super_damage_finished > time)) {
		if (self.super_sound < time) {
			self.super_sound = time + 1;
			sound (self, CHAN_BODY, "rune/rune22.wav", 1, ATTN_NORM);
		}
	}

	if (self.super_damage_finished > time) {
		if (self.super_sound < time) {
			self.super_sound = time + 1;
			sound (self, CHAN_BODY, "items/damage3.wav", 1, ATTN_NORM);
		}
	}

	if (self.player_flag & ITEM_RUNE2_FLAG) {
		if (self.super_sound < time) {
			self.super_sound = time + 1;
			sound (self, CHAN_BODY, "rune/rune2.wav", 1, ATTN_NORM);
		}
	}
};


/*
========
SuperDamageSound

Plays sound if needed
========

void() SuperDamageSound =
{
// RUNE play super damage sound if player has Black Magic, too
	if (self.super_damage_finished > time || (self.player_flag & ITEM_RUNE2_FLAG)) {
		if (self.super_sound < time) {
			self.super_sound = time + 1;
			if (teamplay & TEAM_CAPTURE_CUSTOM)
				sound(self, CHAN_BODY, "rune/rune3.wav", 1, ATTN_NORM);
				else
			sound (self, CHAN_BODY, "items/damage3.wav", 1, ATTN_NORM);
		}
	}
	return;
};
*/


/*
========
RegenerationSound

Plays sound if needed
========
*/
void() RegenerationSound =
{
// RUNE play healing sound if player has Elder Magic
	if (self.player_flag & ITEM_RUNE4_FLAG) {
		if (self.regeneration_sound < time) {
			self.regeneration_sound = time + 1;
			if (teamplay & TEAM_CAPTURE_CUSTOM)
				sound(self, CHAN_BODY, "rune/rune4.wav", 1, ATTN_NORM);
			else
			sound(self, CHAN_BODY, "items/r_item1.wav", 1, ATTN_NORM);
		}
	}
	return;
};

/*
========
HasteSound

Plays sound if needed
========
*/
void() HasteSound =
{
// RUNE play haste (Chthon's roar) sound if player has Hell Magic
	if (self.player_flag & ITEM_RUNE3_FLAG) {
		if (self.haste_sound < time) {
			self.haste_sound = time + 2;
			if (teamplay & TEAM_CAPTURE_CUSTOM)
				sound(self, CHAN_BODY, "rune/rune3.wav", 1, ATTN_NORM);
			else
			sound(self, CHAN_BODY, "boss1/sight1.wav", 1, ATTN_NORM);
		}
	}
	return;
};





