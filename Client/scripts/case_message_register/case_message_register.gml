///@description case_message_register()
//RECIEVE_NETWORK_REGISTER

var action=readbit();
obj_login.registering=false

if action==false{
	//Error
	var error=readstring();
	show_message(error);
}else{
	//Succesful
	var username=readstring();
	show_message("Welcome "+username+"\nYou may now log in!");
}

