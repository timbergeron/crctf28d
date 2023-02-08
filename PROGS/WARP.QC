void() GameTimer;
void() AdminListPlayers;
void() QuadToggle;
void() PentToggle;
void() EyesToggle;
void() RunesToggle;
/*
============
W_WarpEpisode1

============
*/

void() W_WarpEpisode1 =
{
	if (level == 1)
	{
		changelevel ("e1m1");
	}               
	else if (level == 2)
	{
		changelevel ("e1m2");
	}
	else if (level == 3)
	{
		changelevel ("e1m3");
	}
	else if (level == 4)
	{
		changelevel ("e1m4");
	}
	else if (level == 5)
	{
		changelevel ("e1m5");
	}
	else if (level == 6)
	{
		changelevel ("e1m6");
	}
	else if (level == 7)
	{
		changelevel ("e1m7");
	}
	else if (level == 8)
	{
		changelevel ("e1m8");
	}
	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};


/*
============
W_WarpEpisode2

============
*/

void() W_WarpEpisode2 =
{
	if (level == 1)
	{
		changelevel ("e2m1");
	}               
	else if (level == 2)
	{
		changelevel ("e2m2");
	}
	else if (level == 3)
	{
		changelevel ("e2m3");
	}
	else if (level == 4)
	{
		changelevel ("e2m3");
	}
	else if (level == 5)
	{
		changelevel ("e2m5");
	}
	else if (level == 6)
	{
		changelevel ("e2m6");
	}
	else if (level == 7)
	{
		changelevel ("e2m7");
	}
	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};


/*
============
W_WarpEpisode3

============
*/

void() W_WarpEpisode3 =
{
	if (level == 1)
	{
		changelevel ("e3m1");
	}               
	else if (level == 2)
	{
		changelevel ("e3m2");
	}
	else if (level == 3)
	{
		changelevel ("e3m3");
	}
	else if (level == 4)
	{
		changelevel ("e3m4");
	}
	else if (level == 5)
	{
		changelevel ("e3m5");
	}
	else if (level == 6)
	{
		changelevel ("e3m6");
	}
	else if (level == 7)
	{
		changelevel ("e3m7");
	}

	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};


/*
============
W_WarpEpisode4

============
*/

void() W_WarpEpisode4 =
{
	if (level == 1)
	{
		changelevel("e4m1");
	}               
	else if (level == 2)
	{
		changelevel("e4m2");
	}
	else if (level == 3)
	{
		changelevel ("e4m3");
	}
	else if (level == 4)
	{
		changelevel ("e4m4");
	}
	else if (level == 5)
	{
		changelevel ("e4m5");
	}
	else if (level == 6)
	{
		changelevel ("e4m6");
	}
	else if (level == 7)
	{
		changelevel("e4m7");
	}
	else if (level == 8)
	{
		changelevel("e4m8");
	}
	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};


/*
============
W_WarpDeath

============
*/

void() W_WarpDeath =
{
	if (level == 1)
	{
		changelevel ("dm1");
	}               
	else if (level == 2)
	{
		changelevel ("dm2");
	}
	else if (level == 3)
	{
		changelevel ("dm3");
	}
	else if (level == 4)
	{
		changelevel ("dm4");
	}
	else if (level == 5)
	{
		changelevel ("dm5");
	}
	else if (level == 6)
	{
		changelevel ("dm6");
	}

	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};

/*
============
W_WarpCTF

============
*/

void() W_WarpCTF =
{
	if (level == 1)
	{
		changelevel("ctf1");
	}               
	else if (level == 2)
	{
		changelevel("ctf2");
	}
	else if (level == 3)
	{
		changelevel("ctf3");
	}
	else if (level == 4)
	{
		changelevel("ctf4");
	}
	else if (level == 5)
	{
		changelevel("ctf5");
	}
	else if (level == 6)
	{
		changelevel ("ctf6");
	}
	else if (level == 7)
	{
		changelevel ("ctf7");
	}
	else if (level == 8)
	{
		changelevel ("ctf8");
	}
	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};

