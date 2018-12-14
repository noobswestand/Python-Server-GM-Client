///@description case_message_player_join()
//RECIEVE_NETWORK_PLAYER_JOIN

var pid=readbyte();
var username=readstring();
var xx=readdouble(),yy=readdouble();
var msg=readbit()

var nn=instance_create_depth(xx,yy,0,obj_player_other);
nn.pid=pid;
nn.username=username;
nn.real_x=xx;
nn.real_y=yy;
ds_list_add(global.clients,nn)

if msg==true{
	scr_chat_addline(username+" has joined!")
}