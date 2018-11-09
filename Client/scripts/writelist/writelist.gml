///writelist(ds_list)

writebyte(ds_list_size(argument[0]));
for(var _ii=0;_ii<ds_list_size(argument[0]);_ii++){
    writeshort(ds_list_find_value(argument[0],_ii));
}
return 1;