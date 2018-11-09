///scr_find_player(pid,[self])
/*
	pid : pid of the player - assigned when they log in
	[self] : if you want to include yourself in the results
	returns the instances ID of a given pid of a player
*/
var pid=argument[0];
for(var i=0;i<ds_list_size(global.clients);i++){
	var player=global.clients[|i];
	if player.pid==pid{
		return player;
	}
}

if argument_count>1 && argument[1]==true{
	if pid==global.pid{
		return obj_player_self;
	}
}

return noone;