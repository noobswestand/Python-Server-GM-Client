/// @description Login+Register


if (ui_button_clicked(login_button) && loggingin==false && registering==false){
	loggingin=true
	clearbuffer()
	writebyte(SEND_NETWORK_LOGIN)
	writestring(ui_get_text(login_username))
	writestring(ui_get_text(login_password))
	sendmessage()
}

if (ui_button_clicked(register_button) && loggingin==false && registering==false){
	if (ui_get_text(register_password0)!=ui_get_text(register_password1)){
		register_warning=ui_textbox_create(375,600,250,35,"")
		ui_textbox_set_readonly(register_warning,1)
		ui_set_text(register_warning,"Passwords did not match!")
		alarm[0]=240
	}else{
		registering=true
		clearbuffer()
		writebyte(SEND_NETWORK_REGISTER)
		writestring(ui_get_text(register_username))
		writestring(ui_get_text(register_password0))
		sendmessage()
	}
}