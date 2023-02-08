void() StartChaseCam;
//PB not used void() Remove_chase_cam;
void() ChaseUpdate;
void() MakeChaseMode;
void() ExitChaseMode;
void() AutoChaseUpdate;
void() QuakeTV;
void() QTVSwitchToCam;

void() StartChaseCam =
{
	//PB this part was a pain in the ass to write...I think I'm gonna go insane
	//   Thank god autochase will be easier
	
	local entity head;
		
	head = self.chasetarg;
	
        if (!head)
		{
		head = world;
//		bprint("Resetting head\n");
		}
	if (!self.quaketv & QTV_FOUNDTARG)
		{
//		bprint("No FOUNDTARG, finding\n");
                head = find (head, classname, "player");
		}
	else self.quaketv = self.quaketv - QTV_FOUNDTARG;

        while (head != world && (head.quaketv & QTV_OBSERVER || head.deadflag != DEAD_NO || head.not_exist == TRUE))
        {
//	bprint("Target not valid, finding\n");
	//PB this was used for debugging sprint(self, "first check...");
         head = find (head, classname, "player");
	}
	
	if (!head || head == world)
	{
		head = find (world, classname, "player");
//		bprint("First check failed, restarting\n");
		while (head != world && (head.quaketv & QTV_OBSERVER || head.deadflag != DEAD_NO || head.not_exist == TRUE))
		{
//			bprint("Target not valid, finding (2)\n");
			head = find (head, classname,"player");
		}
	}
        if (!head || head == world)  //PB check again from the top
		{
		sprint(self,"No One to Chase\nDefaulting to Observer Mode\n");
		ExitChaseMode();
		MakeObserverMode();
		return;
		}
        self.chasetarg = head;
			
	self.announce_chase_time = time;
	
	self.angles = self.chasetarg.angles;

        setorigin( self, self.chasetarg.origin + '0 0 10' );
	
        self.fixangle = TRUE; //PB i think this is needed

};


void() ChaseUpdate =
{
	local vector    spot2, dir;
	local float dist;
        local string number_of_frags, health_str,status_line;
	//local float lagging;
	//local vector correction;
	//local vector smooth;
        //local string info;
        //local string armor_number;
        //local string health_number;
	if (!(self.quaketv & QTV_CHASE)) return;  //PB for whatever reason this might still be running

        if (self.quaketv & QTV_AUTOCHASE)
	
                AutoChaseUpdate();  //PB called to find player to AutoChase

	if ((self.quaketv & QTV_QUAKETV) && (!(CheckForQuad())))
		{
			QTVSwitchToCam();
			return;
		}

// JKB changed from 2.2i+
	if (self.chasetarg.quaketv & QTV_OBSERVER) StartChaseCam();	
// JKB end 2.2i+

	if (!self.chasetarg || self.chasetarg == world)  //PB something fucked up, kick them out of chasecam
	{
		if(self.quaketv & QTV_AUTOCHASE) self.quaketv = self.quaketv - (self.quaketv & QTV_AUTOCHASE);
		
                //ExitChaseMode();
                //stuffcmd(self,"observer\n");
                //sprint(self,"No One to Chase\nDefaulting to Observer Mode\n");
		return;
	}
	
	
	
	if (self.chasetarg != world) self.chasetarg.oldhealth = self.chasetarg.health;
	

        if (!(self.quaketv & QTV_CHASE)) return;  //PB for whatever reason this might still be running
        if (!self.chasetarg || self.chasetarg == world)  //PB something fucked up, kick them out of chasecam
	{
		if(self.quaketv & QTV_AUTOCHASE) self.quaketv = self.quaketv - (self.quaketv & QTV_AUTOCHASE);
		
		ExitChaseMode();
		MakeObserverMode();
		sprint(self,"No One to Chase\nDefaulting to Observer Mode\n");
		return;
	}        

	self.velocity = self.chasetarg.velocity;
	makevectors( self.chasetarg.v_angle );
        spot2 = ( self.chasetarg.origin - (v_forward * 90) + '0 0 30'); 
	traceline (self.chasetarg.origin, spot2, TRUE, self.chasetarg);

	spot2 = trace_endpos + ( v_forward * 2 );

	traceline (spot2, spot2 + '0 0 30', TRUE, self.chasetarg );
	if (trace_fraction < 1 )
		spot2 = trace_endpos - '0 0 35';
	if (spot2_z < self.chasetarg.origin_z) 
	{
		spot2 = spot2 + (v_forward * ((self.chasetarg.origin_z - spot2_z) - 2	));
		//spot2_z = self.chasetarg.origin_z;
	}
	
	
	setorigin(self, spot2);
/*
PB###################################################################PB
I was watching the new mod on yavin and for some reason it seemed like
the new way of sending view angles wasn't sending al the pakets or
something to that affect.  So I am scrapping the old non-smooth version
of the chasecam.  I don't think it is better for anyone, so I am just
taking it out all together.  Instead, I am going to use the smooth
option to tell the server how to update the clients screen.  If they
don't turn smoothing one, it will do it the old way with self.fizangle
If they turn smoothing on, it will use the packet editting method.
PB##################################################################PB
*/
		
	if (!self.quaketv & QTV_FREELOOK)
	{
		if(self.quaketv & QTV_SMOOTH) //PB smoother less reliable view updating
		{
			ChangeView(self.chasetarg.v_angle);
		}
		else				//PB more reliable view updating
		{				
			self.v_angle = self.chasetarg.v_angle;
			self.angles = self.chasetarg.v_angle;	
			self.fixangle = TRUE;
		}
	}	

	if (!self.announce_chase_time || self.announce_chase_time < time)
	{
			
//SO 2.8b		number_of_frags = ftos(self.chasetarg.frags);
//SO 2.8b               health_str = get_health(self.chasetarg);
                        TeamPlayerUpdate2(self,"Ãèáóéîç: ",self.chasetarg.netname); 
//SO 2.8b /*"\nÆòáçó: ",number_of_frags,"  Èåáìôè: ",health_str,"\n");*/
// SO 2.8b Changed chasecam and QTV style so it changes status bar as if you were the person being chased
			if (self.health!=self.chasetarg.health) // Check each value before setting to elimiate lag (??? mebbe?)
				if (self.chasetarg.health <= 0)
					self.health = 999;
				else
					self.health=self.chasetarg.health;
			if (self.armorvalue!=self.chasetarg.armorvalue)
				self.armorvalue=self.chasetarg.armorvalue;	
			if (self.armortype != self.chasetarg.armortype)
				self.armortype = self.chasetarg.armortype;
			if (self.currentammo!=self.chasetarg.currentammo)
				self.currentammo=self.chasetarg.currentammo;
			if (self.ammo_shells!=self.chasetarg.ammo_shells)
				self.ammo_shells=self.chasetarg.ammo_shells;
			if (self.ammo_nails!=self.chasetarg.ammo_nails)
				self.ammo_nails=self.chasetarg.ammo_nails;
			if (self.ammo_rockets!=self.chasetarg.ammo_rockets)
				self.ammo_rockets=self.chasetarg.ammo_rockets;
			if (self.ammo_cells!=self.chasetarg.ammo_cells)
				self.ammo_cells=self.chasetarg.ammo_cells;
			if (self.items!=self.chasetarg.items)
				self.items=self.chasetarg.items;
			if (self.weapon!=self.chasetarg.weapon)
				self.weapon=self.chasetarg.weapon;
                        self.announce_chase_time = time + 0.5;  //SO 2.8b changed this from 1.5 cause it is more important now...
	}
	

};

