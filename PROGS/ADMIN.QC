void() respawn;
void() GameTimer;
void() TimerOff;
void() ExitChaseMode;
void() MakeObserverMode;
void() ClearObserverFlags;
void() UnHookPlayer;
void() NextLevel;
void() TimerOff;

void () NameBotThink =
{
local entity t, p;
local float x;
local string st;

t = find(world, classname, "player");
p = find(world, classname, "NameBot");
if (p == world) return; // (WOAH! WTF HAPPENED?)
while (t != world)
    {
	if (t.netname == "")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == " ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "  ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "   ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "    ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "     ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "      ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "       ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "        ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "         ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "          ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "           ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "            ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "             ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "              ")
		stuffcmd(t, "name NoNameFaggot\n");
	else if (t.netname == "               ")
		stuffcmd(t, "name NoNameFaggot\n");
	t = find(t, classname, "player");
	} 
p.nextthink = time + 2.5; // Check for invalid nicks every 2.5 seconds
};




/*
==========
NameBotSpawn()
==========
*/
void () NameBotSpawn = 
{
local entity bot;
bot = spawn ();
BotSpawned = 1;
bot.owner = world;
bot.classname = "NameBot";
bot.think = NameBotThink;
bot.nextthink = time + 2.5;

};


/*
============
Commands_Admin
============
*/
void() Commands_Admin =
{
	if (!cvar("samelevel") & CLANRING_MODE)
	{
	
		sprint(self,"Available Commands:\n");
		sprint(self,"Ready........40  Commands.....99\n");
		sprint(self,"ModStatus....49  ModVersion..253\n");
		sprint(self,"StatusBar....70  Score........86\n");
		sprint(self,"ShowScore...200 	ModeSet.....149\n");
		sprint(self,"AimSet......150  DMSet.......181\n");
		sprint(self,"DropSet.....148  ProtectSet..147\n");
		sprint(self,"StaticTmSet.151  RunSet......184\n");
		sprint(self,"Reset........52  SetQuad......53\n");
		sprint(self,"SetPent......54  SetEyes......55\n");
		sprint(self,"SetRunes.....56  WarpList....235\n");
		sprint(self,"TLimit......142  FLimit......144\n");
		sprint(self,"Observer.....42  Camera.......51\n");
		sprint(self,"MakeCam.....170  RemoveCam...172\n");
		sprint(self,"AutoCam.....173  QuakeTV.....207\n");
		sprint(self,"AutoChase...203  ChaseCam....201\n");
		sprint(self,"Smooth......205  FreeLook....209\n");
		sprint(self,"PlayerList...90  Efficiency...84\n");
		sprint(self,"Skick........85  Warp.........48\n");
		sprint(self,"Red.........233  Blue........234\n"); 

	}
	else
	{
	
		sprint(self,"Available Commands:\n");
		sprint(self,"Ready........40  Commands.....99\n");
		sprint(self,"ModStatus....49  ModVersion..253\n");
		sprint(self,"StatusBar....70  Score........86\n");
		sprint(self,"ShowScore...200  MatchSet....135\n");   
		sprint(self,"AimSet......150  DMSet.......181\n");
		sprint(self,"DropSet.....148  ProtectSet..147\n");
		sprint(self,"ModeSet.....149  RunSet......184\n");
		sprint(self,"Reset........52  SetQuad......53\n");
		sprint(self,"SetPent......54  SetEyes......55\n");
		sprint(self,"SetRunes.....56  GhostList....160\n");
		sprint(self,"TLimit......142  FLimit......144\n");
		sprint(self,"TimerStart..130  TimerPause...45\n");
		sprint(self,"ClearClans..161  MatchEnd....133\n");
		sprint(self,"LockOut......46  LockMax......47\n");
		sprint(self,"Observer.....42  Camera........51\n");
		sprint(self,"MakeCam.....170  RemoveCam...172\n");
		sprint(self,"AutoCam.....173  QuakeTV.....207\n");
		sprint(self,"AutoChase...203  ChaseCam....201\n");	
		sprint(self,"Smooth......205  FreeLook....209\n");
		sprint(self,"StatDump.....43  PlayerList...90\n");
		sprint(self,"PlayerStats..91  ClanStats....82\n");
		sprint(self,"Efficiency...84  ViewRecord...44\n");
		sprint(self,"Skick........85  Warp.........48\n");  
		sprint(self,"Red.........233  Blue........234\n");
	}
};

/*
============
Commands_Player
============
*/
void() Commands_Player =
{
	if (!cvar("samelevel") & CLANRING_MODE)
	{

		sprint(self,"Available Commands:\n");
		sprint(self,"Admin........51  Commands.....99\n");
		sprint(self,"ModStatus....49  ModVersion..253\n");
		sprint(self,"StatusBar....70  Score........86\n");
		sprint(self,"PlayerList...90  Efficiency...84\n");
		sprint(self,"Observer.....42  Warplist....235\n");
		sprint(self,"AutoCam.....173  QuakeTV.....207\n");
		sprint(self,"AutoChase...203  ChaseCam....201\n");	
		sprint(self,"Smooth......205  FreeLook....209\n");
		sprint(self,"VKick.......252  Warp.........48\n");
		sprint(self,"AutoWeapon..248  Ready........40\n");
		sprint(self,"Red.........233  Blue........234\n");
	}
	else
	{

		sprint(self,"Available Commands:\n");
		sprint(self,"Admin........51  Commands.....99\n");
		sprint(self,"ModStatus....49  ModVersion..253\n");
		sprint(self,"StatusBar....70  Score........86\n");
		sprint(self,"StatDump.....43  PlayerList...90\n");
		sprint(self,"PlayerStats..91  ClanStats....82\n");
		sprint(self,"Efficiency...84  ViewRecord...44\n");
		sprint(self,"TimerStart..130  GhostList...160\n");
		sprint(self,"Observer.....42  ChaseCam....201\n");		
		sprint(self,"AutoCam.....173  QuakeTV.....207\n");
		sprint(self,"AutoChase...203  FreeLook....209\n");
		sprint(self,"Smooth......205  Warp.........48\n");
		sprint(self,"Ghost........50  AutoWeapon..248\n");
		sprint(self,"Ready........40  NotReady.....41\n");
		sprint(self,"Red.........233  Blue........234\n");
		sprint(self,"SetQuad......53  SetPent......54\n");
		sprint(self,"SetEyes......55  SetRunes.....56\n");
	}
};


void() QuadToggle =
	{
		local float temp;
		local string temp_s;
		temp = cvar("temp1");
		if (temp & 1)
		{
			temp = temp - 1;
			bprint("Quad Damage has been re-enabled!\nThis will not take affect until the next level change.\n");
		}
		else
		{
			temp = temp | 1;
			bprint("Quad Damage has been disabled!\nThis will not take affect until the next level change.\n");
		}
		temp_s = ftos(temp);
		cvar_set("temp1", temp_s);
	};

void () PentToggle =
	{
		local float temp;
		local string temp_s;
		temp = cvar("temp1");
		if (temp & 2)
		{
			temp = temp - 2;
			bprint("Pentagram of Protection has been re-enabled!\nThis will not take affect until the next level change.\n");
		}
		else
		{
			temp = temp | 2;
			bprint("Pentagram of Protection has been disabled!\nThis will not take affect until the next level change.\n");
		}
		temp_s = ftos(temp);
		cvar_set("temp1", temp_s);

	};

void () EyesToggle =
	{
		local float temp;
		local string temp_s;
		temp = cvar("temp1");
		if (temp & 4)
		{
			temp = temp - 4;
			bprint("Ring of Shadows has been re-enabled!\nThis will not take affect until the next level change.\n");
		}
		else
		{
			temp = temp | 4;
			bprint("Ring of Shadows has been disabled!\nThis will not take affect until the next level change.\n");
		}
		temp_s = ftos(temp);
		cvar_set("temp1", temp_s);

	};

void () RunesToggle =
	{
		local float temp;
		local string temp_s;
		temp = cvar("temp1");
		if (temp & 8)
		{
			temp = temp - 8;
			bprint("The Runes have been re-enabled!\nThis will not take affect until the next level change.\n");
		}
		else
		{
			temp = temp | 8;
			bprint("The Runes have been disabled!\nThis will not take affect until the next level change.\n");
		}
		temp_s = ftos(temp);
		cvar_set("temp1", temp_s);
	};


