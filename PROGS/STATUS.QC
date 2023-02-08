
.float laststattime;		// time of last status update
//.float motd_count;
//.float statstate;			// is the status bar on?

float teamscr1;			// team 1's teamscr score
float teamscr2;			// team 2's teamscr score
float lastteamscrtime;		// last time we calculated it

float TEAMSCRTIME = 1;
float PLAYERSTATTIME = 1.75;



void() TeamCheck2 =
{
        local entity p;

        if (gamestart)
              return; // handled by vote exit
        //if (lastteamscrtime > time)
        //      return;
        //bprint("test");
        //lastteamscrtime = time + TEAMSCRTIME;

        // count up teamscr
        teamscr1 = teamscr2 = 0;
// JKB changed from 2.2l
        if (crmode) {
// JKB end 2.2l
                p = find(world, classname, "clan");
                while (p != world) {
                        if (p.clan_number == 1)
                                teamscr1 = p.frags;
                        else if (p.clan_number == 2)
                                teamscr2 = p.frags;
                        p = find(p, classname, "clan");
                }
        }
        else {
                p = find(world, classname, "player");
                while (p != world) {
                        if (p.lastteam == TEAM_COLOR1 + 1)
                                teamscr1 = teamscr1 + p.frags;
                        else if (p.lastteam == TEAM_COLOR2 + 1)
                                teamscr2 = teamscr2 + p.frags;
                        p = find(p, classname, "player");
                }
        }
};


void() TeamCaptureResetUpdate =
{
	lastteamscrtime = 0;
	TeamCheck2();
};

void() TeamEndScore = 
{
	local string s;

	if (gamestart)
		return;

	lastteamscrtime = 0;
	TeamCheck2();

	if (teamscr1 > teamscr2) {
		bprint("ÒÅÄ team won the level with ");
		s = ftos(teamscr1);
		bprint(s);
		bprint(" points!\n");
		bprint("ÂÌÕÅ team lost with ");
		s = ftos(teamscr2);
		bprint(s);
		bprint(" points.\n");
	} else if (teamscr1 < teamscr2) {
		bprint("ÂÌÕÅ team won the level with ");
		s = ftos(teamscr2);
		bprint(s);
		bprint(" points!\n");
		bprint("ÒÅÄ team lost with ");
		s = ftos(teamscr1);
		bprint(s);
		bprint(" points.\n");
	} else {
		bprint("ÂÌÕÅ and ÒÅÄ team tied level with ");
		s = ftos(teamscr1);
		bprint(s);
		bprint(" points!\n");
	}
};

string(entity who) TeamSetStatRes =
{
	if (who.statstate > 7) // 768 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 7) // 600 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 6) // 480 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 5) // 400
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 4) // 384 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 3) // 350 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 2) // 300 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 1) // 240 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	// 200 
	return "\n\n\n\n\n\n\n\n\n\n\n\n";
};

string(entity who) TeamSetStatRes2 =
{
	if (who.statstate > 7) // 768 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 7) // 600 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 6) // 480 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 5) // 400
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 4) // 384 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 3) // 350 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 2) // 300 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	else if (who.statstate == 1) // 240 
		return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	// 200 
	return "\n\n\n\n\n\n\n\n\n\n\n";
};

