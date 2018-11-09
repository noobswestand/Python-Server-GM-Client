

var pid=readbyte();
var str=readstring();
var player=scr_player_find(pid,true);

if pid!=noone{
	var name=player.username;
	
	scr_chat_addline(name+": "+str);
}

