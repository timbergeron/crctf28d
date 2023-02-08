entity() FindIntermission;
void() QTVSwitchToChase;
void(vector stuffangle) ChangeView;
string(entity e) get_health;
void() MakeCameraMode;
void() MakeObserverMode;
/*
============
CheckForQuad -- Returns true if any player has quad
============
*/
float() CheckForQuad =
{
	local entity head;
	head = find(world,classname,"player");
	while (head != world)
	{
		if (head.super_damage_finished)
			return TRUE;
		head = find(head,classname,"player");
	}
	return FALSE;
};

/*
============
CountCamera -- Returns the first available camera number
============
*/
float() CountCamera =
{
	local entity camera;
	local float count_camera;

	camera = find(world,classname,"player_cam");
	while (camera != world)
	{
		count_camera = count_camera + 1;
		camera = find(camera,classname,"player_cam");
	}

	return count_camera;      
};

/*
============
MakeCamera
============
*/
void() MakeCamera =
{
	local entity camera;
	local string temp_string;
	local float new_camera_number;
	new_camera_number = CountCamera();
	if (new_camera_number == 20) 
	{
                sprint(self,"Maximum Number of Cameras Reached\n");
		return;	
	}
		camera = spawn ();
		camera.owner = world;
      	camera.classname = "player_cam";
		camera.solid = SOLID_NOT;
		camera.movetype = MOVETYPE_NONE;
		camera.takedamage = DAMAGE_NO;
		setorigin (camera, self.origin);
		camera.mangle = self.v_angle;
		camera.fixangle = TRUE;

	
	temp_string = ftos(new_camera_number + 1);
        sprint(self,"New Camera Created\nNumber of Cameras: ");
	  sprint(self,temp_string);
	  sprint(self,"\n");
	
 
};


/*
============
RemoveCamera
============
*/
void() RemoveCamera =
{
	local entity camera;
	local string temp_string;
	local float new_camera_number;
	camera = self.current_cam;
	if (!camera)
	{
		sprint(self,"No Camera Selected\n");
		return;
	}
	if (camera.classname == "info_intermission")
	{
		sprint(self,"Cannot Remove Intermission Point\n");
		return;
	}
	camera.nextthink = time + 1;
	camera.think = SUB_Remove;
	sprint(self,"Camera Removed\n");
	new_camera_number = CountCamera();
	temp_string = ftos(new_camera_number - 1);
        sprint(self,"Number of Cameras: ");
	  sprint(self,temp_string);
	  sprint(self,"\n");
};



/*
============
GotoCamera
============
*/
void() GotoCamera =
{
	local entity camera;
	local string temp_string;

	camera = self.current_cam;
	if (!camera)
		camera = find (world, classname, "info_intermission");
	else if (camera.classname == "info_intermission")
		{
			camera = find (camera, classname, "info_intermission");
			if (!camera)
				camera = find (world, classname, "player_cam");
			if (!camera)
				camera = find (world, classname, "info_intermission");
		}
	else
		{
			camera = find (camera, classname, "player_cam");
			if (!camera)
				camera = find (world, classname, "info_intermission");
			if (!camera)					
				camera = find (world, classname, "player_cam"); //PB this should fix the not finding admin cams when no intermissions exist bug
		}
	if (!camera)
		{
		sprint(self,"No Camera or Intermission Points Exist\n");
		return;
		}

			self.current_cam = camera;	
			//ChangeView(camera.mangle); //PB NEW STUFF HERE
			setorigin (self, camera.origin);
			self.angles = self.v_angle = camera.mangle;
			self.fixangle = TRUE;
			self.movetype = MOVETYPE_NONE;
};

/*
=============
visible

returns 1 if the entity is visible to self, even if not infront ()
=============
*/
float (entity camera, entity targ) visible =
{
	traceline (camera.origin, targ.origin, TRUE, self);	// see through other monsters
	
	if (trace_inopen && trace_inwater)
		return FALSE;			// sight line crossed contents

	if (trace_fraction == 1)
		return TRUE;
	return FALSE;
};

