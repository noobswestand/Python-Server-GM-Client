/// @description Network

var net_event_type = ds_map_find_value( async_load, "type" );
//show_debug_message("Event type: " + string(net_event_type))
switch( net_event_type ) {
    case network_type_data:
		var buffer   = async_load[? "buffer" ];
		var size   = async_load[? "size" ];
        buffer_seek( buffer, buffer_seek_start, 0 );
        HandlePacketClient( buffer, size );
        break;
}