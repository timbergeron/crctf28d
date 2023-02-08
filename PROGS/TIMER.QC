void() ClearFrags;
void() DumpScore;
void(entity c) DumpScoreToClient;
void(entity targ, entity attacker) Killed;
void() PlayerDie;
void() set_suicide_frame;
void() UnHookPlayer;
void() respawn;


// called every second

void() Think_GameTimer =
{
local string number, s;
local float     f;
local entity    e;
local entity    g;
local entity    h;
local entity    k;
local entity    oself;
local float     stop_timer, total1, total2;
local float     mostfrags;
local float     FLIMIT;




if(!timer_pause)
{ 
	local entity rune;
	local entity tempself;         //ghgfhgfhgfhfnd
	FLIMIT = cvar("fraglimit");
	e = find(world, classname, "player");
	mostfrags = e.frags;
	while (e != world)
		{
		if (e.frags > mostfrags)
			mostfrags = e.frags;
		e = find(e, classname, "player");
		}
	if (self.cnt2 == 0)
		{
		self.cnt2 = 60;
		self.cnt = self.cnt + 1; // increase the min counter
		}
	self.cnt2 = self.cnt2 - 1;      // decrease the sec counter

	if ( (self.items==TIMER_RALLY) && (self.cnt2 == 30) && (self.cnt == self.items) ) bprint("Pre-CTF rally time\n");
	
	if ( (self.cnt == self.items) && (self.items == TIMER_RALLY) && (self.cnt2 == 0) )
		{               // rally time up - begin match
		self.cnt = 0;
		self.items = TIMER_MATCH;
	    
		// kill everyone when match starts
		matchgoing = 1;
		e = find(world,classname,"deadclan");
		while (e != world)
			{
			e.nextthink = time + 1;
			e.think = SUB_Remove;
			e = find(e,classname,"deadclan");
			}
		k = find(world,classname,"record");
		while (k != world)
			{
			k.nextthink = time + 1;
			k.think = SUB_Remove;
			k = find(k,classname,"record");
			}
		oself=self;
		self = find(world,classname,"player");
		while (self != world)
			{
			if (!self.quaketv & QTV_OBSERVER)
				{
				self.ammo_shells = 0;
				self.ammo_nails = 0;
				self.ammo_rockets = 0;
				self.ammo_cells = 0;
				//T_Damage(h, self, world, 8000);
				DropRune();
				TeamCaptureDropFlagOfPlayer(self);
				set_suicide_frame ();
//                                self.modelindex = modelindex_player;
				self.health = 0;
				UnHookPlayer();
				respawn ();


//                              Killed (h, world);

				self.killed = 0;
				}
			self = find(self,classname,"player");
			}
		self=oself;
		e = find(world,classname,"ghost");
		while (e != world)
			{
				e.frags = 0;
				e.enemy_kill = 0;
				e.friend_kill = 0;
				e.deaths = 0;
				e = find(e,classname,"ghost");
			}
		e = find(world,classname,"clan");
		while (e != world)
			{
			e.frags = 0;
			e.enemy_kill = 0;
			e.friend_kill = 0;
			e.deaths = 0;
			e = find(e,classname,"clan");
			}
		ClearFrags();
		level = 0;
		episode = 0;
		number=ftos(TIMER_MATCH);
		//StartRuneSpawn(
 rune = find(world, classname, "rune");
    while (rune != world) {
	rune.classname = "oldrune";
	rune = find(world, classname, "rune");
    }
    tempself = self;
    rune = find(world, classname, "oldrune");
    while (rune != world) {
	self = rune;
	RuneRespawn();
	rune = find(world, classname, "oldrune");
    }
    self = tempself;


bprint("The match has begun!\n");
// JKB changed from 2.2l
		if (samelevel & TLIMIT_MODE)
// JKB end 2.2l
			{
			bprint("Match ends in ");
			s = ftos(TIMER_MATCH);
			bprint(s);
			bprint(" minutes.\n");
			}                   
// JKB changed from 2.2l
		if (samelevel & FLIMIT_MODE)
// JKB end 2.2l
			{
			bprint("Match ends at ");
			f = cvar("fraglimit");          // reusing variable "f"
			number = ftos(f);
			bprint(number);
			bprint(" frags\n");
			}


		}
// JKB changed from 2.2l
	else if (  ( (self.items == TIMER_MATCH) && ((samelevel & TLIMIT_MODE) && (self.cnt == self.items) && (self.cnt2 == 0)) ) || 
			( ((samelevel & FLIMIT_MODE) && (mostfrags >= FLIMIT) && (FLIMIT > 0)) )  )
// JKB end 2.2l
		
		{
			// DM time is up or max frags reached - enter rally time
			self.cnt = 0;
			total1 = total2 = 0;
			e = find(world, classname, "clan");
			while (e != world) {
			if (e.clan_number == 1)
				total1 = e.frags;
			else if (e.clan_number == 2)
				total2 = e.frags;
			e = find(e, classname, "clan");
			}
		
			if (total1 > total2) {
				bprint("ред team won with ");
				s = ftos(total1);
				bprint(s);
				bprint(" points\n");
				bprint("блуе team lost with ");
				s = ftos(total2);
				bprint(s);
				bprint(" points.\n");
			} else if (total1 < total2) {
				bprint("блуе team won with ");
				s = ftos(total2);
				bprint(s);
				bprint(" points\n");
				bprint("ред team lost with ");
				s = ftos(total1);
				bprint(s);
				bprint(" points.\n");
			} else {
				bprint("блуе and ред team tied with ");
				s = ftos(total1);
				bprint(s);
				bprint(" points\n");
			}
			//LogMatch();
			e = find(world,classname,"clan");
			while (e != world)
				{
				e.classname = "deadclan";
				e = find(e,classname,"clan");
				}
			match_ending = 1;
			oself=self;
			self = find(world,classname,"player");
			while (self != world)
				{
				if ((!self.quaketv & QTV_OBSERVER) && (self.health > 0))
					{
//                                      T_Damage(self, self, world, 8001);
					DropRune();
					TeamCaptureDropFlagOfPlayer(self);
					set_suicide_frame ();
//                                        self.modelindex = modelindex_player;
					self.health = 0;
					UnHookPlayer();
					respawn ();
					}
				self = find(self,classname,"player");
				}
			self=oself;
			e = find(world,classname,"ghost");
			while (e != world)
				{
				e.classname = "record";
				e = find(e,classname,"ghost");
				}
			match_ending = 0;
			if (!observerless_mode)
				{
				self.items = TIMER_RALLY;
//                              DumpScore();
				bprint("Match is over...entering rally time\n");
//                              localcmd("serverinfo status rally\n");
				matchgoing = 0;
				}
			else
				{
//                              DumpScore();
				bprint("Match is over...\n");
				matchgoing = 0;
				stop_timer = 1;
				}
			e = find(world,classname,"player");
			while (e != world)
				{
				e.clan_number = 0;
				e = find(e,classname,"player");
				}
		} 
	else if (self.cnt2 == 0)
		{
		f = self.items-self.cnt;
	     
		number = ftos(f);
		if (stop_timer != 1)
			{
			if (self.items == TIMER_RALLY) 
				{
				bprint("Match begins in ");
				bprint(number);
				bprint(" minutes\n");
				}
// JKB changed from 2.2l
			else if ((self.items == TIMER_MATCH) && (samelevel & TLIMIT_MODE) ) 
// JKB end 2.2l
				{
				bprint("Match ends in ");
				bprint(number);
				bprint(" minutes\n");
				}
//              localcmd("serverinfo timeleft ");
//              localcmd(number);
//              localcmd("\n");
			}
		 
		}



	if (self.items - self.cnt == 0)
		{
		if (self.cnt2 == 15)
			{
			if (self.items == TIMER_RALLY) 
				bprint("Match begins in T-Minus\n");
// JKB changed from 2.2l
			else if ((self.items == TIMER_MATCH) && (samelevel & TLIMIT_MODE)) 
// JKB end 2.2l
				bprint("Match ends in T-Minus\n");
			}
		if (self.cnt2 < 15 && ( (self.items == TIMER_RALLY) || 
// JKB changed from 2.2l
		(self.items == TIMER_MATCH && (samelevel & TLIMIT_MODE))) )
// JKB end 2.2l
		if (self.cnt2 < 15)
			{
			number = ftos(self.cnt2);
			bprint(number);
			bprint(" seconds\n");
			}
		}
	
//      self.nextthink = time + 1; // SO 2.8E movded this down.. timerpause didnd't work correctly. it's 3:00 AM i can'ty type
	if (stop_timer != 1)
		{
		self.think = Think_GameTimer;
		}
	else
		{
//              localcmd("serverinfo status standby\n ");
		self.think = SUB_Remove;
		observerless_mode = 0;
		timer_exist = 0;
		}
	}               
	self.nextthink = time + 1;
};      