/*
=============
infront

returns 1 if the entity is in front (in sight) of self
=============
*/
float(entity camera, entity targ) infront =
{
	local vector	vec;
	local float		dot;
	makevectors (camera.angles);
	if (!camera.angles) makevectors (camera.mangle);
	vec = normalize (targ.origin - camera.origin);
	dot = vec * v_forward;
	
	if ( dot > 0.3)
	{
		return TRUE;
	}
	return FALSE;
};
void() CheckCameraSwitch;
/*
=============
CamUpdate
=============
*/
void() CamUpdate =
{
	local vector bestaim;
	local entity camera;
	local entity head;
	local entity bestcam;
	local float r;
	local vector	spot1, spot2;
	local string number_of_frags;
	local string health_str,status_line;
	
	if (self.camera_switch_time < time)
	{
			CheckCameraSwitch();
	}
	//sprint(self,"Caming....\n");
	if ((self.besttarg.super_damage_finished) && (self.quaketv & QTV_QUAKETV))
	{
		QTVSwitchToChase();
		return;
        }
       
	if (self.camera_tracking_time < time)
	{
		if ((CheckForQuad()) && (self.quaketv & QTV_QUAKETV))
		{
			QTVSwitchToChase();
			return;
		}
		if (self.besttarg)
		{
// SO 2.8b		health_str = get_health(self.besttarg);
// SO 2.8b		number_of_frags = ftos(self.besttarg.frags);
			TeamPlayerUpdate2(self, "Ôעבדכימח: ",self.besttarg.netname); 
// SO 2.8b /*"Æעבחף: ",number_of_frags);"  Èובלפט: ",health_str,"\n");*/

// SO 2.8b Changed chasecam and QTV style so it changes status bar as if you were the person being chased
			if (self.health!=self.besttarg.health) //SO 2.8b Check each value before setting to avoid sending lots of info (??? i dunno, it might make a difference)
				self.health=self.besttarg.health;
			if (self.armorvalue!=self.besttarg.armorvalue)
				self.armorvalue=self.besttarg.armorvalue;	
			if (self.currentammo!=self.besttarg.currentammo)
				self.currentammo=self.besttarg.currentammo;
			if (self.ammo_shells!=self.besttarg.ammo_shells)
				self.ammo_shells=self.besttarg.ammo_shells;
			if (self.ammo_nails!=self.besttarg.ammo_nails)
				self.ammo_nails=self.besttarg.ammo_nails;
			if (self.ammo_rockets!=self.besttarg.ammo_rockets)
				self.ammo_rockets=self.besttarg.ammo_rockets;
			if (self.ammo_cells!=self.besttarg.ammo_cells)
				self.ammo_cells=self.besttarg.ammo_cells;
			if (self.items!=self.besttarg.items)
				self.items=self.besttarg.items;
			if (self.weapon!=self.besttarg.weapon)
				self.weapon=self.besttarg.weapon;


                        self.camera_tracking_time = time + 0.5;//SO 2.8b sped up this interval from 1.5 because it's more important now.
		}
		
	}	
	if (self.besttarg != world)   //PB hmm....why run this now?
	{
		//PB if the player is dead, try and find someone else nearby to watch.
		if((self.besttarg.health < 1) && (self.besttarg.velocity == '0 0 0'))
		{
			self.besttarg = world;  //PB this erases who the camera was looking at
			head = find (world,classname,"player");  //PB find a player
			while (head != world)
			{
				//PB if you can see him, and he ain't dead
                       		if((visible(self, head)) && (head.health > 0) && (head != self) && (head.velocity != '0 0 0') && (!head.quaketv & QTV_OBSERVER))
				{	
					spot1 = self.origin + self.view_ofs;
					spot2 = head.origin + head.view_ofs;
					r = vlen (spot1 - spot2);
					if (head.super_damage_finished) r = r * -1;
	                                if (head.invincible_finished) r = r * 0.3;
					if (self.besttarg == world)
					{
						self.besttarg = head;
						self.besttarg.targdist = r;
					}
					else if (r < self.besttarg.targdist)
					{
						self.besttarg = head;
						self.besttarg.targdist = r;
					}
				}
				head = find(head,classname, "player");
			}
			//PB the closest person in view should have been picked, so look at him.
			if (self.besttarg != world)
			{
				bestaim = vectoangles(self.besttarg.origin - self.origin);
				if (bestaim_x >= 270 && bestaim_x < 360) 
			 	     bestaim_x = 360 - bestaim_x;
				else if (bestaim_x >= 0 && bestaim_x < 90) 
			 	     bestaim_x = bestaim_x - 90;
   				 if (bestaim_x > 60)
					bestaim_x = 60;
				 if (bestaim_x < -10)
					bestaim_x = -10;

				if (!self.quaketv & QTV_FREELOOK)
				{
					if(self.quaketv & QTV_SMOOTH)
					{
						ChangeView(bestaim); //PB NEW STUFF
					}
					else
					{
						self.angles = bestaim;
						self.v_angle = bestaim;
						self.fixangle = TRUE;
					}
				}	
				self.camera_switch_time = time + 3;
			}
			//PB if we didn't find a person, sit here for a bit and go find someone new on next turn
			else
				self.camera_switch_time = time;
		}
		//PB Peeps are good.  Especially if they are stale.
		//PB well, the player is alive, but can you still see him?
		else if (!visible(self, self.besttarg))
		{
			//PB I guess he isn't, so find out where he went.
			//try to find another cam with the person
			bestcam = world;
			camera = find(world,classname,"player_cam");  //PB marmot had intermission here and playercams down there. Not very consistent at all. So i fixed it.
			while(camera != world)
			{
	     		      	if(visible(camera, self.besttarg))
				{	
					spot1 = camera.origin + camera.view_ofs;
					spot2 = self.besttarg.origin + self.besttarg.view_ofs;
					r = vlen (spot1 - spot2);
					if (bestcam == world)
					{
						bestcam = camera;
						bestcam.targdist = r;
					}
					else if (r < bestcam.targdist)
					{
						bestcam = camera;
						bestcam.targdist = r;
					}
				}
				camera = find(camera,classname,"player_cam");
			}
			camera = find(world,classname,"info_intermission");
			while(camera != world)
			{
     			      	if(visible(camera, self.besttarg))
				{	
					spot1 = camera.origin + camera.view_ofs;
					spot2 = self.besttarg.origin + self.besttarg.view_ofs;
					r = vlen (spot1 - spot2);
					if (bestcam == world)
					{
						bestcam = camera;
						bestcam.targdist = r;
					}
					else if (r < bestcam.targdist)
					{
						bestcam = camera;
						bestcam.targdist = r;
					}
				}
				camera = find(camera,classname,"info_intermission");
			}
			if (bestcam != world) //PB well, how about that, we found him.
			{
				self.current_cam = bestcam;	
				setorigin (self, bestcam.origin);
				//self.angles = self.v_angle = bestcam.mangle;
				//self.movetype = MOVETYPE_NONE;

				bestaim = vectoangles(self.besttarg.origin - bestcam.origin);
				if (bestaim_x >= 270 && bestaim_x < 360) 
			 	     bestaim_x = 360 - bestaim_x;
				else if (bestaim_x >= 0 && bestaim_x < 90) 
			 	     bestaim_x = bestaim_x - 90;
   				 if (bestaim_x > 60)
					bestaim_x = 60;
				 if (bestaim_x < -10)
					bestaim_x = -10;

				bestcam.besttarg = self.besttarg;
				if(!self.quaketv & QTV_FREELOOK)
				{
					if(self.quaketv & QTV_SMOOTH)
					{
						ChangeView(bestaim); //PB NEW STUFF
					}
					else
					{
						self.angles = bestaim;
						self.v_angle = bestaim;
						self.fixangle = TRUE;
					}
				}	
				self.camera_switch_time = time + 3;
				return;
			}
			else //PB well, we didn't find him, how long has he been missing?
			{
				if (time >= self.last_visible_time + 1)
					self.camera_switch_time = time;
			}

		}	
		else //PB all is good, keep tracking
		{

			bestaim = vectoangles(self.besttarg.origin - self.origin);
			if (bestaim_x >= 270 && bestaim_x < 360) 
		 	     bestaim_x = 360 - bestaim_x;
			else if (bestaim_x >= 0 && bestaim_x < 90) 
		 	     bestaim_x = bestaim_x - 90;
   			 if (bestaim_x > 60)
				bestaim_x = 60;
			 if (bestaim_x < -10)
				bestaim_x = -10;

			if(!self.quaketv & QTV_FREELOOK)
			{
				if(self.quaketv & QTV_SMOOTH)
				{
					ChangeView(bestaim); //PB NEW STUFF
				}
				else
				{
					self.angles = bestaim;
					self.v_angle = bestaim;
					self.fixangle = TRUE;
				}
			}	
			self.last_visible_time = time;
			return;
		}
	}
};