/*
============
PlayerList
============
*/
void() PlayerList =
{
	local string temp_string;
	local entity e;

	e = find(world,classname,"player");
	while (e != world)
	{
		if ((!e.not_exist) && (e.netname != ""))
		{
			sprint(self,e.netname);
			sprint(self," : ");
			temp_string=ftos(self.dead_time_total);
			sprint(self,temp_string);
			sprint(self," : ");
			if (e.quaketv & QTV_ADMIN) sprint(self,"Admin\n"); else
			if (e.quaketv & QTV_OBSERVER) sprint(self,"Observer"); else
			if (e.clan_number == 1)
				sprint(self, "“≈ƒ team\n");
			else if (e.clan_number == 2)
				sprint(self, "¬Ã’≈ team\n");
			else
				sprint(self,"Undeclared\n");
		}
	     	e = find(e,classname,"player");
	}
};

/*
============
PlayerStats
============
*/
void() PlayerStats =
{
	local entity e;
	local string temp;

	sprint(self,"Name:Team:Frags:Scoring breakdown...\n");

	e = find(world,classname,"player");
	while (e != world)
	{
		if ((!e.not_exist) && (!e.quaketv & QTV_OBSERVER) && (e.netname != ""))
		{
			sprint(self,e.netname);
			sprint(self,":");
			if (e.clan_number == 1)
				sprint(self, "“≈ƒ");
			else if (e.clan_number == 2)
				sprint(self, "¬Ã’≈");
			else
				sprint(self,"Undeclared");
			sprint(self,":");
			temp = ftos(e.frags);
			sprint(self,temp);
			sprint(self,":");
			temp = ftos(e.enemy_kill);
			sprint(self,temp);
			sprint(self,":");
			temp = ftos(e.friend_kill);
			sprint(self,temp);
			sprint(self,":");
			temp = ftos(e.captures);
			sprint(self,temp);
			sprint(self,":");
			temp = ftos(e.recoveries);
			sprint(self,temp);
			sprint(self,":");
			temp = ftos(e.get_flags);
			sprint(self,temp);
			sprint(self,":");
			temp = ftos(e.frag_carriers);
			sprint(self,temp);
			sprint(self,":");
			temp = ftos(e.carrier_danger_protects);
			sprint(self,temp);
			sprint(self,":");
			temp = ftos(e.carrier_protects);
			sprint(self,temp);
			sprint(self,":");
			temp = ftos(e.flag_defences);
			sprint(self,temp);
			sprint(self,":");
			temp = ftos(e.flag_assists);
			sprint(self,temp);
			sprint(self,":");
			temp = ftos(e.carrier_assists);
			sprint(self,temp);
			sprint(self,"\n");
		}
		e = find(e,classname,"player");
	}
};


/*
==========
Efficency
==========
*/
void() Efficiency =
{
	local entity e;
	local string temp_string;
	sprint(self,"Name : Kill : Ammo\n");
	e = find(world,classname,"player");
	while (e != world)
	{
		if ((!e.not_exist) && (!e.quaketv & QTV_OBSERVER)  && (e.netname != ""))
		{
			sprint(self,e.netname);
			sprint(self," :");
			temp_string = ftos(e.kills * 100/(e.kills + e.deaths));
			sprint(self,temp_string);
			sprint(self,"% :");
			temp_string = ftos(e.total_damage_done * 100/e.total_damage_fired);
			sprint(self,temp_string);
			sprint(self,"%\n");
		}
		e = find(e,classname,"player");
	}
};

/*
==========
ClanStats
=========
*/

void() ClanStats =
{
	local entity e;
	local string temp;


	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}

	sprint(self,"Team:Frags:Scoring breakdown...\n");
	e = find(world,classname,"clan");
	while (e != world)
	{
		if (e.clan_number == 1)
			sprint(self, "“≈ƒ");
		else
			sprint(self, "¬Ã’≈");
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.frags);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.enemy_kill);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.friend_kill);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.captures);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.recoveries);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.get_flags);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.frag_carriers);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.carrier_danger_protects);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.carrier_protects);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.flag_defences);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.flag_assists);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.carrier_assists);
		sprint(self,temp);
		sprint(self,"\n");
		e = find(e,classname,"clan");
	}
};


/*
==========
UpdateFrags
==========
*/
void(entity c, float score, float kill_enemy, float kill_friend) UpdateFrags =
{
	if (!cvar("samelevel") & CLANRING_MODE) return;
	local entity ghost;
	local entity clan;

	ghost = find(world,classname,"ghost");
	if(match_ending) return;
	while(ghost != world)
	{
		if (ghost.ghostcode == c.ghostcode)
		{
			ghost.frags = ghost.frags + score;
			ghost.enemy_kill = ghost.enemy_kill + kill_enemy;
			ghost.friend_kill = ghost.friend_kill + kill_friend;
		}
		ghost = find(ghost,classname,"ghost");
	}
	if (c.clan_number)
	{
		clan = find(world,classname,"clan");
		while(clan != world)
		{
			if (clan.clan_number == c.clan_number)
			{
				clan.frags = clan.frags + score;
				clan.enemy_kill = clan.enemy_kill + kill_enemy;
				clan.friend_kill = clan.friend_kill + kill_friend;
			}
			clan = find(clan,classname,"clan");
		}
	}
};

/*
===========
UpdateFlags
===========
*/
void(entity c, float score, float capture, float recovery, float get_flag, float frag_carrier) UpdateFlags =
{
	if (!cvar("samelevel") & CLANRING_MODE) return;
	local entity ghost;
	local entity clan;

	ghost = find(world,classname,"ghost");
	if(match_ending) return;
	while(ghost != world)
	{
		if (ghost.ghostcode == c.ghostcode)
		{
			ghost.frags = ghost.frags + score;
			ghost.captures = ghost.captures + capture;
			ghost.recoveries = ghost.recoveries + recovery;
			ghost.get_flags = ghost.get_flags + get_flag;
			ghost.frag_carriers = ghost.frag_carriers + frag_carrier;
		}
		ghost = find(ghost,classname,"ghost");
	}
	if (c.clan_number)
	{
		clan = find(world,classname,"clan");
		while(clan != world)
		{
			if (clan.clan_number == c.clan_number)
			{
				clan.frags = clan.frags + score;
				clan.captures = clan.captures + capture;
				clan.recoveries = clan.recoveries + recovery;
				clan.get_flags = clan.get_flags + get_flag;
				clan.frag_carriers = clan.frag_carriers + frag_carrier;
			}
			clan = find(clan,classname,"clan");
		}
	}
};

void(entity c, float score, float carrier_danger_protect, float carrier_protect, float flag_defence) UpdateProtects =
{
	if (!cvar("samelevel") & CLANRING_MODE) return;
	local entity ghost;
	local entity clan;

	ghost = find(world,classname,"ghost");
	if(match_ending) return;
	while(ghost != world)
	{
		if (ghost.ghostcode == c.ghostcode)
		{
			ghost.frags = ghost.frags + score;
			ghost.carrier_danger_protects = ghost.carrier_danger_protects + carrier_danger_protect;
			ghost.carrier_protects = ghost.carrier_protects + carrier_protect;
			ghost.flag_defences = ghost.flag_defences + flag_defence;
		}
		ghost = find(ghost,classname,"ghost");
	}
	if (c.clan_number)
	{
		clan = find(world,classname,"clan");
		while(clan != world)
		{
			if (clan.clan_number == c.clan_number)
			{
				clan.frags = clan.frags + score;
				clan.carrier_danger_protects = clan.carrier_danger_protects + carrier_danger_protect;
				clan.carrier_protects = clan.carrier_protects + carrier_protect;
				clan.flag_defences = clan.flag_defences + flag_defence;
			}
			clan = find(clan,classname,"clan");
		}
	}
};

void(entity c, float score, float flag_assist, float carrier_assist) UpdateAssists =
{
	if (!cvar("samelevel") & CLANRING_MODE) return;
	local entity ghost;
	local entity clan;

	ghost = find(world,classname,"ghost");
	if(match_ending) return;
	while(ghost != world)
	{
		if (ghost.ghostcode == c.ghostcode)
		{
			ghost.frags = ghost.frags + score;
			ghost.flag_assists = ghost.flag_assists + flag_assist;
			ghost.carrier_assists = ghost.carrier_assists + carrier_assist;
		}
		ghost = find(ghost,classname,"ghost");
	}
	if (c.clan_number)
	{
		clan = find(world,classname,"clan");
		while(clan != world)
		{
			if (clan.clan_number == c.clan_number)
			{
				clan.frags = clan.frags + score;
				clan.flag_assists = clan.flag_assists + flag_assist;
				clan.carrier_assists = clan.carrier_assists + carrier_assist;
			}
			clan = find(clan,classname,"clan");
		}
	}
};

void(entity c, float damage_fired, float damage_done) UpdateWeapon =
{
	if (c.super_damage_finished > time)
		damage_fired = damage_fired * 4;
	if (c.player_flag & ITEM_RUNE2_FLAG)
		damage_fired = damage_fired * 2;
	c.total_damage_fired = c.total_damage_fired + damage_fired;
	c.total_damage_done = c.total_damage_done + damage_done;
};