/*
============
W_WarpCTFEpisode2

============
*/

void() W_WarpCTFEpisode2 =
{
	if (level == 1)
	{
		changelevel("ctf2m1");
	}               
	else if (level == 2)
	{
		changelevel("ctf2m2");
	}
	else if (level == 3)
	{
		changelevel("ctf2m3");
	}
	else if (level == 4)
	{
		changelevel("ctf2m4");
	}
	else if (level == 5)
	{
		changelevel("ctf2m5");
	}
	else if (level == 6)
	{
		changelevel ("ctf2m6");
	}
	else if (level == 7)
	{
		changelevel ("ctf2m7");
	}
	else if (level == 8)
	{
		changelevel ("ctf2m8");
	}
	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};

/*
============
W_WarpExpansion

============
*/

void() W_WarpExpansion =
{
	if (level == 1)
	{
		changelevel("ctf1bsp1");
	}               
	else if (level == 2)
	{
		changelevel ("ctf1bsp2");
	}
	else if (level == 3)
	{
		changelevel ("ctf1bsp3");
	}
	else if (level == 4)
	{
		changelevel ("ctf1bsp4");
	}
	else if (level == 5)
	{
		changelevel ("ctf1bsp5");
	}
	else if (level == 6)
	{
		changelevel ("ctf1bsp6");
	}
	else if (level == 7)
	{
		changelevel ("ctf1bsp7");
	}
	else if (level == 8)
	{
		changelevel ("ctf1bsp8");
	}
	else if (level == 9)
	{
		changelevel ("ctf1bsp9");
	}
	else if (level == 10)
	{
		changelevel ("ctf1bsp0");
	}
	else if (level == 11)
	{
		changelevel ("ctf1bspx");
	}
	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};

/*
============
W_WarpTW

============
*/

void() W_WarpTW =
{
	if (level == 1)
	{
		changelevel("twctf1");
	}               
	else if (level == 2)
	{
		changelevel ("twctf2");
	}
	else if (level == 3)
	{
		changelevel ("twctf3");
	}
	else if (level == 4)
	{
		changelevel ("twctf4");
	}
	else if (level == 5)
	{
		changelevel ("twctf5");
	}
	else if (level == 6)
	{
		changelevel ("twctf6");
	}
	else if (level == 7)
	{
		changelevel ("twctf7");
	}
	else if (level == 8)
	{
		changelevel ("twctf8");
	}
	else if (level == 9)
	{
		changelevel ("twctf9");
	}
	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};

/*
============
W_WarpTWEpisode2

============
*/

void() W_WarpTWEpisode2 =
{
	if (level == 1)
	{
		changelevel("twctf2m1");
	}               
	else if (level == 2)
	{
		changelevel ("twctf2m2");
	}
	else if (level == 3)
	{
		changelevel ("twctf2m3");
	}
	else if (level == 4)
	{
		changelevel ("twctf2m4");
	}
	else if (level == 5)
	{
		changelevel ("twctf2m5");
	}
	else if (level == 6)
	{
		changelevel ("twctf2m6");
	}
	else if (level == 7)
	{
		changelevel ("twctf2m7");
	}
	else if (level == 8)
	{
		changelevel ("twctf2m8");
	}
	else if (level == 9)
	{
		changelevel ("twctf2m9");
	}
	else if (level == 10)
	{
		changelevel ("twctf2ma");
	}
	else if (level == 11)
	{
		changelevel ("twctf2mb");
	}
	else if (level == 12)
	{
		changelevel ("twctf2mc");
	}
	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};

/*
============
W_WarpXeno

============
*/

