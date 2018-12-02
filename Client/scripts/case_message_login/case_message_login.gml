///case_message_login
//NETWORK_LOGIN

if room==rm_menu{
	obj_login.loggingin=false
	
	var succ=readbit();
	if succ==true{
		global.username=readstring();
		global.pid=readbyte();
		global.login_x=readdouble();
		global.login_y=readdouble();
		
		room_goto_next();
	}else{
		var msg=readstring();
		
		show_message(msg);
	}
}