/*
==========
MatchEnd - Ends a match
==========
*/
void() MatchEnd =
{
	local entity e;
	if (matchgoing != 1)
	{
	  	sprint(self,"No Match in Progress\n");
		return;
	}

	e = find(e,classname,"timer");
	
	e.cnt = e.items;
	e.cnt2 = 1;
	bprint("Match Ended by ");
	bprint(self.netname);
	bprint("\n");
	dprint("Match Ended by ");
	dprint(self.netname);
	dprint("\n");
	observerless_mode = 1;
};

/*
==========
FraglimitChange
==========
*/
void() FraglimitChange =
{
	local float fraglimit;
	local string temp_string;

	if (self.input_point == 0) {
		self.temp_f = 0;
		fraglimit = cvar("fraglimit");
		temp_string = ftos(fraglimit);
		sprint(self, "Current fraglimit: ");
		sprint(self, temp_string);		
		sprint(self, "\nEnter 1st of 3 digits for new limit\n");
		self.input_point = 1;
		self.admin_last_impulse = 144;
	} else 
	if (self.input_point == 1) {
		sprint(self, "Enter 2nd of 3 digits for new limit\n");
		self.temp_f = (self.impulse * 100);
		self.input_point = 2;
	} else
	if (self.input_point == 2) {
		sprint(self, "Enter 3rd of 3 digits for new limit\n");
		self.temp_f = (self.temp_f + (self.impulse * 10));	
		self.input_point = 3;
	} else
	if (self.input_point == 3) {
		self.temp_f = (self.temp_f + (self.impulse));
		self.input_point = 0;
		temp_string = ftos(self.temp_f);
		localcmd("fraglimit ");
		localcmd(temp_string);
		localcmd("\n");
		self.temp_f = 0; 
		self.admin_last_impulse = 0;
		bprint("FragLimit changed to ");
		bprint(temp_string);
		bprint("\n");
	}  
};

/*
==========
TimelimitChange
==========
*/
void() TimelimitChange =
{
local float timelimit;
local string temp_string;

	if (self.input_point == 0) {
		self.temp_f = 0;
		timelimit = cvar("timelimit");
		if (cvar("samelevel") & CLANRING_MODE)
			temp_string = ftos(TIMER_MATCH);
		else temp_string = ftos(timelimit);
		sprint(self, "Current timelimit: ");
		sprint(self, temp_string);		
		sprint(self, "\nEnter 1st of 2 digits for new limit\n");
		if (!cvar("samelevel") & CLANRING_MODE)
			sprint(self, "Enter 0 for no timelimit\n");
		self.input_point = 1;
		self.admin_last_impulse = 142;
	} else 
	if (self.input_point == 1) {
		sprint(self, "Enter 2nd of 2 digits for new limit\n");
		self.temp_f = (self.impulse * 10);
		self.input_point = 2;
	} else
	if (self.input_point == 2) {
		self.temp_f = (self.temp_f + (self.impulse));
		self.input_point = 0;
		temp_string = ftos(self.temp_f);
		if (cvar("samelevel") & CLANRING_MODE)
		{
			if (self.temp_f <= 1)
			{
				self.temp_f = 20;
				sprint(self, "Um.. How bout 20 minutes instead?");
				sprint(self, ftos(self.temp_f));
				sprint(self, " is too low.\n");
			}
			TIMER_MATCH=self.temp_f;	// Added May 30 2:27AM. Duh.
		}
		else 	
		{	
			localcmd("timelimit ");
			localcmd(temp_string);
			localcmd("\n");
		}
		bprint("TimeLimit changed to ");
		bprint(temp_string);
		bprint("\n");
		self.temp_f = 0; 
		self.admin_last_impulse = 0;
	}  
};

/*
============
Timer_Pause
============
*/
void() Timer_Pause =
{

	local entity h;

	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}

	if (!timer_exist)
	{
		sprint(self,"Timer not Active\n");
		return;
	}
	if (timer_pause == 1)
	{
		timer_pause = 0;
		if (timer_temp) matchgoing = 1;
		timer_temp = 0;
		h = find(world,classname,"player");
		while (h != world)
		{
			if (!h.quaketv & QTV_OBSERVER)
			{
				h.movetype = MOVETYPE_WALK;
				if(h.super_damage_left) h.super_damage_finished = h.super_damage_left + time;
				if(h.radsuit_left) h.radsuit_finished = h.radsuit_left + time;
				if(h.invincible_left) h.invincible_finished = h.invincible_left + time;
				if(h.invisible_left) h.invisible_finished = h.invisible_left + time;
				h.air_finished = time + 12;
				centerprint(self,"Match Resumed\n");
			}
			h = find(h,classname,"player");
		}
		bprint("Match Resuming\n");
	}
	else
	{
		if (matchgoing)
		{
		timer_temp = 1;
		matchgoing = 2;
		}
		timer_pause = 1;		
		h = find(world,classname,"player");
		while (h != world)
		{
			if (!h.quaketv & QTV_OBSERVER)
			{
				h.movetype = MOVETYPE_NONE;
				if(h.super_damage_finished > time) h.super_damage_left = h.super_damage_finished - time;
				if(h.radsuit_finished > time) h.radsuit_left = h.radsuit_finished - time;
				if(h.invincible_finished > time) h.invincible_left = h.invincible_finished - time;
				if(h.invisible_finished > time) h.invisible_left = h.invisible_finished - time;
					centerprint(self,"Match is Paused\n");
			}
			h = find(h,classname,"player");
		}
		bprint("Match Paused\n");
	}	 
};

/*
============
Count_Players
============
*/
float(float count_clan_number) Count_Players =
{
	local entity clan_member;
	local float num_clan;

	clan_member = find(world,classname,"player");

	while(clan_member != world)
	{
		if ((clan_member.clan_number == count_clan_number) && (!clan_member.not_exist) && (!clan_member.quaketv & QTV_OBSERVER) && (clan_member.netname != "")) num_clan = num_clan + 1; 
		clan_member = find(clan_member,classname,"player");
	}
	return num_clan;	
};

/*
============
Count_Clans
============
*/
float() Count_Clans =
{
	local entity clan;
	local float num_clans;

	clan = find(world,classname,"clan");

	while(clan != world)
	{
		if (!clan.not_exist)
		{
			num_clans = num_clans + 1; 
		}
		clan = find(clan,classname,"clan");
	}
	return num_clans;	
};

/*
============
Check_Players
============
*/
void() Check_Players =
{
	local float noclan;
	local float num_clans;
	local float num_clan;
	local float not_ready;
	local entity clan;
	
	local string temp_string;
	if (!cvar("samelevel") & CLANRING_MODE) return;

// Check number of people in each clan, if any clans empty, remove clan
	clan = find(world,classname,"clan");

	while(clan != world)
	{
		num_clan = Count_Players(clan.clan_number);
		if ((!num_clan) && (!matchgoing))
		{
			clan.nextthink = time + 1;	   
			clan.think = SUB_Remove;
			clan.not_exist = 1;
		} 
		clan = find(clan,classname,"clan");
	}
// Check number of clans, if less than 2, warn and set noclan
	num_clans = Count_Clans(); 
	if (num_clans == 1)
	{
		bprint("Only 1 Clan Present\n");
		noclan = 1;
	}
	if (num_clans == 0)
	{
		noclan = 1;
		bprint("No Clans Present\n");
	}
	
	not_ready = Count_Players(0);
	if ((timer_exist == 1) && (!matchgoing) && (observerless_mode) && (noclan))
	{
		bprint("Timer stopped\n");
		TimerOff();
	}
	if ((not_ready) && (timer_exist == 1) && (!matchgoing) && (observerless_mode))
	{
		bprint("Timer stopped\n");
		TimerOff();
	}
	if (not_ready)
	{	 
		temp_string = ftos(not_ready);
		bprint(temp_string);
		bprint(" players without clan\n");
	}
	if ((!not_ready) && (num_clans > 1) && (!timer_exist))
	{
		bprint("Timer started\n");
		TIMER_RALLY = 1;
		observerless_mode = 1;
		GameTimer();
	}
	
};

/*
============
MakeGhost
============
*/
void(entity c) MakeGhost =
{
	local entity ghost;

	ghost = spawn ();
	ghost.owner = world;
	ghost.classname = "ghost";
	ghost.ghostcode = c.ghostcode;
	ghost.clan_number = c.clan_number;
	ghost.pant_color = c.pant_color;
};

