
void() T_MissileTouch;
void() info_player_start;
void(entity targ, entity attacker) ClientObituary;

// void() monster_death_use;
void(entity c, float damage_fired, float damage_done) UpdateWeapon;
//============================================================================

/*
============
CanDamage

Returns true if the inflictor can directly damage the target.  Used for
explosions and melee attacks.
============
*/
float(entity targ, entity inflictor) CanDamage =
{
// bmodels need special checking because their origin is 0,0,0
	if (targ.movetype == MOVETYPE_PUSH)
	{
		traceline(inflictor.origin, 0.5 * (targ.absmin + targ.absmax), TRUE, self);
		if (trace_fraction == 1)
			return TRUE;
		if (trace_ent == targ)
			return TRUE;
		return FALSE;
	}
	
	traceline(inflictor.origin, targ.origin, TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '15 15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '-15 -15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '-15 15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '15 -15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;

	return FALSE;
};


/*
============
Killed
============
*/
void(entity targ, entity attacker) Killed =
{
	local entity oself;

	oself = self;
	self = targ;

	if (self.classname == "player") self.dead_time = time;	
	if (self.health < -99)
		self.health = -99;		// don't let sbar look bad if a player

	if (self.movetype == MOVETYPE_PUSH || self.movetype == MOVETYPE_NONE)
	{	// doors, triggers, etc
		self.th_die ();
		self = oself;
		return;
	}

	self.enemy = attacker;

	ClientObituary(self, attacker);
	
	self.takedamage = DAMAGE_NO;
	self.touch = SUB_Null;

	self.th_die ();
	
	self = oself;
};

float(entity targ, entity inflictor, entity attacker, float damage) TeamArmorDam;
float(entity targ, entity inflictor, entity attacker, float damage) TeamHealthDam;

/*
============
T_Damage

The damage is coming from inflictor, but get mad at attacker
This should be the only function that ever reduces health.
============
*/
void(entity targ, entity inflictor, entity attacker, float damage) T_Damage=
{
	local	vector	dir;
	local	entity	oldself;
	local	float	save;
	local	float	take;

	if (!targ.takedamage)
		return;
// JKB changed from 2.2l
// JKB changed from 2.2k
        if ((!gamestart) && (matchgoing != 1) && crmode)
// JKB end 2.2k
// JKB end 2.2l
                return;

// used by buttons and triggers to set activator for target firing
	damage_attacker = attacker;

// check for quad damage powerup on the attacker
	if (attacker.super_damage_finished > time)
		damage = damage * 4;
// RUNE: check for double damage for rune of Black Magic powerup
	if (attacker.player_flag & ITEM_RUNE2_FLAG)
		damage = damage * 2;
	if (targ.player_flag & ITEM_RUNE1_FLAG) {
		damage = damage / 2;
		ResistanceSound(targ);
		}
// RUNE

	if (attacker.classname == "player")
		UpdateWeapon(attacker, 0, damage);
	// *XXX* EXPERT CTF mark players who hurt the flag carrier, so they 
	// are worth more points for a while.
 	if ( (attacker.classname == "player") && // attacker must be a player
 	     (targ.player_flag & ITEM_ENEMY_FLAG) && // target is a flag carrier
 	     (attacker.lastteam != targ.lastteam) && // target and attacker on diff teams
 	     (targ.lastteam > 0) ) // unconnected check?
 		attacker.last_hurt_carrier = time;


// *TEAMPLAY*
// TeamArmorDam returns true iff the attacker can damage the target's armor

	if (TeamArmorDam(targ, inflictor, attacker, damage))
		save = ceil(targ.armortype*damage);
	else
		save = 0;

	if (save >= targ.armorvalue)
	{
		save = targ.armorvalue;
		targ.armortype = 0;	// lost all armor
		targ.items = targ.items - (targ.items & (IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3));
	}
	if (attacker.classname == "player")
		attacker.LastDamageInflicted = time;

	targ.armorvalue = targ.armorvalue - save;
	take = ceil(damage-save);
//RUNE check if target has rune of Earth Magic (half damage)
//	if (targ.player_flag & ITEM_RUNE1_FLAG) {
//		take = take / 2;
//		ResistanceSound(targ);
//WTF IS ALL THIS RESIST STUFF DOING HERE
		//if (targ.invincible_sound < time) {
		//	sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
		//	targ.invincible_sound = time + 2;
		//}
//	}
//RUNE


// add to the damage total for clients, which will be sent as a single
// message at the end of the frame
// FIXME: remove after combining shotgun blasts?
	if (targ.flags & FL_CLIENT)
	{
		targ.dmg_take = targ.dmg_take + take;
		targ.dmg_save = targ.dmg_save + save;
		targ.dmg_inflictor = inflictor;
	}

// figure momentum add
	if ( (inflictor != world) && (targ.movetype == MOVETYPE_WALK) )
	{
		dir = targ.origin - (inflictor.absmin + inflictor.absmax) * 0.5;
		dir = normalize(dir);
		targ.velocity = targ.velocity + dir*damage*8;
	}

// check for godmode or invincibility
	if (targ.flags & FL_GODMODE)
		return;
	if (targ.invincible_finished >= time)
	{
		if (self.invincible_sound < time)
		{
			sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
			self.invincible_sound = time + 2;
		}
		return;
	}
// *TEAMPLAY*
// TeamHealthDam will return true if the attacker can damage the target's
// health

        if (!TeamHealthDam(targ, inflictor, attacker, damage))
                return;

// do the damage
	targ.health = targ.health - take;
			
	if (targ.health <= 0)
	{
		Killed (targ, attacker);
		return;
	}

// react to the damage
	oldself = self;
	self = targ;
/*
	if ( (self.flags & FL_MONSTER) && attacker != world)
	{
	// get mad unless of the same class (except for soldiers)
		if (self != attacker && attacker != self.enemy)
		{
			if ( (self.classname != attacker.classname) 
			|| (self.classname == "monster_army" ) )
			{
				if (self.enemy.classname == "player")
					self.oldenemy = self.enemy;
				self.enemy = attacker;
				FoundTarget ();
			}
		}
	}
*/
	if (self.th_pain)
	{
		self.th_pain (attacker, take);
	// nightmare mode monsters don't go into pain frames often
		if (skill == 3)
			self.pain_finished = time + 5;		
	}

	self = oldself;
};

/*
============
T_RadiusDamage
============
*/
void(entity inflictor, entity attacker, float damage, entity ignore) T_RadiusDamage =
{
	local	float 	points;
	local	entity	head;
	local	vector	org;
	local string attacker_weapon;

	head = findradius(inflictor.origin, damage+40);
	
	while (head)
	{
		if (head != ignore)
		{
			if (head.takedamage)
			{
				org = head.origin + (head.mins + head.maxs)*0.5;
				points = 0.5*vlen (inflictor.origin - org);
				if (points < 0)
					points = 0;
				points = damage - points;
				if (head == attacker)
					points = points * 0.5;
				if (points > 0)
				{
					if (CanDamage (head, inflictor))
						T_Damage (head, inflictor, attacker, points);
				}
			}
		}
		head = head.chain;
	}
};

/*
============
T_BeamDamage
============
*/
void(entity attacker, float damage) T_BeamDamage =
{
	local	float 	points;
	local	entity	head;
	
	head = findradius(attacker.origin, damage+40);
	
	while (head)
	{
		if (head.takedamage)
		{
			points = 0.5*vlen (attacker.origin - head.origin);
			if (points < 0)
				points = 0;
			points = damage - points;
			if (head == attacker)
				points = points * 0.5;
			if (points > 0)
			{
				if (CanDamage (head, attacker))
				{
					if (head.classname == "monster_shambler")						
						T_Damage (head, attacker, attacker, points*0.5);
					else
						T_Damage (head, attacker, attacker, points);
				}
			}
		}
		head = head.chain;
	}
};

