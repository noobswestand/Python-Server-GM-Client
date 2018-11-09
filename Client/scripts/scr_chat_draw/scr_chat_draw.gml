///scr_chat_draw(x,y,lines)
/*
	Draws the chatbox
*/

var xx=argument[0],yy=argument[1],lines=argument[2];
var hh=string_height("A");
var size=ds_list_size(global.chatbox);

var lim=min(lines,size);

var c=0;
for(var i=size-1;i>=0;i-=1){
	draw_text(xx,yy+(hh*c),global.chatbox[|i])
	c+=1;
}