/*
============
MakeNonEntity
============
*/
void() MakeNonEntity =
{

	stuffcmd(self, "color 0\n");
	local string player_color_string;
	local entity e;
	self.armorvalue    = 0;
	self.items	   = 0;
	self.health	  = 666;
	self.ammo_shells   = 0;
	self.ammo_nails    = 0;
	self.ammo_rockets  = 0;
	self.ammo_cells    = 0;
	self.weapon	  = 0;
	self.currentammo   = 1;
	self.max_health = 666;
	self.takedamage    = DAMAGE_NO;
	self.solid	   = SOLID_NOT;
	self.deadflag	= DEAD_NO;
	self.movetype = MOVETYPE_NONE;
	self.frags = 0;
	self.quaketv	 = self.quaketv | QTV_OBSERVER;
	if (self.quaketv & QTV_AUTOCAM)
	self.quaketv = self.quaketv - (self.quaketv & QTV_AUTOCAM);
	if (self.quaketv & QTV_CAMERA)
	self.quaketv = self.quaketv - (self.quaketv & QTV_CAMERA);
	if (self.quaketv & QTV_CHASE)
	self.quaketv = self.quaketv - (self.quaketv & QTV_CHASE);
	if (self.quaketv & QTV_AUTOCHASE)
	self.quaketv = self.quaketv - (self.quaketv & QTV_AUTOCHASE);
	setmodel (self, string_null);
	setsize (self, '-16 -16 -24','16 16 40');
	self.view_ofs = '0 0 22';
	self.weaponmodel = "";
	self.weaponframe = 0;
	self.weapon = IT_EXTRA_WEAPON;
	self.clan_number = 0;
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
	self.invisible_finished = 0;
	self.invincible_finished = 0;
	self.effects = 0;
	self.invincible_time = 0;
	DropBackpack();
	DropRune();
	UnHookPlayer();
	TeamCaptureDropFlagOfPlayer(self); 
	self.lastteam = 0;
	self.ghostcode = 0;
	self.stat_dump = 0;
	Check_Players();
};

/*
============
MakeCameraMode
============
*/
void() MakeCameraMode =
{

	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}
	if (self.impulse == 171) MakeObserverMode(); // SO 2.8b if we got here by typeing camera
	self.quaketv	   = self.quaketv | QTV_CAMERA;
	self.current_cam = find (world, classname, "info_intermission");
	if (!self.current_cam) self.current_cam = find (world, classname, "player_cam");
	GotoCamera();
	if (!(self.quaketv & QTV_QUAKETV)) sprint(self,"Camera Mode Enabled\n");
};


/*
============
MakeObserverMode
============
*/
void() MakeObserverMode =
{

	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}

	if (self.quaketv & QTV_QUAKETV)
		{ self.quaketv = self.quaketv - (self.quaketv & QTV_QUAKETV);} // SO added 2.8b
	if (self.quaketv & QTV_AUTOCAM)
		{self.quaketv = self.quaketv - (self.quaketv & QTV_AUTOCAM);} //SO changed 2.8b
	if (self.quaketv & QTV_AUTOCHASE)
		{self.quaketv = self.quaketv - (self.quaketv & QTV_AUTOCHASE);}//SO changed 2.8b
	if (self.quaketv & QTV_FOUNDTARG)
		{self.quaketv = self.quaketv - (self.quaketv & QTV_FOUNDTARG);}//SO changed 2.8c
	MakeNonEntity();
	self.observer_status = OBSERVER_BECOME_OBSERVER; 
	ObserverBecomeObserver(self);
	self.current_cam = world;
};

/*
============
AdminCode
============
*/
void() AdminCode =
{
	local entity e;
	local float temp;

	temp = self.impulse;
	if (temp == 10) temp = 0;
	if (self.admin_stage == 1)
	{
		self.admincode = temp * 1000;
		self.admin_stage = 2;
		sprint(self,"Enter second number of 4 digit code:\n");
	}
	else
	if (self.admin_stage == 2)
	{
		self.admincode = self.admincode + temp * 100;
		self.admin_stage = 3;
		sprint(self,"Enter third number of 4 digit code:\n");
	}
	else
	if (self.admin_stage == 3)
	{
		self.admincode = self.admincode + temp * 10;
		self.admin_stage = 4;
		sprint(self,"Enter fourth number of 4 digit code: \n");

	}
	else
	if (self.admin_stage == 4)
	{
		self.admincode = self.admincode + temp;
		self.admin_stage = 0;
	     	self.try = self.try + 1;
	   	if (self.try > 3)
		{
			//stuffcmd(self, "say I just entered an incorrect Admin code!\n");
			sprint(self, "Too many incorrect guesses!\n");
			stuffcmd(self, "quit\n");
			self.admincode = 0;
			return;
		}
		if (self.admincode == admin_code_real)
		{
	  		if (!cvar("samelevel") & CLANRING_MODE)
			{
				self.quaketv = self.quaketv | QTV_ADMIN;
				self.try = 0;
				stuffcmd (self, "bf\n");
		   		sprint(self,"\nAdmin commands available\n");
				dprint(self.netname);
				dprint(" has become an Admin\n");
				bprint(self.netname);
				bprint(" has become an Admin\n");

				Commands_Admin();
			}
			else
			{
				self.quaketv = self.quaketv | QTV_ADMIN;
				self.try = 0;
				if (!(self.quaketv & QTV_OBSERVER)) {
					MakeObserverMode();
				}
			   	stuffcmd (self, "bf\n");
		   		sprint(self,"\nAdmin commands available\n");
				dprint(self.netname);
				dprint(" has become an Admin\n");
				bprint(self.netname);
				bprint(" has become an Admin\n");

				Commands_Admin();
			}
		}
		self.admincode = 0;
	}
	self.impulse = 0;
};

/*
=============
ViewGhosts
=============
*/

void() ViewGhosts=
{
	local entity e;
	local string temp;


	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}

	sprint(self,"GhostCode:Team:Frags:Scoring breakdown...\n");

	e = find(world,classname,"ghost");
	while (e != world)
	{
		temp=ftos(e.ghostcode);
		sprint(self,temp);
		sprint(self,":");
		if (e.clan_number == 1)
			sprint(self, "“≈ƒ");
		else
			sprint(self, "¬Ã’≈");
		sprint(self,":");
		temp = ftos(e.frags);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.enemy_kill);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.friend_kill);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.captures);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.recoveries);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.get_flags);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.frag_carriers);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.carrier_danger_protects);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.carrier_protects);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.flag_defences);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.flag_assists);
		sprint(self,temp);
		sprint(self,":");
		temp = ftos(e.carrier_assists);
		sprint(self,temp);
		sprint(self,"\n");
		e = find(e,classname,"ghost");
	}

	sprint(self,"End of ghost list\n");
};


/*
============
ViewRecord
============
*/

void() ViewRecord =
{
	local entity e;
	local string temp_string;


	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}

	e = find(world,classname,"deadclan");
	while(e != world)
	{
		if (e.clan_number == 1)
			sprint(self, "“≈ƒ team");
		else
			sprint(self, "¬Ã’≈ team");
		sprint (self,"'s Score = ");
		temp_string=ftos(e.frags);
		sprint (self,"\n");
		e = find(e,classname,"deadclan");
	}

	sprint(self,"\nGhost:Team:Frags:Scoring breakdown...\n"); 
 	e = find(world,classname,"record");
    	while (e != world)
 	{
		temp_string = ftos(e.ghostcode);
		sprint(self,temp_string);
		sprint(self,":");
		if (e.clan_number == 1)
			sprint(self, "“≈ƒ");
		else
			sprint(self, "¬Ã’≈");
		sprint(self,":");
		temp_string = ftos(e.frags);
		sprint(self,temp_string);
		sprint(self,":");
		temp_string = ftos(e.enemy_kill);
		sprint(self,temp_string);
		sprint(self,":");
		temp_string = ftos(e.friend_kill);
		sprint(self,temp_string);
		sprint(self,":");
		temp_string = ftos(e.captures);
		sprint(self,temp_string);
		sprint(self,":");
		temp_string = ftos(e.recoveries);
		sprint(self,temp_string);
		sprint(self,":");
		temp_string = ftos(e.get_flags);
		sprint(self,temp_string);
		sprint(self,":");
		temp_string = ftos(e.frag_carriers);
		sprint(self,temp_string);
		sprint(self,":");
		temp_string = ftos(e.carrier_danger_protects);
		sprint(self,temp_string);
		sprint(self,":");
		temp_string = ftos(e.carrier_protects);
		sprint(self,temp_string);
		sprint(self,":");
		temp_string = ftos(e.flag_defences);
		sprint(self,temp_string);
		sprint(self,":");
		temp_string = ftos(e.flag_assists);
		sprint(self,temp_string);
		sprint(self,":");
		temp_string = ftos(e.carrier_assists);
		sprint(self,temp_string);
		sprint(self,"\n");
		e = find(e,classname,"record");
	}
	sprint(self,"End of Record\n");
};


/*
============
GhostCode
============
*/

