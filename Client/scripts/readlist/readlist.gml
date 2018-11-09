///readlist(ds_list)

var size=readbyte();
for(var _ii=0;_ii<size;_ii++){
    //ds_list_replace(argument[0],_ii,buffer_read(buffer,buffer_s16));
    argument0[| _ii]=buffer_read(buffer,buffer_s16)
}

return 1;
