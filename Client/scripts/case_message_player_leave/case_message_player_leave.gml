///@description case_message_player_leave()
//RECIEVE_NETWORK_PLAYER_LEAVE

var pid=readbyte();
var player=scr_player_find(pid);

if player!=noone{
	scr_chat_addline(player.username+" has left")
	with(player){instance_destroy()}
	//remove from list of players
	ds_list_delete(global.clients,ds_list_find_index(global.clients,player))
}