/*
============
CheckCameraSwitch
============
*/
void() CheckCameraSwitch =
{
	local entity camera;
	local entity head;
	local string temp_string;
	local vector	spot1, spot2;
	local float		r;
	local entity bestcam;
	local vector bestaim;
        local vector lastaim;  //PB used store last viewangle incase besttarg is lost

	lastaim = self.angles; //PB stores last viewangle

// Check cameras first
	self.besttarg = world;
	bestcam = self.current_cam;   //PB it can't be this easy this should make it stick instead of defaulting
	camera = find(world,classname,"player_cam");
	while(camera != world)
	{
		camera.number_players = 0;
		camera.weight = 0;
		camera.besttarg = world;
		head = find (world,classname,"player");
		while (head != world)
		{
                        if((visible(camera, head)) && (head.health > 0) && (head != self) && (head.velocity != '0 0 0') && (!head.quaketv & QTV_OBSERVER))
			{	
				spot1 = camera.origin + camera.view_ofs;
				spot2 = head.origin + head.view_ofs;
				r = vlen (spot1 - spot2);
				//PB added weight to quad and pent types hehe
				if (head.super_damage_finished) r = r * -1;
                                if (head.invincible_finished) r = r * 0.3;
				//PB
				if (camera.besttarg == world)
				{
					camera.besttarg = head;
					camera.besttarg.targdist = r;
				}
				else if (r < camera.besttarg.targdist)
				{
					camera.besttarg = head;
					camera.besttarg.targdist = r;
				}
				camera.number_players = camera.number_players + 1;
				//PB makes camera most likely point to quad or pent
				if (head.super_damage_finished) camera.number_players = camera.number_players + 5;
				if (head.invincible_finished) camera.number_players = camera.number_players + 3;
				//PBcamera.weight = camera.weight + r;
			}
			head = find(head,classname, "player");
		}
		//if (bestcam == world) bestcam = camera; else
		//{
		if (camera.number_players > bestcam.number_players) bestcam = camera;
		//}
		camera = find(camera,classname,"player_cam");
	}

// Now check intermission points

	camera = find (world, classname, "info_intermission");
	while(camera != world)
	{
		camera.number_players = 0;
		camera.weight = 0;
		camera.besttarg = world;

		head = find (world,classname,"player");
		while (head != world)
		{
                        if((visible(camera, head)) && (head.health > 0) && (head != self) && (head.velocity != '0 0 0') && (!head.quaketv & QTV_OBSERVER))
			{	
				spot1 = camera.origin + camera.view_ofs;
				spot2 = head.origin + head.view_ofs;
				r = vlen (spot1 - spot2);
				//PB added weight to quad and pent types hehe
				if (head.super_damage_finished) r = r * -1;
                                if (head.invincible_finished) r = r * 0.3;
				//PB
				if (camera.besttarg == world)
				{
					camera.besttarg = head;
					camera.besttarg.targdist = r;
				}
				else if (r < camera.besttarg.targdist)
				{
					camera.besttarg = head;
					camera.besttarg.targdist = r;
				}
				camera.number_players = camera.number_players + 1;
				//PB makes camera most likely point to quad or pent
				if (head.super_damage_finished) camera.number_players = camera.number_players + 5;
				if (head.invincible_finished) camera.number_players = camera.number_players + 3;
				//PBcamera.weight = camera.weight + r;
			}	
			head = find(head,classname, "player");
		}
		//if (bestcam == world) 
		//	bestcam = camera; 
		//else
		//{
		if (camera.number_players > bestcam.number_players) bestcam = camera;
		//}
		camera = find(camera,classname,"info_intermission");
	}
	if (self.current_cam != bestcam)
	{
		setorigin (self, bestcam.origin);
	//PB do you need this?	self.movetype = MOVETYPE_NONE;
	}
	
	self.current_cam = bestcam;	
	if (bestcam.besttarg != world) 
	{
 		bestaim = vectoangles(bestcam.besttarg.origin - bestcam.origin);
		if (bestaim_x >= 270 && bestaim_x < 360) 
		bestaim_x = 360 - bestaim_x;
		else if (bestaim_x >= 0 && bestaim_x < 90) 
			bestaim_x = bestaim_x - 90;
   		if (bestaim_x > 60)
			bestaim_x = 60;
		if (bestaim_x < -10)
			bestaim_x = -10;
		
		if(!self.quaketv & QTV_FREELOOK)
		{
			if(self.quaketv & QTV_SMOOTH)
			{
				ChangeView(bestaim); //PB NEW STUFF
			}
			else
			{
				self.angles = bestaim;
				self.v_angle = bestaim;
				self.fixangle = TRUE;
			}
		}			


	}

	//PB i added this to keep last angle
	else 
	{
		if(!self.quaketv & QTV_FREELOOK)
		{
                	if (!(self.quaketv & QTV_SMOOTH))
                        //{
			//ChangeView(lastaim); //PB NEW STUFF
                        //}
                        //else
			{
				self.angles = lastaim;
				self.v_angle = lastaim;
				self.fixangle = TRUE;
			}
		}    	
	}
			
	self.besttarg = bestcam.besttarg;
	if (self.besttarg != world)
		self.camera_switch_time = time + 5;
	else
                self.camera_switch_time = time;
};