/*
=============
MakeChaseMode by PB
	i'm trying to follow the current mod style as closely as possible
=============
*/


void() MakeChaseMode =
{
// JKB changed from 2.2k
	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}
// JKB end 2.2k
	if (self.quaketv & QTV_CHASE) return;
	//PB DEBUG
        //dprint(self.netname);
        //dprint(" entering ChaseCam\n");
	if (!self.quaketv & QTV_FOUNDTARG) MakeObserverMode(); // reset observer modes unless we got here from pressing fire...
	self.quaketv         = self.quaketv | QTV_CHASE;
        self.solid = SOLID_NOT;
        self.movetype = MOVETYPE_FLY;
        if (!(self.quaketv & QTV_QUAKETV)) sprint(self, "Chase Camera Mode Enabled\n");
	  
	StartChaseCam();

};


void() ExitChaseMode =
{
/*
	if (self.quaketv & QTV_CHASE)
	{
// JKB changed from 2.2i+
		self.quaketv = self.quaketv - (self.quaketv & QTV_CHASE);
// JKB end 2.2i+
		self.chasetarg = world;
		self.angles = '0 0 0';
		self.velocity = '0 0 0';
		//if (self.flags & FL_OBSERVER)
			//self.flags = self.flags - (self.flags & FL_OBSERVER);
		//if (!(self.flags & FL_ONGROUND))
			//self.flags = self.flags & FL_ONGROUND;
	}
*/
};

/*
PB
####################################################
####  AutoChase - toggles autochase on and off  ####
####################################################
PB
*/
void() AutoChase =
{
         
	if (!(self.quaketv & QTV_CHASE))
		MakeChaseMode();          
        if (self.quaketv & QTV_AUTOCHASE)
        {
                        sprint(self,"AutoChase Deactivated\n");
			self.quaketv = self.quaketv - (self.quaketv & QTV_AUTOCHASE);
        }
        else
        {
               //dprint(self.netname);
               // dprint(" entering AutoChase\n");
                 if (!(self.quaketv & QTV_QUAKETV)) sprint(self,"AutoChase Activated\n");
		    self.quaketv = self.quaketv | QTV_AUTOCHASE;
		    self.chase_switch_time = -1;

        }           
};

