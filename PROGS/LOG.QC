void() LogMatch =
{
	local entity e, f, g;
	local string temp;
	local float gotem;
	local float id_number1;
	local float id_number2;
	local string temp_string;

	local entity statdude;

	id_number1 = 10000*random();
	id_number2 = 10000*random();
	bprint("Match Number: ");
	temp_string = ftos(ceil(id_number1));
	bprint(temp_string);
	bprint("-");
	temp_string = ftos(ceil(id_number2));
	bprint(temp_string);
	bprint("\n");

	dprint("===============================\n");
	dprint("Clanring Match Results: CTF\n");
	dprint("Match Number: ");
	temp_string = ftos(ceil(id_number1));
	dprint(temp_string);
	dprint("-");
	temp_string = ftos(ceil(id_number2));
	dprint(temp_string);
	dprint("\n");
	dprint("Clan Results\n");
            e = find(world,classname,"clan");
            while (e != world)
            {
			dprint("Clan ");
			temp = ftos(e.clan_number);
			dprint(temp);
			dprint(":");
			temp = ftos(e.frags);
			dprint(temp);
			dprint(":");
			temp = ftos(e.enemy_kill);
			dprint(temp);
			dprint(":");
			temp = ftos(e.friend_kill);
			dprint(temp);
			dprint(":");
			temp = ftos(e.captures);
			dprint(temp);
			dprint(":");
			temp = ftos(e.recoveries);
			dprint(temp);
			dprint(":");
			temp = ftos(e.get_flags);
			dprint(temp);
			dprint(":");
			temp = ftos(e.frag_carriers);
			dprint(temp);
			dprint(":");
			temp = ftos(e.carrier_danger_protects);
			dprint(temp);
			dprint(":");
			temp = ftos(e.carrier_protects);
			dprint(temp);
			dprint(":");
			temp = ftos(e.flag_defences);
			dprint(temp);
			dprint(":");
			temp = ftos(e.flag_assists);
			dprint(temp);
			dprint(":");
			temp = ftos(e.carrier_assists);
			dprint(temp);
			dprint("\n");
	           	e = find(e,classname,"clan");
            }
		dprint("Player Results\n");
		f = find(world,classname,"ghost");
		while(f != world)
		{
			gotem = 0;
			g = find(world,classname,"player");
			while((g != world) && (!gotem))
			{
				if (g.ghostcode == f.ghostcode) gotem = 1;
				else g = find(g,classname,"player");
			}
			if (g != world) dprint(g.netname);
			else {
			temp=ftos(f.ghostcode);
			dprint(temp); }
			dprint(":");
			temp = ftos(f.clan_number);
			dprint(temp);
			dprint(":");
			temp = ftos(f.frags);
			dprint(temp);
			dprint(":");
			temp = ftos(f.enemy_kill);
			dprint(temp);
			dprint(":");
			temp = ftos(f.friend_kill);
			dprint(temp);
			dprint(":");
			temp = ftos(f.captures);
			dprint(temp);
			dprint(":");
			temp = ftos(f.recoveries);
			dprint(temp);
			dprint(":");
			temp = ftos(f.get_flags);
			dprint(temp);
			dprint(":");
			temp = ftos(f.frag_carriers);
			dprint(temp);
			dprint(":");
			temp = ftos(f.carrier_danger_protects);
			dprint(temp);
			dprint(":");
			temp = ftos(f.carrier_protects);
			dprint(temp);
			dprint(":");
			temp = ftos(f.flag_defences);
			dprint(temp);
			dprint(":");
			temp = ftos(f.flag_assists);
			dprint(temp);
			dprint(":");
			temp = ftos(f.carrier_assists);
			dprint(temp);
			dprint("\n");
	           	f = find(f,classname,"ghost");
		}
	dprint("===============================\n");

	statdude = find(world,classname,"player");
	while (statdude != world)
	{
		if (statdude.stat_dump) 
		{
	sprint(statdude,"===============================\n");
	sprint(statdude,"Clanring Match Results: TM\n");
	sprint(statdude,"Match Number: ");
	temp_string = ftos(ceil(id_number1));
	sprint(statdude,temp_string);
	sprint(statdude,"-");
	temp_string = ftos(ceil(id_number2));
	sprint(statdude,temp_string);
	sprint(statdude,"\n");
	sprint(statdude,"Clan Results\n");
            e = find(world,classname,"clan");
            while (e != world)
            {
			sprint(statdude,"Clan ");
			temp = ftos(e.clan_number);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(e.frags);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(e.enemy_kill);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(e.friend_kill);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(e.captures);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(e.recoveries);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(e.get_flags);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(e.frag_carriers);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(e.carrier_danger_protects);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(e.carrier_protects);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(e.flag_defences);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(e.flag_assists);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(e.carrier_assists);
			sprint(statdude,temp);
			sprint(statdude,"\n");
	           	e = find(e,classname,"clan");
            }
		sprint(statdude,"Player Results\n");
		f = find(world,classname,"ghost");
		while(f != world)
		{
			gotem = 0;
			g = find(world,classname,"player");
			while((g != world) && (!gotem))
			{
				if (g.ghostcode == f.ghostcode) gotem = 1;
				else g = find(g,classname,"player");
			}
			if (g != world) sprint(statdude,g.netname);
			else {
			temp=ftos(f.ghostcode);
			sprint(statdude,temp); }
			sprint(statdude,":");
			temp = ftos(f.clan_number);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(f.frags);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(f.enemy_kill);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(f.friend_kill);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(f.captures);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(f.recoveries);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(f.get_flags);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(f.frag_carriers);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(f.carrier_danger_protects);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(f.carrier_protects);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(f.flag_defences);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(f.flag_assists);
			sprint(statdude,temp);
			sprint(statdude,":");
			temp = ftos(f.carrier_assists);
			sprint(statdude,temp);
			sprint(statdude,"\n");
	           	f = find(f,classname,"ghost");
		}
	sprint(statdude,"===============================\n");
		}
		statdude = find(statdude,classname,"player");
	}	

};		


		


void(entity targ, entity attacker, string what) LogPlayerDMDeath =
{
	// note embedded tabs in the next string
	dprint("LOG:	DEATH	");
	dprint(targ.netname);
	dprint("/");
	dprint(ftos(targ.frags));
	dprint("	");
	dprint(attacker.netname);
	dprint("/");
	dprint(ftos(attacker.frags));
	dprint("	");
	dprint(what);
	dprint("\n");
};

void (entity targ, string what) LogPlayerDeath =
{
	dprint("LOG:	DEATH	");
	dprint(targ.netname);
	dprint("/");
	dprint(ftos(targ.frags));
	dprint("	");
	dprint(what);
	dprint("\n");
};

void (entity who, string what) LogMsg =
{
	dprint("LOG:	");
	dprint(what);
	dprint("	");
	dprint(who.netname);
	dprint("\n");
};
