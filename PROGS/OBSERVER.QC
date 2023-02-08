entity(entity slf, float disp) identify_player;
void() MakeChaseMode;
void(entity who, string s) TeamPlayerUpdate;
void(entity who, string s1, string s2) TeamPlayerUpdate2;


void(entity player) ObserverInfo =
{
};

void(entity player) ObserverInit =
{
};

void(entity player) ObserverHelp =
{
};

void(entity player) ObserverSetPlayerPos;
//==============================================================
//   ObserverTeleportThroughDoor
//==============================================================

void(entity player,entity door) ObserverTeleportThroughDoor =
{
  local entity d,d_master;
  local vector dmin,dmax;
  
  d_master = d = door.owner;
  if (d_master) {
    dmin = d_master.absmin;
    dmax = d_master.absmax;
  } else { 
    dmin = dmax = '0 0 0'; 
  }
  if (dmin != dmax) {
    // regular doors
    if (d_master.state != STATE_BOTTOM) return;
    do {
      // dprint (vtos(d.absmin)); dprint (" "); dprint (vtos(d.absmax)); dprint ("\n");
      if (d.absmin_x < dmin_x) { dmin_x = d.absmin_x; }
      if (d.absmax_x > dmax_x) { dmax_x = d.absmax_x; }
      if (d.absmin_y < dmin_y) { dmin_y = d.absmin_y; }
      if (d.absmax_y > dmax_y) { dmax_y = d.absmax_y; }
      if (d.absmin_z < dmin_z) { dmin_z = d.absmin_z; }
      if (d.absmax_z > dmax_z) { dmax_z = d.absmax_z; }
      d = d.enemy; // next linked door;
    } while ((d != d_master) && (d != world));
  }
  else {
    // secret doors
    // we ignore these currently
    return;
  }
  
  {
    local float is_x,is_y,is_z,set;
    local vector dir,or;
    set = is_x = is_y = is_z = FALSE;
    or = player.origin;
    if (dmin_x + 15 < player.absmin_x && player.absmax_x < dmax_x - 15) is_x = TRUE;
    if (dmin_y + 15 < player.absmin_y && player.absmax_y < dmax_y - 15) is_y = TRUE;
    if (dmin_z + 15 < player.absmin_z && player.absmax_z < dmax_z - 15) is_z = TRUE;
//     bprint("doors:  "); bprint (vtos(dmin)); bprint (" "); bprint (vtos(dmax)); bprint ("\n");
//     bprint("player: "); bprint (vtos(player.absmin)); bprint (" "); bprint (vtos(player.absmax)); bprint ("\n");
    if (is_x && is_y) {
//       bprint("door is in xy plane\n");
      if      (or_z < dmin_z) { dir = '0 0  1'; or_z = dmax_z + 25; }
      else if (or_z > dmax_z) { dir = '0 0 -1'; or_z = dmin_z - 25; }
      set = TRUE;
    }
    else if (is_x && is_z) {
//       bprint("door is in xz plane\n");
      if      (or_y < dmin_y) { dir = '0  1 0'; or_y = dmax_y + 25; }
      else if (or_y > dmax_y) { dir = '0 -1 0'; or_y = dmin_y - 25; }
      set = TRUE;
    }
    else if (is_y && is_z) {
//       bprint("door is in yz plane\n");
      if      (or_x < dmin_x) { dir = ' 1 0 0'; or_x = dmax_x + 25; }
      else if (or_x > dmax_x) { dir = '-1 0 0'; or_x = dmin_x - 25; }
      set = TRUE;
    }
      if (set) { 
	local vector v;
	v =  normalize(player.velocity);
	if (dir * v < 0.5) return;
	player.origin = or;
	setorigin (player, player.origin);
      }
  }
};

//==============================================================
//   ObserverTeleportThroughTeleporter
//==============================================================

