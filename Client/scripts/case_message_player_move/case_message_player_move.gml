///case_message_player_move()
//RECIEVE_NETWORK_PLAYER_MOVE

var pid=readbyte();
var player=scr_player_find(pid);

if player!=noone{
	player.left=readbit();
	player.right=readbit();
	player.up=readbit();
	player.down=readbit();
		
	var xx,yy;
	xx=readdouble()
	yy=readdouble()
	player.real_x=xx;
	player.real_y=yy;
}