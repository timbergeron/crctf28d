// Identify the player you are pointed towards
// By Suck (Nat Friedman)
// This code falls under the GNU public license, and cannot be 
// redistributed without my name attached.

// hacked by Zoid for CTF4

// This is called with the player who wants to know whose in front
// of him as "self."  I call it with an impulse in weapons.qc 

//SO 1-24-98 2.8b Stole fixed identify_player(float) from expert quake
//SO 1-24-98 2.8b Added my own comments cause i deleted theirs... whups
entity(entity slf, float disp) identify_player =
{
	// e is a temp entity; guy is our current best guess
	// as to at whom the player is pointing
	local entity e, guy;

	// The best "closeness" heuristic so far.
	local float closeness = 50;  //SO  WAAAAY off

	// Temp vars.
	local vector diff, point;
	local float currclose;
	local string s1, s2, s3;

	// Walk the list of players...
	e=find(world, classname, "player"); //SO Find a player...
	while (e!=world)
	{
		traceline(slf.origin, e.origin, FALSE, slf); // Trace a line between me and him
		if (trace_ent == e) // If we hit something and it IS him
		{
			diff = e.origin - slf.origin;  // create vector between where i am and where he is
	
			// Normalize it since we only care where he's pointing,
			// not how far away the guy is.
			diff=normalize(diff);
			
			makevectors(slf.v_angle);  // Here's the fix... have to convert from angle to vector
			diff = diff - v_forward;  // Find the difference between the vector pointing at HIM, and our own forward vector
			currclose=vlen(diff);  // Find the length of that vector (that's our measure of how good it is... if it is zero, then the vectors are identical)
			if (currclose < closeness) // if that length is less than the old lowest length, replace it.
			{
				closeness = currclose;
				guy = e;  // Our best guess so far as to who we peepin at..
			}
		}
		e = find(e, classname, "player");	// Find next player, repeat process
	}

	// Now we display.
	if ( (guy == world) || (closeness > 0.5) )  // If we found SOMEBODY, and our "close" value is less than .5 (set lower for greater accuracy)
	{
	   if (disp) // If we passed true, then centerprint who we found
                TeamPlayerUpdate2(slf, "You're not looking at anyone!", "");
	   return world;
	}
	if (disp)
	        TeamPlayerUpdate2(slf, "You're looking at ", guy.netname);
	return guy;
};	 

