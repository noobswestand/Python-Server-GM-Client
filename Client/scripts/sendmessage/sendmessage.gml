///@description sendmessage([tcp])
///@param [tcp]
var __a;

if argument_count==1{ 
	__a=network_send_raw( argument[0] , global.Buffer , buffer_tell( global.Buffer ) );
}else{
	__a=network_send_raw( global.clienttcp , global.Buffer , buffer_tell( global.Buffer ) );
}
if __a<0{
    buffer_seek(global.Buffer,0,0)
    _case=buffer_read(global.Buffer,buffer_u8)
    show_debug_message("Sent Message of id "+string(_case)+" failed")
}
return __a;