void() W_WarpXeno =
{
	if (level == 1)
	{
		changelevel("xeno1");
	}               
	else if (level == 2)
	{
		changelevel ("xeno2");
	}
	else if (level == 3)
	{
		changelevel ("xeno3");
	}
	else if (level == 4)
	{
		changelevel ("xeno4");
	}
	else if (level == 5)
	{
		changelevel ("expctf1");
	}
	else if (level == 6)
	{
		changelevel ("xeno6");
	}
	else if (level == 7)
	{
		changelevel ("xeno7");
	}
	else if (level == 8)
	{
		changelevel ("xeno8");
	}
	else if (level == 9)
	{
		changelevel ("expctf2");
	}
	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};


/*
============
W_WarpLOCPak

============
*/

void() W_WarpLOCPak =
{
	if (level == 1)
	{
		changelevel("ctf3m1");
	}               
	else if (level == 2)
	{
		changelevel ("ctf3m2");
	}
	else if (level == 3)
	{
		changelevel ("ctf3m3");
	}
	else if (level == 4)
	{
		changelevel ("ctf3m4");
	}
	else if (level == 5)
	{
		changelevel ("ctf3m5");
	}
	else if (level == 6)
	{
		changelevel ("ctf3m6");
	}
	else if (level == 7)
	{
		changelevel ("ctf3m7");
	}
	else if (level == 8)
	{
		changelevel ("ctf3m8");
	}
	else if (level == 9)
	{
		changelevel ("ctf3m9");
	}
	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};

/*
============
W_WarpCustom

============
*/

void() W_WarpCustom =
{
	changelevel (custom);
	level = 0;
	self.s_switch = 0;
	self.s_episode = 0;
};

/*
============
SetCustomLevel

============
*/

float() SetCustomLevel =
{
	custom = "none";
	if (self.impulse == 1)
	{
		custom = custom_1;
	}               
	else if (self.impulse == 2)
	{
		custom = custom_2;
	}
	else if (self.impulse == 3)
	{
		custom = custom_3;
	}
	else if (self.impulse == 4)
	{
		custom = custom_4;
	}
	else if (self.impulse == 5)
	{
		custom = custom_5;
	}
	else if (self.impulse == 6)
	{
		custom = custom_6;
	}
	else if (self.impulse == 7)
	{
		custom = custom_7;
	}
	else if (self.impulse == 8)
	{
		custom = custom_8;
	}
	else if (self.impulse == 9)
	{
		custom = custom_9;
	}
	else if (self.impulse == 10)
	{
		custom = custom_10;
	}
	else if (self.impulse == 11)
	{
		custom = custom_11;
	}
	else if (self.impulse == 12)
	{
		custom = custom_12;
	}
	if (custom == "none") {
		sprint(self, "Invalid Level Requested\n");
		return FALSE; }
	else
		return TRUE;
};

/*
==========
ResetVKick
(actually, resets entire vote engine, not just VKick)
==========
*/
void() ResetVKick =

{

local entity p;

        p = find(world, classname, "player");
        while (p != world) {
		p.s_episode = 0;	// used by nonVKick vote
		p.s_switch = 0;		// used by nonVKick vote
		p.init_vkick = 0;
		p.vkick_voted_for = 0;
		p.vkick_voted_for_count = 0;
		p.vkick_voted_against_count = 0;
		p.vote = 0;  		// used by all vote systems
                p = find (p, classname, "player");
        }
	vote_topic = 0;
	p = find(world, classname, "vtimer");
	if (p != world) {
		p.nextthink = time + 1;
		p.think = SUB_Remove;
	}
};

/*
========
InitiateVkick
========
*/

void () InitiateVKick = 
{
if (cvar("samelevel") & CLANRING_MODE) return;

local entity p;
local float n;
	if (vote_topic) {
		sprint(self, "Vote already in progress. Please wait.\n");
		return;
	}
        self.init_vkick = 1; //marks this one as the initiater
	sprint(self, "Kick Whom?\n");	
	AdminListPlayers();
};


