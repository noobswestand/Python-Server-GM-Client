

var pid=readbyte();
var str=readstring();
var player=scr_player_find(pid,true);

if player!=noone{
	var name=player.username;
	
	scr_chat_addline(name+": "+str);
}

//server message
if pid==0{
	scr_chat_addline(str);
}