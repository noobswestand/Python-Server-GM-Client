/// @description Movement

left=keyboard_check(vk_left)
right=keyboard_check(vk_right)
up=keyboard_check(vk_up)
down=keyboard_check(vk_down)

x+=(right-left)*5
y+=(down-up)*5

if pup!=up || pdown!=down || pleft!=left || pright!=right || move_update==true{
	pup=up
	pdown=down
	pleft=left
	pright=right
	move_update=false
	
	clearbuffer()
	writebyte(SEND_NETWORK_PLAYER_MOVE)
	writebit(left)
	writebit(right)
	writebit(up)
	writebit(down)
	writedouble(x)
	writedouble(y)
	sendmessage()
}