/*
==========
TallyVKick
==========
*/

void () TallyVKick =

{

local string sstrings;                                       
local float total;
local entity asdfjkl;
local entity t;
local string number_s;

	t = find(world, classname, "player");
	while ( (t != world) && (!(t.vkick_voted_for)) ) 
		t = find(t, classname, "player");
	if (t == world) {
		bprint("Program error! Function TallyKick. Resetting...");
		ResetVKick;
		return;
	}
        total = 0;
        bprint("Vote count is ");
        sstrings = ftos(t.vkick_voted_for_count);
        bprint(sstrings);
        asdfjkl = find(world, classname, "player");
        while (asdfjkl != world) {
                total = total + 1;
                asdfjkl = find(asdfjkl, classname, "player");
        }
        sstrings = ftos(total);
        bprint("/");
        bprint(sstrings);
        bprint(" = ");
        sstrings = ftos(t.vkick_voted_for_count / total * 100);
        bprint(sstrings);
        bprint("% 51% needed.\n");

        if ( (t.vkick_voted_for_count / total) >= 0.51) {
		localcmd("kick # ");
                number_s = ftos(t.colormap);
                localcmd(number_s);
                localcmd("\n");
                stuffcmd(t,"disconnect\n");
		status_isvalid = 0;     // QSmack mod
                              // isvalid must be reset whenever a client
                              // leaves the server... so it is done in
                              // ClientDisconnect and also wherever a
                              // localcmd kick is done.

                bprint("Popular vote has kicked ");
                bprint(t.netname);
		bprint("\n");
                ResetVKick();
        }
};


/*
==========
VKickVoteYes
==========
*/

void() VKickVoteYes =

{

local entity t;

	if (self.vote) {
		sprint(self, "You have already voted.");
		return;
	}
        t = find(world, classname, "player");
        while (t.vkick_voted_for != 1)
        {
                t = find(t, classname, "player");
        }
        if (t == world)
	{
		bprint ("Program Error!!!  Resetting Data\nFunction VOTEYES\n");
		ResetVKick;
		return;		
	}
        bprint(self.netname);
        bprint(" has voted Ÿ≈” to kicking ™®");
        bprint(t.netname);
        bprint("©™\n");
        t.vkick_voted_for_count = t.vkick_voted_for_count + 1;
        self.vote = 1;
        TallyVKick();
        
};