void() GhostCode =
{
	local entity e;
	local float temp;
	local entity clan;
	local float clan_exists;


	temp = self.impulse;
	if (temp == 10) temp = 0;
	if (self.ghostcode_stage == 1)
	{
		self.ghostcode = temp * 100;
		self.ghostcode_stage = 2;
		sprint(self,"Enter second number of 3 digit code:\n");
		return;
	}
	else
	if (self.ghostcode_stage == 2)
	{
		self.ghostcode = self.ghostcode + temp * 10;
		self.ghostcode_stage = 3;
		sprint(self,"Enter third number of 3 digit code: \n");
		return;
	}
	else
	if (self.ghostcode_stage == 3)
	{
		self.ghostcode = self.ghostcode + temp;
		self.ghostcode_stage = 0;
		sprint(self,"id code entered\n");
		clan_exists = 0;
		e = find(world,classname,"ghost");
		while (e != world)
		{
			if (self.ghostcode == e.ghostcode)
			{
				self.clan_number = e.clan_number;
				self.pant_color = e.pant_color;
				self.frags = e.frags;
				self.deaths = e.deaths;
				self.enemy_kill = e.enemy_kill;
				self.friend_kill = e.friend_kill;
				self.captures = e.captures;
				self.recoveries = e.recoveries;
				self.get_flags = e.get_flags;
				self.frag_carriers = e.frag_carriers;
				self.carrier_danger_protects = e.carrier_danger_protects;
				self.carrier_protects = e.carrier_protects;
				self.flag_defences = e.flag_defences;
				self.flag_assists = e.flag_assists;
				self.carrier_assists = e.carrier_assists;
				self.team = e.pant_color + 1;
				self.lastteam = e.pant_color + 1;
				self.player_flag = self.player_flag | TEAM_STUFF_COLOR;
				clan = find(world,classname,"clan");
				while (clan != world)
				{
					if (clan.clan_number == self.clan_number)
						clan_exists = 1;
					clan = find(clan,classname,"clan");
				}
				if (!clan_exists)
				{
					clan = spawn ();
					clan.owner = world;
					clan.classname = "clan";
					clan.clan_number = self.clan_number;
					clan.pant_color = self.pant_color;
					clan.frags = self.frags;
					clan.deaths = self.deaths;
					clan.enemy_kill = self.enemy_kill;
					clan.friend_kill = self.friend_kill;
					clan.captures = self.captures;
					clan.recoveries = self.recoveries;
					clan.get_flags = self.get_flags;
					clan.frag_carriers = self.frag_carriers;
					clan.carrier_danger_protects = self.carrier_danger_protects;
					clan.carrier_protects = self.carrier_protects;
					clan.flag_defences = self.flag_defences;
					clan.flag_assists = self.flag_assists;
					clan.carrier_assists = self.carrier_assists;

					if (clan.clan_number == 1)
						 bprint("“≈ƒ team recreated\n");
					else
			 			bprint("¬Ã’≈ team recreated\n");

				}
				bprint(self.netname);
				bprint(" restored from ghost\n");
				bprint(self.netname);
				bprint(" set to ");

				if (self.clan_number == 1)
					 bprint("“≈ƒ team\n");
				else
			 		bprint("¬Ã’≈ team\n");

				if (self.quaketv & QTV_OBSERVER)
				{
					self.quaketv = self.quaketv - (self.quaketv & QTV_OBSERVER);
					self.movetype = MOVETYPE_NONE;
					respawn();
				}
				self.impulse = 0;
				return;
			}
			e = find(e,classname,"ghost");
		}
		self.ghostcode = 0;
	}
};


/*
==========
Mod_Status
==========
*/
void() Mod_Status =
{
	local string b;
	local entity clan;
	sprint(self,"Deathmatch is ");
	b = ftos(cvar("deathmatch"));
	sprint(self,b);
	sprint(self,"\n");
	sprint(self,"Mode is ");
	if (cvar("samelevel") & CLANRING_MODE) sprint(self,"Clanring\n");
	else sprint(self,"Skirmish\n");
	if ((cvar("samelevel") & (TEAM_STATIC_TEAMS | CLANRING_MODE)) == TEAM_STATIC_TEAMS) sprint(self,"Static teams\n");
	if (cvar("samelevel") & CLANRING_MODE)
	{
	 	sprint(self, "MatchSet is ");
		b = ftos(TIMER_MATCH);
		if ( (cvar("samelevel") & TLIMIT_MODE) && !(cvar("samelevel") & FLIMIT_MODE) )
		{
			sprint(self,"TimeLimit ONLY (");
			sprint(self, b);
			sprint(self, ")\n");
		}
		else if ( (cvar("samelevel") & TLIMIT_MODE) && (cvar("samelevel") & FLIMIT_MODE) )
		{
			sprint(self,"TimeLimit / FragLimit (");
			sprint(self, b);
			sprint(self, " / ");
			b = ftos(cvar("fraglimit"));
			sprint(self, b);
			sprint(self, ")\n");
		}
		else if ( !(cvar("samelevel") & TLIMIT_MODE) && (cvar("samelevel") & FLIMIT_MODE) )
		{
			sprint(self,"FragLimit ONLY (");
			b = ftos(cvar("fraglimit"));
			sprint(self, b);		  
			sprint(self, ")\n");
		}
	}
	sprint(self,"Item Dropping is ");
	if (cvar("samelevel") & TEAM_DROP_ITEMS) sprint(self,"on\n");    
	else sprint(self,"off\n");
	sprint(self,"Team Protect is ");
	if ((cvar("samelevel") & TEAM_HEALTH_PROTECT) && (cvar("samelevel") & TEAM_ARMOR_PROTECT))
		sprint(self,"full\n");
	else if (cvar("samelevel") & TEAM_HEALTH_PROTECT)
		sprint(self,"health\n");
	else if (cvar("samelevel") & TEAM_ARMOR_PROTECT)
		sprint(self,"armor\n");
	else sprint(self,"none\n");
	if (LOCK_LEVEL)
		sprint(self,"Level Locked\n");
	if (cvar("samelevel") & CLANRING_MODE) {

		if (cvar("samelevel") & TLIMIT_MODE) {
			sprint(self,"Timelimit is ");
			b = ftos(TIMER_MATCH);
			sprint(self,b);
			sprint(self,"\n");
		}
		if (cvar("samelevel") & FLIMIT_MODE) {
			sprint(self,"Fraglimit is ");
			b = ftos(cvar("fraglimit"));
			sprint(self,b);
			sprint(self,"\n");
		}
		sprint(self,"Lockout is ");
		if (LOCKOUT == 1)
			sprint(self,"on\n");
		else
			sprint(self,"off\n");


		sprint(self,"Lockmax is ");
		if (LOCK_NUM != 0)
		{
			b = ftos(LOCK_NUM);
			sprint(self,b);
			sprint(self,"\n");
		}
		else sprint(self,"off\n");
	}
	else
	{
		if (cvar("timelimit") != 0) {
			sprint(self,"Timelimit is ");
			b = ftos(cvar("timelimit"));
			sprint(self,b);
			sprint(self,"\n");
		}
		if (cvar("fraglimit") != 0) {
			sprint(self,"Fraglimit is ");
			b = ftos(cvar("fraglimit"));
			sprint(self,b);
			sprint(self,"\n");
		}

	}
};

/*
==========
DMToggle
==========
*/
void() DMToggle =
{
	bprint("Deathmatch is now ");
	if (cvar("deathmatch") == 1)
	{
		bprint(" 2\n");
		localcmd("deathmatch 2\n");
	}
	else if (cvar("deathmatch") == 2)
	{
		bprint(" 3\n");
		localcmd("deathmatch 3\n");
	}
	else
	{
		bprint(" 1\n");
		localcmd("deathmatch 1\n"); 
	}
	bprint("Restarting level with new settings...\n");
	changelevel(mapname);
};

/*
==========
ProtectToggle
==========
*/
void() ProtectToggle =
{
	local float newteamplay;
	local string temp_string;
	bprint("Team Protect is now ");
	if ((cvar("samelevel") & TEAM_HEALTH_PROTECT) && (cvar("samelevel") & TEAM_ARMOR_PROTECT))
	{
		newteamplay = cvar("samelevel") - TEAM_HEALTH_PROTECT - TEAM_ARMOR_PROTECT;

		bprint("none -- WARNING NOT IMPLEMENTED YET DO NOT USE THIS!\n");

		temp_string = ftos(newteamplay);
		localcmd("samelevel ");
		localcmd(temp_string);
		localcmd("\n");
	}
	else if (cvar("samelevel") & TEAM_HEALTH_PROTECT)
	{
		newteamplay = cvar("samelevel") | TEAM_ARMOR_PROTECT;
		bprint("full\n");
		temp_string = ftos(newteamplay);
		localcmd("samelevel ");
		localcmd(temp_string);
		localcmd("\n");
	}
	else
	{
		newteamplay = cvar("samelevel") | TEAM_HEALTH_PROTECT;
		newteamplay = newteamplay - (newteamplay & TEAM_ARMOR_PROTECT);
		bprint("health\n");
		temp_string = ftos(newteamplay);
		localcmd("samelevel ");
		localcmd(temp_string);
		localcmd("\n");
	}
};

