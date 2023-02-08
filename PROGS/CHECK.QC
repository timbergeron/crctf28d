
/*
============
Check_Binding_Initiate
============
*/
void() Check_Binding_Initiate =
{
	self.bind_check = 1;
};

/*
============
Run_Binding_Check
============
*/
void() Run_Binding_Check =
{
	self.bind_check = 0;
	self.check_running = 1;
	stuffcmd(self,"ignorethis\n");
	self.check_time = time + 3;
};