/*
============
Vote
============
*/
void() Vote =
{
	  local entity e;
	  local string temp;
	  local float yes_votes;
	  local float no_votes;

	if (!vote_topic || self.vote) return;
		if ( vote_topic == 3 ) {       //VKick
			VKickVoteYes();
			return;
		}


		yes_votes = 0;
		no_votes = 0;
		self.vote = 1;
		e = find(world,classname,"player");
	while (e != world)
	    {
			if ((!e.quaketv & QTV_ADMIN) && (!e.not_exist)  && (e.netname != ""))
			{
				if(e.vote == 1) yes_votes = yes_votes + 1;
				if(e.vote == 0) no_votes = no_votes + 1;
				
			}
			e = find(e,classname,"player");
		}
	if (!self.init_vote) {
	  bprint(self.netname);
	  bprint(" just voted.\nYes/Total Votes: ");
	  bprint(ftos(yes_votes));
	  bprint("/");
	  bprint(ftos(yes_votes+no_votes));
	  bprint("\n");
 	}
		if( (vote_topic == 1) && (yes_votes >= no_votes ) )
			{
				if (episode == 1)
					W_WarpEpisode1 ();
				else if (episode == 2)
					W_WarpEpisode2 ();
				else if (episode == 3)
					W_WarpEpisode3 ();
				else if (episode == 4)
					W_WarpEpisode4 ();
				else if (episode == 5)
					W_WarpDeath ();
				else if (episode == 7)
					W_WarpCTF ();
                        	else if (episode == 8)
	                              W_WarpCTFEpisode2 ();
				else if (episode == 14)
					W_WarpLOCPak ();
				else if (EXPANDED_MAPS >= 1) {
				if (episode == 9)
					W_WarpExpansion ();
				if (EXPANDED_MAPS == 2) {
	                              	if (episode == 10)
        	                            	W_WarpTW ();
                                	if (episode == 11)
                	                    	W_WarpTWEpisode2 ();
                        	      	if (episode == 12)
                                	    	W_WarpXeno ();
					if (episode == 13)
						W_WarpCustom ();
					}
				else {
					if (episode == 10)
						W_WarpCustom ();
					} 
				}
				else {
					if (episode == 9)
						W_WarpCustom ();
				}
				if (episode == 6)
					{
						self.impulse = 0;
						self.s_switch = 0;
						changelevel(ctfstartmap);
					}
				vote_topic = 0;
				ResetVKick();
			}
	 		if((vote_topic == 2) && ( (yes_votes/(yes_votes + no_votes)) >= OVERRIDE_VOTES))
			{
			bprint("Match Start Override Initiated\n");
			bprint("Timer started\n");
			TIMER_RALLY = 1;
			observerless_mode = 1;
			GameTimer();
			vote_topic = 0;
			ResetVKick();
			}
			else if ((vote_topic == 5) && ( (yes_votes/(yes_votes + no_votes)) >= OVERRIDE_VOTES))
			{
				QuadToggle();
				vote_topic = 0;
				ResetVKick();
			}
			else if ((vote_topic == 6) && ( (yes_votes/(yes_votes + no_votes)) >= OVERRIDE_VOTES))
			{
				PentToggle();
				vote_topic = 0;
				ResetVKick();
			}
			else if ((vote_topic == 7) && ( (yes_votes/(yes_votes + no_votes)) >= OVERRIDE_VOTES))
			{
				EyesToggle();
				vote_topic = 0;
				ResetVKick();
			}
			else if ((vote_topic == 8) && ( (yes_votes/(yes_votes + no_votes)) >= OVERRIDE_VOTES))
			{
				RunesToggle();
				vote_topic = 0;
				ResetVKick();
			}
};

void() InitiateOverride =
{
	local string h;
	local entity e;
	local float temp1;
// JKB changed from 2.2k
	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}
// JKB end 2.2k
	if (vote_topic) {
		sprint(self, "Vote already in progress. Please wait.");
		return;
	}

	temp1 = 0;
		bprint("Match Start Override\nrequested by ");
		bprint(self.netname);
		bprint("\n");
		self.init_vote = 1;
	vote_topic = 2;

      e = find(world,classname,"player");
      while (e != world)
            {
		if (!e.quaketv & QTV_ADMIN)
		{
			sprint(e,"Type Yes in console to approve\n");
			e.vote = 0;
	      }
		e = find(e,classname,"player");

		}
		VoteTimer();
		Vote();

};

void() SettingOverride =
{
	local string h;
	local entity e;
	local float temp1;
// JKB changed from 2.2k
	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}
