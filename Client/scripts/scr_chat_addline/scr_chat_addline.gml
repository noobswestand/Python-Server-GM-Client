///scr_chat_addline(string)
/*
	Adds a new line to the chatbox
*/

ds_list_insert(global.chatbox,0,argument[0]);
