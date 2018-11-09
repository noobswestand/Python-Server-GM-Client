/// @description Disconnect
/*
buffer_seek( buffer, buffer_seek_start, 0 );
buffer_write( buffer, buffer_u8, NETWORK_DISCONNECT );
result = network_send_raw( socket, buffer, buffer_tell(buffer) );
*/

clearbuffer()
writebyte(SEND_NETWORK_DISCONNECT)
sendmessage()
