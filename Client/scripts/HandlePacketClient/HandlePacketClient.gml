///@description HandlePacketClient(buffer,size)
///@param buffer
///@param size
var size=argument[1];


if buffer_reading==true{
	//if we are in the middle of reading a very large packet
	buffer_copy(argument[0],0,argument[1],buffer,buffer_size)
	buffer_size+=size;
}else{
	buffer_copy(argument[0],0,argument[1],buffer,0)
	buffer_seek(buffer,buffer_seek_start,0)
	buffer_size=size;
}


while( buffer_tell(buffer) < size ){

if buffer_reading==false{
	msg_size=readushort()//Read the header
	buffer_reading=true
}

if msg_size>buffer_size{
	break//wait for the rest of the packet
}


var msg_id = readbyte();
switch( msg_id ) {
    case RECIEVE_NETWORK_PING://Ping
        var time = readint();
        ping = current_time - time - room_speed;
    break;
	case RECIEVE_NETWORK_HANDSHAKE: //Handshake
		clearbuffer()
		writebyte(SEND_NETWORK_HANDSHAKE)
		sendmessage()
	break;
	
	case RECIEVE_NETWORK_LOGIN://Logging In
		case_message_login();
	break;
	
	case RECIEVE_NETWORK_REGISTER:
		case_message_register();
	break;
	
	case RECIEVE_NETWORK_PLAYER_MOVE:
		case_message_player_move();
	break;
	
	case RECIEVE_NETWORK_PLAYER_JOIN:
		case_message_player_join();
	break;
	case RECIEVE_NETWORK_PLAYER_LEAVE:
		case_message_player_leave();
	break;
	
	case RECIEVE_NETWORK_PLAYER_CHAT:
		case_message_player_chat();
	break;
	
	case RECIEVE_NETWORK_CLOSE:
		case_message_close()
	break;
	
	
	default:
		show_debug_message("Unkown packet of id: "+string(msg_id))
	break;
	
}

//Jump forward the packet size
msg_offset+=msg_size
buffer_seek(buffer,buffer_seek_start,msg_offset)
buffer_reading=false

}

msg_offset=0