/*
==========
ItemDropToggle
==========
*/
void() ItemDropToggle =
{
	local float newteamplay;
	local string temp_string;
	bprint("Item Dropping is now ");
	if (cvar("samelevel") & TEAM_DROP_ITEMS)
	{
		newteamplay = cvar("samelevel") - (cvar("samelevel") & TEAM_DROP_ITEMS);
		bprint("off\n");
		temp_string = ftos(newteamplay);
		localcmd("samelevel ");
		localcmd(temp_string);
		localcmd("\n");
	}
	else
	{
		newteamplay = cvar("samelevel") | TEAM_DROP_ITEMS;
		bprint("on\n");
		temp_string = ftos(newteamplay);
		localcmd("samelevel ");
		localcmd(temp_string);
		localcmd("\n");
	}
};

/*
==========
StaticTmToggle
==========
*/
void() StaticTmToggle =
{
	local float newteamplay;
	local string temp_string;
	bprint("Static Teams (skirmish) is now ");
	if (cvar("samelevel") & TEAM_STATIC_TEAMS)
	{
		newteamplay = cvar("samelevel") - (cvar("samelevel") & TEAM_STATIC_TEAMS);
	    	bprint("off\n");
		temp_string = ftos(newteamplay);
	    	localcmd("samelevel ");
		localcmd(temp_string);
		localcmd("\n");
	}
	else
	  {
		newteamplay = cvar("samelevel") | TEAM_STATIC_TEAMS;
	    	bprint("on\n");
		temp_string = ftos(newteamplay);
	    	localcmd("samelevel ");
		localcmd(temp_string);
		localcmd("\n");
	}
};

/*
==========
ModeToggle
==========
*/
void() ModeToggle =
{
	local float newteamplay;
	local string temp_string;
	bprint("Mode is now ");
	if (cvar("samelevel") & CLANRING_MODE)
	{

		if (timer_exist == 1)
			TimerOff();

		newteamplay = cvar("samelevel") - (cvar("samelevel") & CLANRING_MODE);
		bprint("skirmish\n");
		temp_string = ftos(newteamplay);
		localcmd("samelevel ");
		localcmd(temp_string);
		localcmd("\n");
	}
	else
	{
		newteamplay = cvar("samelevel") | CLANRING_MODE;
		newteamplay = newteamplay | TLIMIT_MODE;
		bprint("clanring\n");
		temp_string = ftos(newteamplay);
	 	localcmd("samelevel ");
		localcmd(temp_string);
		localcmd("\n");
	}
	bprint("Restarting level with new settings...\n");
	changelevel(mapname); 
};

/*
==========
Lockout
==========
*/
void() Lockout =
{
	sprint(self,"Lockout is now ");
	if (LOCKOUT == 1)
	{
		sprint(self," off\n");
		LOCKOUT = 0;
	  }
	else
	{
		sprint(self," on\n");
		LOCKOUT = 1;
	}
};

/*
==========
Toggle_StatDump
==========
*/
void() Toggle_StatDump =
{
	sprint(self,"Stat Dump is now ");
	if (self.stat_dump == 1)
	{
		sprint(self," off\n");
		self.stat_dump = 0;
	  }
	else
	{
		sprint(self," off\n");
		self.stat_dump = 0;
	}
};

/*
==========
Lock_Max
==========
*/
void() Lock_max =
{
	local string b;
	sprint(self,"Lock_Max is now ");
	if (LOCK_NUM < 2)
	{
		sprint(self," 2\n");
		LOCK_NUM = 2;
	} else
	if (LOCK_NUM > 8)
	{
		sprint(self," off\n");
		LOCK_NUM = 0;
	} 
	else
	{
		LOCK_NUM = LOCK_NUM + 1;
		sprint(self," ");
		b = ftos(LOCK_NUM);
		sprint(self,b);
		sprint(self,"\n");
	}
};

/*
==========
AdminListPlayers
==========
*/
void () AdminListPlayers =
{
	local entity p;
	local float n;
	local string st;

	p = find(world, classname, "player");
	n = 1;
	while (p != world) {
		st = ftos(n);
		if (n < 10)
			sprint(self, " ");
		sprint(self, st);
		sprint(self, " ");
		sprint(self, p.netname);
		sprint(self, "\n");
		p = find(p, classname, "player");
		n = n + 1;
	} 
	self.admin_last_impulse = ADMIN_LIST_PLAYERS;	
};
	 

/*
==========
DoKick
==========
*/
void(float n) DoKick =
{
	local entity p;
	local string st;
        local string number_s;

	n = n - 1;
	p = find(world, classname, "player");
	while (p != world && n > 0) {
		p = find(p, classname, "player");
		n = n - 1;
	}
	if (p != world) {
		sprint(p, "\n\nYou have been kicked.\n");
                localcmd("kick # ");
                number_s = ftos(p.colormap);
                localcmd(number_s);
                localcmd("\n");
		stuffcmd(p, "disconnect\n");
		bprint(p.netname);
		bprint(" was kicked by ");
		bprint(self.netname);
		bprint("\n");
	} else {
		sprint(self, "Can't kick #");
		st = ftos(self.impulse);
		sprint(self, st);
		sprint(self, "\n");
	}
	self.admin_last_impulse = 0;
	};

/*
==========
AdminKick
==========
*/
void (float n) AdminKick =
{
	if (self.admin_last_impulse != ADMIN_KICK) {
	sprint(self, "Kick Whom?\n");	
		AdminListPlayers();	  
		self.admin_last_impulse = ADMIN_KICK;
		return;
	}
	DoKick(n);
};

/*
==========
Ready
==========
*/
void() Ready =
{
	local string player_color_string, ghostcode_string;
	local float player_color, number_in_clan, new_clan_number, number_of_clans;
	local entity ghost,clan;
	local string temp_string;
	local float force_spawn, clan_exist;
	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}

	if((!cvar("samelevel") & CLANRING_MODE) && (!self.quaketv& QTV_OBSERVER)) return;
	self.seen_motd = self.seen_motd | 1;
	if (!cvar("samelevel") & CLANRING_MODE) {
		self.movetype = MOVETYPE_NONE;
		ClearObserverFlags();

		if (self.team == 0) {
			self.lastteam = -1;
		}


		respawn();
		return;
	}
	 
	if ((LOCKOUT) && (matchgoing))
	{
		sprint(self,"Lockout currently enabled\n");
		return;
	} else
		player_color = self.team - 1;

	if ((player_color != 4) && (player_color != 13))
	{
		sprint(self,"Error!  Invalid Color!\n");
		return;
	} else

	if (self.clan_number)
	{
		sprint(self,"You have already committed\n");
		sprint(self,"Type ŒÔÙÚÂ·‰˘ at console to uncommit or switch teams\n");
		return;
	} else
	if(player_color == 4)
	{
		number_in_clan = Count_Players(1);
		if (LOCK_NUM && number_in_clan >= LOCK_NUM)
		{

			sprint(self,"“≈ƒ team already at full strength\n");
			return;

		}
		player_number = player_number + 1;
		self.ghostcode = 100 + player_number;
		self.clan_number = 1;
		self.pant_color = player_color;
		self.skin = 1;
		self.killed = 0;
		if (self.quaketv & QTV_OBSERVER) 
		{
			self.quaketv = self.quaketv - (self.quaketv & QTV_OBSERVER);
			ClearObserverFlags();
			force_spawn = 1;
		}
		clan = find(world,classname,"clan");
		while(clan != world)
		{
			if ((clan.pant_color == 4)  && (!clan.not_exist)) clan_exist = 1;
			clan = find(clan,classname,"clan");
		}
		if (!clan_exist)
		{
			clan = spawn ();
			clan.owner = world;
			clan.classname = "clan";
			clan.clan_number = self.clan_number;
			clan.pant_color = player_color;

			bprint("“≈ƒ team created\n");

		}
	}
	if(player_color == 13)
	{
		number_in_clan = Count_Players(2);
		if (LOCK_NUM && number_in_clan >= LOCK_NUM)
		{

			sprint(self,"¬Ã’≈ team already at full strength\n");

			return;
		}
		player_number = player_number + 1;
		self.ghostcode = 200 + player_number;
		self.clan_number = 2;
		self.skin = 3;
		self.killed = 0;
		self.pant_color = player_color;
		if (self.quaketv & QTV_OBSERVER) {
			self.quaketv = self.quaketv - (self.quaketv & QTV_OBSERVER);
			ClearObserverFlags();
			force_spawn = 1;
		}
		clan = find(world,classname,"clan");
		while(clan != world)
		{
			if ((clan.pant_color == 13) && (!clan.not_exist)) clan_exist = 1;
			clan = find(clan,classname,"clan");
		}
		if (!clan_exist)
		{
			clan = spawn ();
			clan.owner = world;
			clan.classname = "clan";
			clan.clan_number = self.clan_number;
			clan.pant_color = player_color;

			bprint("¬Ã’≈ team created\n");

		}
	}
	if (self.clan_number)
	{
	  
		ghostcode_string = ftos(self.ghostcode);
		sprint(self,"Your ghost id code is ");
		sprint(self,ghostcode_string);
		sprint(self,"\n");
		bprint(self.netname);
		bprint(" set to ");

		if (self.clan_number == 1)
			bprint("“≈ƒ team ");
		else
			bprint("¬Ã’≈ team ");

		bprint("\n");
		self.lastteam = self.team;
		MakeGhost(self);
	}
	Check_Players();
	if ((self.clan_number) && ((self.deadflag)|| (force_spawn)))
	{
		self.movetype = MOVETYPE_NONE;
		respawn();
	}
};