void() TeamCapturePlayerUpdate =
{
	local entity e;
	local string n, t, s1, s2, s3, res;

	if (self.laststattime > time)
		return;

if (self.motd && (!(self.seen_motd & 1))) {
		return;
	}

	TeamCheck2();

	self.laststattime = time + PLAYERSTATTIME;

	//if (self.motd_count) {
	//	if (self.observer)
	//		MOTD_ChooseTeam();
	//	else
	//		MOTD();
	//	return;
	//}

	if (self.statstate < 0)
		return;

	res = TeamSetStatRes(self);

	if (gamestart) {
		if (vote_leader == world)
			centerprint2(self, res, "                    Choose an exit...");
		else {
			res = TeamSetStatRes2();
			n = ftos(voteexit_time - time);
			centerprint5(self, res, vote_leader.message,
				" leads\n", n, " seconds until exit");
		}
		return;
	}

	//.1234567890123456789012345678901234567
	// Res.R.B.             Capture The Flag
	// Res.R.B.                     BLUE 999

	if (self.player_flag & ITEM_RUNE1_FLAG)
		s1 = "Òåóéóô  ";
	else if (self.player_flag & ITEM_RUNE2_FLAG)
		s1 = "Óôòåîçôè";
	else if (self.player_flag & ITEM_RUNE3_FLAG)
		s1 = "Èáóôå   ";
	else if (self.player_flag & ITEM_RUNE4_FLAG)
		s1 = "Òåçåî   ";
	else
		s1 = "        ";
	
	e = find(world, classname, "item_flag_team1");
	if (e.cnt == FLAG_AT_BASE)
		s2 = " ";
	else if (e.cnt == FLAG_CARRIED)
		s2 = "r";
	else
		s2 = "ò";

	e = find(world, classname, "item_flag_team2");
	if (e.cnt == FLAG_AT_BASE)
		s3 = " Ÿ";
	else if (e.cnt == FLAG_CARRIED)
		s3 = "bŸ";
	else
		s3 = "âŸ";
		
	if (teamscr1 == 0 && teamscr2 == 0) {
		centerprint5(self, res, s1, s2, s3, "                         ");		// CTFBOT
		return;
	}
	
	if (time < (last_flag_capture + 6))
	{
		if (last_capture_team == TEAM_COLOR1)
		{
			if (teamscr1 > teamscr2) {
				t = "Æìáç ãáğôõòå¡  ÒÅÄ ";
				n = ftos(teamscr1 - teamscr2);
			} else if (teamscr1 < teamscr2) {
				t = "Æìáç ãáğôõòå¡ ÂÌÕÅ ";
				n = ftos(teamscr2 - teamscr1);
			} else {
				t = "Æìáç ãáğôõòå¡ ÔÉÅÄ ";
				n = "";
			}
		}
		else
		{
			if (teamscr1 > teamscr2) {
				t = "Æìáç ãáğôõòå¡ ÒÅÄ ";
				n = ftos(teamscr1 - teamscr2);
			} else if (teamscr1 < teamscr2) {
				t = "Æìáç ãáğôõòå¡ ÂÌÕÅ ";
				n = ftos(teamscr2 - teamscr1);
			} else {
				t = "Æìáç ãáğôõòå¡ ÔÉÅÄ ";
				n = "";
			}
		}
	}
	else
	{
		if (teamscr1 > teamscr2) {
			     t = "              ÒÅÄ ";
			n = ftos(teamscr1 - teamscr2);
		} else if (teamscr1 < teamscr2) {
			     t = "              ÂÌÕÅ ";
			n = ftos(teamscr2 - teamscr1);
		} else {
			     t = "              ÔÉÅÄ ";
			n = "";
		}
	}
	centerprint7(self, res, s1, s2, s3, "    ", t, n);		//
};

void(entity who, string s) TeamPlayerUpdate =
{
	local string n, res;

if (self.motd && (!(self.seen_motd & 1))) {
		return;
	}

	TeamCheck2();
	who.laststattime = time + PLAYERSTATTIME;

	if (who.statstate < 0) {
		centerprint(who, s);
		return;
	}

	res = TeamSetStatRes2(who);

	if (teamscr1 == 0 && teamscr2 == 0) {
		centerprint3(who, res, s, "\n                                        ");
	} else if (teamscr1 > teamscr2) {
		n = ftos(teamscr1 - teamscr2);
		centerprint4(who, res, s, "\n                                    ÒÅÄ ", n);
	} else if (teamscr1 < teamscr2) {
		n = ftos(teamscr2 - teamscr1);
		centerprint4(who, res, s, "\n                                    ÂÌÕÅ ", n);
	} else
		centerprint3(who, res, s, "\n                                    ÔÉÅÄ");
};

void(entity who, string s1, string s2) TeamPlayerUpdate2 =
{
	local string n, res;

if (self.motd && (!(self.seen_motd & 1))) {
		return;
	}


	TeamCheck2();
	who.laststattime = time + PLAYERSTATTIME;

	if (who.statstate < 0) {
		centerprint2(who, s1, s2);
		return;
	}

	res = TeamSetStatRes2(who);

	if (teamscr1 == 0 && teamscr2 == 0) {
		centerprint4(who, res, s1, s2, "\n                                       ");
		return;
	} else if (teamscr1 > teamscr2) {
		n = ftos(teamscr1 - teamscr2);
		centerprint5(who, res, s1, s2, "\n                                ÒÅÄ ", n);
	} else if (teamscr1 < teamscr2) {
		n = ftos(teamscr2 - teamscr1);
		centerprint5(who, res, s1, s2, "\n                                ÂÌÕÅ ", n);
	} else {
		centerprint4(who, res, s1, s2, "\n                                ÔÉÅÄ");
		return;
	}
};

