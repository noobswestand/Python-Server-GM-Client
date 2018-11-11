buffer = argument[0];
var size=argument[1];

while( buffer_tell(buffer) < size ){
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

}