/*
==========
NotReady
==========
*/
void() NotReady =
{
	local entity e;

	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}

	if (matchgoing)
	{
		MakeObserverMode();
		sprint(self,"You have left the match.\n");
		return;
	}
	if (!self.clan_number)
	{
		sprint(self,"You have not committed yet\n");
		sprint(self,"Type Ready at console to commit\n");
		return;
	}
	self.clan_number = 0;
	e = find(world,classname,"ghost");
	while (e != world)
	{
		if (e.ghostcode == self.ghostcode)
		{
			e.nextthink = time + 1;
	    		e.think = SUB_Remove;
		}
		e = find(e,classname,"ghost");
		self.ghostcode = 0;
	}
	bprint(self.netname);
	bprint(" is no longer in a clan\n");

	Check_Players();

};

/*
==========
TimeDown
==========
*/
void() TimeDown =
{
	local string s;
	local entity e;


	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}

	if (timer_exist != 1)
	{
		sprint(self,"Timer not active\n");
		return;
	}

	e = find(e,classname,"timer");
	if (e.cnt < e.items )
	{
		e.cnt = e.cnt + 1;
		s = ftos(e.items - e.cnt);
		bprint("Time decreased to ");
		bprint(s);
		bprint(" minutes and \n");
		s = ftos(e.cnt2);
		bprint(s);
		bprint(" seconds.\n");
//		localcmd("serverinfo timeleft ");
//		localcmd(s);
//		localcmd("\n");
	} else
		bprint("Timer cannot go any lower\n");
};

/*
==========
TimeUp
==========
*/
void() TimeUp =
{
	local string s;
	local entity e;


	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}

	if (timer_exist != 1)
	{
		sprint(self,"Timer not active\n");
		return;
	}
	e = find(e,classname,"timer");
	e.cnt = e.cnt - 1;

	s = ftos(e.items - e.cnt);
	bprint("Time increased to ");
	bprint(s);
	bprint(" minutes and \n");
	s = ftos(e.cnt2);
	bprint(s);
	bprint(" seconds.\n");
//	localcmd("serverinfo timeleft ");
//	localcmd(s);
//	localcmd("\n");
};

/*
==========
TimerOff/Matchend
==========
*/
void() TimerOff =
{
	local entity e;
	if (matchgoing == 1)
	{
		MatchEnd();
		return;
	}
	e = find(e,classname,"timer");
	e.nextthink = time + 1;
	e.think = SUB_Remove;
	observerless_mode = 0;
	timer_exist = 0;
	matchgoing = 0;
};

/*
==========
Clear Frags
==========
*/
void() ClearFrags =
{
	local entity e;

	e = find(world,classname,"player");
	while (e)
	{
		e.frags = 0;
		e.killed = 0;
		e = find(e,classname,"player");	  
	}
	bprint("All frags reset to 0\n");
};


/*
=========
DumpScore
=========
*/
void() DumpScore =
{
	local entity p, e;
	local float score1;
	local float score2;
	local string b;
	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}

        score1 = score2 = 0;
        if (cvar("samelevel") & CLANRING_MODE) {
		e = find(world,classname,"timer");
		b = ftos(e.items - e.cnt);
		sprint(self,"Time Remaining: ");
		sprint(self,b);
		sprint(self,"m ");
		b = ftos(e.cnt2);
		sprint(self, b);
		sprint(self, "s\n");
                p = find(world, classname, "clan");
                while (p != world) {
                        if (p.clan_number == 1)
                                score1 = p.frags;
                        else if (p.clan_number == 2)
                                score2 = p.frags;
                        p = find(p, classname, "clan");
                }
        }
        else {
                p = find(world, classname, "player");
                while (p != world) {
                        if (p.lastteam == TEAM_COLOR1 + 1)
                                score1 = score1 + p.frags;
                        else if (p.lastteam == TEAM_COLOR2 + 1)
                                score2 = score2 + p.frags;
                        p = find(p, classname, "player");
                }
        }
	bprint("“≈ƒ team Score is ");
	b = ftos(score1);
	bprint(b);
	bprint("\n");
	bprint( "¬Ã’≈ team Score is ");
	b = ftos(score2);
	bprint(b);
	bprint("\n");
};

void(entity c) DumpScoreToClient =
{
	local entity p, e;	  
	local float score1;
	local float score2;
	local string b;


	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}

        score1 = score2 = 0;
        if (cvar("samelevel") & CLANRING_MODE) {
		e = find(world,classname,"timer");
		b = ftos(e.items - e.cnt);
		sprint(self,"Time Remaining: ");
		sprint(self,b);
		sprint(self,"m ");
		b = ftos(e.cnt2);
		sprint(self,b);
		sprint(self,"s\n");
                p = find(world, classname, "clan");
                while (p != world) {
                        if (p.clan_number == 1)
                                score1 = p.frags;
                        else if (p.clan_number == 2)
                                score2 = p.frags;
                        p = find(p, classname, "clan");
                }
        }
        else {
                p = find(world, classname, "player");
                while (p != world) {
                        if (p.lastteam == TEAM_COLOR1 + 1)
                                score1 = score1 + p.frags;
                        else if (p.lastteam == TEAM_COLOR2 + 1)
                                score2 = score2 + p.frags;
                        p = find(p, classname, "player");
                }
        }
	sprint(c, "“≈ƒ team Score is ");
	b = ftos(score1);
	sprint(c,b);
	sprint(c,"\n");
	sprint(c, "¬Ã’≈ team Score is ");
	b = ftos(score2);
	sprint(c,b);
	sprint(c,"\n");
};



/*
==========
AIMSET
==========
*/
void() AimSet =
{
	  sprint(self,"sv_aim is now ");
	  if (cvar("sv_aim") == 0.93)
	  {
		    sprint(self,"2\n");
		    cvar_set("sv_aim","2");
	  }
	  else
	  {
		    sprint(self,"0.93\n");
		    cvar_set("sv_aim","0.93");
	  }
};

/*
=========
RUNSET
=========
*/
void() RunSet =
{
local float runset;
local string temp_string;

	if (self.input_point == 0) {
		self.temp_f = 0;
		runset = cvar("sv_maxspeed");
		temp_string = ftos(runset);
		sprint(self, "Default Runspeed: 320\nCurrent RunSpeed: ");
		sprint(self, temp_string);		
		sprint(self, "\nEnter 1st of 3 digits for new speed\n");
		self.input_point = 1;
		self.admin_last_impulse = 184;
	} else 
	if (self.input_point == 1) {
		sprint(self, "Enter 2nd of 3 digits for new speed\n");
		self.temp_f = (self.impulse * 100);
		self.input_point = 2;
	} else
	if (self.input_point == 2) {
		sprint(self, "Enter 3rd of 3 digits for new speed\n");
		self.temp_f = (self.temp_f + (self.impulse * 10));
		self.input_point = 3;
	} else
	if (self.input_point == 3) {
		self.temp_f = (self.temp_f + (self.impulse));
		self.input_point = 0;
		temp_string = ftos(self.temp_f);
		cvar_set("sv_maxspeed",temp_string);
		bprint("RunSpeed changed to ");
		bprint(temp_string);
		bprint("\n");
		self.temp_f = 0; 
		self.admin_last_impulse = 0;
	}  
};

/*
=========
REDTEAM  
=========
*/
void() Red =
{

	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}

	stuffcmd(self, "color 4\n");
	stuffcmd(self, "impulse 40\n");
};