void() GameTimer =
{
	local   entity timer;
	local   string s;

	timer_exist = 1;
	timer = spawn ();
	timer.owner = world;
	timer.classname = "timer";
	timer.cnt = 0;          // minutes
	timer.cnt2 = 0;        // counts down from 60 after it gets set in Think_GameTimer

	timer.items = TIMER_RALLY;      // number of minutes

	timer.nextthink = time + 1;
	timer.think = Think_GameTimer;

	matchgoing = 0;
	s = ftos(timer.items);
//      localcmd("serverinfo timeleft ");
//      localcmd(s);
//      localcmd("\n");
//      localcmd("serverinfo status rally\n");
	bprint("Match begins in ");
	bprint(s);
	bprint(" minutes\n");
};



void() Think_VoteTimer =
{
local entity p;
local entity vtimer;            
local string temp_string;

	vtimer = find(vtimer, classname, "vtimer");
	if (vtimer.items == 1) {
		vtimer.nextthink = time + 60;   // When to SPAM (1 min from now)
		vtimer.think = Think_VoteTimer;
		vtimer.items = 2;
	} else
	if (vtimer.items == 2) {
		bprint("You have 60 seconds to vote for\n");
		if (vote_topic == 1)
			bprint("Level Change. Type YES in\nconsole to vote.\n");
		else if (vote_topic == 2)
			bprint("Timer Override. Type YES in\nconsole to vote.\n");
		else if (vote_topic == 3) {
			bprint("Kicking ");
			p = find(world, classname, "player");
			while ((p.vkick_voted_for != 1) || (p == world))
				p = find(p, classname, "player");
			if (p == world) {
				bprint("\nProgram error. Kickee Not found.\nResetting data...\n");
				ResetVKick();
				return;
			}
			temp_string = p.netname;
			bprint(temp_string);
			bprint(" Type YES in\nconsole to vote.\n");
		} 
		else if (vote_topic == 4)
			bprint("ItemDrop toggle. Type YES in\nconsole to vote.\n");
		else if (vote_topic == 5)
			bprint("Quad toggle. Type YES in\nconsole to vote.\n");
		else if (vote_topic == 6)
			bprint("Pent toggle. Type YES in\nconsole to vote.\n");
		else if (vote_topic == 7)
			bprint("Eyes toggle. Type YES in\nconsole to vote.\n");
		else if (vote_topic == 8)
			bprint("Runes toggle. Type YES in\nconsole to vote.\n");

		vtimer.nextthink = time + 50;   // When to warn of pending reset :)
		vtimer.items = 3;
	} else
	if (vtimer.items == 3) {
		localcmd("say You have 10 seconds to vote YES\n");
		vtimer.nextthink = time + 10;   // When to reset votes
		vtimer.items = 4;
	} else 
	if (vtimer.items == 4) {
		bprint("Time is up for voting\nResetting Votes\n");
		ResetVKick();
	} else {                                // Whoops, something went wrong.
		vtimer.items = 0;
		bprint("Program Error. Resetting Data.\nFunction ThinkVotetimer\n");
		ResetVKick();
	}      
};

void() VoteTimer =
{
	local   entity vtimer;
	local   string s;

	vtimer = spawn ();
	vtimer.owner = world;
	vtimer.classname = "vtimer";
	vtimer.cnt2 = 120;      // counts down from 120 (not used)
	vtimer.items = 1;       // simply a marker used in Think_VoteTimer
	
	vtimer.nextthink = time + 1;
	vtimer.think = Think_VoteTimer;
};