/*
PB
####################################################
#### AutoChaseUpdate - picks a player to Chase  ####
####################################################
PB
*/
void() AutoChaseUpdate =
{
	local entity head;
	local entity besthead;
	local entity tempent;
	local string temps;
	local float chasebestscore;
	local float chasescore;
	
	besthead = self.chasetarg;
	chasebestscore = 0;
	if (besthead.not_exist == TRUE || besthead.quaketv & QTV_OBSERVER || besthead == world) 
	{
		besthead = find(world,classname,"player");
		while ((besthead.not_exist == TRUE || besthead.quaketv & QTV_OBSERVER) && besthead != world)
		{
			besthead = find(besthead,classname,"player");
		}
	}
	
	if(besthead == world) return;
	
        if(self.chase_switch_time < time || besthead == world)
	{
                head = find(world,classname,"player");
		while(head != world)
		{
			tempent = identify_player(head, 0);
			chasescore=( // the following code will choose the best target weighted by the following:
				    (50 * (0 || head.player_flag & ITEM_ENEMY_FLAG))  // target has flag
				    + (25 * (0 || head.super_damage_finished)) 	  // target has quad
				    + (10 * ( 
					     (head.items & (IT_ROCKET_LAUNCHER | IT_GRENADE_LAUNCHER) && (head.ammo_rockets > 1) ) 
					     || (head.items & IT_LIGHTNING && head.ammo_cells > 5) 
					    )  // target has (RL or GL + rox) or (Zapper + cells)
				      )
				    + (62 * (0 || tempent.player_flag & ITEM_ENEMY_FLAG)) // target is chasing enemy flag carrier
				    + (10 * (0 || head.player_flag & (ITEM_RUNE1_FLAG | ITEM_RUNE2_FLAG | ITEM_RUNE3_FLAG | ITEM_RUNE4_FLAG) ) ) // target has a rune
				    + (51 * ( (time - head.LastDamageInflicted) <= 5) )
				   );
/*
			sprint(self, head.netname);
			temps = ftos(chasescore);
			sprint(self, temps);

			if (head.not_exist != TRUE || !head.quaketv & QTV_OBSERVER || head != world || (!head.clan_number) )
			{
			if (0 || tempent.player_flag & ITEM_ENEMY_FLAG)
				{
				sprint(self, head.netname);
				sprint(self, " is looking at flag\n");
				}
			if (0 || head.super_damage_finished)
				{
				sprint(self, head.netname);
				sprint(self, " has quad\n");
				}
			if ( (time - head.LastDamageInflicted) <= 5)
				{
				sprint(self, head.netname);
				sprint(self, " shot somebody\n");
				}
			if ( (0 || tempent.player_flag & ITEM_ENEMY_FLAG))
				{
				sprint(self, head.netname);
				sprint(self, " has the flag\n");
				}		
			}
*/
                        if ( (chasescore > chasebestscore) && (!head.quaketv & QTV_OBSERVER) && (head.deadflag == DEAD_NO) && (head.not_exist != TRUE) )
				{
				besthead = head;
				chasebestscore = chasescore;
 				}		
			head = find(head,classname,"player");
		}
                self.chasetarg = besthead;
/*		temps = ftos(chasebestscore);
		sprint(self, temps);
		sprint(self, besthead.netname);
		sprint(self, self.chasetarg.netname);
		sprint(self, " is best target\n");*/
		self.chase_switch_time = time + 2;
        }
};			


//PB ############# QUAKETV ####################
void() QuakeTV =
{
// JKB changed from 2.2k
	if (gamestart) {
		sprint(self, "Can't do that in the start map!\n");
		return;
	}
// JKB end 2.2k
	MakeObserverMode();
	if(self.quaketv & QTV_QUAKETV)  //PB Turn QuakeTV mode off and go to observer mode
	{
                sprint(self,"Quake TV Deactivated\n");
		return;
	}
        sprint(self,"Quake TV Activated\n"); 
	self.quaketv = self.quaketv | QTV_QUAKETV;
	QTVSwitchToCam();
	
};

void() QTVSwitchToCam =
{
	MakeCameraMode();
        //centerprint(self, " ");
	AutoCamera();
	self.camera_switch_time = time;
};

void() QTVSwitchToChase =
{
	MakeChaseMode();
	AutoChase();
	self.chase_switch_time = time;
};


/*
PB######################################################################PB
Below is some rather simple looking yet very scary code.
It seems to make autocam and chasecam much much smoother.
And in the Words of AM-Hump, "I LIKE THE NEW SMOOTHER CAMERA!!!"
The only thing that scares me is that I'm afraid it is a time bomb
waiting to go off.  Instead of relying on the Quake Engine to set
the camera angles and such, I just send them directly to the player
by hard coding the packets.  Scary Stuff.   Just have to wait and see....
PB######################################################################PB
*/
void(vector stuffangle) ChangeView =
{
		msg_entity = self;                         // target of message
		WriteByte (MSG_ONE, SVC_SETVIEWANGLES);
        	WriteAngle(MSG_ONE, stuffangle_x);    // tilt
	        WriteAngle(MSG_ONE, stuffangle_y);    // yaw
	        WriteAngle(MSG_ONE, stuffangle_z);    // flip
		
};