/*
==========
BLUETEAM 
==========
*/
void() Blue =
{

	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}
	stuffcmd(self, "color 13\n");
	stuffcmd(self, "impulse 40\n");
};

/*
==========
WARPLIST 
==========
*/
void()Warplist =
{
		sprint(self, "\n");
		sprint(self, "\n");
		sprint(self, "\n");
		sprint(self, "	  ≈ÈÛÔ‰Â ◊·Ú ÃÈÛÙ\n");
		sprint(self, "≈ÈÛÔ‰Â   Dimension of the Doomed\n");	
		sprint(self, "≈ÈÛÔ‰Â   Realm of Black Magic\n");
		sprint(self, "≈ÈÛÔ‰Â   The Netherworld\n");
		sprint(self, "≈ÈÛÔ‰Â   The Elder World\n");
		sprint(self, "≈ÈÛÔ‰Â   The Deathmatch Arenas\n");
		sprint(self, "≈ÈÛÔ‰Â   Start Map\n");
		sprint(self, "≈ÈÛÔ‰Â   Threewave Levels - One\n");
	      	sprint(self, "≈ÈÛÔ‰Â   Threewave Levels - Two\n");
		if (EXPANDED_MAPS >= 1) {
			sprint(self, "≈ÈÛÔ‰Â   Expansion Levels\n");
			if (EXPANDED_MAPS == 2) {
				sprint(self, "≈ÈÛÔ‰Â  Thunderwalker Levels - One\n");
				sprint(self, "≈ÈÛÔ‰Â  Thunderwalker Levels - Two\n");
				sprint(self, "≈ÈÛÔ‰Â  Xeno Levels\n");
				sprint(self, "≈ÈÛÔ‰Â  Custom Levels\n");
			}
			else {
				sprint(self, "≈ÈÛÔ‰Â  Custom Levels\n");
			}
		}
		else {
			sprint(self, "≈ÈÛÔ‰Â   Custom Levels\n");
		}
};

/*
==========
MatchSetCycle
==========
*/

void () MatchSetCycle = 
{
	local string temp_string;
	local float temp_float;
	temp_float = cvar("samelevel");
	if (temp_float & CLANRING_MODE) {
		if ((temp_float & TLIMIT_MODE) && !(temp_float & FLIMIT_MODE)) {
			if (cvar("fraglimit") <= 0.0) {
				cvar_set("fraglimit", "100");
				bprint("Fraglimit set to 100\n");
				sprint(self, "Admin: Use Flimit to change\n");
			}
			temp_float=temp_float + FLIMIT_MODE;
			bprint("MatchSet is now Time/Fraglimit\n");
			temp_string = ftos(temp_float);
			cvar_set("samelevel", temp_string);
		}
		else if ((temp_float & TLIMIT_MODE) && (temp_float & FLIMIT_MODE)) {
			if (cvar("fraglimit") <= 0.0) {
				cvar_set("fraglimit", "100");
				bprint("Fraglimit set to 100\n");
				sprint(self, "Admin: Use Flimit to change\n");
			}
			temp_float=temp_float - TLIMIT_MODE;
			bprint("MatchSet is now Fraglimit ONLY\n");
			temp_string = ftos(temp_float);
			cvar_set("samelevel", temp_string);
		}
		else if ( !(temp_float & TLIMIT_MODE) && (temp_float & FLIMIT_MODE)) {
			temp_float=temp_float + TLIMIT_MODE - FLIMIT_MODE;
			bprint("MatchSet is now Timelimit ONLY\n");
			temp_string = ftos(temp_float);
			cvar_set("samelevel", temp_string);
		} 
		else if ( !(temp_float & TLIMIT_MODE) && !(temp_float & FLIMIT_MODE)) {
			temp_float=temp_float + TLIMIT_MODE;
			bprint("MatchSet is now Timelimit ONLY\n");
			temp_string = ftos(temp_float);
			cvar_set("samelevel", temp_string);
		}
	} // End if Clanring mode
};

/*
==================
ClearObserverFlags
==================
*/
void() ClearObserverFlags =
{
	self.quaketv = 0;
};

/*
==========
AdminCommands
==========
*/
void() AdminCommands =
{
	local entity e;

	if (self.impulse == 150) AimSet(); else
	if (self.impulse == 233) Red(); else
	if (self.impulse == 234) Blue(); else
	if (self.impulse == 235) Warplist(); else	
	if (self.impulse == 184) RunSet(); else
	if (self.impulse == 147) ProtectToggle(); else
	if (self.impulse == 148) ItemDropToggle(); else
	if (self.impulse == 149) ModeToggle(); else
	if (self.impulse == 151) StaticTmToggle(); else
	if (self.impulse == 181) DMToggle(); else
	if (self.impulse == 142) TimelimitChange(); else
	if (self.impulse == 144)  FraglimitChange(); else
	if (self.impulse == 85) {	// Admin Kick routine
		self.admin_last_impulse = 0;
		AdminKick(self.impulse);
	} else
	if (self.admin_last_impulse) {	// To allow for other admin functions in future
		if (self.admin_last_impulse == ADMIN_KICK) {
			if ((self.impulse < 1.0) || (self.impulse > 16.0))
				sprint(self, "Number out of range... try again.\n");
			else
				DoKick(self.impulse);
			self.impulse = 0;
			return;
		}

		if (self.admin_last_impulse == 142) {  //setTimelimit
			if (self.impulse == 10) self.impulse = 0;  // Why do we change this to 10 anyway?
			if ((self.impulse < 0) || (self.impulse > 9))
				sprint(self, "Number out of range... try again.\n");
			else
				TimelimitChange();
			self.impulse = 0;
			return;
		}

		if (self.admin_last_impulse == 144) {  //setFraglimit
			if (self.impulse == 10) self.impulse = 0;
			if ((self.impulse < 0) || (self.impulse > 9))
				sprint(self, "Number out of range... try again.\n");
			else
				FraglimitChange();
			self.impulse = 0;
			return;
		}

		if (self.admin_last_impulse == 184) {	//RunSet
			if (self.impulse == 10) self.impulse = 0;
			if ((self.impulse <0) || (self.impulse >9))
				sprint(self, "Number out of range... try again.\n");
			else
				RunSet();
			self.impulse = 0;
			return;
		}

	} else 				// (if self.admin_last_impulse != 0)
	if (self.impulse == 99) Commands_Admin(); else
	if ((self.impulse == 170) && (!self.quaketv & QTV_CAMERA)) MakeCamera(); else
	if ((self.impulse == 172) && (self.quaketv & QTV_CAMERA)) RemoveCamera(); else
	if (self.impulse == 134) TimelimitChange(); else
	if (self.impulse == 200) DumpScore(); else
	if (!cvar("samelevel") & CLANRING_MODE)
	{
		if (self.impulse == 133) NextLevel();
		return;
	}
	else
	if (self.impulse == 45) Timer_Pause(); else
	if (self.impulse == 46) Lockout(); else
	if (self.impulse == 47) Lock_max(); else

	if (self.impulse == 130)
	{
		if (timer_exist == 1) bprint("Timer already active\n"); else
		{
			observerless_mode = 0;
			TIMER_RALLY = 1; //SO 2.8b changed from 10 minutes (what were we thinking?)
			bprint("Timer started\n");
			GameTimer();
		}
	} else
	if (self.impulse == 133)
	{
		if (timer_exist == 0) bprint("Timer not active\n"); else
		{
			observerless_mode = 0;
			bprint("Timer stopped\n");
			TimerOff();
		}
	} else

	if (self.impulse == 131) TimeUp(); else
	if (self.impulse == 132) TimeDown(); else
	if (self.impulse == 135) MatchSetCycle(); else
	if (self.impulse == 76) DumpScoreToClient(self); else
	if (self.impulse == 161)
	{
		e = find(world,classname,"clan");
		while (e != world)
		{
			e.nextthink = time + 1;
			e.think = SUB_Remove;
			e = find(e,classname,"clan");
		}
		e = find(world,classname,"player");
		while (e != world)
		{
			e.clan_number = 0;
			e = find(e,classname,"player");
		}
		bprint("All clan data cleared");
	} else
	if (self.impulse == 52)
	{
		bprint("Restarting Server...\n");
		changelevel(mapname);
		localcmd("changelevel ");
		localcmd(mapname);
		localcmd("\n");

      } else
	if (self.impulse == 53)
		{ QuadToggle(); self.impulse = 0; }
	else if (self.impulse == 54)
		{ PentToggle(); self.impulse = 0; }
	else if (self.impulse == 55)
		{ EyesToggle(); self.impulse = 0; }
	else if (self.impulse == 56)
		{ RunesToggle(); self.impulse = 0; }
};