void(entity player,entity tele) ObserverTeleportThroughTeleporter =
{
  local entity targ;
  local vector v1,v2;
  
  v1 = ((tele.absmax + tele.absmin) * 0.5) - player.origin; normalize(v1);
  v2 = player.velocity; normalize(v2);
  if (v1 * v2 <= 0.1) return;
  
  targ = find (world, targetname, tele.target);
  if (!targ) {
    dprint("ObserverTeleportThroughTeleporter: couldn't find teleporter target\n");
    return;
  }
  makevectors (targ.mangle);
  setorigin (player, targ.origin);
  player.angles = targ.mangle;
  player.fixangle = TRUE; // turn this way immediately
  player.teleport_time = time + 0.7;
  player.velocity = v_forward * 300;
  // player.flags = player.flags - player.flags & FL_ONGROUND;
};

/* SO 2.8c OMG does anyone but me think that the CRCTF code is getting bloated and unoptimized?
Me too.  But i don't want to be the one to rewrite CRCTF!! :) So, who's it gonna be? */

void () ObserverThink =
{
   local entity ent;

   if (!(self.quaketv & QTV_OBSERVER)) return;
   if (!self.announce_chase_time || self.announce_chase_time < time && !(self.motd) && !(self.quaketv & (QTV_CHASE | QTV_AUTOCAM))) //SO 2.8b if we're observer but not chasecam or autocam, constantly update who we're looking at
        {
        self.announce_chase_time = time + 0.2;
        ent = identify_player(self, !self.quaketv & QTV_FOUNDTARG); // pass this value so if we hae a targ found, it won't display "youre staring at" but "release fire to chase" instead
	if (self.button0)
		{
		if (ent != world)
			{
			self.quaketv = self.quaketv | QTV_FOUNDTARG;
			self.chasetarg = ent;
			TeamPlayerUpdate2(self, "Release fire to chase ", self.chasetarg.netname);
			}
		else
			{
			self.quaketv = self.quaketv - QTV_FOUNDTARG;
			self.chasetarg = world;
			TeamPlayerUpdate(self, "Find somebody, point at them\n and release to chase!");
			}
		}
	else if ( (self.chasetarg != world) && (self.quaketv & QTV_FOUNDTARG) ) // SO we not pressing fire, we have a player in sights, and were (at one time) pressing fire
		{
		MakeChaseMode();
		}
	else self.quaketv = self.quaketv - (self.quaketv & QTV_FOUNDTARG); // SO after button is released (and we werent looking at peoples) it will resume displaying "you starin at"
        }
   else if ( (self.button0) && (self.quaketv & QTV_CHASE) ) // SO 2.8c ok, if we're chasing a guy, and we hit fire, we go to observer, but stay where we are, not go to a spawn point. Much thanx to BSF-Schroedinger for this idea!!!
	{
	self.quaketv = self.quaketv - QTV_CHASE;
	if (self.quaketv & QTV_CAMERA)
		self.quaketv = self.quaketv - QTV_CAMERA;
	if (self.quaketv & QTV_AUTOCAM)
		self.quaketv = self.quaketv - QTV_AUTOCAM;
	if (self.quaketv & QTV_CHASE)
		self.quaketv = self.quaketv - QTV_CHASE;
	if (self.quaketv & QTV_AUTOCHASE)
		self.quaketv = self.quaketv - QTV_AUTOCHASE;
	if (self.quaketv & QTV_QUAKETV)
		self.quaketv = self.quaketv - QTV_QUAKETV;
	if (self.quaketv & QTV_FREELOOK)
		self.quaketv = self.quaketv - QTV_FREELOOK;
	if (self.quaketv & QTV_FOUNDTARG)
		self.quaketv = self.quaketv - QTV_FOUNDTARG;
	self.health = 998;
	self.armorvalue = 0;
	self.items = 0;
	self.armortype = 0;
	self.currentammo = 0;
	self.ammo_shells = 0;
	self.ammo_nails = 0;
	self.ammo_rockets = 0;
	self.ammo_cells = 0;
	self.weapon = 0;
	setorigin( self, self.chasetarg.origin); // SO 2.8c so we don't get stuck in walls and crap
	}
   if (self.quaketv & QTV_CAMERA) 
	{	return; 	}
   if (self.movetype != MOVETYPE_FLY) {
      // will come here after changing level
      self.observer_status = self.observer_status | OBSERVER_BECOME_OBSERVER;
       
   }

//  local string tmp;
//  local float norm;
//  tmp = ftos(self.speed); dprint(tmp); dprint(" ");
//  tmp = vtos(v_forward); dprint(tmp); dprint(" ");
//  dprint("\n");

//  { 
      local float invcos,nv,nvp,nvpmax,nvs,nsp,sp,svz;
      local vector f,vp,vs;

      svz = self.velocity_z;
      self.velocity_z = 0;

      // v_forward is normalized
      f_x = v_forward_x; 
      f_y = v_forward_y; 
      f_z = 0;
      invcos = vlen(f); if (invcos) invcos= 1/invcos; else invcos=0;
      f = f*invcos; // normalize f

      sp = f * self.velocity;
      vp = sp*f;
      nvp = vlen(vp); if (sp<0) nvp = nvp*(-1);
      vs = self.velocity - vp;

      vp = v_forward * (nvp * invcos);
      vp_z = vp_z + svz;
      nvp = vlen(vp);
      nvpmax = (320 - 100*(v_forward * '0 0 1'));
      if (nvp > nvpmax) { vp = vp * (nvpmax/nvp); }

      self.velocity = vp + vs;

//  }
  {
    local entity e;
    local float cont;
    e = findradius(self.origin,75);
    if (e) { cont = TRUE;  }
    else   { cont = FALSE; }
    while (cont) {
      // dprint(e.classname); dprint("\n");
      if (e.classname == "door") {
	ObserverTeleportThroughDoor(self,e);
	cont = FALSE;
      }
      if (e.classname == "trigger_teleport") {
	ObserverTeleportThroughTeleporter(self,e);
	cont = FALSE;
      }
      e = e.chain;
      if (!e) { cont = FALSE; }
    }
  }

   self.weaponmodel = "";
   self.weaponframe = 0;

   if (self.observer_status & OBSERVER_BECOME_OBSERVER) {
	self.movetype = MOVETYPE_WALK;
      self.observer_pos_num = 0;
      self.observer_status = self.observer_status - OBSERVER_BECOME_OBSERVER;
      self.observer_pos_num = 1 + random() * 4;
      ObserverBecomeObserver(self);
      ObserverSetPlayerPos(self);
      centerprint(self, "Observer Mode Enabled\n");
   }

   if (self.observer_status & OBSERVER_NEXTVIEW) {
      self.observer_pos_num = self.observer_pos_num + 1;
      ObserverSetPlayerPos(self);
      self.observer_status = self.observer_status - OBSERVER_NEXTVIEW;
      return;
   }

   if (self.observer_status & OBSERVER_PREVVIEW) {
      self.observer_pos_num = self.observer_pos_num - 1;
      ObserverSetPlayerPos(self);
      self.observer_status = self.observer_status - OBSERVER_PREVVIEW;
      return;
   }

   if (self.button0) {
      self.observer_status = self.observer_status | OBSERVER_BUTTON0;
   }
   if (self.button1) {
      self.observer_status = self.observer_status | OBSERVER_BUTTON1;
   }
   if (self.button2) {
      self.observer_status = self.observer_status | OBSERVER_BUTTON2;
   }
   if (self.button0 || self.button1 || self.button2) {
      return;
   }

   if (self.observer_status & (OBSERVER_BUTTON2 | OBSERVER_BUTTON1)) {
      if (!self.button0 && !self.button1 && !self.button2) {
         self.observer_status = OBSERVER_NEXTVIEW;
         return;
      
	}
   }
};

