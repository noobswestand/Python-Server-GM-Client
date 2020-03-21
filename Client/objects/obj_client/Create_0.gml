/// @description Connect

#region Macros

//States
#macro STATE_MENU 0
#macro STATE_GAME 1

//Packets  receive
#macro RECIEVE_NETWORK_PING 0
#macro RECIEVE_NETWORK_HANDSHAKE 1
#macro RECIEVE_NETWORK_DISCONNECT 2
#macro RECIEVE_NETWORK_REGISTER 3
#macro RECIEVE_NETWORK_LOGIN 4
#macro RECIEVE_NETWORK_PLAYER_MOVE 5
#macro RECIEVE_NETWORK_PLAYER_JOIN 6
#macro RECIEVE_NETWORK_PLAYER_LEAVE 7
#macro RECIEVE_NETWORK_PLAYER_CHAT 8
#macro RECIEVE_NETWORK_CLOSE 9



//Packets send
#macro SEND_NETWORK_PING 0
#macro SEND_NETWORK_HANDSHAKE 1
#macro SEND_NETWORK_DISCONNECT 2
#macro SEND_NETWORK_REGISTER 3
#macro SEND_NETWORK_LOGIN 4
#macro SEND_NETWORK_PLAYER_MOVE 5
#macro SEND_NETWORK_PLAYER_CHAT 6


#endregion

#region Connect to server

var type, ip_address, port;
type = network_socket_tcp;
ip_address = "127.0.0.1";
port = 64198;

// Create the socket
global.clienttcp = network_create_socket( type );
network_connect_raw( global.clienttcp, ip_address, port );

// Initialize client variables
ping = -1;
result = -1;

/// Initialize the buffer

var size, type, alignment;

size = 1024;
type = buffer_grow;
alignment = 1;
global.Buffer = buffer_create( size, type, alignment );
buffer = buffer_create( size, type, alignment );
buffer_reading=false
buffer_size=0

alarm[0] = room_speed;

#endregion


#region Logic

state=STATE_MENU;
msg_offset=0
msg_size=0



global.clients=ds_list_create();

global.username="";
global.pid=-1;

scr_chat_init();
chatting=false

#endregion
