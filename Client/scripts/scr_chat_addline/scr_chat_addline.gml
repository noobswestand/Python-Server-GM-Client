///@description scr_chat_addline(string) Adds a new line to the chatbox
///@param string
if ds_list_size(global.chatbox)>10{
	ds_list_delete(global.chatbox,ds_list_size(global.chatbox)-1)
}
ds_list_insert(global.chatbox,0,argument[0]);