float() ObserverDeathThink = 
{

   if (self.button1) {
      self.observer_status = self.observer_status | OBSERVER_BUTTON1;
      return(1);
   }
   if (self.button2) {
      self.observer_status = self.observer_status | OBSERVER_BUTTON2;
      return(1);
   }

   return(0);
};

void(entity player) ObserverBecomeObserver =
{
   //dprint("ObserverBecomeObserver: executing\n");//#jp#(debug)

   player.armorvalue    = 0;
   player.items         = 0;
   player.health        = 998;
   player.ammo_shells   = 0;
   player.ammo_nails    = 0;
   player.ammo_rockets  = 0;
   player.ammo_cells    = 0;
   player.weapon        = 0;
   player.currentammo   = 1;
   player.takedamage    = DAMAGE_NO;
   player.solid         = SOLID_NOT;
   player.movetype      = MOVETYPE_FLY;
   player.deadflag      = DEAD_NO;
//   player.quaketv         = player.quaketv | QTV_OBSERVER;

   setmodel (player, string_null);
};


entity(entity player) ObserverFindPos =
{
   local entity spot;
   local float pos_num_startsearch;

   //dprint("ObserverFindPos: executing\n");
   if      (player.observer_pos_num <= 0)  player.observer_pos_num = 1;
   else if (player.observer_pos_num >= 21) player.observer_pos_num = 1;
   pos_num_startsearch = player.observer_pos_num;

   if (player.observer_pos_num <= 5) {
                                                     spot = find (world, classname, "info_intermission");
      if (player.observer_pos_num >= 2 && !(!spot))  spot = find (spot,  classname, "info_intermission");
      if (player.observer_pos_num >= 3 && !(!spot))  spot = find (spot,  classname, "info_intermission");
      if (player.observer_pos_num >= 4 && !(!spot))  spot = find (spot,  classname, "info_intermission");
      if (!spot) player.observer_pos_num = 5;
   }
   if (player.observer_pos_num >= 5) {
                                                     spot = find (world, classname, "info_player_deathmatch");
      if (player.observer_pos_num >=  6 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >=  7 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >=  8 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >=  9 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >= 10 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >= 11 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >= 12 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >= 13 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >= 14 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >= 15 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >= 16 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >= 17 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >= 18 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >= 19 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (player.observer_pos_num >= 20 && !(!spot)) spot = find (spot,  classname, "info_player_deathmatch");
      if (!spot) player.observer_pos_num = 21;
   }
   if (player.observer_pos_num >= 21) {
         spot = find (world, classname, "info_player_start");
         player.observer_pos_num = 21;
   }
   if (!spot && pos_num_startsearch != 1) {
      player.observer_pos_num = player.observer_pos_num + 1;
      spot=ObserverFindPos(player);
   }
   if (!spot) error ("ObserverFindPos: could not find start pos");
   return spot;
};

void(entity player) ObserverSetPlayerPos =
{
   local entity pos;
   local vector posoffset;

   //dprint("ObserverSetPlayerPos: executing\n");//#jp#(debug)

   pos = ObserverFindPos(player);

   player.angles        = player.v_angle = pos.mangle;
   player.fixangle      = TRUE;         // turn this way immediately
   player.view_ofs      = '0 0 12'; // must be != '0 0 0'
   player.velocity      = '0 0 0';

   makevectors (self.angles);
   setsize (player, '-12  -12 -12', '12 12 12');


   // avoid stuck observers for intermission spots 
   if (player.observer_pos_num <=4) setorigin (player, pos.origin + '0 0 -60');
   else                           setorigin (player, pos.origin);

//#jp# Hack to provide a decent flying velocity.
//#jp# I'd normally expect the above three lines to be sufficient, but ...
//#jp# Damn it, what a mess this is.
//#jp# Hope this doesn't cause side effects.

   player.flags = player.flags | FL_ONGROUND;
};

/*
=============
Unused:
   player.view_ofs      = '0 0 22'; // must be != '0 0 0'
   setsize (player, VEC_HULL_MIN, VEC_HULL_MAX);
=============
*/