// JKB end 2.2k
	if (vote_topic) {
		sprint(self, "Vote already in progress. Please wait.");
		return;
	}

	temp1 = 0;
	if (self.impulse == 53) // Quad Toggle
	{
		bprint("Quad toggle requested\nby ");
		bprint(self.netname);
		bprint("\n");
		vote_topic = 5;
		self.init_vote = 1;
	} else 
	if (self.impulse == 54) // Pent Toggle
	{
		bprint("Pent toggle requested\nby ");
		bprint(self.netname);
		bprint("\n");
		vote_topic = 6;
		self.init_vote = 1;
	} else 
	if (self.impulse == 55) // Eyes Toggle
	{
		bprint("Ring-o-Shadows toggle\nrequested by ");
		bprint(self.netname);
		bprint("\n");
		vote_topic = 7;
		self.init_vote = 1;
	} else
	if (self.impulse == 56) // Runes Toggle
	{
		bprint("SetRunes toggle requested\nby ");
		bprint(self.netname);
		bprint("\n");
		vote_topic = 8;
		self.init_vote = 1;
	}


      e = find(world,classname,"player");
      while (e != world)
            {
		if (!e.quaketv & QTV_ADMIN)
		{
			sprint(e,"Type Yes in console to approve\n");
			e.vote = 0;
	      }
		e = find(e,classname,"player");

		}
		VoteTimer();
		Vote();

};
void() InitiateLevel =
{
	local string h;
	local entity e;
	local float temp1;
	if (vote_topic) {
		sprint(self, "Vote already in progress. Please wait.");
		return;
	}
	level = self.impulse;
	episode = self.s_episode;
	temp1 = 0;
	self.init_vote = 1;
	bprint("Level Change requested\nby ");
	bprint(self.netname);
	bprint(" to: \n");
	bprint("Episode: ");
	h = ftos(episode);
	bprint(h);
	if(episode != 6)
	{
      	bprint(" Level: ");
		h = ftos(level);
		bprint(h);
	}
	bprint("\n");
	if (EXPANDED_MAPS == 1) {
		if (episode == 10)
		{
			if (SetCustomLevel())
			{
				bprint(" Custom Level Name: ");
				bprint(custom);
				bprint("\n");
			}
			else
			{
				self.s_switch = 0;
				self.s_episode = 0;
				episode = 0;
				level = 0;
				return;
			}
		}
	}
	else {
		if (EXPANDED_MAPS == 2) {
			if (episode == 13)
			{
				if (SetCustomLevel())
				{
					bprint(" Custom Level Name: ");
					bprint(custom);
					bprint("\n");
				}
				else
				{
					self.s_switch = 0;
					self.s_episode = 0;
					episode = 0;
					level = 0;
					return;
				}
			}
		}
		else {
			if (episode == 9)
			{
				if (SetCustomLevel())
				{
					bprint(" Custom Level Name: ");
					bprint(custom);
					bprint("\n");
				}
				else
				{
					self.s_switch = 0;
					self.s_episode = 0;
					episode = 0;
					level = 0;
					return;
				}
			}
		}
	}
	vote_topic = 1;
      e = find(world,classname,"player");
      while (e != world)
            {
		if (!e.quaketv & QTV_ADMIN)
		{
			sprint(e,"Type Yes in console to approve\n");
			e.vote = 0;
	      }
		e = find(e,classname,"player");

		}
		VoteTimer();
		Vote();
};


void () StartVKick = 
{

local entity kickee;  
local float n;                                   
local string temp;

	if ((self.impulse < 1) || (self.impulse > 16)) {
		sprint(self, "Number out of range.. Try again\n");
		return;
	} else {
		kickee = find(world, classname, "player");
		n = 1;
		while ((n != self.impulse) && (kickee != world)) {
			kickee = find(kickee, classname, "player");
			n = n + 1;         
		} // while
	} // if
        if (kickee == world)
	{
		sprint (self, "Invalid number. Resetting Data\nFunction StartVKick\n");
		ResetVKick();
		return;		
	}
        bprint("Type ˘ÂÛ or ÓÔ in console to vote\n");
        bprint(self.netname);
        bprint(" has initiated a ÷œ‘≈ for À…√Àing ™®");
        bprint(kickee.netname);
        bprint("©™\n");
        stuffcmd(self, "say type Ÿ≈” or Œœ in console to vote.\n");
        kickee.vkick_voted_for = 1;
        kickee.vkick_voted_for_count = 1;
	kickee.vote = 1;
        self.vote = 1;
        self.init_vkick = 0;
	VoteTimer();
	vote_topic = 3;
	sprint(kickee, "You are being Voted on\nYou may not vote.\n");
        TallyVKick();
};
