/// @description Debug + Chat

draw_set_alpha(1)
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_text(0,0,"ping: "+string(ping)+"ms")

scr_chat_draw(0,20,5);
if chatting==true{
	draw_text(0,300,keyboard_string+"|")
	if keyboard_check_released(vk_enter) && keyboard_string!=""{
		chatting=false
		clearbuffer()
		writebyte(SEND_NETWORK_PLAYER_CHAT)
		writestring(keyboard_string)
		sendmessage()
	}
	if keyboard_check_released(vk_enter) && keyboard_string==""{
		chatting=false
	}
}else{
	if keyboard_check_released(vk_enter){
		chatting=true
		keyboard_string=""
	}
}

