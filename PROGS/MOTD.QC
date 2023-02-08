/*
================
MOTDShow
Display the MOTD.
================
*/


// JKB changed from 2.2l
void() MOTDShow =
{
	local string s;
	local string s1;
	local string s2;
// JKB changed from 2.2i+
	local float showit;
// JKB end 2.2i+

	if (self.motd == 5) {
		Run_Binding_Check();
		if (!BotSpawned)
			NameBotSpawn(); // spawn entity for banning null string
	}
// JKB changed from 2.2i+
	else if (self.motd == 4) {
// JKB end 2.2i+
		if (self.quaketv & QTV_ADMIN)
			Commands_Admin();
		else
			Commands_Player();
		sprint(self,"\n");
		if (self.clan_number)
		{
			s = ftos(self.ghostcode);
			sprint(self,"Your ghost id code is ");
			sprint(self,s);
			sprint(self,"\n");
		}
		sprint(self,"\n");
		sprint(self,"Mode is ");
		if (crmode) sprint(self,"Clanring\n");
		else sprint(self,"Skirmish\n");
		// JKB add
		if ((samelevel & (TEAM_STATIC_TEAMS | CLANRING_MODE)) == TEAM_STATIC_TEAMS) sprint(self,"Static teams\n");
		// JKB end
// JKB changed from 2.2i+
		if (crmode) {
			sprint(self, "MatchSet is ");
			if ( (samelevel & TLIMIT_MODE) && !(samelevel & FLIMIT_MODE) )
				sprint(self,"TimeLimit ONLY\n");
			else if ( (samelevel & TLIMIT_MODE) && (samelevel & FLIMIT_MODE) )
				sprint(self,"TimeLimit AND FragLimit\n");
			else if ( !(samelevel & TLIMIT_MODE) && (samelevel & FLIMIT_MODE) )
				sprint(self,"FragLimit ONLY\n");
		}
		else {
			if ( (cvar("timelimit") != 0) && (cvar("fraglimit") == 0) )
				sprint(self,"TimeLimit ONLY\n");
			else if ( (cvar("timelimit") != 0) && (cvar("fraglimit") != 0) )
				sprint(self,"TimeLimit AND FragLimit\n");
			else if ( (cvar("timelimit") == 0) && (cvar("fraglimit") != 0) )
				sprint(self,"FragLimit ONLY\n");
		}
// JKB end 2.2i+
		sprint(self,"Item Dropping is ");
		if (samelevel & TEAM_DROP_ITEMS) sprint(self,"on\n");	
		else sprint(self,"off\n");
		sprint(self,"Team Protect is ");
		if ((samelevel & TEAM_HEALTH_PROTECT) && (samelevel & TEAM_ARMOR_PROTECT))
		  	sprint(self,"full\n");
		else if (samelevel & TEAM_HEALTH_PROTECT)
			sprint(self,"health\n");
		else if (samelevel & TEAM_ARMOR_PROTECT)
			sprint(self,"armor\n");
		else sprint(self,"none\n");
// JKB changed from 2.2i+
		if(self.flags & FL_NOAUTOWEAPON)
			sprint(self,"AutoWeapon Switching is Disabled\n");
		else if(self.flags & FL_NOTSMARTAUTOWEAPON)
			sprint(self,"AutoWeapon Switching is Enabled\n");
		else
			sprint(self,"SMART AutoWeapon Switching is Enabled\n");
// JKB end 2.2i+
		sprint(self, "Impulses 71-81 set status bar position\n");
		sprint(self, "71:200 72:240 73:300 74:350 75:384 76:400 77:480 78:600 79:768 81:1024\n");
		sprint(self,"Check console for list of commands \n");
	}

// JKB changed from 2.2i+
	showit = 0;
	if ((self.seen_motd & 1) == 0) {
		showit = 1;
	}
	else {
		if ((crmode) && ((self.seen_motd & 2) == 0)) { self.seen_motd = 0; showit = 1; }
		else if ((!crmode) && ((self.seen_motd & 2) != 0)) { self.seen_motd = 0; showit = 1; }
	}
	if (showit) {
		self.seen_motd = self.seen_motd | 2;
		if (self.quaketv & QTV_OBSERVER) {
			if (crmode) {
				centerprint(self,server_greeting_observer_cr);
			}
			else {
				centerprint(self,server_greeting_observer_sk);
				self.seen_motd = self.seen_motd - 2;
			}
		}
		else if ((!crmode) && (self.team == 5)) { centerprint(self,server_greeting_red); self.seen_motd = self.seen_motd - 2;}
		else if ((!crmode) && (self.team == 14)) { centerprint(self,server_greeting_blue); self.seen_motd = self.seen_motd - 2;}
		else centerprint(self,server_greeting_clanring);
			// QSmack mod
                  if (self.motd == 1) {
                          stuffcmd(self,"init;\n");
                                  // Must stuff "init" once, and only once if
                                  // admin privileges persist across level
                                  // changes.  Otherwise we would have to stuff
                                  // it after each level change.
                  }
                  // QSmack mod end
          }

};
/*
================
MOTDCheck

Display the MOTD if needed, and set self.motd to 1.
================
*/
void() MOTDCheck =
{
	if((self.motd) && (self.motd_next < time))
	{
		MOTDShow();
		self.motd = self.motd - 1;
		self.motd_next = self.motd_next + 1;
	}
};
	
