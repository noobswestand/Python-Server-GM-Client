///@description sendmessage([tcp])
///@param [tcp]
var tell=buffer_tell(global.Buffer);


//Write the length header
buffer_seek(global.Buffer,buffer_seek_start,0);

buffer_write(global.Buffer,global.Buffer_header,tell);//Header

//Send the message
var sent,tcp = argument_count==1 ? argument[0] : global.clienttcp;
sent=network_send_raw( tcp , global.Buffer , tell );

//If we failed to send the message, debug output
if sent<0{
    buffer_seek(global.Buffer,buffer_seek_start,2);
    var msg_id=buffer_read(global.Buffer,buffer_u8);
    show_debug_message("Sent Message of id "+string(msg_id)+" failed");
}


return sent;