string newmap;


/*
================
Programmable Level Sequence
================
*/

void() ProgLevel =
{

	local float next_available;

	if (mapname == level_1)
		newmap = level_2;
	else if (mapname == level_2)
		newmap = level_3;
	else if (mapname == level_3)
		newmap = level_4;
	else if (mapname == level_4)
		newmap = level_5;
	else if (mapname == level_5)
		newmap = level_6;
	else if (mapname == level_6)
		newmap = level_7;
	else if (mapname == level_7)
		newmap = level_8;
	else if (mapname == level_8)
		newmap = level_9;
	else if (mapname == level_9)
		newmap = level_10;
	else if (mapname == level_10)
		newmap = level_11;
	else if (mapname == level_11)
		newmap = level_12;
	else if (mapname == level_12)
		newmap = level_13;
	else if (mapname == level_13)
		newmap = level_14;
	else if (mapname == level_14)
		newmap = level_15;
	else if (mapname == level_15)
		newmap = level_16;
	else if (mapname == level_16)
		newmap = level_17;
	else if (mapname == level_17)
		newmap = level_18;
	else if (mapname == level_18)
		newmap = level_19;
	else if (mapname == level_19)
		newmap = level_20;
	else if (mapname == level_20)
		newmap = level_21;
	else if (mapname == level_21)
		newmap = level_22;
	else if (mapname == level_22)
		newmap = level_23;
	else if (mapname == level_23)
		newmap = level_24;
	else if (mapname == level_24)
		newmap = level_25;
	else if (mapname == level_25)
		newmap = level_26;
	else if (mapname == level_26)
		newmap = level_27;
	else if (mapname == level_27)
		newmap = level_28;
	else if (mapname == level_28)
		newmap = level_29;
	else if (mapname == level_29)
		newmap = level_30;
	else if (mapname == level_30)
		newmap = level_31;
	else if (mapname == level_31)
		newmap = level_32;
	else if (mapname == level_32)
		newmap = level_33;
	else if (mapname == level_33)
		newmap = level_34;
	else if (mapname == level_34)
		newmap = level_35;
	else if (mapname == level_35)
		newmap = level_36;
	else if (mapname == level_36)
		newmap = level_37;
	else if (mapname == level_37)
		newmap = level_38;
	else if (mapname == level_38)
		newmap = level_39;
	else if (mapname == level_39)
		newmap = level_40;
	else if (mapname == level_40)
		newmap = level_41;
	else if (mapname == level_41)
		newmap = level_42;
	else if (mapname == level_42)
		newmap = level_43;
	else if (mapname == level_43)
		newmap = level_44;
	else if (mapname == level_44)
		newmap = level_45;
	else if (mapname == level_45)
		newmap = level_46;
	else if (mapname == level_46)
		newmap = level_47;
	else if (mapname == level_47)
		newmap = level_48;
	else if (mapname == level_48)
		newmap = level_49;
	else if (mapname == level_49)
		newmap = level_50;
	else
		newmap = level_1;
	if (newmap == "none")
		newmap = level_1;
	changelevel (newmap);
};
string newmap;
void() CTFLevel =
{
	local entity o;

	// episode one
	if (mapname == "e1m1") newmap = "e1m2";
	else if (mapname == "e1m2") newmap = "e1m3";
	else if (mapname == "e1m3") newmap = "e1m4";
	else if (mapname == "e1m4") newmap = "e1m5";
	else if (mapname == "e1m5") newmap = "e1m6";
	else if (mapname == "e1m6") newmap = "e1m8";
	// e1m7 skipped, lag city
	else if (mapname == "e1m8") newmap = ctfstartmap;

	// episode two
	else if (mapname == "e2m1") newmap = "e2m2";
	else if (mapname == "e2m2") newmap = "e2m3";
	else if (mapname == "e2m3") newmap = "e2m4";
	else if (mapname == "e2m4") newmap = "e2m5";
	else if (mapname == "e2m5") newmap = "e2m6";
	else if (mapname == "e2m6") newmap = "e2m7";
	else if (mapname == "e2m7") newmap = ctfstartmap;

	// episode three
	else if (mapname == "e3m1") newmap = "e3m2";
	else if (mapname == "e3m2") newmap = "e3m3";
	else if (mapname == "e3m3") newmap = "e3m4";
	else if (mapname == "e3m4") newmap = "e3m5";
	else if (mapname == "e3m5") newmap = "e3m6";
	else if (mapname == "e3m6") newmap = "e3m7";
	else if (mapname == "e3m7") newmap = ctfstartmap;

	// episode four
	else if (mapname == "e4m1") newmap = "e4m2";
	else if (mapname == "e4m2") newmap = "e4m3";
	else if (mapname == "e4m3") newmap = "e4m4";
	else if (mapname == "e4m4") newmap = "e4m5";
	else if (mapname == "e4m5") newmap = "e4m6";
	else if (mapname == "e4m6") newmap = "e4m7";
	else if (mapname == "e4m7") newmap = "e4m8";
	else if (mapname == "e4m8") newmap = ctfstartmap;

	// the deathmatch arenas
	else if (mapname == "dm1") newmap = "dm2";
	else if (mapname == "dm2") newmap = "dm3";
	else if (mapname == "dm3") newmap = "dm4";
	else if (mapname == "dm4") newmap = "dm5";
	else if (mapname == "dm5") newmap = "dm6";
	else if (mapname == "dm6") newmap = ctfstartmap;

	// ctf episode one
	else if (mapname == "ctf1") newmap = "ctf2";
	else if (mapname == "ctf2") newmap = "ctf3";
	else if (mapname == "ctf3") newmap = "ctf4";
	else if (mapname == "ctf4") newmap = "ctf5";
	else if (mapname == "ctf5") newmap = "ctf6";
	else if (mapname == "ctf6") newmap = "ctf7";
	else if (mapname == "ctf7") newmap = "ctf8";
	else if (mapname == "ctf8") newmap = ctfstartmap;

	// ctf episode two
	else if (mapname == "ctf2m1") newmap = "ctf2m2";
	else if (mapname == "ctf2m2") newmap = "ctf2m3";
	else if (mapname == "ctf2m3") newmap = "ctf2m4";
	else if (mapname == "ctf2m4") newmap = "ctf2m5";
	else if (mapname == "ctf2m5") newmap = "ctf2m6";
	else if (mapname == "ctf2m6") newmap = "ctf2m7";
	else if (mapname == "ctf2m7") newmap = "ctf2m8";
	else if (mapname == "ctf2m8") newmap = ctfstartmap;

	else if (EXPANDED_MAPS >= 1) {

	// ctf expansion pack
	if (mapname == "ctf1bsp1") newmap = "ctf1bsp2";
	else if (mapname == "ctf1bsp2") newmap = "ctf1bsp3";
	else if (mapname == "ctf1bsp3") newmap = "ctf1bsp4";
	else if (mapname == "ctf1bsp4") newmap = "ctf1bsp5";
	else if (mapname == "ctf1bsp5") newmap = "ctf1bsp6";
	else if (mapname == "ctf1bsp6") newmap = "ctf1bsp7";
	else if (mapname == "ctf1bsp7") newmap = "ctf1bsp8";
	else if (mapname == "ctf1bsp8") newmap = "ctf1bsp9";
	else if (mapname == "ctf1bsp9") newmap = "ctf1bsp0";
	else if (mapname == "ctf1bsp0") newmap = ctfstartmap;

	else if (EXPANDED_MAPS == 2) {

	// thunderwalker episode one
	if (mapname == "twctf1") newmap = "twctf2";
	else if (mapname == "twctf2") newmap = "twctf3";
	else if (mapname == "twctf3") newmap = "twctf4";
	else if (mapname == "twctf4") newmap = "twctf5";
	else if (mapname == "twctf5") newmap = "twctf6";
	else if (mapname == "twctf6") newmap = "twctf7";
	else if (mapname == "twctf7") newmap = "twctf8";
	else if (mapname == "twctf8") newmap = "twctf9";
	else if (mapname == "twctf9") newmap = ctfstartmap;

	// thunderwalker episode two
	else if (mapname == "twctf2m1") newmap = "twctf2m2";
	else if (mapname == "twctf2m2") newmap = "twctf2m3";
	else if (mapname == "twctf2m3") newmap = "twctf2m4";
	else if (mapname == "twctf2m4") newmap = "twctf2m5";
	else if (mapname == "twctf2m5") newmap = "twctf2m6";
	else if (mapname == "twctf2m6") newmap = "twctf2m7";
	else if (mapname == "twctf2m7") newmap = "twctf2m8";
	else if (mapname == "twctf2m8") newmap = "twctf2m9";
	else if (mapname == "twctf2m9") newmap = "twctf2ma";
	else if (mapname == "twctf2ma") newmap = "twctf2mb";
	else if (mapname == "twctf2mb") newmap = "twctf2mc";
	else if (mapname == "twctf2mc") newmap = ctfstartmap;

	// xenocide episode
	else if (mapname == "xeno1") newmap = "xeno2";
	else if (mapname == "xeno2") newmap = "xeno3";
	else if (mapname == "xeno3") newmap = "xeno4";
	else if (mapname == "xeno4") newmap = "expctf1";
	else if (mapname == "expctf1") newmap = "xeno6";
	else if (mapname == "xeno6") newmap = "xeno7";
	else if (mapname == "xeno7") newmap = "xeno8";
	else if (mapname == "xeno8") newmap = "expctf2";
	else if (mapname == "expctf2") newmap = ctfstartmap;

	else
		newmap = level_1;

	}
	else
		newmap = level_1;

	}
	else
		newmap = level_1;

	if (newmap == "none")
		newmap = level_1;
	changelevel (newmap);


	/*o = spawn();
	o.map = newmap;
	o.think = execute_changelevel;
	o.nextthink = time + 0.1;
	return;

// DISABLED from here

	// find a trigger changelevel
	o = find(world, classname, "trigger_changelevel");

	// go back to start if no trigger_changelevel
	if (!o)
	{
		mapname = "start";
		o = spawn();
		o.map = mapname;
	}

	newmap = o.map;
	gameover = TRUE;

	if (o.nextthink < time)
	{
		o.think = execute_changelevel;
		o.nextthink = time + 0.1;
	}*/

};