/*
================
DoBindings
================
*/
void() DoBindings =
{
        stuffcmd(self,"alias setrunes \"impulse 56\"\n");
	stuffcmd(self,"alias skick \"impulse 85\"\n");
	stuffcmd(self,"alias aimset \"impulse 150\"\n");
	stuffcmd(self,"alias ignorethis \"impulse 240\"\n");
	stuffcmd(self,"alias camera \"impulse 171\"\n");
	stuffcmd(self,"alias ready \"impulse 40\"\n");
	stuffcmd(self,"alias notready \"impulse 41\"\n");
	stuffcmd(self,"alias statdump \"impulse 43\"\n");
	stuffcmd(self,"alias timerstart \"impulse 130\"\n");
	stuffcmd(self,"alias timerstop \"impulse 133\"\n");
	stuffcmd(self,"alias matchset \"impulse 135\"\n");
	stuffcmd(self,"alias makeCam \"impulse 170\"\n");
	stuffcmd(self,"alias removeCam \"impulse 172\"\n");
	stuffcmd(self,"alias autoCam \"impulse 173\"\n");
	stuffcmd(self,"alias commands \"impulse 99\"\n");
	stuffcmd(self,"alias ghostlist \"impulse 160\"\n");
	stuffcmd(self,"alias playerlist \"impulse 90\"\n");
	stuffcmd(self,"alias playerstats \"impulse 91\"\n");
	stuffcmd(self,"alias clanstats \"impulse 82\"\n");
	stuffcmd(self,"alias efficiency \"impulse 84\"\n");
	stuffcmd(self,"alias observer \"impulse 42\"\n");
	stuffcmd(self,"alias clearclans \"impulse 161\"\n");
	stuffcmd(self,"alias showscore \"impulse 200\"\n");
	stuffcmd(self,"alias yes \"impulse 121\"\n");
	stuffcmd(self,"alias no \"impulse 110\"\n");
	stuffcmd(self,"alias score \"impulse 86\"\n");
	stuffcmd(self,"alias warp \"impulse 48\"\n");
	stuffcmd(self,"alias ghost \"impulse 50\"\n");
	stuffcmd(self,"alias admin \"impulse 51\"\n");
	stuffcmd(self,"alias viewrecord \"impulse 44\"\n");
	stuffcmd(self,"alias dmset \"impulse 181\"\n");
	stuffcmd(self,"alias modeset \"impulse 149\"\n");
	stuffcmd(self,"alias dropset \"impulse 148\"\n");
 	stuffcmd(self,"alias statictmset \"impulse 151\"\n");
	stuffcmd(self,"alias protectset \"impulse 147\"\n");
	stuffcmd(self,"alias tlimit \"impulse 142\"\n");
	stuffcmd(self,"alias flimit \"impulse 144\"\n");
	stuffcmd(self,"alias timerpause \"impulse 45\"\n");
	stuffcmd(self,"alias lockout \"impulse 46\"\n");
	stuffcmd(self,"alias lockmax \"impulse 47\"\n");
	stuffcmd(self,"alias modstatus \"impulse 49\"\n");
	stuffcmd(self,"alias modversion \"impulse 253\"\n");
	stuffcmd(self,"alias runset \"impulse 184\"\n");
	stuffcmd(self,"alias identify \"impulse 141\"\n");
	stuffcmd(self,"alias statusbar \"impulse 70\"\n");
	stuffcmd(self,"alias red \"impulse 233\"\n");
 	stuffcmd(self,"alias blue \"impulse 234\"\n");
	stuffcmd(self,"alias warplist \"impulse 235\"\n");
	stuffcmd(self,"alias autoweapon \"impulse 248\"\n");
	stuffcmd(self,"alias aw \"impulse 248\"\n");
	stuffcmd(self,"alias matchend \"impulse 133\"\n");
	stuffcmd(self,"alias chasecam \"impulse 201\"\n");  
	stuffcmd(self,"alias autochase \"impulse 203\"\n");  
	stuffcmd(self,"alias smooth \"impulse 205\"\n"); 
	stuffcmd(self,"alias quaketv \"impulse 207\"\n"); 
	stuffcmd(self,"alias freelook \"impulse 209\"\n"); 
	stuffcmd(self, "alias vkick \"impulse 252\"\n");
	stuffcmd(self,"alias reset \"impulse 52\"\n"); //PB 2.58e3
	stuffcmd(self,"alias setquad \"impulse 53\"\n"); //PB 2.58e3
	stuffcmd(self,"alias setpent \"impulse 54\"\n"); //PB 2.58e3
	stuffcmd(self,"alias seteyes \"impulse 55\"\n"); //PB 2.58e3
	stuffcmd(self,"alias 0 \"impulse 10\"\n");
	stuffcmd(self,"alias 1 \"impulse 1\"\n");
	stuffcmd(self,"alias 2 \"impulse 2\"\n");
	stuffcmd(self,"alias 3 \"impulse 3\"\n");
	stuffcmd(self,"alias 4 \"impulse 4\"\n");
	stuffcmd(self,"alias 5 \"impulse 5\"\n");
	stuffcmd(self,"alias 6 \"impulse 6\"\n");
	stuffcmd(self,"alias 7 \"impulse 7\"\n");
	stuffcmd(self,"alias 8 \"impulse 8\"\n");
	stuffcmd(self,"alias 9 \"impulse 9\"\n");
	stuffcmd(self,"alias 10 \"impulse 10\"\n");
	stuffcmd(self,"alias 11 \"impulse 11\"\n");
	stuffcmd(self,"alias 12 \"impulse 12\"\n");
	stuffcmd(self,"alias 13 \"impulse 13\"\n");
	stuffcmd(self,"alias 14 \"impulse 14\"\n");
	stuffcmd(self,"alias 15 \"impulse 15\"\n");
	stuffcmd(self,"alias 16 \"impulse 16\"\n");
	  
};

