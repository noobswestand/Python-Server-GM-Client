/// @description Ping
/*
buffer_seek( buffer, buffer_seek_start, 0 );
buffer_write( buffer, buffer_u8, NETWORK_PING );
buffer_write( buffer, buffer_s32, current_time );
result = network_send_raw( socket, buffer, buffer_tell(buffer) );
*/

clearbuffer()
writebyte(SEND_NETWORK_PING)
writeint(current_time)
sendmessage()

alarm[0] = room_speed;