/*
==========
AutoCamera
==========
*/
void() AutoCamera =
{         
	local entity camera; 
	local string temp_string;
        if (self.quaketv & QTV_AUTOCAM)
        {
                        sprint(self,"AutoCam Deactivated\n");
			MakeObserverMode();
			return;
        }
	if (self.impulse == 173) MakeObserverMode(); // Reset observer modes if we got here by typing autocam
	MakeCameraMode();
	self.quaketv = self.quaketv | QTV_CAMERA;          
        if (!(self.quaketv & QTV_QUAKETV))  sprint(self,"AutoCam Activated\n");
	self.quaketv = self.quaketv | QTV_AUTOCAM;
	self.camera_switch_time = time + 1;
};

string(entity e) get_health =
{
	local string temp;
	if (e.health <= 0) return "0";
	if (e.health <= 5) return "5";
	if (e.health <= 10) return "10";
	if (e.health <= 20) return "20";
	if (e.health <= 30) return "30";
	if (e.health <= 40) return "40";
	if (e.health <= 50) return "50";
	if (e.health <= 60) return "60";
	if (e.health <= 70) return "70";
	if (e.health <= 80) return "80";
	if (e.health <= 90) return "90";
	if (e.health <= 100) return "100";
	if (e.health <= 110) return "110";
	if (e.health <= 120) return "120";
	if (e.health <= 130) return "130";
	if (e.health <= 140) return "140";
	if (e.health <= 150) return "150";
	if (e.health <= 160) return "160";
	if (e.health <= 170) return "170";
	if (e.health <= 180) return "180";
	if (e.health <= 190) return "190";
	if (e.health <= 200) return "200";
	if (e.health <= 210) return "210";
	if (e.health <= 220) return "220";
	if (e.health <= 230) return "230";
	if (e.health <= 240) return "240";
	if (e.health <= 250) return "250";
	if (e.health <= 666) return "666";
	else return "???";
};

	
