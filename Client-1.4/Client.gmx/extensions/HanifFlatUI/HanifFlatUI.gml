#define ui_start
globalvar ui_global_config, ui_global_controls, ui_keyboard;
ui_global_config = ds_map_create();
ds_map_add(ui_global_config, "debug_mode", false);
ds_map_add(ui_global_config, "keyboard_action", true);
ds_map_add(ui_global_config, "enable_keyboard", true);
ds_map_add(ui_global_config, "draw_on_gui", true);
ds_map_add(ui_global_config, "default_background_colour", ui_teal);
ds_map_add(ui_global_config, "default_foreground_colour", ui_white);
ds_map_add(ui_global_config, "default_text_font", ui_default);
ds_map_add(ui_global_config, "default_label_font", ui_default);
ds_map_add(ui_global_config, "enable_shadow", true);
ds_map_add(ui_global_config, "enable_effect", true);
ds_map_add(ui_global_config, "effect_speed", 8);
ui_global_controls = ds_list_create();
ui_keyboard = ds_map_create();
ds_map_add(ui_keyboard, "ui_active", true);
ds_map_add(ui_keyboard, "ui_target", ui_default);
ds_map_add(ui_keyboard, "ui_nav", true);
ds_map_add(ui_keyboard, "ui_nav_height", 32);
ds_map_add(ui_keyboard, "ui_height", 248);
ds_map_add(ui_keyboard, "ui_show", false);
ds_map_add(ui_keyboard, "ui_clicked", false);
ds_map_add(ui_keyboard, "ui_time_entered", 0);
ds_map_add(ui_keyboard, "ui_shift", 0);
ds_map_add(ui_keyboard, "ui_fn", false);
ds_map_add(ui_keyboard, "ui_hold", 0);
ds_map_add(ui_keyboard, "ui_background_colour", ui_colour_darker(ui_white));
ds_map_add(ui_keyboard, "ui_foreground_colour", ui_colour_darker(ui_grey));
ds_map_add(ui_keyboard, "ui_font", ui_default);
ds_map_add(ui_keyboard, "ui_top", 0);
ds_map_add(ui_keyboard, "ui_effect", ds_map_find_value(ui_global_config, "enable_effect"));
ds_map_add(ui_keyboard, "ui_effect_speed", ds_map_find_value(ui_global_config, "effect_speed") / 20);
ds_map_add(ui_keyboard, "ui_shadow", ds_map_find_value(ui_global_config, "enable_shadow"));
return true;



#define ui_end
if(ds_exists(ui_global_controls, ds_type_list)){
  for(var ui_i = 0 ; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
    var control = ds_list_find_value(ui_global_controls, ui_i);
    if(ds_exists(control, ds_type_map)){
      if(ui_get_type(control) == ui_type_select){
        var ui_items = ds_map_find_value(control, "ui_items");
        if(ds_exists(ui_items, ds_type_list)){ds_list_destroy(ui_items);}
        ds_map_destroy(control);
      }
      else if(ui_get_type(control) == ui_type_tab){
        var ui_items = ds_map_find_value(control, "ui_items");
        if(ds_exists(ui_items, ds_type_list)){
          for(var ui_j = 0; ui_j < ds_list_size(ui_items); ui_j += 1){
            var ui_tab_item = ds_list_find_value(ui_items, ui_j);
            if(ds_exists(ui_tab_item, ds_type_map)){
              if(ds_map_exists(ui_tab_item, "ui_tab_surface")){
                if(surface_exists(ds_map_find_value(ui_tab_item, "ui_tab_surface"))){surface_free(ds_map_find_value(ui_tab_item, "ui_tab_surface"));}
              }
              ds_map_destroy(ui_tab_item);
            }
          }
          ds_list_destroy(ui_items);
        }
        ds_map_destroy(control);
      }
      else if(ui_get_type(control) == ui_type_sidenav){
        var ui_surface = ds_map_find_value(control, "ui_surface");
        if(surface_exists(ui_surface)){surface_free(ui_surface);}
        ds_map_destroy(control);
      }
      else{ds_map_destroy(control);}
    }
    else if(ds_exists(control, ds_type_list)){ds_list_destroy(control);}
  }
  ds_list_destroy(ui_global_controls);
  ds_map_destroy(ui_global_config);
  ds_map_destroy(ui_keyboard);
  return true;
}
else{
  ui_debug_error(100, "ui_end", object_get_name(object_index));
  return false;
}


#define ui_exists
if(argument_count == 1){
  if(ds_exists(ui_global_controls, ds_type_list)){  
    if(ds_exists(argument[0], ds_type_map)){    
      var index = ds_list_find_index(ui_global_controls, argument[0]);
      if(index != undefined){
        return true;
      }
    }
    else{
      ui_debug_error(102, "ui_exists", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(100, "ui_exists", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_exists", object_get_name(object_index));
  return false;
}



#define ui_destroy
if(argument_count == 1){
  if(ds_exists(ui_global_controls, ds_type_list)){
    if(ds_exists(argument[0], ds_type_map)){
      if(ui_get_type(argument[0]) == ui_type_select){
        var ui_items = ds_map_find_value(argument[0], "ui_items");
        if(ds_exists(ui_items, ds_type_list)){ds_list_destroy(ui_items);}
        ds_map_destroy(argument[0]);
      }
      else if(ui_get_type(argument[0]) == ui_type_tab){
        var ui_items = ds_map_find_value(argument[0], "ui_items");
        if(ds_exists(ui_items, ds_type_list)){
          for(var ui_j = 0; ui_j < ds_list_size(ui_items); ui_j += 1){
            var ui_tab_item = ds_list_find_value(ui_items, ui_j);
            if(ds_exists(ui_tab_item, ds_type_map)){
              if(ds_map_exists(ui_tab_item, "ui_tab_surface")){
                if(surface_exists(ds_map_find_value(ui_tab_item, "ui_tab_surface"))){surface_free(ds_map_find_value(ui_tab_item, "ui_tab_surface"));}
              }
              ds_map_destroy(ui_tab_item);
            }
          }
          ds_list_destroy(ui_items);
        }
        ds_map_destroy(argument[0]);
      }
      else if(ui_get_type(argument[0]) == ui_type_sidenav){
        var ui_surface = ds_map_find_value(argument[0], "ui_surface");
        if(surface_exists(ui_surface)){surface_free(ui_surface);}
        ds_map_destroy(argument[0]);
      }
      else{ds_map_destroy(argument[0]);}
      
      var index = ds_list_find_index(ui_global_controls, argument[0]);
      if(index != undefined){
        ds_list_delete(ui_global_controls, index);
      }
      return true;
    }
    else if(ds_exists(argument[0], ds_type_list)){
      ds_list_destroy(argument[0]);
      return true;
    }
    else{
      ui_debug_error(102, "ui_destroy", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(100, "ui_destroy", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_destroy", object_get_name(object_index));
  return false;
}


#define ui_clear_all
if(ds_exists(ui_global_controls, ds_type_list)){
  for(var ui_i = 0 ; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
    var control = ds_list_find_value(ui_global_controls, ui_i);
    if(ds_exists(control, ds_type_map)){
      if(ui_get_type(control) == ui_type_select){
        var ui_items = ds_map_find_value(control, "ui_items");
        if(ds_exists(ui_items, ds_type_list)){ds_list_destroy(ui_items);}
        ds_map_destroy(control);
      }
      else if(ui_get_type(control) == ui_type_tab){
        var ui_items = ds_map_find_value(control, "ui_items");
        if(ds_exists(ui_items, ds_type_list)){
          for(var ui_j = 0; ui_j < ds_list_size(ui_items); ui_j += 1){
            var ui_tab_item = ds_list_find_value(ui_items, ui_j);
            if(ds_exists(ui_tab_item, ds_type_map)){
              if(ds_map_exists(ui_tab_item, "ui_tab_surface")){
                if(surface_exists(ds_map_find_value(ui_tab_item, "ui_tab_surface"))){surface_free(ds_map_find_value(ui_tab_item, "ui_tab_surface"));}
              }
              ds_map_destroy(ui_tab_item);
            }
          }
          ds_list_destroy(ui_items);
        }
        ds_map_destroy(control);
      }
      else if(ui_get_type(control) == ui_type_sidenav){
        var ui_surface = ds_map_find_value(control, "ui_surface");
        if(surface_exists(ui_surface)){surface_free(ui_surface);}
        ds_map_destroy(control);
      }
      else{ds_map_destroy(control);}
    }
    else if(ds_exists(control, ds_type_list)){ds_list_destroy(control);}
  }
  ds_list_clear(ui_global_controls);
  return true;
}
else{
  ui_debug_error(100, "ui_clear_all", object_get_name(object_index));
  return false;
}

#define ui_draw_all
if(ds_exists(ui_global_controls, ds_type_list)){
  for(var ui_i = 0; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
    var control = ds_list_find_value(ui_global_controls, ui_i);
    if(ds_exists(control, ds_type_map)){
      var ui_start_x = 0;
      var ui_start_y = 0;      
      if(ds_map_exists(control, "ui_start_x")){
        ui_start_x = ds_map_find_value(control, "ui_start_x")
      }
      if(ds_map_exists(control, "ui_start_y")){
        ui_start_y = ds_map_find_value(control, "ui_start_y")
      }
      if(ui_start_x == 0 && ui_start_y == 0){
        switch(ui_get_type(control)){
          case ui_type_button:ui_button_draw(control);break;
          case ui_type_textbox:ui_textbox_draw(control);break;
          case ui_type_checkbox:ui_checkbox_draw(control);break;
          case ui_type_switch:ui_switch_draw(control);break;
          case ui_type_radio:ui_radio_draw(control);break;
          case ui_type_range:ui_range_draw(control);break;
          case ui_type_tab:ui_tab_draw(control);break;
        }
      }
    }
  }
  for(var ui_i = 0; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
    var control = ds_list_find_value(ui_global_controls, ui_i);
    if(ds_exists(control, ds_type_map)){
      var ui_start_x = 0;
      var ui_start_y = 0;      
      if(ds_map_exists(control, "ui_start_x")){
        ui_start_x = ds_map_find_value(control, "ui_start_x")
      }
      if(ds_map_exists(control, "ui_start_y")){
        ui_start_y = ds_map_find_value(control, "ui_start_y")
      }
      if(ui_start_x == 0 && ui_start_y == 0){     
        switch(ui_get_type(control)){
          case ui_type_select:ui_select_draw(control);break;
          case ui_type_sidenav:ui_sidenav_draw(control);break;
        }
      }
    }
  }
  if(ds_exists(ui_global_config, ds_type_map)){
    if(ds_map_find_value(ui_global_config, "enable_keyboard")){
      ui_keyboard_draw();
    }
  }
  return true;
}
else{
  ui_debug_error(100, "ui_draw_all", object_get_name(object_index));
  return false;
}






#define ui_colour_lighter
if(argument_count == 1){
  var ui_h = colour_get_hue(argument[0]);
  var ui_s = colour_get_saturation(argument[0]);
  var ui_v = colour_get_value(argument[0]);
  return make_colour_hsv(ui_h, ui_s, min(ui_v + 32, 255));
}
else{
  ui_debug_error(101, "ui_colour_lighter", object_get_name(object_index));
  return false;
}






#define ui_colour_darker
if(argument_count == 1){
  var ui_h = colour_get_hue(argument[0]);
  var ui_s = colour_get_saturation(argument[0]);
  var ui_v = colour_get_value(argument[0]);
  return make_colour_hsv(ui_h, ui_s, max(ui_v - 32, 0));
}
else{
  ui_debug_error(101, "ui_colour_darker", object_get_name(object_index));
  return false;
}






#define ui_colour_lighter_ext
if(argument_count == 2){
  var ui_h = colour_get_hue(argument[0]);
  var ui_s = colour_get_saturation(argument[0]);
  var ui_v = colour_get_value(argument[0]);
  return make_colour_hsv(ui_h, ui_s, min(ui_v + argument[1] * 32, 255));
}
else{
  ui_debug_error(101, "ui_colour_lighter_ext", object_get_name(object_index));
  return false;
}






#define ui_colour_darker_ext
if(argument_count == 2){
  var ui_h = colour_get_hue(argument[0]);
  var ui_s = colour_get_saturation(argument[0]);
  var ui_v = colour_get_value(argument[0]);
  return make_colour_hsv(ui_h, ui_s, min(ui_v - argument[1] * 32, 255));
}
else{
  ui_debug_error(101, "ui_colour_darker_ext", object_get_name(object_index));
  return false;
}






#define ui_set_foreground_colour
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_foreground_colour")){
      ds_map_replace(argument[0], "ui_foreground_colour", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_set_foreground_colour", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_foreground_colour", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_foreground_colour", object_get_name(object_index));
  return false;
}






#define ui_set_inner_colour
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_inner_colour")){
      ds_map_replace(argument[0], "ui_inner_colour", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_set_inner_colour", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_inner_colour", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_inner_colour", object_get_name(object_index));
  return false;
}






#define ui_set_background_colour
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_background_colour")){
      ds_map_replace(argument[0], "ui_background_colour", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_set_background_colour", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_background_colour", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_background_colour", object_get_name(object_index));
  return false;
}






#define ui_get_enable
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_enable")){return ds_map_find_value(argument[0], "ui_enable");}
    else{
      ui_debug_error(103, "ui_get_enable", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_get_enable", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_get_enable", object_get_name(object_index));
  return false;
}






#define ui_set_enable
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_enable")){
      ds_map_replace(argument[0], "ui_enable", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_set_enable", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_enable", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_enable", object_get_name(object_index));
  return false;
}






#define ui_get_focus
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_focus")){return ds_map_find_value(argument[0], "ui_focus");}
    else{
      ui_debug_error(103, "ui_get_focus", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_get_focus", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_get_focus", object_get_name(object_index));
  return false;
}






#define ui_set_focus
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_focus")){
      if(ds_exists(ui_global_controls, ds_type_list) && argument[1] == true){
         for(var ui_i = 0; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
          var control = ds_list_find_value(ui_global_controls, ui_i);
          if(ds_map_exists(control, ds_type_map)){
            if(ds_map_exists(control, "ui_focus")){ds_map_replace(control, "ui_focus", false);}
          }
        }
      }
      ds_map_replace(argument[0], "ui_focus", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_set_focus", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_focus", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_focus", object_get_name(object_index));
  return false;
}






#define ui_get_position
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(argument[1] == 0) var ui_request = "ui_x";
    else if(argument[1] == 1) var ui_request = "ui_y";
    if(ds_map_exists(argument[0], ui_request)){return ds_map_find_value(argument[0], ui_request);}
    else{
      ui_debug_error(103, "ui_get_position", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_get_position", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_get_position", object_get_name(object_index));
  return false;
}






#define ui_set_position
if(argument_count == 3){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_x") && ds_map_exists(argument[0], "ui_y")){
      ds_map_replace(argument[0], "ui_x", argument[1]);
      ds_map_replace(argument[0], "ui_y", argument[2]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_set_position", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_position", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_position", object_get_name(object_index));
  return false;
}






#define ui_get_padding
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(argument[1] == 0) var ui_request = "ui_padding_horizontal";
    else if(argument[1] == 1) var ui_request = "ui_padding_vertical";
    if(ds_map_exists(argument[0], ui_request)){return ds_map_find_value(argument[0], ui_request);}
    else{
      ui_debug_error(103, "ui_get_padding", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_get_padding", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_get_padding", object_get_name(object_index));
  return false;
}





#define ui_set_padding
if(argument_count == 3){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_padding_horizontal") or ds_map_exists(argument[0], "ui_padding_vertical")){
      if(ds_map_exists(argument[0], "ui_padding_horizontal")){
        ds_map_replace(argument[0], "ui_padding_horizontal", argument[1]);
      }
      if(ds_map_exists(argument[0], "ui_padding_vertical")){
        ds_map_replace(argument[0], "ui_padding_vertical", argument[2]);
      }     
      return true;
    }
    else{
      ui_debug_error(103, "ui_set_padding", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_padding", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_padding", object_get_name(object_index));
  return false;
}



#define ui_set_size
if(argument_count == 3){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_width") && ds_map_exists(argument[0], "ui_height")){
      ds_map_replace(argument[0], "ui_width", argument[1]);
      ds_map_replace(argument[0], "ui_height", argument[2]);
      return true;
    }
    else if(ds_map_exists(argument[0], "ui_size")){
      if(argument[1] > argument[2]){
        ds_map_replace(argument[0], "ui_size", argument[1]);
        return true;
      }
      else{
        ds_map_replace(argument[0], "ui_size", argument[2]);
        return true;
      }
    }
    else{
      ui_debug_error(103, "ui_set_size", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_size", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_size", object_get_name(object_index));
  return false;
}






#define ui_get_text
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_text")){return ds_map_find_value(argument[0], "ui_text");}
    else{
      ui_debug_error(103, "ui_get_text", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_get_text", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_get_text", object_get_name(object_index));
  return false;
}






#define ui_set_text
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_text")){
      ds_map_replace(argument[0], "ui_text", argument[1]);
      if(ds_map_find_value(argument[0], "ui_type") == ui_type_textbox){
        ds_map_replace(argument[0], "ui_alias_text", argument[1]);
      }
      return true;
    }
    else{
      ui_debug_error(103, "ui_set_text", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_text", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_text", object_get_name(object_index));
  return false;
}






#define ui_get_label
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_label")){return ds_map_find_value(argument[0], "ui_label");}
    else{
      ui_debug_error(103, "ui_get_label", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_get_label", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_get_label", object_get_name(object_index));
  return false;
}






#define ui_get_size
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(argument[1] == 0) var ui_request = "ui_width";
    else if(argument[1] == 1) var ui_request = "ui_height";
    if(ds_map_exists(argument[0], ui_request)){return ds_map_find_value(argument[0], ui_request);}
    else{
      ui_debug_error(103, "ui_get_size", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_get_size", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_get_size", object_get_name(object_index));
  return false;
}






#define ui_set_label
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_label")){
      ds_map_replace(argument[0], "ui_label", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_set_label", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_label", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_label", object_get_name(object_index));
  return false;
}






#define ui_set_text_font
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_font")){
      ds_map_replace(argument[0], "ui_font", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_set_text_font", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_text_font", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_text_font", object_get_name(object_index));
  return false;
}






#define ui_set_label_font
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_label_font")){
      ds_map_replace(argument[0], "ui_label_font", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_set_label_font", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_label_font", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_label_font", object_get_name(object_index));
  return false;
}






#define ui_get_type
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_type")){return ds_map_find_value(argument[0], "ui_type");}
    else{
      ui_debug_error(103, "ui_get_type", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_get_type", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_get_type", object_get_name(object_index));
  return false;
}


#define ui_get_entered
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    var ui_start_x = ds_map_find_value(argument[0], "ui_start_x");
    var ui_start_y = ds_map_find_value(argument[0], "ui_start_y");
    var ui_mouse_x = device_mouse_x(0) - ui_start_x;
      var ui_mouse_y = device_mouse_y(0) - ui_start_y;
      if(ds_exists(ui_global_config, ds_type_map)){
        if(ds_map_find_value(ui_global_config, "draw_on_gui")){
          ui_mouse_x = device_mouse_x_to_gui(0) - ui_start_x;
          ui_mouse_y = device_mouse_y_to_gui(0) - ui_start_y;
        }
      }
    if(ui_get_type(argument[0]) == ui_type_button or ui_get_type(argument[0]) == ui_type_textbox or ui_get_type(argument[0]) == ui_type_select){
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_text = ds_map_find_value(argument[0], "ui_text");
      var ui_width = ds_map_find_value(argument[0], "ui_width");
      var ui_height = ds_map_find_value(argument[0], "ui_height");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
      var ui_padding_vertical = ds_map_find_value(argument[0], "ui_padding_vertical");
      var ui_font = ds_map_find_value(argument[0], "ui_font");
      if(font_exists(ui_font)) draw_set_font(ui_font);
      if(ui_get_type(argument[0]) == ui_type_button){
        if(ui_width == ui_default) ui_width = string_width(ui_text);
        if(ui_height == ui_default) ui_height = string_height(ui_text);
      }
      else if(ui_get_type(argument[0]) == ui_type_select){
        if(ui_width == ui_default) ui_width = 320;
        if(ui_height == ui_default) ui_height = string_height('|');
        var ui_items = ds_map_find_value(argument[0], "ui_items");
        var ui_open = ds_map_find_value(argument[0], "ui_open");
        if(ui_open){
          ui_width = ui_width + 16
          ui_height = (ds_list_size(ui_items) * (ui_height + 20));
        }
      }
      else{
        if(ui_width == ui_default) ui_width = 320;
        if(ui_height == ui_default) ui_height = string_height('|');
      }
      return (ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_width + (ui_padding_horizontal * 2) && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_height + (ui_padding_vertical * 2));
    }
    else if(ui_get_type(argument[0]) == ui_type_checkbox or ui_get_type(argument[0]) == ui_type_radio){
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_label = ds_map_find_value(argument[0], "ui_label");
      var ui_size = ds_map_find_value(argument[0], "ui_size");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
      if(ui_get_type(argument[0]) == ui_type_checkbox){
        if(ui_size == ui_default) ui_size = 20;
      }
      else{
        if(ui_size == ui_default) ui_size = 18;
      }
      return ((ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_size && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_size) or (ui_mouse_x > ui_x + ui_size && ui_mouse_x < ui_x + ui_size + ui_padding_horizontal + string_width(ui_label) && ui_mouse_y > ui_y + ((ui_size * 0.5) - (string_height(ui_label) * 0.5))&& ui_mouse_y < ui_y + ((ui_size * 0.5) + (string_height(ui_label) * 0.5))));
    }
    else if(ui_get_type(argument[0]) == ui_type_switch){
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_label = ds_map_find_value(argument[0], "ui_label");
      var ui_width = ds_map_find_value(argument[0], "ui_width");
      var ui_height = ds_map_find_value(argument[0], "ui_height");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
      if(ui_width == ui_default) ui_width = 48;
      if(ui_height == ui_default) ui_height = 22;
      return ((ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_width && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_height) or (ui_mouse_x > ui_x + ui_width && ui_mouse_x < ui_x + ui_width + ui_padding_horizontal + string_width(ui_label) && ui_mouse_y > ui_y + ((ui_height * 0.5) - (string_height(ui_label) * 0.5))&& ui_mouse_y < ui_y + ((ui_height * 0.5) + (string_height(ui_label) * 0.5))));
    }
    else if(ui_get_type(argument[0]) == ui_type_tab){
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_width = ds_map_find_value(argument[0], "ui_width");
      var ui_height = ds_map_find_value(argument[0], "ui_height");
      var ui_font = ds_map_find_value(argument[0], "ui_font");
      if(font_exists(ui_font)) draw_set_font(ui_font);
      if(ui_width == ui_default) ui_width = 480;
      if(ui_height == ui_default) ui_height = string_height('|') + 16;
      return (ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_width && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_height);
    }
    else if(ui_get_type(argument[0]) == ui_type_sidenav){
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_size = ds_map_find_value(argument[0], "ui_size");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
      var ui_padding_vertical = ds_map_find_value(argument[0], "ui_padding_vertical");
      if(ui_size == ui_default) ui_width = 24;
      return (ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_size + (ui_padding_horizontal * 2) && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_size + (ui_padding_vertical * 2));
    }
    else{
      ui_debug_error(104, "ui_get_entered", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_get_entered", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_get_entered", object_get_name(object_index));
  return false;
}






#define ui_get_checked
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_checked")){return ds_map_find_value(argument[0], "ui_checked");}
    else{
      ui_debug_error(103, "ui_get_checked", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_get_checked", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_get_checked", object_get_name(object_index));
  return false;
}




#define ui_set_checked
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_checked")){
      ds_map_replace(argument[0], "ui_checked", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_set_checked", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_set_checked", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_set_checked", object_get_name(object_index));
  return false;
}






#define ui_item_add
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_items")){
      var ui_type = ds_map_find_value(argument[0], "ui_type");
      var ui_items = ds_map_find_value(argument[0], "ui_items");
      if(ui_type == ui_type_select){
        ds_list_add(ui_items, string(argument[1]));
        ds_map_replace(argument[0], "ui_items", ui_items);
        return ds_list_find_index(ui_items, string(argument[1]));
      }
      else if(ui_type == ui_type_tab){
        var ui_item = ds_map_create();
        var ui_x = ds_map_find_value(argument[0], "ui_x");
        var ui_y = ds_map_find_value(argument[0], "ui_y");
        var ui_height = ds_map_find_value(argument[0], "ui_height");
        var ui_width = ds_map_find_value(argument[0], "ui_width");
        var ui_font = ds_map_find_value(argument[0], "ui_font");
        var ui_content_height = ds_map_find_value(argument[0], "ui_content_height");
        if(ui_width == ui_default) ui_width = 480;
        if(ui_height == ui_default) ui_height = string_height('|') + 16;
        if(ui_content_height == ui_default) ui_content_height = 320;
        var ui_surface = surface_create(ui_width, ui_content_height);
        ds_map_add(ui_item, "ui_tab_name", string(argument[1]));
        ds_map_add(ui_item, "ui_x", ui_x);
        ds_map_add(ui_item, "ui_y", ui_y + ui_height);
        ds_map_add(ui_item, "ui_tab_surface", ui_surface);
        ds_list_add(ui_items, ui_item);
        ds_map_replace(argument[0], "ui_items", ui_items);
        return ui_item;
      }
      else{return false;}
    }
    else{
      ui_debug_error(103, "ui_item_add", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_item_add", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_item_add", object_get_name(object_index));
  return false;
}






#define ui_item_delete
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_items")){
      var ui_items = ds_map_find_value(argument[0], "ui_items");
      ds_list_delete(ui_items, argument[1]);
      ds_map_replace(argument[0], "ui_items", ui_items);
    }
    else{
      ui_debug_error(103, "ui_item_delete", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_item_delete", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_item_delete", object_get_name(object_index));
  return false;
}






#define ui_item_get_selected
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_selected")){return ds_map_find_value(argument[0], "ui_selected");}
    else{
      ui_debug_error(103, "ui_item_get_selected", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_item_get_selected", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_item_get_selected", object_get_name(object_index));
  return false;
}






#define ui_item_set_selected
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_selected")){
      ds_map_replace(argument[0], "ui_selected", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_item_set_selected", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_item_set_selected", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_item_set_selected", object_get_name(object_index));
  return false;
}






#define ui_item_get_text
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    if(ui_get_type(argument[0]) == ui_type_select){
      if(ds_map_exists(argument[0], "ui_items") && ds_map_exists(argument[0], "ui_selected")){
        var ui_text = "undefined";
        var ui_items = ds_map_find_value(argument[0], "ui_items");
        var ui_selected = ds_map_find_value(argument[0], "ui_selected");
        if(ds_exists(ui_items, ds_type_list)){
          if(ds_list_find_value(ui_items, ui_selected) != undefined){ui_text = ds_list_find_value(ui_items, ui_selected);}
        }
        return ui_text;
      }
    }
    else{
      ui_debug_error(103, "ui_item_get_text", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_item_get_text", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_item_get_text", object_get_name(object_index));
  return false;
}






#define ui_debug_error
if(argument_count == 3){
  var ui_text_message;
  switch(argument[0]){
    case 100: ui_text_message = "Initialization failed!"; break;
    case 101: ui_text_message = "Wrong number of arguments!"; break;
    case 102: ui_text_message = "Control not found!"; break;
    case 103: ui_text_message = "Control property not found!"; break;
    case 104: ui_text_message = "Control type not found!"; break;
    case 105: ui_text_message = "Keyboard not initialize!"; break;
    default: ui_text_message = "Unexpected error occured!"; break;
  }
  if(ds_exists(ui_global_config, ds_type_map)){
    if(ds_map_find_value(ui_global_config, "debug_mode")){
      show_debug_message("Error occurred in function: " + argument[1] + " | for object: " + argument[2] + " | ERROR: " + ui_text_message);
      return true;
    }
  }
  else{show_debug_message(ui_text_message);}
}
else{return false;}




#define ui_button_create
if(argument_count == 5){
  if(ds_exists(ui_global_config, ds_type_map)){
    var ui_background_colour = ds_map_find_value(ui_global_config, "default_background_colour");
    var ui_foreground_colour = ds_map_find_value(ui_global_config, "default_foreground_colour");
    var ui_font = ds_map_find_value(ui_global_config, "default_text_font");
    var ui_effect = ds_map_find_value(ui_global_config, "enable_effect");
    var ui_effect_speed = max(ds_map_find_value(ui_global_config, "effect_speed") / 100, 0.05);
    var ui_shadow = ds_map_find_value(ui_global_config, "enable_shadow");
  }
  else{
    var ui_background_colour = ui_teal;
    var ui_foreground_colour = ui_white;
    var ui_font = ui_default;
    var ui_effect = true;
    var ui_effect_speed = 0.08;
    var ui_shadow = true;
  }
  var ui_control = ds_map_create();
  var ui_width = max(argument[2], ui_default);
  var ui_height = max(argument[3], ui_default);
  ds_map_add(ui_control, "ui_type", ui_type_button);
  ds_map_add(ui_control, "ui_x", argument[0]);
  ds_map_add(ui_control, "ui_y", argument[1]);
  ds_map_add(ui_control, "ui_start_x", 0);
  ds_map_add(ui_control, "ui_start_y", 0);
  ds_map_add(ui_control, "ui_width", ui_width);
  ds_map_add(ui_control, "ui_height", ui_height);
  ds_map_add(ui_control, "ui_text", argument[4]);
  ds_map_add(ui_control, "ui_clicked", false);
  ds_map_add(ui_control, "ui_background_colour", ui_background_colour);
  ds_map_add(ui_control, "ui_foreground_colour", ui_foreground_colour);
  ds_map_add(ui_control, "ui_focus", false);
  ds_map_add(ui_control, "ui_enable", true);
  ds_map_add(ui_control, "ui_active", true);
  ds_map_add(ui_control, "ui_flat", false);
  ds_map_add(ui_control, "ui_font", ui_font);
  ds_map_add(ui_control, "ui_wave", false);
  ds_map_add(ui_control, "ui_alpha", 0);
  ds_map_add(ui_control, "ui_wave_size", 0);
  ds_map_add(ui_control, "ui_padding_horizontal", 0);
  ds_map_add(ui_control, "ui_padding_vertical", 0);
  ds_map_add(ui_control, "ui_effect", ui_effect);
  ds_map_add(ui_control, "ui_effect_speed", ui_effect_speed);
  ds_map_add(ui_control, "ui_shadow", ui_shadow);
  if(ds_exists(ui_global_controls, ds_type_list)){ds_list_add(ui_global_controls, ui_control);}
  return ui_control;
}
else{
  ui_debug_error(101, "ui_button_create", object_get_name(object_index));
  return false;
}






#define ui_button_set_flat
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_flat")){
      ds_map_replace(argument[0], "ui_flat", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103);
      return false;
    }
  }
  else{
    ui_debug_error(102);
    return false;
  }
}
else{
  ui_debug_error(101, "ui_button_set_flat", object_get_name(object_index));
  return false;
}






#define ui_button_clicked
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    var ui_x = ds_map_find_value(argument[0], "ui_x");
    var ui_y = ds_map_find_value(argument[0], "ui_y");
    var ui_start_x = ds_map_find_value(argument[0], "ui_start_x");
    var ui_start_y = ds_map_find_value(argument[0], "ui_start_y");
    var ui_text = ds_map_find_value(argument[0], "ui_text");
    var ui_width = ds_map_find_value(argument[0], "ui_width");
    var ui_height = ds_map_find_value(argument[0], "ui_height");
    var ui_clicked = ds_map_find_value(argument[0], "ui_clicked");
    var ui_enable = ds_map_find_value(argument[0], "ui_enable");
    var ui_active = ds_map_find_value(argument[0], "ui_active");
    var ui_focus = ds_map_find_value(argument[0], "ui_focus");
    var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
    var ui_padding_vertical = ds_map_find_value(argument[0], "ui_padding_vertical");
    if(ui_width == ui_default) ui_width = string_width(ui_text);
    if(ui_height == ui_default) ui_height = string_height(ui_text);
    var ui_mouse_x = device_mouse_x(0) - ui_start_x;
      var ui_mouse_y = device_mouse_y(0) - ui_start_y;
      if(ds_exists(ui_global_config, ds_type_map)){
        if(ds_map_find_value(ui_global_config, "draw_on_gui")){
          ui_mouse_x = device_mouse_x_to_gui(0) - ui_start_x;
          ui_mouse_y = device_mouse_y_to_gui(0) - ui_start_y;
        }
      }
    var keyboard_action = true;
    if(ds_exists(ui_global_config, ds_type_map)){
      if(!ds_map_find_value(ui_global_config, "keyboard_action")){keyboard_action = false;}
    }
    if(ui_active && ((ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_width + (ui_padding_horizontal * 2) && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_height + (ui_padding_vertical * 2)) or (ui_focus && keyboard_action && keyboard_check_pressed(vk_enter)))){
      if(ui_enable){
        if(device_mouse_check_button_pressed(0, mb_left)){
          ui_clicked = true;
          ds_map_replace(argument[0], "ui_clicked", ui_clicked);
        }
        return ((device_mouse_check_button_released(0, mb_left) && ui_clicked) or (ui_focus && keyboard_action && keyboard_check_pressed(vk_enter)));
      }
    }
    if(device_mouse_check_button_released(0, mb_left)){
      if(ui_enable){
        if(device_mouse_check_button_pressed(0, mb_left)){
          ui_clicked = false;
          ds_map_replace(argument[0], "ui_clicked", ui_clicked);
        }
      }
    }
  }
  else{
    ui_debug_error(102, "ui_button_clicked", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_button_clicked", object_get_name(object_index));
  return false;
}






#define ui_button_draw
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    var ui_type = ds_map_find_value(argument[0], "ui_type");
    if(ui_type == ui_type_button){
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_start_x = ds_map_find_value(argument[0], "ui_start_x");
      var ui_start_y = ds_map_find_value(argument[0], "ui_start_y");
      var ui_text = ds_map_find_value(argument[0], "ui_text");
      var ui_width = ds_map_find_value(argument[0], "ui_width");
      var ui_height = ds_map_find_value(argument[0], "ui_height");
      var ui_background_colour = ds_map_find_value(argument[0], "ui_background_colour");
      var ui_foreground_colour = ds_map_find_value(argument[0], "ui_foreground_colour");
      var ui_enable = ds_map_find_value(argument[0], "ui_enable");
      var ui_active = ds_map_find_value(argument[0], "ui_active");
      var ui_focus = ds_map_find_value(argument[0], "ui_focus");
      var ui_flat = ds_map_find_value(argument[0], "ui_flat");
      var ui_font = ds_map_find_value(argument[0], "ui_font");
      var ui_wave = ds_map_find_value(argument[0], "ui_wave");
      var ui_alpha = ds_map_find_value(argument[0], "ui_alpha");
      var ui_wave_size = ds_map_find_value(argument[0], "ui_wave_size");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
      var ui_padding_vertical = ds_map_find_value(argument[0], "ui_padding_vertical");
      var ui_effect = ds_map_find_value(argument[0], "ui_effect");
      var ui_effect_speed = ds_map_find_value(argument[0], "ui_effect_speed");
      var ui_shadow = ds_map_find_value(argument[0], "ui_shadow");
      if(font_exists(ui_font)) draw_set_font(ui_font);
      if(ui_width == ui_default) ui_width = string_width(ui_text);
      if(ui_height == ui_default) ui_height = string_height(ui_text);
      if(ui_enable){
        var ui_btn_control_colour = ui_background_colour;
        if(!ui_flat){ui_alpha = 0.015;}
        var ui_mouse_x = device_mouse_x(0) - ui_start_x;
        var ui_mouse_y = device_mouse_y(0) - ui_start_y;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "draw_on_gui")){
            ui_mouse_x = device_mouse_x_to_gui(0) - ui_start_x;
            ui_mouse_y = device_mouse_y_to_gui(0) - ui_start_y;
          }
        }
        var keyboard_action = true;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(!ds_map_find_value(ui_global_config, "keyboard_action")){keyboard_action = false;}
        }
        if(ui_active && ((ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_width + (ui_padding_horizontal * 2) && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_height + (ui_padding_vertical * 2)) or (ui_focus && keyboard_action && keyboard_check_pressed(vk_enter)))){
          ui_btn_control_colour = ui_colour_lighter(ui_btn_control_colour);
          if(ui_flat){
            if(ui_effect){
              if(ui_alpha < 1){
                ui_alpha += ui_effect_speed;
                ui_alpha = min(ui_alpha, 1);
                ds_map_replace(argument[0], "ui_alpha", ui_alpha);
              }
            }
            else{
              ui_alpha = 1;
              ds_map_replace(argument[0], "ui_alpha", ui_alpha);
            }
          }
          else{ui_alpha = 0.02;}
          if(device_mouse_check_button_pressed(0, mb_left) or (ui_focus && keyboard_action && keyboard_check_pressed(vk_enter))){
            if(ui_effect){
              ui_wave = true;
              ds_map_replace(argument[0], "ui_wave", ui_wave);
              ui_focus = true;
              ds_map_replace(argument[0], "ui_focus", ui_focus);
            }
          }
        }
        else{
          ui_btn_control_colour = ui_background_colour;
          if(ui_flat){
            if(ui_effect){
              if(ui_alpha > 0){
                ui_alpha -= ui_effect_speed;
                ui_alpha = max(ui_alpha, 0);
                ds_map_replace(argument[0], "ui_alpha", ui_alpha);
              }
            }
            else{
              ui_alpha = 1;
              ds_map_replace(argument[0], "ui_alpha", ui_alpha);
            }
          }
          else{ui_alpha = 0.015;}
          if(device_mouse_check_button_pressed(0, mb_left)){
            ui_focus = false;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
          }
        }
        if(ui_flat){
          draw_set_alpha(ui_alpha);
          draw_rectangle_colour(ui_x, ui_y, ui_x + ui_width + (ui_padding_horizontal * 2), ui_y + ui_height + (ui_padding_vertical * 2), ui_background_colour, ui_background_colour, ui_background_colour, ui_background_colour, false);
          draw_set_alpha(1);
        }
        else{
          if(ui_shadow){
            draw_set_alpha(ui_alpha);
            draw_roundrect_colour_ext(ui_x - 3 + (ui_alpha * 10), ui_y - 3 + (ui_alpha * 10), ui_x + ui_width + (ui_padding_horizontal * 2) + 3 + (ui_alpha * 10), ui_y + ui_height + (ui_padding_vertical * 2) + 4, 4, 4, ui_black, ui_black, false);
            draw_roundrect_colour_ext(ui_x - 2 + (ui_alpha * 10), ui_y - 2 + (ui_alpha * 10), ui_x + ui_width + (ui_padding_horizontal * 2) + 2 + (ui_alpha * 10), ui_y + ui_height + (ui_padding_vertical * 2) + 3, 4, 4, ui_black, ui_black, false);
            draw_roundrect_colour_ext(ui_x - 1 + (ui_alpha * 10), ui_y - 1 + (ui_alpha * 10), ui_x + ui_width + (ui_padding_horizontal * 2) + 1 + (ui_alpha * 10), ui_y + ui_height + (ui_padding_vertical * 2) + 2, 6, 6, ui_black, ui_black, false);
            draw_roundrect_colour_ext(ui_x - 1 + (ui_alpha * 10), ui_y - 1 + (ui_alpha * 10), ui_x + ui_width + (ui_padding_horizontal * 2) + 1 + (ui_alpha * 10), ui_y + ui_height + (ui_padding_vertical * 2) + 1, 6, 6, ui_black, ui_black, false);
            draw_roundrect_colour_ext(ui_x - 1 + (ui_alpha * 10), ui_y - 1 + (ui_alpha * 10), ui_x + ui_width + (ui_padding_horizontal * 2) + 1 + (ui_alpha * 10), ui_y + ui_height + (ui_padding_vertical * 2) + 1, 6, 6, ui_black, ui_black, false);
            draw_set_alpha(1);
          }
          draw_roundrect_colour_ext(ui_x, ui_y, ui_x + ui_width + (ui_padding_horizontal * 2), ui_y + ui_height + (ui_padding_vertical * 2), 4, 4, ui_btn_control_colour, ui_btn_control_colour, false);
        }
        if(ui_wave && ui_effect){
          if(ui_wave_size < 1){
            ui_wave_size += ui_effect_speed;
            ui_wave_size = min(ui_wave_size, 1);
            ds_map_replace(argument[0], "ui_wave_size", ui_wave_size);
          }
          else{
            ui_wave = false;
            ds_map_replace(argument[0], "ui_wave", ui_wave);
            ui_wave_size = 0;
            ds_map_replace(argument[0], "ui_wave_size", ui_wave_size);
          }
        }
        draw_set_alpha(0.5 * (1 - ui_wave_size));
        draw_roundrect_colour_ext(ui_x, ui_y, ui_x + ((ui_width + (ui_padding_horizontal * 2)) * ui_wave_size), ui_y + ui_height + (ui_padding_vertical * 2), 4, 4, ui_white, ui_white, false);
        draw_set_alpha(1);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        if(ui_shadow) draw_text_colour(ui_x + (ui_width * 0.5) + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical + 1, ui_text, ui_black, ui_black, ui_black, ui_black, 0.05);
        draw_text_colour(ui_x + (ui_width * 0.5) + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical , ui_text, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
      }
      else{
        draw_roundrect_colour_ext(ui_x, ui_y, ui_x + ui_width + (ui_padding_horizontal * 2), ui_y + ui_height + (ui_padding_vertical * 2), 4, 4, ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey), false);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_colour(ui_x + (ui_width * 0.5) + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical , ui_text, ui_grey, ui_grey, ui_grey, ui_grey, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
      }
      if(ui_focus){
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "debug_mode")){
            draw_set_alpha(0.25);
            draw_rectangle_colour(ui_x, ui_y, ui_x + ui_width + (ui_padding_horizontal * 2) + 2, ui_y + ui_height + (ui_padding_vertical * 2) + 2, ui_blue_grey, ui_blue_grey, ui_blue_grey, ui_blue_grey, true);
            draw_set_alpha(1);
          }
        }
      }
    }
    else{
      ui_debug_error(102, "ui_button_draw", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_button_draw", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_button_draw", object_get_name(object_index));
  return false;
}






#define ui_textbox_create
if(argument_count == 5){
  if(ds_exists(ui_global_config, ds_type_map)){
    var ui_background_colour = ds_map_find_value(ui_global_config, "default_background_colour");
    var ui_font = ds_map_find_value(ui_global_config, "default_text_font");
    var ui_label_font = ds_map_find_value(ui_global_config, "default_label_font");
    var ui_effect = ds_map_find_value(ui_global_config, "enable_effect");
    var ui_effect_speed = ds_map_find_value(ui_global_config, "effect_speed");
    var ui_shadow = ds_map_find_value(ui_global_config, "enable_shadow");
  }
  else{
    var ui_background_colour = ui_teal;
    var ui_font = ui_default;
    var ui_label_font = ui_default;
    var ui_effect = true;
    var ui_effect_speed = 8;
    var ui_shadow = true;
  }
  var ui_control = ds_map_create();
  var ui_width = max(argument[2], ui_default);
  var ui_height = max(argument[3], ui_default);
  ds_map_add(ui_control, "ui_type", ui_type_textbox);
  ds_map_add(ui_control, "ui_x", argument[0]);
  ds_map_add(ui_control, "ui_y", argument[1]);
  ds_map_add(ui_control, "ui_start_x", 0);
  ds_map_add(ui_control, "ui_start_y", 0);
  ds_map_add(ui_control, "ui_width", ui_width);
  ds_map_add(ui_control, "ui_height", ui_height);
  ds_map_add(ui_control, "ui_label", argument[4]);
  ds_map_add(ui_control, "ui_text", "");
  ds_map_add(ui_control, "ui_alias_text", "");
  ds_map_add(ui_control, "ui_readonly", false);
  ds_map_add(ui_control, "ui_password", false);
  ds_map_add(ui_control, "ui_acceptable", ui_default);
  ds_map_add(ui_control, "ui_maxchar", ui_default);
  ds_map_add(ui_control, "ui_changed", false);
  ds_map_add(ui_control, "ui_background_colour", ui_background_colour);
  ds_map_add(ui_control, "ui_foreground_colour", ui_grey);
  ds_map_add(ui_control, "ui_focus", false);
  ds_map_add(ui_control, "ui_beam", false);
  ds_map_add(ui_control, "ui_beam_position", 0);
  ds_map_add(ui_control, "ui_enable", true);
  ds_map_add(ui_control, "ui_active", true);
  ds_map_add(ui_control, "ui_label_font", ui_label_font);
  ds_map_add(ui_control, "ui_font", ui_font);
  ds_map_add(ui_control, "ui_label_top", 0); 
  ds_map_add(ui_control, "ui_padding_horizontal", 0);
  ds_map_add(ui_control, "ui_padding_vertical", 0);
  ds_map_add(ui_control, "ui_effect", ui_effect);
  ds_map_add(ui_control, "ui_effect_speed", ui_effect_speed);
  ds_map_add(ui_control, "ui_shadow", ui_shadow);
  if(ds_exists(ui_global_controls, ds_type_list)){ds_list_add(ui_global_controls, ui_control);}
  return ui_control;
}
else{
  ui_debug_error(101, "ui_textbox_create", object_get_name(object_index));
  return false;
}






#define ui_textbox_set_maxchar
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_maxchar")){
      ds_map_replace(argument[0], "ui_maxchar", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_textbox_set_maxchar", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_textbox_set_maxchar", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_textbox_set_maxchar", object_get_name(object_index));
  return false;
}






#define ui_textbox_set_readonly
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_readonly")){
      ds_map_replace(argument[0], "ui_readonly", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_textbox_set_readonly", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_textbox_set_readonly", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_textbox_set_readonly", object_get_name(object_index));
  return false;
}






#define ui_textbox_set_acceptable
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_acceptable")){
      ds_map_replace(argument[0], "ui_acceptable", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_textbox_set_acceptable", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_textbox_set_acceptable", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_textbox_set_acceptable", object_get_name(object_index));
  return false;
}






#define ui_textbox_set_password
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_password")){
      ds_map_replace(argument[0], "ui_password", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_textbox_set_password", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_textbox_set_password", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_textbox_set_password", object_get_name(object_index));
  return false;
}






#define ui_textbox_changed
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    var ui_char_before = string_copy(ds_map_find_value(argument[0], "ui_text"), string_length(ds_map_find_value(argument[0], "ui_text")), 1);
    var ui_focus = ds_map_find_value(argument[0], "ui_focus");
    var ui_changed = ds_map_find_value(argument[0], "ui_changed");
    var ui_readonly = ds_map_find_value(argument[0], "ui_readonly");
    var ui_acceptable = ds_map_find_value(argument[0], "ui_acceptable");
    var ui_check_acceptable = false;
    switch(ui_acceptable){
      case ui_letter_only:
        if((keyboard_lastkey > 64 && keyboard_lastkey < 91) or (keyboard_lastkey > 96 && keyboard_lastkey < 123)){ui_check_acceptable = true;}
      break;
      case ui_number_only:
        if((keyboard_lastkey > 47 && keyboard_lastkey < 58)){ui_check_acceptable = true;}
      break;
      default:
        if((keyboard_lastkey > 31 && keyboard_lastkey < 128) or keyboard_lastkey == vk_backspace){ui_check_acceptable = true;}
      break;
    }
    if(!ui_readonly && ui_focus && ui_check_acceptable){
      if((ui_char_before != keyboard_lastchar) && !ui_changed){
        ui_changed = true;
        ds_map_replace(argument[0], "ui_changed", ui_changed);
      }
      else{
        ui_changed = false;
        ds_map_replace(argument[0], "ui_changed", false);
      }
      return ui_changed;
    }
    else{return false;}
  }
  else{
    ui_debug_error(102, "ui_textbox_changed", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_textbox_changed", object_get_name(object_index));
  return false;
}



#define ui_textbox_draw
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    var ui_type = ds_map_find_value(argument[0], "ui_type");
    if(ui_type == ui_type_textbox){
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_start_x = ds_map_find_value(argument[0], "ui_start_x");
      var ui_start_y = ds_map_find_value(argument[0], "ui_start_y");
      var ui_width = ds_map_find_value(argument[0], "ui_width");
      var ui_height = ds_map_find_value(argument[0], "ui_height");
      var ui_label = ds_map_find_value(argument[0], "ui_label");
      var ui_text = ds_map_find_value(argument[0], "ui_text");
      var ui_alias_text = ds_map_find_value(argument[0], "ui_alias_text");
      var ui_readonly = ds_map_find_value(argument[0], "ui_readonly");
      var ui_password = ds_map_find_value(argument[0], "ui_password");
      var ui_acceptable = ds_map_find_value(argument[0], "ui_acceptable");
      var ui_maxchar = ds_map_find_value(argument[0], "ui_maxchar");
      var ui_beam = ds_map_find_value(argument[0], "ui_beam");
      var ui_beam_position = ds_map_find_value(argument[0], "ui_beam_position");
      var ui_background_colour = ds_map_find_value(argument[0], "ui_background_colour");
      var ui_foreground_colour = ds_map_find_value(argument[0], "ui_foreground_colour");
      var ui_enable = ds_map_find_value(argument[0], "ui_enable");
      var ui_active = ds_map_find_value(argument[0], "ui_active");
      var ui_label_font = ds_map_find_value(argument[0], "ui_label_font");
      var ui_font = ds_map_find_value(argument[0], "ui_font");
      var ui_focus = ds_map_find_value(argument[0], "ui_focus");
      var ui_label_top = ds_map_find_value(argument[0], "ui_label_top");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
      var ui_padding_vertical = ds_map_find_value(argument[0], "ui_padding_vertical");
      var ui_effect = ds_map_find_value(argument[0], "ui_effect");
      var ui_effect_speed = ds_map_find_value(argument[0], "ui_effect_speed");
      var ui_shadow = ds_map_find_value(argument[0], "ui_shadow");
      if(font_exists(ui_font)) draw_set_font(ui_font);
      if(ui_width == ui_default) ui_width = 320;
      if(ui_height == ui_default) ui_height = string_height('|');
      if(string_width(string_replace_all(ui_alias_text, "#", "\#")) > ui_width){
        while(string_width(string_replace_all(ui_alias_text, "#", "\#")) > ui_width){
          ui_alias_text = string_delete(ui_alias_text, string_length(ui_alias_text), 1);
        }
      }
      else{
        if(ui_alias_text == ""){
          ui_alias_text = ui_text;
          ds_map_replace(argument[0], "ui_alias_text", ui_alias_text);
        }
      }
      if(ui_enable){
        var ui_alpha = 0.015;
        if(!ui_readonly){
          var ui_mouse_x = device_mouse_x(0) - ui_start_x;
          var ui_mouse_y = device_mouse_y(0) - ui_start_y;
          if(ds_exists(ui_global_config, ds_type_map)){
            if(ds_map_find_value(ui_global_config, "draw_on_gui")){
              ui_mouse_x = device_mouse_x_to_gui(0) - ui_start_x;
              ui_mouse_y = device_mouse_y_to_gui(0) - ui_start_y;
            }
          }
          if(ui_active && (ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_width + (ui_padding_horizontal * 2) && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_height + (ui_padding_vertical * 2))){
            ui_alpha = 0.02;
            if(device_mouse_check_button_pressed(0, mb_left)){
              if(!ui_focus){keyboard_string = "";}
              ui_focus = true;
              ds_map_replace(argument[0], "ui_focus", ui_focus);
              if(ui_password){
                ui_beam_position = string_length(ui_alias_text);
                ds_map_replace(argument[0], "ui_beam_position", ui_beam_position);
              }
              else{
                if(ui_text == ""){ui_beam_position = 0;}
                else{
                  ui_beam_position = max(0, round((min(ui_mouse_x, ui_x + ui_padding_horizontal + string_width(string_replace_all(ui_alias_text, "#", "\#"))) - (ui_x + ui_padding_horizontal)) / string_width(string_replace_all(ui_alias_text, "#", "\#")) * string_length(ui_alias_text)) + (string_pos(ui_alias_text, ui_text) - 1));
                }
                ds_map_replace(argument[0], "ui_beam_position", ui_beam_position);
              }
            }
          }
          else{
            if(device_mouse_check_button_pressed(0, mb_left)){
              if(ds_exists(ui_keyboard, ds_type_map)){
                if(!ds_map_find_value(ui_keyboard, "ui_show") or ds_map_find_value(ui_keyboard, "ui_target") != argument[0]){
                  ui_focus = false;
                  ds_map_replace(argument[0], "ui_focus", ui_focus);
                }
              }
              else{
                ui_focus = false;
                ds_map_replace(argument[0], "ui_focus", ui_focus);
              }
            }
          }
        }
        var ui_line_size = 1;
        if(font_exists(ui_label_font)){draw_set_font(ui_label_font);}
        if(ui_text != ""){
          ui_label_top = string_height('|') * 0.85 + ui_padding_vertical;
          ds_map_replace(argument[0], "ui_label_top", ui_label_top);
        }
        if(ui_focus){
          ui_line_size = 2;
          if(!ui_readonly){
            if(ui_text == ""){
              if(ui_effect){
                if(ui_label_top < (string_height('|') * 0.85 + ui_padding_vertical)){
                  ui_label_top += ui_effect_speed;
                  ui_label_top = min(ui_label_top, (string_height('|') * 0.85 + ui_padding_vertical));
                  ds_map_replace(argument[0], "ui_label_top", ui_label_top);
                }
              }
              else{ds_map_replace(argument[0], "ui_label_top", string_height('|') * 0.85 + ui_padding_vertical);}
            }
            if(ui_beam < room_speed){
              ui_beam += 1;
              ds_map_replace(argument[0], "ui_beam", ui_beam);
            }
            else{ds_map_replace(argument[0], "ui_beam", 0);}
            if(keyboard_check(vk_anykey)){
              if((keyboard_key == vk_left) && !ui_password){
                if(ui_beam_position > 0){
                  if(ui_beam_position < string_pos(ui_alias_text, ui_text)){
                    var ui_temp = string_copy(ui_text, ui_beam_position, string_length(ui_alias_text) + 1);
                    if(string_width(ui_temp) > ui_width){
                      while(string_width(ui_temp) > ui_width){
                        ui_temp = string_delete(ui_temp, string_length(ui_temp), 1);
                      }
                    }
                    ds_map_replace(argument[0], "ui_alias_text", ui_temp);
                  }       
                  ui_beam_position -= 1;
                  ds_map_replace(argument[0], "ui_beam_position", ui_beam_position);
                  keyboard_string = "";
                  io_clear();
                }
              }
              else if((keyboard_key == vk_right) && !ui_password){
                if(ui_beam_position < string_length(ui_text)){
                  if((ui_beam_position - (string_pos(ui_alias_text, ui_text) - 1)) >= string_length(ui_alias_text)){
                    var ui_temp = string_copy(ui_text, 1, ui_beam_position + 1);
                    if(string_width(ui_temp) > ui_width){
                      while(string_width(ui_temp) > ui_width){
                        ui_temp = string_delete(ui_temp, 1, 1);
                      }
                    }
                    ds_map_replace(argument[0], "ui_alias_text", ui_temp);
                  }
                  ui_beam_position += 1;
                  ds_map_replace(argument[0], "ui_beam_position", ui_beam_position);
                  keyboard_string = "";
                  io_clear();
                }
              }
              else if(keyboard_key == vk_backspace or keyboard_string == chr(8)){
                if(string_length(ui_text) > 0){
                  ui_text = string_delete(ui_text, ui_beam_position, 1);
                  ds_map_replace(argument[0], "ui_text", ui_text);
                  var ui_temp = string_copy(ui_text, string_pos(ui_alias_text, ui_text), string_length(ui_text));
                  if(string_width(ui_temp) > ui_width){
                    while(string_width(ui_temp) > ui_width){
                      if(ui_beam_position > string_length(ui_alias_text)){ui_temp = string_delete(ui_temp, 1, 1);}
                      else{ui_temp = string_delete(ui_temp, string_length(ui_temp), 1);}
                    }
                  }
                  ds_map_replace(argument[0], "ui_alias_text", ui_temp);
                  ui_beam_position -= 1;
                  ds_map_replace(argument[0], "ui_beam_position", ui_beam_position);
                  keyboard_string = "";
                  io_clear();
                }
              }
              else if(keyboard_key == vk_delete){
                if(string_length(ui_text) > 0){
                  if(ui_beam_position < string_length(ui_text)){
                    ui_text = string_delete(ui_text, ui_beam_position + 1, 1);
                    ds_map_replace(argument[0], "ui_text", ui_text);
                    var ui_temp = string_copy(ui_text, string_pos(ui_alias_text, ui_text), string_length(ui_text));
                    if(string_width(ui_temp) > ui_width){
                      while(string_width(ui_temp) > ui_width){
                        if(ui_beam_position > string_length(ui_alias_text)){ui_temp = string_delete(ui_temp, 1, 1);}
                        else{ui_temp = string_delete(ui_temp, string_length(ui_temp), 1);}
                      }
                    }
                    ds_map_replace(argument[0], "ui_alias_text", ui_temp);
                    keyboard_string = "";
                    io_clear();
                  }
                }
              }
              else{
                if((ui_maxchar > 0 && string_length(ui_text) < ui_maxchar) or ui_maxchar == ui_default){
                  switch(ui_acceptable){
                    case ui_letter_only:
                      if(((keyboard_key > 64 && keyboard_key < 91) or (keyboard_key > 96 && keyboard_key < 123)) or  ((ord(keyboard_string) > 64 && ord(keyboard_string) < 91) or (ord(keyboard_string) > 96 && ord(keyboard_string) < 123))){
                        ui_text = string_insert(keyboard_string, ui_text, ui_beam_position + 1);
                        ds_map_replace(argument[0], "ui_text", ui_text);
                        ui_beam_position += string_length(keyboard_string);
                        ds_map_replace(argument[0], "ui_beam_position", ui_beam_position);
                        keyboard_string = "";
                        io_clear();
                      }
                      else{
                        keyboard_string = "";
                        io_clear();
                      }
                    break;
                    case ui_number_only:
                      if((keyboard_key > 47 && keyboard_key < 58) or (ord(keyboard_string) > 47 && ord(keyboard_string) < 58)){
                        ui_text = string_insert(keyboard_string, ui_text, ui_beam_position + 1);
                        ds_map_replace(argument[0], "ui_text", ui_text);
                        ui_beam_position += string_length(keyboard_string);
                        ds_map_replace(argument[0], "ui_beam_position", ui_beam_position);
                        keyboard_string = "";
                        io_clear();
                      }
                      else{
                        keyboard_string = "";
                        io_clear();
                      }
                    break;
                    default:
                      ui_text = string_insert(keyboard_string, ui_text, ui_beam_position + 1);
                      ds_map_replace(argument[0], "ui_text", ui_text);
                      ui_beam_position += string_length(keyboard_string);
                      ds_map_replace(argument[0], "ui_beam_position", ui_beam_position);
                      keyboard_string = "";
                      io_clear();
                    break;
                  }
                  var ui_temp = string_copy(ui_text, string_pos(ui_alias_text, ui_text), string_length(ui_text));
                  if(string_width(ui_temp) > ui_width){
                    while(string_width(ui_temp) > ui_width){
                      if(ui_beam_position > string_length(ui_alias_text)){ui_temp = string_delete(ui_temp, 1, 1);}
                      else{ui_temp = string_delete(ui_temp, string_length(ui_temp), 1);}
                    }
                  }
                  ds_map_replace(argument[0], "ui_alias_text", ui_temp);
                }
              }
            }
          }
        }
        else{
          ui_line_size = 1;
          if(ui_text == ""){
            if(ui_effect){
              if(ui_label_top > 0){
                ui_label_top -= ui_effect_speed;
                ui_label_top = max(ui_label_top, 0);
                ds_map_replace(argument[0], "ui_label_top", ui_label_top);
              }
            }
            else{
              ui_label_top = 0;
              ds_map_replace(argument[0], "ui_label_top", ui_label_top);
            }
          }
        }
        if(ui_text = ""){
          if(ui_effect){
            var ui_col_r = lerp(colour_get_red(ui_background_colour), colour_get_red(ui_foreground_colour), 1 - (ui_label_top / (string_height('|') * 0.85 + ui_padding_vertical)));
            var ui_col_g = lerp(colour_get_green(ui_background_colour), colour_get_green(ui_foreground_colour), 1 - (ui_label_top / (string_height('|') * 0.85 + ui_padding_vertical)));
            var ui_col_b = lerp(colour_get_blue(ui_background_colour), colour_get_blue(ui_foreground_colour), 1 - (ui_label_top / (string_height('|') * 0.85 + ui_padding_vertical)));
            ui_background_colour = make_colour_rgb(ui_col_r, ui_col_g, ui_col_b);
          }
          else{
            if(ui_label_top < (string_height('|') * 0.85 + ui_padding_vertical)){ui_background_colour = ui_foreground_colour;}
          }
        }
        if(ui_shadow){
          draw_set_alpha(ui_alpha);
          draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + ui_height + (ui_padding_vertical * 2) + 1, ui_x + ui_width + ui_padding_horizontal, ui_y + ui_height + (ui_padding_vertical * 2) + 1, ui_line_size, ui_black, ui_black);
          draw_set_alpha(1);
        }
        draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + ui_height + (ui_padding_vertical * 2), ui_x + ui_width + ui_padding_horizontal, ui_y + ui_height + (ui_padding_vertical * 2), ui_line_size, ui_background_colour, ui_background_colour);
        if(font_exists(ui_font)){draw_set_font(ui_font);}
        if(ui_password){
          var ui_password_length = string_length(ui_alias_text);
          if(string_length(ui_alias_text) > floor(ui_width / 12)){ui_password_length = floor(ui_width / 12);}
          for(ui_i = 0; ui_i < ui_password_length; ui_i += 1){
            draw_set_alpha(0.05);
            draw_circle_colour(ui_x + ui_padding_horizontal + 2 + (ui_i * 12), ui_y + ui_padding_vertical + ((string_height('|') * 0.5)) + 1, 4, ui_black, ui_black, false);
            draw_set_alpha(1);
            draw_circle_colour(ui_x + ui_padding_horizontal + 2 + (ui_i * 12), ui_y + ui_padding_vertical + ((string_height('|') * 0.5)), 4, ui_foreground_colour, ui_foreground_colour, false);
          }
          if(ui_focus){
            if(ui_beam < room_speed * 0.5){
              draw_set_alpha(0.05);
              draw_line_width_colour(ui_x + ui_padding_horizontal + (ui_password_length * 12), ui_y + ui_padding_vertical + 1, ui_x + ui_padding_horizontal + (ui_password_length * 12), ui_y + ui_padding_vertical + string_height('|') + 1, 1, ui_black, ui_black);
              draw_set_alpha(1);
              draw_line_width_colour(ui_x + ui_padding_horizontal + (ui_password_length * 12), ui_y + ui_padding_vertical, ui_x + ui_padding_horizontal + (ui_password_length * 12), ui_y + ui_padding_vertical + string_height('|'), 1, ui_foreground_colour, ui_foreground_colour);
            }
          }
        }
        else{
          draw_set_halign(fa_left);
          draw_set_valign(fa_top);
          if(ui_shadow) draw_text_colour(ui_x + ui_padding_horizontal, ui_y + ui_padding_vertical + 1, string_replace_all(ui_alias_text, "#", "\#"), ui_black, ui_black, ui_black, ui_black, 0.05);
          draw_text_colour(ui_x + ui_padding_horizontal, ui_y + ui_padding_vertical, string_replace_all(ui_alias_text, "#", "\#"), ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
          if(ui_focus){
            if(ui_beam < room_speed * 0.5){
              if(ui_shadow){
                draw_set_alpha(0.05);
                draw_line_width_colour(ui_x + ui_padding_horizontal + string_width(string_replace_all(string_copy(ui_alias_text, 1, ui_beam_position - (string_pos(ui_alias_text, ui_text) - 1)), "#", "\#")) + 1, ui_y + ui_padding_vertical, ui_x + ui_padding_horizontal + string_width(string_replace_all(string_copy(ui_alias_text, 1, ui_beam_position - (string_pos(ui_alias_text, ui_text) - 1)), "#", "\#")) + 1, ui_y + ui_padding_vertical + string_height('|') + 1, 1, ui_black, ui_black);
                draw_set_alpha(1);
              }
              draw_line_width_colour(ui_x + ui_padding_horizontal + string_width(string_replace_all(string_copy(ui_alias_text, 1, ui_beam_position - (string_pos(ui_alias_text, ui_text) - 1)), "#", "\#")) + 1, ui_y + ui_padding_vertical, ui_x + ui_padding_horizontal + string_width(string_replace_all(string_copy(ui_alias_text, 1, ui_beam_position - (string_pos(ui_alias_text, ui_text) - 1)), "#", "\#")) + 1, ui_y + ui_padding_vertical + string_height('|'), 1, ui_foreground_colour, ui_foreground_colour);
            }
          }
        }
        if(font_exists(ui_label_font)){draw_set_font(ui_label_font);}
        draw_text_transformed_colour(ui_x + ui_padding_horizontal, ui_y + ui_padding_vertical - ui_label_top, ui_label, max(1 - ui_label_top / ((string_height('|') * 0.85) + ui_padding_vertical), 0.85), max(1 - ui_label_top / (string_height('|') * 0.85), 0.85), 0, ui_background_colour, ui_background_colour, ui_background_colour, ui_background_colour, 1);
      }
      else{
        if(ui_text != ""){
          ui_label_top = string_height('|') * 0.85 + ui_padding_vertical;
          ds_map_replace(argument[0], "ui_label_top", ui_label_top);
        }
        draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + ui_height + (ui_padding_vertical * 2), ui_x + ui_width + ui_padding_horizontal, ui_y + ui_height + (ui_padding_vertical * 2), 1, ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey));
        if(ui_password){
          var ui_password_length = string_length(ui_alias_text);
          if(string_length(ui_alias_text) > floor(ui_width / 12)){ui_password_length = floor(ui_width / 12);}
          for(ui_i = 0; ui_i < ui_password_length; ui_i += 1){draw_circle_colour(ui_x + ui_padding_horizontal + 2 + (ui_i * 12), ui_y + ui_padding_vertical + ((string_height('|') * 0.5)), 4, ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey), false);}
        }
        else{
          if(font_exists(ui_font)){draw_set_font(ui_font);}
          draw_set_halign(fa_left);
          draw_set_valign(fa_top);
          draw_text_colour(ui_x + ui_padding_horizontal, ui_y + ui_padding_vertical, string_replace_all(ui_alias_text, "#", "\#"), ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey), 1);
        }
        if(font_exists(ui_label_font)){draw_set_font(ui_label_font);}
        draw_text_transformed_colour(ui_x + ui_padding_horizontal, ui_y + ui_padding_vertical - ui_label_top, ui_label, max(1 - ui_label_top / ((string_height('|') * 0.85) + ui_padding_vertical), 0.85), max(1 - ui_label_top / (string_height('|') * 0.85), 0.85), 0, ui_grey, ui_grey, ui_grey, ui_grey, 1);
      }
      if(ui_focus){
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "debug_mode")){
            draw_set_alpha(0.25);
            draw_rectangle_colour(ui_x, ui_y, ui_x + ui_width + (ui_padding_horizontal * 2) + 1, ui_y + ui_height + (ui_padding_vertical * 2) + 1, ui_blue_grey, ui_blue_grey, ui_blue_grey, ui_blue_grey, true);
            draw_set_alpha(1);
          }
        }
      }
    }
    else{
      ui_debug_error(102, "ui_textbox_draw", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_textbox_draw", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_textbox_draw", object_get_name(object_index));
  return false;
}






#define ui_checkbox_create
if(argument_count == 4){
  if(ds_exists(ui_global_config, ds_type_map)){
    var ui_background_colour = ds_map_find_value(ui_global_config, "default_background_colour");
    var ui_foreground_colour = ds_map_find_value(ui_global_config, "default_foreground_colour");
    var ui_label_font = ds_map_find_value(ui_global_config, "default_label_font");
    var ui_effect = ds_map_find_value(ui_global_config, "enable_effect");
    var ui_effect_speed = max(ds_map_find_value(ui_global_config, "effect_speed") / 50, 0.1);
    var ui_shadow = ds_map_find_value(ui_global_config, "enable_shadow");
  }
  else{
    var ui_background_colour = ui_teal;
    var ui_foreground_colour = ui_white;
    var ui_label_font = ui_default;
    var ui_effect = true;
    var ui_effect_speed = 0.16;
    var ui_shadow = true;
  }
  var ui_control = ds_map_create();
  var ui_size = argument[2];
  ds_map_add(ui_control, "ui_type", ui_type_checkbox);
  ds_map_add(ui_control, "ui_x", argument[0]);
  ds_map_add(ui_control, "ui_y", argument[1]);
  ds_map_add(ui_control, "ui_start_x", 0);
  ds_map_add(ui_control, "ui_start_y", 0);
  ds_map_add(ui_control, "ui_size", ui_size);
  ds_map_add(ui_control, "ui_label", argument[3]);
  ds_map_add(ui_control, "ui_checked", false);
  ds_map_add(ui_control, "ui_changed", false);
  ds_map_add(ui_control, "ui_background_colour", ui_background_colour);
  ds_map_add(ui_control, "ui_inner_colour", ui_default);
  ds_map_add(ui_control, "ui_foreground_colour", ui_foreground_colour);
  ds_map_add(ui_control, "ui_focus", false);
  ds_map_add(ui_control, "ui_active", true); 
  ds_map_add(ui_control, "ui_enable", true); 
  ds_map_add(ui_control, "ui_label_font", ui_label_font);
  ds_map_add(ui_control, "ui_alpha", 0);
  ds_map_add(ui_control, "ui_padding_horizontal", 8);
  ds_map_add(ui_control, "ui_effect", ui_effect);
  ds_map_add(ui_control, "ui_effect_speed", ui_effect_speed);
  ds_map_add(ui_control, "ui_shadow", ui_shadow);
  if(ds_exists(ui_global_controls, ds_type_list)){ds_list_add(ui_global_controls, ui_control);}
  return ui_control;
}
else{
  ui_debug_error(101, "ui_checkbox_create", object_get_name(object_index));
  return false;
}






#define ui_checkbox_draw
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){ 
    var ui_type = ds_map_find_value(argument[0], "ui_type");
    if(ui_type == ui_type_checkbox){ 
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_start_x = ds_map_find_value(argument[0], "ui_start_x");
      var ui_start_y = ds_map_find_value(argument[0], "ui_start_y");
      var ui_size = ds_map_find_value(argument[0], "ui_size");
      var ui_label = ds_map_find_value(argument[0], "ui_label");
      var ui_checked = ds_map_find_value(argument[0], "ui_checked");
      var ui_changed = ds_map_find_value(argument[0], "ui_changed");
      var ui_inner_colour = ds_map_find_value(argument[0], "ui_inner_colour");
      var ui_background_colour = ds_map_find_value(argument[0], "ui_background_colour");
      var ui_foreground_colour = ds_map_find_value(argument[0], "ui_foreground_colour");
      var ui_enable = ds_map_find_value(argument[0], "ui_enable");
      var ui_active = ds_map_find_value(argument[0], "ui_active");
      var ui_focus = ds_map_find_value(argument[0], "ui_focus");
      var ui_label_font = ds_map_find_value(argument[0], "ui_label_font");
      var ui_alpha = ds_map_find_value(argument[0], "ui_alpha");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
      var ui_effect = ds_map_find_value(argument[0], "ui_effect");
      var ui_effect_speed = ds_map_find_value(argument[0], "ui_effect_speed");
      var ui_shadow = ds_map_find_value(argument[0], "ui_shadow");
      ui_size = max(ui_size - (ui_padding_horizontal * 2), ui_default);
      if(ui_size == ui_default) ui_size = 20;
      if(ui_inner_colour == ui_default) ui_inner_colour = surface_getpixel(application_surface, ui_x + ui_padding_horizontal + (ui_size * 0.5), ui_y + (ui_size * 0.5));
      if(font_exists(ui_label_font)) draw_set_font(ui_label_font);
      if(ui_enable){
        var ui_shadow_alpha = 0.015;
        var ui_mouse_x = device_mouse_x(0) - ui_start_x;
        var ui_mouse_y = device_mouse_y(0) - ui_start_y;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "draw_on_gui")){
            ui_mouse_x = device_mouse_x_to_gui(0) - ui_start_x;
            ui_mouse_y = device_mouse_y_to_gui(0) - ui_start_y;
          }
        }
        var keyboard_action = true;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(!ds_map_find_value(ui_global_config, "keyboard_action")){keyboard_action = false;}
        }
        if(ui_active && ((ui_mouse_x > ui_x + ui_padding_horizontal && ui_mouse_x < ui_x + ui_padding_horizontal + ui_size && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_padding_horizontal + ui_size) or (ui_mouse_x > ui_x + ui_padding_horizontal + ui_size && ui_mouse_x < ui_x + ui_size + (ui_padding_horizontal * 2) + string_width(ui_label) && ui_mouse_y > ui_y + ui_padding_horizontal + ((ui_size * 0.5) - (string_height(ui_label) * 0.5))&& ui_mouse_y < ui_y + ui_padding_horizontal + ((ui_size * 0.5) + (string_height(ui_label) * 0.5))) or (ui_focus && keyboard_action && keyboard_check_pressed(vk_enter)))){
          ui_shadow_alpha = 0.02;
          if(device_mouse_check_button_pressed(0, mb_left) or (ui_focus && keyboard_action && keyboard_check_pressed(vk_enter))){
            ui_checked = !ui_checked;
            ds_map_replace(argument[0], "ui_checked", ui_checked);
            ui_focus = true;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
          }
        }
        else{
          if(device_mouse_check_button_pressed(0, mb_left)){
            ui_focus = false;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
          }
        }
        if(ui_checked){
          if(ui_effect){
            if(ui_alpha < 1){
              ui_alpha += ui_effect_speed;
              ui_alpha = min(ui_alpha, 1);
              ds_map_replace(argument[0], "ui_alpha", ui_alpha);
            }
          }
          else{
            ui_alpha = 1;
            ds_map_replace(argument[0], "ui_alpha", ui_alpha);
          }
        }
        else{
          if(ui_effect){
            if(ui_alpha > 0){
              ui_alpha -= ui_effect_speed;
              ui_alpha = max(ui_alpha, 0);
              ds_map_replace(argument[0], "ui_alpha", ui_alpha);
            }
          }
          else{
            ui_alpha = 0;
            ds_map_replace(argument[0], "ui_alpha", ui_alpha);
          }
        }
        if(ui_shadow){
          draw_set_alpha(ui_shadow_alpha);
          draw_rectangle_colour(ui_x + ui_padding_horizontal - 1, ui_y + ui_padding_horizontal - 1, ui_x + ui_padding_horizontal + ui_size + 1, ui_y + ui_padding_horizontal + ui_size + 1, ui_black, ui_black, ui_black, ui_black, false);
          draw_rectangle_colour(ui_x + ui_padding_horizontal - 1, ui_y + ui_padding_horizontal - 1, ui_x + ui_padding_horizontal + ui_size + 1, ui_y + ui_padding_horizontal + ui_size + 2, ui_black, ui_black, ui_black, ui_black, false);
          draw_set_alpha(1);
        }      
        draw_rectangle_colour(ui_x + ui_padding_horizontal, ui_y + ui_padding_horizontal, ui_x + ui_padding_horizontal + ui_size, ui_y + ui_padding_horizontal + ui_size, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, false);
        draw_rectangle_colour(ui_x + ui_padding_horizontal + 2, ui_y + ui_padding_horizontal + 2, ui_x + ui_padding_horizontal + ui_size - 2, ui_y + ui_padding_horizontal + ui_size - 2, ui_inner_colour, ui_inner_colour, ui_inner_colour, ui_inner_colour, false);
        if(ui_checked or ui_alpha > 0){
          draw_set_alpha(ui_alpha);
          draw_rectangle_colour(ui_x + ui_padding_horizontal, ui_y + ui_padding_horizontal, ui_x + ui_padding_horizontal + ui_size, ui_y + ui_padding_horizontal + ui_size, ui_background_colour, ui_background_colour, ui_background_colour, ui_background_colour, false);
          draw_line_width_colour(ui_x + ui_padding_horizontal + (ui_size * 0.5) - (min(ui_size, 20) / 2.66), ui_y + ui_padding_horizontal + (ui_size * 0.5) - (min(ui_size, 20) / 16), ui_x + ui_padding_horizontal + (ui_size * 0.5) - (min(ui_size, 20) / 8), ui_y + ui_padding_horizontal + (ui_size * 0.5) + (min(ui_size, 20) / 5.33), round(min(ui_size / 8, 3)), ui_inner_colour, ui_inner_colour);
          draw_line_width_colour(ui_x + ui_padding_horizontal + (ui_size * 0.5) - (min(ui_size, 20) / 8), ui_y + ui_padding_horizontal + (ui_size * 0.5) + (min(ui_size, 20) / 5.33), ui_x + ui_padding_horizontal + (ui_size * 0.5) + ((min(ui_size, 20) / 3.2) * ui_alpha), ui_y + ui_padding_horizontal + (ui_size * 0.5) - ((min(ui_size, 20) / 4) * ui_alpha), round(min(ui_size / 8, 3)), ui_inner_colour, ui_inner_colour);
          draw_set_alpha(1);
        }
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        if(ui_shadow) draw_text_colour(ui_x + ui_padding_horizontal + ui_size + ui_padding_horizontal, ui_y + ui_padding_horizontal +(ui_size * 0.5) + 1, ui_label, ui_black, ui_black, ui_black, ui_black, 0.05);
        draw_text_colour(ui_x + ui_padding_horizontal + ui_size + ui_padding_horizontal, ui_y + ui_padding_horizontal +(ui_size * 0.5), ui_label, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
      }
      else{
        draw_roundrect_colour_ext(ui_x + ui_padding_horizontal, ui_y + ui_padding_horizontal, ui_x + ui_padding_horizontal + ui_size, ui_y + ui_padding_horizontal + ui_size, 4, 4, ui_colour_lighter_ext(ui_grey, 2), ui_colour_lighter_ext(ui_grey, 2), false);
        if(ui_checked){
          draw_line_width_colour(ui_x + ui_padding_horizontal + (ui_size * 0.5) - (min(ui_size, 20) / 2.66), ui_y + ui_padding_horizontal + (ui_size * 0.5) - (min(ui_size, 20) / 16), ui_x + ui_padding_horizontal + (ui_size * 0.5) - (min(ui_size, 20) / 8), ui_y + ui_padding_horizontal + (ui_size * 0.5) + (min(ui_size, 20) / 5.33), round(min(ui_size / 8, 3)), ui_inner_colour, ui_inner_colour);
          draw_line_width_colour(ui_x + ui_padding_horizontal + (ui_size * 0.5) - (min(ui_size, 20) / 8), ui_y + ui_padding_horizontal + (ui_size * 0.5) + (min(ui_size, 20) / 5.33), ui_x + ui_padding_horizontal + (ui_size * 0.5) + (min(ui_size, 20) / 3.2), ui_y + ui_padding_horizontal + (ui_size * 0.5) - (min(ui_size, 20) / 4), round(min(ui_size / 8, 3)), ui_inner_colour, ui_inner_colour);
        }
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text_colour(ui_x + ui_padding_horizontal + ui_size + ui_padding_horizontal, ui_y + ui_padding_horizontal +(ui_size * 0.5), ui_label, ui_grey, ui_grey, ui_grey, ui_grey, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top); 
      }
      if(ui_focus){
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "debug_mode")){
            draw_set_alpha(0.25);
            draw_rectangle_colour(ui_x - 1, ui_y - 1, ui_x + ui_size + (ui_padding_horizontal * 3) + string_width(ui_label) + 2, ui_y + ui_size + (ui_padding_horizontal * 2)+ 2, ui_blue_grey, ui_blue_grey, ui_blue_grey, ui_blue_grey, true);
            draw_set_alpha(1);
          }
        }
      }
    }
    else{
      ui_debug_error(102, "ui_checkbox_draw", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_checkbox_draw", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_checkbox_draw", object_get_name(object_index));
  return false;
}






#define ui_radio_create
if(argument_count == 4){
  if(ds_exists(ui_global_config, ds_type_map)){
    var ui_background_colour = ds_map_find_value(ui_global_config, "default_background_colour");
    var ui_foreground_colour = ds_map_find_value(ui_global_config, "default_foreground_colour");
    var ui_label_font = ds_map_find_value(ui_global_config, "default_label_font");
    var ui_effect = ds_map_find_value(ui_global_config, "enable_effect");
    var ui_effect_speed = max(ds_map_find_value(ui_global_config, "effect_speed") / 50, 0.1);
    var ui_shadow = ds_map_find_value(ui_global_config, "enable_shadow");
  }
  else{
    var ui_background_colour = ui_teal;
    var ui_foreground_colour = ui_white;
    var ui_label_font = ui_default;
    var ui_effect = true;
    var ui_effect_speed = 0.16;
    var ui_shadow = true;
  }
  var ui_control = ds_map_create();
  var ui_size = argument[2];
  ds_map_add(ui_control, "ui_type", ui_type_radio);
  ds_map_add(ui_control, "ui_group", "ui_default_group");
  ds_map_add(ui_control, "ui_x", argument[0]);
  ds_map_add(ui_control, "ui_y", argument[1]);
  ds_map_add(ui_control, "ui_start_x", 0);
  ds_map_add(ui_control, "ui_start_y", 0);
  ds_map_add(ui_control, "ui_size", ui_size);
  ds_map_add(ui_control, "ui_label", argument[3]);
  ds_map_add(ui_control, "ui_checked", false);
  ds_map_add(ui_control, "ui_changed", false);
  ds_map_add(ui_control, "ui_background_colour", ui_background_colour);
  ds_map_add(ui_control, "ui_inner_colour", ui_default);
  ds_map_add(ui_control, "ui_foreground_colour", ui_foreground_colour);
  ds_map_add(ui_control, "ui_focus", false);
  ds_map_add(ui_control, "ui_enable", true);
  ds_map_add(ui_control, "ui_active", true);
  ds_map_add(ui_control, "ui_label_font", ui_label_font);
  ds_map_add(ui_control, "ui_alpha", 0);
  ds_map_add(ui_control, "ui_padding_horizontal", 8);
  ds_map_add(ui_control, "ui_effect", ui_effect);
  ds_map_add(ui_control, "ui_effect_speed", ui_effect_speed);
  ds_map_add(ui_control, "ui_shadow", ui_shadow);
  if(ds_exists(ui_global_controls, ds_type_list)){ds_list_add(ui_global_controls, ui_control);}
  return ui_control;
}
else{
  ui_debug_error(101, "ui_radio_create", object_get_name(object_index));
  return false;
}






#define ui_radio_set_group
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_group")){
      ds_map_replace(argument[0], "ui_group", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_radio_set_group", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_radio_set_group", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_radio_set_group", object_get_name(object_index));
  return false;
}






#define ui_radio_draw
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){  
    var ui_type = ds_map_find_value(argument[0], "ui_type");
    if(ui_type == ui_type_radio){ 
      var ui_group = ds_map_find_value(argument[0], "ui_group");
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_start_x = ds_map_find_value(argument[0], "ui_start_x");
      var ui_start_y = ds_map_find_value(argument[0], "ui_start_y");
      var ui_size = ds_map_find_value(argument[0], "ui_size");
      var ui_label = ds_map_find_value(argument[0], "ui_label");
      var ui_checked = ds_map_find_value(argument[0], "ui_checked");
      var ui_changed = ds_map_find_value(argument[0], "ui_changed");
      var ui_inner_colour = ds_map_find_value(argument[0], "ui_inner_colour");
      var ui_background_colour = ds_map_find_value(argument[0], "ui_background_colour");
      var ui_foreground_colour = ds_map_find_value(argument[0], "ui_foreground_colour");
      var ui_enable = ds_map_find_value(argument[0], "ui_enable");
      var ui_active = ds_map_find_value(argument[0], "ui_active");
      var ui_focus = ds_map_find_value(argument[0], "ui_focus");
      var ui_label_font = ds_map_find_value(argument[0], "ui_label_font");
      var ui_alpha = ds_map_find_value(argument[0], "ui_alpha");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
      var ui_effect = ds_map_find_value(argument[0], "ui_effect");
      var ui_effect_speed = ds_map_find_value(argument[0], "ui_effect_speed");
      var ui_shadow = ds_map_find_value(argument[0], "ui_shadow");
      ui_size = max(ui_size - (ui_padding_horizontal * 2), ui_default);
      if(ui_size == ui_default) ui_size = 18;
      if(ui_inner_colour == ui_default) ui_inner_colour = surface_getpixel(application_surface, ui_x + ui_padding_horizontal + (ui_size * 0.5), ui_y + ui_padding_horizontal + (ui_size * 0.5));
      if(font_exists(ui_label_font)) draw_set_font(ui_label_font);
      if(ui_enable){
        var ui_shadow_alpha = 0.015;
        var ui_mouse_x = device_mouse_x(0) - ui_start_x;
        var ui_mouse_y = device_mouse_y(0) - ui_start_y;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "draw_on_gui")){
            ui_mouse_x = device_mouse_x_to_gui(0) - ui_start_x;
            ui_mouse_y = device_mouse_y_to_gui(0) - ui_start_y;
          }
        }
        if(ui_active && ((ui_mouse_x > ui_x + ui_padding_horizontal && ui_mouse_x < ui_x + ui_padding_horizontal + ui_size && ui_mouse_y > ui_y + ui_padding_horizontal && ui_mouse_y < ui_y + ui_padding_horizontal + ui_size) or (ui_mouse_x > ui_x + ui_padding_horizontal + ui_size && ui_mouse_x < ui_x + ui_padding_horizontal + ui_size + ui_padding_horizontal + string_width(ui_label) && ui_mouse_y > ui_y + ui_padding_horizontal + ((ui_size * 0.5) - (string_height(ui_label) * 0.5))&& ui_mouse_y < ui_y + ui_padding_horizontal + ((ui_size * 0.5) + (string_height(ui_label) * 0.5))))){
          ui_shadow_alpha = 0.02;
          if(device_mouse_check_button_pressed(0, mb_left)){
            if(!ui_checked){
              ui_set_checked(argument[0], true);
              if(ds_exists(ui_global_controls, ds_type_list)){
                for(var ui_i = 0; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
                  var control = ds_list_find_value(ui_global_controls, ui_i);
                  if(control != argument[0]){
                    if(ds_exists(control, ds_type_map)){
                      if(ui_get_type(control) == ui_type_radio){
                        if(ds_map_find_value(control, "ui_group") == ui_group){ui_set_checked(control, false);}
                      }
                    }
                  }
                }
              }
            }
            ui_focus = true;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
          }
        }
        else{
          if(device_mouse_check_button_pressed(0, mb_left)){
            ui_focus = false;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
          }
        }
        if(ui_checked){
          if(ui_effect){
            if(ui_alpha < 1){
              ui_alpha += ui_effect_speed;
              ui_alpha = min(ui_alpha, 1);
              ds_map_replace(argument[0], "ui_alpha", ui_alpha);
            }
          }
          else{
            ui_alpha = 1;
            ds_map_replace(argument[0], "ui_alpha", ui_alpha);
          }
        }
        else{
          if(ui_effect){
            if(ui_alpha > 0){
              ui_alpha -= ui_effect_speed;
              ui_alpha = max(ui_alpha, 0);
              ds_map_replace(argument[0], "ui_alpha", ui_alpha);
            }
          }
          else{
            ui_alpha =  0;
            ds_map_replace(argument[0], "ui_alpha", ui_alpha);
          }
        }
        if(ui_shadow){
          draw_set_alpha(ui_shadow_alpha);
          draw_circle_colour(ui_x + ui_padding_horizontal + (ui_size * 0.5), ui_y + ui_padding_horizontal + (ui_size * 0.5), (ui_size * 0.5) + 2, ui_black, ui_black, false);
          draw_circle_colour(ui_x + ui_padding_horizontal + (ui_size * 0.5), ui_y + ui_padding_horizontal + (ui_size * 0.5) + 1, (ui_size * 0.5) + 1, ui_black, ui_black, false);
          draw_set_alpha(1);
        }
        draw_circle_colour(ui_x + ui_padding_horizontal + (ui_size * 0.5), ui_y + ui_padding_horizontal + (ui_size * 0.5), (ui_size * 0.5) + 1, ui_foreground_colour, ui_foreground_colour, false);
        draw_circle_colour(ui_x + ui_padding_horizontal + (ui_size * 0.5), ui_y + ui_padding_horizontal + (ui_size * 0.5), (ui_size * 0.5) - 1, ui_inner_colour, ui_inner_colour, false);
        if(ui_checked or ui_alpha > 0){
          draw_set_alpha(ui_alpha);
          draw_circle_colour(ui_x + ui_padding_horizontal + (ui_size * 0.5), ui_y + ui_padding_horizontal + (ui_size * 0.5), ((ui_size * 0.5) + 1) * ui_alpha, ui_background_colour, ui_background_colour, false);
          draw_set_alpha(1);
        }
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        if(ui_shadow) draw_text_colour(ui_x + ui_padding_horizontal + ui_size + ui_padding_horizontal, ui_y + ui_padding_horizontal +(ui_size * 0.5) + 1, ui_label, ui_black, ui_black, ui_black, ui_black, 0.05);
        draw_text_colour(ui_x + ui_padding_horizontal + ui_size + ui_padding_horizontal, ui_y + ui_padding_horizontal +(ui_size * 0.5), ui_label, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
      }
      else{
        draw_circle_colour(ui_x + ui_padding_horizontal + (ui_size * 0.5), ui_y + ui_padding_horizontal + (ui_size * 0.5), (ui_size * 0.5) + 1, ui_colour_lighter_ext(ui_grey, 2), ui_colour_lighter_ext(ui_grey, 2), false);
        if(!ui_checked){
          draw_circle_colour(ui_x + ui_padding_horizontal + (ui_size * 0.5), ui_y + ui_padding_horizontal + (ui_size * 0.5), (ui_size * 0.5) - 1, ui_inner_colour, ui_inner_colour, false);
        } 
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text_colour(ui_x + ui_padding_horizontal + ui_size + ui_padding_horizontal, ui_y + ui_padding_horizontal +(ui_size * 0.5), ui_label, ui_grey, ui_grey, ui_grey, ui_grey, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top); 
      }
      if(ui_focus){
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "debug_mode")){
            draw_set_alpha(0.25);
            draw_rectangle_colour(ui_x - 1, ui_y - 1, ui_x + ui_size + (ui_padding_horizontal * 3) + string_width(ui_label) + 2, ui_y + ui_size + (ui_padding_horizontal * 2)+ 2, ui_blue_grey, ui_blue_grey, ui_blue_grey, ui_blue_grey, true);
            draw_set_alpha(1);
          }
        }
      }
    }
    else{
      ui_debug_error(102, "ui_radio_draw", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_radio_draw", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_radio_draw", object_get_name(object_index));
  return false;
}






#define ui_switch_create
if(argument_count == 5){
  if(ds_exists(ui_global_config, ds_type_map)){
    var ui_background_colour = ds_map_find_value(ui_global_config, "default_background_colour");
    var ui_foreground_colour = ds_map_find_value(ui_global_config, "default_foreground_colour");
    var ui_label_font = ds_map_find_value(ui_global_config, "default_label_font");
    var ui_effect = ds_map_find_value(ui_global_config, "enable_effect");
    var ui_effect_speed = max(ds_map_find_value(ui_global_config, "effect_speed") / 40, 0.1);
    var ui_shadow = ds_map_find_value(ui_global_config, "enable_shadow");
  }
  else{
    var ui_background_colour = ui_teal;
    var ui_foreground_colour = ui_white;
    var ui_label_font = ui_default;
    var ui_effect = true;
    var ui_effect_speed = 0.2;
    var ui_shadow = true;
  }
  var ui_control = ds_map_create();
  var ui_size = max(argument[2], ui_default);
  ds_map_add(ui_control, "ui_type", ui_type_switch);
  ds_map_add(ui_control, "ui_x", argument[0]);
  ds_map_add(ui_control, "ui_y", argument[1]);
  ds_map_add(ui_control, "ui_start_x", 0);
  ds_map_add(ui_control, "ui_start_y", 0);
  ds_map_add(ui_control, "ui_width", ui_size);
  ds_map_add(ui_control, "ui_height", argument[3]);
  ds_map_add(ui_control, "ui_label", argument[4]);
  ds_map_add(ui_control, "ui_checked", false);
  ds_map_add(ui_control, "ui_changed", false);
  ds_map_add(ui_control, "ui_background_colour", ui_background_colour);
  ds_map_add(ui_control, "ui_inner_colour", ui_default);
  ds_map_add(ui_control, "ui_foreground_colour", ui_foreground_colour);
  ds_map_add(ui_control, "ui_focus", false);
  ds_map_add(ui_control, "ui_enable", true);
  ds_map_add(ui_control, "ui_active", true);
  ds_map_add(ui_control, "ui_label_font", ui_label_font);
  ds_map_add(ui_control, "ui_left", 0);
  ds_map_add(ui_control, "ui_padding_horizontal", 8);
  ds_map_add(ui_control, "ui_effect", ui_effect);
  ds_map_add(ui_control, "ui_effect_speed", ui_effect_speed);
  ds_map_add(ui_control, "ui_shadow", ui_shadow);
  if(ds_exists(ui_global_controls, ds_type_list)){ds_list_add(ui_global_controls, ui_control);}
  return ui_control;
}
else{
  ui_debug_error(101, "ui_switch_create", object_get_name(object_index));
  return false;
}






#define ui_switch_draw
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){ 
    var ui_type = ds_map_find_value(argument[0], "ui_type");
    if(ui_type == ui_type_switch){  
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_start_x = ds_map_find_value(argument[0], "ui_start_x");
      var ui_start_y = ds_map_find_value(argument[0], "ui_start_y");
      var ui_width = ds_map_find_value(argument[0], "ui_width");
      var ui_height = ds_map_find_value(argument[0], "ui_height");
      var ui_label = ds_map_find_value(argument[0], "ui_label");
      var ui_checked = ds_map_find_value(argument[0], "ui_checked");
      var ui_changed = ds_map_find_value(argument[0], "ui_changed");
      var ui_inner_colour = ds_map_find_value(argument[0], "ui_inner_colour");
      var ui_background_colour = ds_map_find_value(argument[0], "ui_background_colour");
      var ui_foreground_colour = ds_map_find_value(argument[0], "ui_foreground_colour");
      var ui_enable = ds_map_find_value(argument[0], "ui_enable");
      var ui_active = ds_map_find_value(argument[0], "ui_active");
      var ui_focus = ds_map_find_value(argument[0], "ui_focus");
      var ui_label_font = ds_map_find_value(argument[0], "ui_label_font");
      var ui_left = ds_map_find_value(argument[0], "ui_left");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
      var ui_effect = ds_map_find_value(argument[0], "ui_effect");
      var ui_effect_speed = ds_map_find_value(argument[0], "ui_effect_speed");
      var ui_shadow = ds_map_find_value(argument[0], "ui_shadow");
      if(ui_width == ui_default) ui_width = 48;
      if(ui_height == ui_default) ui_height = 22;
      if(ui_inner_colour == ui_default) ui_inner_colour = ui_grey;
      if(font_exists(ui_label_font)) draw_set_font(ui_label_font);
      if(ui_enable){
        var ui_alpha = 0.015;
        var ui_control_colour = ui_colour_lighter_ext(ui_inner_colour, 2);
        var ui_mouse_x = device_mouse_x(0) - ui_start_x;
        var ui_mouse_y = device_mouse_y(0) - ui_start_y;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "draw_on_gui")){
            ui_mouse_x = device_mouse_x_to_gui(0) - ui_start_x;
            ui_mouse_y = device_mouse_y_to_gui(0) - ui_start_y;
          }
        }
        var keyboard_action = true;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(!ds_map_find_value(ui_global_config, "keyboard_action")){keyboard_action = false;}
        }
        if(ui_active && ((ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_width && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_height) or (ui_mouse_x > ui_x + ui_width && ui_mouse_x < ui_x + ui_width + ui_padding_horizontal + string_width(ui_label) && ui_mouse_y > ui_y + ((ui_height * 0.5) - (string_height(ui_label) * 0.5))&& ui_mouse_y < ui_y + ((ui_height * 0.5) + (string_height(ui_label) * 0.5))) or (ui_focus && keyboard_action && keyboard_check_pressed(vk_enter)))){
          ui_alpha = 0.02;
          if(device_mouse_check_button_pressed(0, mb_left) or (ui_focus && keyboard_action && keyboard_check_pressed(vk_enter))){
            ui_checked = !ui_checked;
            ds_map_replace(argument[0], "ui_checked", ui_checked);
            ui_focus = true;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
          }
          if(device_mouse_check_button(0, mb_left)){
            draw_set_alpha(0.2);
            draw_circle_colour(ui_x + (ui_height * 0.5) + ((ui_width - ui_height) * ui_left), ui_y + (ui_height * 0.5), ui_height, ui_colour_lighter(ui_grey), ui_colour_lighter_ext(ui_grey, 2), false);
            draw_set_alpha(1);
          }
        }
        else{
          if(device_mouse_check_button_pressed(0, mb_left)){
            ui_focus = false;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
          }
        }
        if(ui_checked){
          if(ui_effect){
            if(ui_left < 1){
              ui_left += ui_effect_speed;
              ui_left = min(ui_left, 1);
              ds_map_replace(argument[0], "ui_left", ui_left);
            }
          }
          else{
            ui_left = 1;
            ds_map_replace(argument[0], "ui_left", ui_left);
          }
          ui_control_colour = ui_background_colour;
          ui_inner_colour = ui_colour_lighter_ext(ui_background_colour, 2);
        }
        else{
          if(ui_effect){
            if(ui_left > 0){
              ui_left -= ui_effect_speed;
              ui_left = max(ui_left, 0);
              ds_map_replace(argument[0], "ui_left", ui_left);
            }
          }
          else{
            ui_left = 0;
            ds_map_replace(argument[0], "ui_left", ui_left);
          }
        }     
        draw_roundrect_colour_ext(ui_x + (ui_height * 0.25), ui_y + (ui_height * 0.5) - (ui_height * 0.4), ui_x + ui_width - (ui_height * 0.25), ui_y + (ui_height * 0.5) + (ui_height * 0.4), ui_height - (ui_height * 0.25), ui_height, ui_inner_colour, ui_inner_colour, false);
        if(ui_shadow){
          draw_set_alpha(ui_alpha)
          draw_circle_colour(ui_x + (ui_height * 0.5) + ((ui_width - ui_height) * ui_left), ui_y + (ui_height * 0.5), (ui_height * 0.5) + 3, ui_black, ui_black, false);
          draw_circle_colour(ui_x + (ui_height * 0.5) + ((ui_width - ui_height) * ui_left), ui_y + (ui_height * 0.5), (ui_height * 0.5) + 2, ui_black, ui_black, false);
          draw_circle_colour(ui_x + (ui_height * 0.5) + ((ui_width - ui_height) * ui_left), ui_y + (ui_height * 0.5), (ui_height * 0.5) + 1, ui_black, ui_black, false); 
          draw_circle_colour(ui_x + (ui_height * 0.5) + ((ui_width - ui_height) * ui_left), ui_y + (ui_height * 0.5), (ui_height * 0.5) + 1, ui_black, ui_black, false);
          draw_set_alpha(1);
        }
        draw_circle_colour(ui_x + (ui_height * 0.5) + ((ui_width - ui_height) * ui_left), ui_y + (ui_height * 0.5), (ui_height * 0.5), ui_control_colour, ui_control_colour, false);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        if(ui_shadow) draw_text_colour(ui_x + ui_width + ui_padding_horizontal, ui_y +(ui_height * 0.5) + 1, ui_label, ui_black, ui_black, ui_black, ui_black, 0.05);
        draw_text_colour(ui_x + ui_width + ui_padding_horizontal, ui_y +(ui_height * 0.5), ui_label, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
      }
      else{
        draw_roundrect_colour_ext(ui_x + (ui_height * 0.25), ui_y + (ui_height * 0.5) - (ui_height * 0.4), ui_x + ui_width - (ui_height * 0.25), ui_y + (ui_height * 0.5) + (ui_height * 0.4), ui_height - (ui_height * 0.25), ui_height, ui_grey, ui_grey, false);
        if(ui_shadow){
          draw_set_alpha(0.015)
          draw_circle_colour(ui_x + (ui_height * 0.5) + ((ui_width - ui_height) * ui_checked), ui_y + (ui_height * 0.5), (ui_height * 0.5) + 3, ui_black, ui_black, false);
          draw_circle_colour(ui_x + (ui_height * 0.5) + ((ui_width - ui_height) * ui_checked), ui_y + (ui_height * 0.5), (ui_height * 0.5) + 2, ui_black, ui_black, false);
          draw_circle_colour(ui_x + (ui_height * 0.5) + ((ui_width - ui_height) * ui_checked), ui_y + (ui_height * 0.5), (ui_height * 0.5) + 1, ui_black, ui_black, false); 
          draw_circle_colour(ui_x + (ui_height * 0.5) + ((ui_width - ui_height) * ui_checked), ui_y + (ui_height * 0.5), (ui_height * 0.5) + 1, ui_black, ui_black, false);
          draw_set_alpha(1);
        }
        draw_circle_colour(ui_x + (ui_height * 0.5) + ((ui_width - ui_height) * ui_checked), ui_y + (ui_height * 0.5), (ui_height * 0.5), ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey), false);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text_colour(ui_x + ui_width + ui_padding_horizontal, ui_y +(ui_height * 0.5), ui_label, ui_grey, ui_grey, ui_grey, ui_grey, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
      }
      if(ui_focus){
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "debug_mode")){
            draw_set_alpha(0.25);
            draw_rectangle_colour(ui_x - 1, ui_y - 1, ui_x + ui_width + ui_padding_horizontal + string_width(ui_label) + 2, ui_y + ui_height + 3, ui_blue_grey, ui_blue_grey, ui_blue_grey, ui_blue_grey, true);
            draw_set_alpha(1);
          }
        }
      }
    }
    else{
      ui_debug_error(102, "ui_switch_draw", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_switch_draw", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_switch_draw", object_get_name(object_index));
  return false;
}






#define ui_select_create
if(argument_count == 5){
  if(ds_exists(ui_global_config, ds_type_map)){
    var ui_background_colour = ds_map_find_value(ui_global_config, "default_background_colour");
    var ui_foreground_colour = ds_map_find_value(ui_global_config, "default_foreground_colour");
    var ui_font = ds_map_find_value(ui_global_config, "default_text_font");
    var ui_label_font = ds_map_find_value(ui_global_config, "default_label_font");
    var ui_effect = ds_map_find_value(ui_global_config, "enable_effect");
    var ui_effect_speed = max(ds_map_find_value(ui_global_config, "effect_speed") / 40, 0.1);
    var ui_shadow = ds_map_find_value(ui_global_config, "enable_shadow");
  }
  else{
    var ui_background_colour = ui_teal;
    var ui_foreground_colour = ui_white;
    var ui_font = ui_default;
    var ui_label_font = ui_default;
    var ui_effect = true;
    var ui_effect_speed = 0.12;
    var ui_shadow = true;
  }
  var ui_control = ds_map_create();
  var ui_width = max(argument[2], ui_default);
  var ui_height = max(argument[3], ui_default);
  ds_map_add(ui_control, "ui_type", ui_type_select);
  ds_map_add(ui_control, "ui_x", argument[0]);
  ds_map_add(ui_control, "ui_y", argument[1]);
  ds_map_add(ui_control, "ui_start_x", 0);
  ds_map_add(ui_control, "ui_start_y", 0);
  ds_map_add(ui_control, "ui_width", ui_width);
  ds_map_add(ui_control, "ui_height", ui_height);
  ds_map_add(ui_control, "ui_label", argument[4]);
  ds_map_add(ui_control, "ui_clicked", false);
  ds_map_add(ui_control, "ui_items", ds_list_create());
  ds_map_add(ui_control, "ui_selected", 0);
  ds_map_add(ui_control, "ui_open", false);
  ds_map_add(ui_control, "ui_background_colour", ui_background_colour);
  ds_map_add(ui_control, "ui_foreground_colour", ui_foreground_colour);
  ds_map_add(ui_control, "ui_focus", false);
  ds_map_add(ui_control, "ui_enable", true);
  ds_map_add(ui_control, "ui_active", true);
  ds_map_add(ui_control, "ui_label_font", ui_label_font);
  ds_map_add(ui_control, "ui_font", ui_font);
  ds_map_add(ui_control, "ui_padding_horizontal", 0);
  ds_map_add(ui_control, "ui_padding_vertical", 0);
  ds_map_add(ui_control, "ui_top", 0); 
  ds_map_add(ui_control, "ui_effect", ui_effect);
  ds_map_add(ui_control, "ui_effect_speed", ui_effect_speed);
  ds_map_add(ui_control, "ui_shadow", ui_shadow);
  if(ds_exists(ui_global_controls, ds_type_list)){
    ds_list_add(ui_global_controls, ui_control);
  }
  return ui_control;
}
else{
  ui_debug_error(101, "ui_select_create", object_get_name(object_index));
  return false;
}






#define ui_select_draw
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    var ui_type = ds_map_find_value(argument[0], "ui_type");
    if(ui_type == ui_type_select){
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_start_x = ds_map_find_value(argument[0], "ui_start_x");
      var ui_start_y = ds_map_find_value(argument[0], "ui_start_y");
      var ui_width = ds_map_find_value(argument[0], "ui_width");
      var ui_height = ds_map_find_value(argument[0], "ui_height");
      var ui_label = ds_map_find_value(argument[0], "ui_label");
      var ui_clicked = ds_map_find_value(argument[0], "ui_clicked");
      var ui_items = ds_map_find_value(argument[0], "ui_items");
      var ui_selected = ds_map_find_value(argument[0], "ui_selected");
      var ui_open = ds_map_find_value(argument[0], "ui_open");
      var ui_text = "Choose your option";
      if(ds_exists(ui_items, ds_type_list)){
        if(ds_list_find_value(ui_items, ui_selected) != undefined){ui_text = ds_list_find_value(ui_items, ui_selected);}
      }
      var ui_background_colour = ds_map_find_value(argument[0], "ui_background_colour");
      var ui_foreground_colour = ds_map_find_value(argument[0], "ui_foreground_colour");
      var ui_enable = ds_map_find_value(argument[0], "ui_enable");
      var ui_active = ds_map_find_value(argument[0], "ui_active");
      var ui_label_font = ds_map_find_value(argument[0], "ui_label_font");
      var ui_font = ds_map_find_value(argument[0], "ui_font");
      var ui_focus = ds_map_find_value(argument[0], "ui_focus");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
      var ui_padding_vertical = ds_map_find_value(argument[0], "ui_padding_vertical");
      var ui_top = ds_map_find_value(argument[0], "ui_top");
      var ui_effect = ds_map_find_value(argument[0], "ui_effect");
      var ui_effect_speed = ds_map_find_value(argument[0], "ui_effect_speed");
      var ui_shadow = ds_map_find_value(argument[0], "ui_shadow");
      if(font_exists(ui_font)) draw_set_font(ui_font);
      if(ui_width == ui_default) ui_width = 320;
      if(ui_height == ui_default) ui_height = string_height('|');
      if(ui_enable){
        var ui_alpha = 0.015;
        var ui_mouse_x = device_mouse_x(0) - ui_start_x;
        var ui_mouse_y = device_mouse_y(0) - ui_start_y;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "draw_on_gui")){
            ui_mouse_x = device_mouse_x_to_gui(0) - ui_start_x;
            ui_mouse_y = device_mouse_y_to_gui(0) - ui_start_y;
          }
        }
        var keyboard_action = true;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(!ds_map_find_value(ui_global_config, "keyboard_action")) keyboard_action = false;
        }
        if(ui_active && ((ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_width + (ui_padding_horizontal * 2) && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_height + (ui_padding_vertical * 2)) or (ui_focus && keyboard_action && keyboard_check_pressed(vk_enter)))){
          if(!ui_open){
            ui_alpha = 0.02;
            if(device_mouse_check_button_pressed(0, mb_left) or (ui_focus && keyboard_action && keyboard_check_pressed(vk_enter))){
              ui_open = true;
              ds_map_replace(argument[0], "ui_open", ui_open);
              for(var ui_i = 0; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
                var control = ds_list_find_value(ui_global_controls, ui_i);
                if(ds_exists(control, ds_type_map)){
                  if(control != argument[0]){ds_map_replace(control, "ui_active", false);}
                }
              }
              if(ds_exists(ui_keyboard, ds_type_map)){
                ds_map_replace(ui_keyboard, "ui_active", false);
              }
              ui_focus = true;
              ds_map_replace(argument[0], "ui_focus", ui_focus);
            }
          }
        }
        else{
          if(device_mouse_check_button_pressed(0, mb_left)){
            ui_focus = false;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
          }
        }
        if(ui_shadow){
          draw_set_alpha(ui_alpha);
          draw_line_width_colour(ui_x, ui_y + ui_height + (ui_padding_vertical * 2) + 1, ui_x + ui_width + (ui_padding_horizontal * 2), ui_y + ui_height + (ui_padding_vertical * 2) + 1, 1, ui_black, ui_black);
          draw_set_alpha(1);
        }
        draw_line_width_colour(ui_x, ui_y + ui_height + (ui_padding_vertical * 2), ui_x + ui_width + (ui_padding_horizontal * 2), ui_y + ui_height + (ui_padding_vertical * 2), 1, ui_background_colour, ui_background_colour);
        draw_triangle_colour(ui_x + ui_width + ui_padding_horizontal - 8, ui_y + (ui_height * 0.5) + ui_padding_vertical, ui_x + ui_width + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical, ui_x + ui_width + ui_padding_horizontal - 4, ui_y + (ui_height * 0.5) + ui_padding_vertical + 4, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, false);
        if(font_exists(ui_font)){
          draw_set_font(ui_font);
        }
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        if(ui_shadow) draw_text_colour(ui_x + ui_padding_horizontal, ui_y + ui_padding_vertical + (ui_height * 0.5) + 1, ui_text, ui_black, ui_black, ui_black, ui_black, 0.05);
        draw_text_colour(ui_x + ui_padding_horizontal, ui_y + ui_padding_vertical + (ui_height * 0.5), ui_text, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
        if(font_exists(ui_label_font)){
          draw_set_font(ui_label_font);
        }
        draw_set_valign(fa_top);
        var ui_label_top = (string_height('|') * 0.85 + ui_padding_vertical);
        draw_text_transformed_colour(ui_x + ui_padding_horizontal, ui_y + ui_padding_vertical - ui_label_top, ui_label, max(1 - ui_label_top / ((string_height('|') * 0.85) + ui_padding_vertical), 0.85), max(1 - ui_label_top / (string_height('|') * 0.85), 0.85), 0, ui_background_colour, ui_background_colour, ui_background_colour, ui_background_colour, 1);
        if(font_exists(ui_font)){
          draw_set_font(ui_font);
        }
        if(ui_open){
          if(ui_effect){
            if(ui_top < 1){
              ui_top += ui_effect_speed; 
              ui_top = min(ui_top, 1);
              ds_map_replace(argument[0], "ui_top", ui_top);
            }
          }
          else{
            ui_top = 1;
            ds_map_replace(argument[0], "ui_top", ui_top);
          }
          if(ui_shadow){
            draw_set_alpha(0.02*ui_top);
            draw_rectangle_colour(ui_x-4, ui_y-3, ui_x + ui_width + 16 + 4, ui_y + ((ds_list_size(ui_items)*(ui_height + 20))*ui_top) + 4, ui_black, ui_black, ui_black, ui_black, false);
            draw_rectangle_colour(ui_x-3, ui_y-2, ui_x + ui_width + 16 + 3, ui_y + ((ds_list_size(ui_items)*(ui_height + 20))*ui_top) + 3, ui_black, ui_black, ui_black, ui_black, false);
            draw_rectangle_colour(ui_x-2, ui_y-1, ui_x + ui_width + 16 + 2, ui_y + ((ds_list_size(ui_items)*(ui_height + 20))*ui_top) + 2, ui_black, ui_black, ui_black, ui_black, false);
            draw_rectangle_colour(ui_x-1, ui_y-0, ui_x + ui_width + 16 + 1, ui_y + ((ds_list_size(ui_items)*(ui_height + 20))*ui_top) + 2, ui_black, ui_black, ui_black, ui_black, false);
            draw_rectangle_colour(ui_x-1, ui_y-0, ui_x + ui_width + 16 + 1, ui_y + ((ds_list_size(ui_items)*(ui_height + 20))*ui_top) + 1, ui_black, ui_black, ui_black, ui_black, false);
            draw_set_alpha(1);
          }
          draw_set_alpha(ui_top);
          draw_rectangle_colour(ui_x, ui_y, ui_x + ui_width + 16, ui_y + ((ds_list_size(ui_items)*(ui_height + 20)) * ui_top), ui_white, ui_white, ui_white, ui_white, false);
          draw_set_alpha(1);
          if(ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_width + 16 && ui_mouse_y > ui_y && ui_mouse_y < ui_y + (ds_list_size(ui_items)*(ui_height + 20))){
            var ui_index = (ui_mouse_y - ui_y) div (ui_height + 20);
            draw_rectangle_colour(ui_x, ui_y + (ui_index * (ui_height + 20)), ui_x + ui_width + 16, ui_y + (ui_index * (ui_height + 20)) + (ui_height + 20), ui_colour_lighter_ext(ui_grey, 2), ui_colour_lighter_ext(ui_grey, 2), ui_colour_lighter_ext(ui_grey, 2), ui_colour_lighter_ext(ui_grey, 2), false);
            if(device_mouse_check_button_released(0, mb_left)){
              if(ui_clicked){
                ui_selected = ui_index;
                ds_map_replace(argument[0], "ui_selected", ui_selected);
                ui_open = false;
                ds_map_replace(argument[0], "ui_open", ui_open);
                for(var ui_i = 0; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
                  var control = ds_list_find_value(ui_global_controls, ui_i);
                  if(ds_exists(control, ds_type_map)){
                    if(control != argument[0]){ds_map_replace(control, "ui_active", true);}
                  }
                }
                if(ds_exists(ui_keyboard, ds_type_map)){
                  ds_map_replace(ui_keyboard, "ui_active", true);
                }
                ui_clicked = false;
                ds_map_replace(argument[0], "ui_clicked", ui_clicked);
                ui_focus = true;
                ds_map_replace(argument[0], "ui_focus", ui_focus);
              }
              else{
                ui_clicked = true;
                ds_map_replace(argument[0], "ui_clicked", ui_clicked);
              }
            }
          }
          else{
            if(ui_open && ui_clicked && device_mouse_check_button_released(0, mb_left)){
              ui_open = false;
              ds_map_replace(argument[0], "ui_open", ui_open);
              for(var ui_i = 0; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
                var control = ds_list_find_value(ui_global_controls, ui_i);
                if(ds_exists(control, ds_type_map)){
                  if(control != argument[0]){ds_map_replace(control, "ui_active", true);}
                }
              }
              if(ds_exists(ui_keyboard, ds_type_map)){
                ds_map_replace(ui_keyboard, "ui_active", true);
              }
            }
          }
          draw_set_halign(fa_left);
          draw_set_valign(fa_middle);
          for(var ui_i=0;ui_i<ds_list_size(ui_items);ui_i+=1){
            var ui_item_text = ds_list_find_value(ui_items, ui_i);
            if(ui_shadow) draw_text_colour(ui_x + 16, ui_y + (ui_i * (ui_height + 20)) + (ui_height * 0.5) + 11 , ui_item_text, ui_black, ui_black, ui_black, ui_black, 0.05*ui_top);
            draw_text_colour(ui_x + 16, ui_y + (ui_i * (ui_height + 20)) + (ui_height * 0.5) + 10 , ui_item_text, ui_background_colour, ui_background_colour, ui_background_colour, ui_background_colour, ui_top);
          }
          draw_set_valign(fa_top);
        }
        else{
          ui_top = 0;
          ds_map_replace(argument[0], "ui_top", ui_top);
        }
      }
      else{
        draw_line_width_colour(ui_x, ui_y + ui_height + (ui_padding_vertical * 2), ui_x + ui_width + (ui_padding_horizontal * 2), ui_y + ui_height + (ui_padding_vertical * 2), 1, ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey));
        draw_triangle_colour(ui_x + ui_width + ui_padding_horizontal - 8, ui_y + (ui_height * 0.5) + ui_padding_vertical, ui_x + ui_width + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical, ui_x + ui_width + ui_padding_horizontal - 4, ui_y + (ui_height * 0.5) + ui_padding_vertical + 4, ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey), false);
        if(font_exists(ui_font)){
          draw_set_font(ui_font);
        }
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text_colour(ui_x + ui_padding_horizontal, ui_y + ui_padding_vertical + (ui_height * 0.5), ui_text, ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey), 1);
        if(font_exists(ui_label_font)){
          draw_set_font(ui_label_font);
        }
        draw_set_valign(fa_top);
        var ui_label_top = (string_height('|') * 0.85 + ui_padding_vertical);
        draw_text_transformed_colour(ui_x + ui_padding_horizontal, ui_y + ui_padding_vertical - ui_label_top, ui_label, max(1 - ui_label_top / ((string_height('|') * 0.85) + ui_padding_vertical), 0.85), max(1 - ui_label_top / (string_height('|') * 0.85), 0.85), 0, ui_grey, ui_grey, ui_grey, ui_grey, 1);
      }
      if(ui_focus){
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "debug_mode") && !ui_open){
            draw_set_alpha(0.25);
            draw_rectangle_colour(ui_x, ui_y, ui_x + ui_width + (ui_padding_horizontal * 2) + 1, ui_y + ui_height + (ui_padding_vertical * 2) + 1, ui_blue_grey, ui_blue_grey, ui_blue_grey, ui_blue_grey, true);
            draw_set_alpha(1);
          }
        }
      }
    }
    else{
      ui_debug_error(102, "ui_select_draw", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_select_draw", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_select_draw", object_get_name(object_index));
  return false;
}




#define ui_range_create
if(argument_count == 4){
  if(ds_exists(ui_global_config, ds_type_map)){
    var ui_foreground_colour = ds_map_find_value(ui_global_config, "default_background_colour");
    var ui_effect = ds_map_find_value(ui_global_config, "enable_effect");
    var ui_effect_speed = max(ds_map_find_value(ui_global_config, "effect_speed") / 40, 0.1);
    var ui_shadow = ds_map_find_value(ui_global_config, "enable_shadow");
  }
  else{
    var ui_foreground_colour = ui_teal;
    var ui_effect = true;
    var ui_effect_speed = 0.2;
    var ui_shadow = true;
  }
  var ui_control = ds_map_create();
  var ui_width = max(argument[2], ui_default);
  var ui_height = max(argument[3], ui_default);
  ds_map_add(ui_control, "ui_type", ui_type_range);
  ds_map_add(ui_control, "ui_x", argument[0]);
  ds_map_add(ui_control, "ui_y", argument[1]);
  ds_map_add(ui_control, "ui_start_x", 0);
  ds_map_add(ui_control, "ui_start_y", 0);
  ds_map_add(ui_control, "ui_width", ui_width);
  ds_map_add(ui_control, "ui_height", ui_height);
  ds_map_add(ui_control, "ui_clicked", false);
  ds_map_add(ui_control, "ui_minval", 0);
  ds_map_add(ui_control, "ui_maxval", 100);
  ds_map_add(ui_control, "ui_value", 0);
  ds_map_add(ui_control, "ui_rangesize", 100);
  ds_map_add(ui_control, "ui_changed", false);
  ds_map_add(ui_control, "ui_background_colour", ui_colour_lighter(ui_grey));
  ds_map_add(ui_control, "ui_inner_colour", ui_white);
  ds_map_add(ui_control, "ui_foreground_colour", ui_foreground_colour);
  ds_map_add(ui_control, "ui_focus", false);
  ds_map_add(ui_control, "ui_enable", true);
  ds_map_add(ui_control, "ui_active", true);
  ds_map_add(ui_control, "ui_label_font", ui_default);
  ds_map_add(ui_control, "ui_padding_horizontal", 0);
  ds_map_add(ui_control, "ui_padding_vertical", 0);
  ds_map_add(ui_control, "ui_top", 0); 
  ds_map_add(ui_control, "ui_effect", ui_effect);
  ds_map_add(ui_control, "ui_effect_speed", ui_effect_speed);
  ds_map_add(ui_control, "ui_shadow", ui_shadow);
  if(ds_exists(ui_global_controls, ds_type_list)){
    ds_list_add(ui_global_controls, ui_control);
  }
  return ui_control;
}
else{
  ui_debug_error(101, "ui_range_create", object_get_name(object_index));
  return false;
}






#define ui_range_set_value
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_value")){
      ds_map_replace(argument[0], "ui_value", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_range_set_value", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_range_set_value", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_range_set_value", object_get_name(object_index));
  return false;
}






#define ui_range_set_max
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_rangesize")){
      ds_map_replace(argument[0], "ui_rangesize", argument[1]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_range_set_max", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_range_set_max", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_range_set_max", object_get_name(object_index));
  return false;
}






#define ui_range_set_limit
if(argument_count == 3){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_minval") && ds_map_exists(argument[0], "ui_maxval")){
      ds_map_replace(argument[0], "ui_minval", argument[1]);
      ds_map_replace(argument[0], "ui_maxval", argument[2]);
      return true;
    }
    else{
      ui_debug_error(103, "ui_range_set_limit", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_range_set_limit", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_range_set_limit", object_get_name(object_index));
  return false;
}






#define ui_range_get_value
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_value")){
      return ds_map_find_value(argument[0], "ui_value");
    }
    else{
      ui_debug_error(103, "ui_range_get_value", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_range_get_value", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_range_get_value", object_get_name(object_index));
  return false;
}






#define ui_range_draw
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    var ui_type = ds_map_find_value(argument[0], "ui_type");
    if(ui_type == ui_type_range){
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_start_x = ds_map_find_value(argument[0], "ui_start_x");
      var ui_start_y = ds_map_find_value(argument[0], "ui_start_y");
      var ui_width = ds_map_find_value(argument[0], "ui_width");
      var ui_height = ds_map_find_value(argument[0], "ui_height");
      var ui_clicked = ds_map_find_value(argument[0], "ui_clicked");
      var ui_rangesize = ds_map_find_value(argument[0], "ui_rangesize");
      var ui_minval = max(0, ds_map_find_value(argument[0], "ui_minval"));
      var ui_maxval = min(ui_rangesize, ds_map_find_value(argument[0], "ui_maxval"));
      var ui_value = clamp(ds_map_find_value(argument[0], "ui_value"), max(0, ui_minval), min(ui_rangesize,  ui_maxval));
      var ui_changed = ds_map_find_value(argument[0], "ui_changed");
      var ui_background_colour = ds_map_find_value(argument[0], "ui_background_colour");
      var ui_inner_colour = ds_map_find_value(argument[0], "ui_inner_colour");
      var ui_foreground_colour = ds_map_find_value(argument[0], "ui_foreground_colour");
      var ui_focus = ds_map_find_value(argument[0], "ui_focus");
      var ui_enable = ds_map_find_value(argument[0], "ui_enable");
      var ui_active = ds_map_find_value(argument[0], "ui_active");
      var ui_label_font = ds_map_find_value(argument[0], "ui_label_font");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");;
      var ui_padding_vertical = ds_map_find_value(argument[0], "ui_padding_vertical");
      var ui_top = ds_map_find_value(argument[0], "ui_top"); 
      var ui_effect = ds_map_find_value(argument[0], "ui_effect");
      var ui_effect_speed = ds_map_find_value(argument[0], "ui_effect_speed");
      var ui_shadow = ds_map_find_value(argument[0], "ui_shadow");
      if(ui_width == ui_default) ui_width = 320;
      if(ui_height == ui_default) ui_height = 16;
      if(font_exists(ui_label_font)) draw_set_font(ui_label_font);
      if(ui_enable){
        var ui_alpha = 0.015;
        var ui_mouse_x = device_mouse_x(0) - ui_start_x;
        var ui_mouse_y = device_mouse_y(0) - ui_start_y;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "draw_on_gui")){
            ui_mouse_x = device_mouse_x_to_gui(0) - ui_start_x;
            ui_mouse_y = device_mouse_y_to_gui(0) - ui_start_y;
          }
        }
        var keyboard_action = true;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(!ds_map_find_value(ui_global_config, "keyboard_action")) keyboard_action = false;
        }
        if(ui_active && ((ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_width + (ui_padding_horizontal * 2) && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_height + (ui_padding_vertical * 2)) or (ui_focus && keyboard_action && keyboard_check_pressed(vk_enter)))){
          ui_alpha = 0.02;
          if(device_mouse_check_button_pressed(0, mb_left)){
          ui_focus = true;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
            ui_clicked = true;
            ds_map_replace(argument[0], "ui_clicked", ui_clicked);
          }
        }
        else{
          if(device_mouse_check_button_pressed(0, mb_left)){
            ui_focus = false;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
          }
        }
        if(device_mouse_check_button(0, mb_left) && ui_clicked){
          ui_value = clamp(round((ui_mouse_x - (ui_x + ui_padding_horizontal)) / ui_width * ui_rangesize), max(ui_minval, 0), min(ui_maxval, ui_rangesize));
          ds_map_replace(argument[0], "ui_value", ui_value);
        }
        if(device_mouse_check_button_released(0, mb_left) && ui_clicked){
          ui_clicked = false;
          ds_map_replace(argument[0], "ui_clicked", ui_clicked);
        }
        if(ui_shadow){
          draw_set_alpha(ui_alpha);
          draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical, ui_x + ui_width - ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical + 1, 3, ui_black, ui_black);
          draw_set_alpha(1);
        }
        draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical, ui_x + ui_width + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical, 3, ui_background_colour, ui_background_colour);
        
        if(ui_minval > 0){
          draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical, ui_x + (ui_minval / ui_rangesize * ui_width) + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical, 3, ui_colour_lighter(ui_red), ui_colour_lighter(ui_red));
        }
        if(ui_maxval < ui_rangesize){
          draw_line_width_colour(ui_x + ui_padding_horizontal + (ui_maxval / ui_rangesize * ui_width), ui_y + (ui_height * 0.5) + ui_padding_vertical, ui_x + ui_width + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical, 3, ui_colour_lighter(ui_red), ui_colour_lighter(ui_red));
        }
        
        draw_circle_colour(ui_x + ui_padding_horizontal + (ui_height * 0.5) + ((ui_width - (ui_height))*(ui_value / ui_rangesize)), ui_y + ui_padding_vertical + (ui_height * 0.5), (ui_height * 0.5), ui_foreground_colour, ui_foreground_colour, false);
        if(ui_clicked){
          if(ui_effect){
            if(ui_top < 1){
              ui_top += ui_effect_speed;
              ui_top = min(ui_top, 1);
              ds_map_replace(argument[0], "ui_top", ui_top);
            }
          }
          else{
            ui_top= 1;
            ds_map_replace(argument[0], "ui_top", ui_top);
          }
        }
        else{
          if(ui_effect){
            if(ui_top > 0){
              ui_top -= ui_effect_speed;
              ui_top = max(ui_top, 0);
              ds_map_replace(argument[0], "ui_top", ui_top);
            }
          }
          else{
            ui_top = 0;
            ds_map_replace(argument[0], "ui_top", ui_top);
          }
        }
        if(ui_clicked or ui_top > 0){
          draw_set_alpha(ui_top);
          draw_circle_colour(ui_x + ui_padding_horizontal + (ui_height * 0.5) - 1 + ((ui_width - (ui_height))*(ui_value / ui_rangesize)), ui_y + (ui_padding_vertical + (ui_height * 0.5) - (ui_height * 0.45) - 20) * ui_top, ((string_width(string(ui_rangesize)) * 0.5) + 4) * ui_top, ui_foreground_colour, ui_foreground_colour, false);
          if(ui_top > 0.9){
            var tx1 = ui_x + ui_padding_horizontal + (ui_height * 0.5) + ((ui_width - (ui_height))*(ui_value / ui_rangesize)) - (string_width(string(ui_rangesize)) * 0.5);
            var ty1 = ui_y + ui_padding_vertical + (((ui_height * 0.5) - (ui_height * 0.45) - (string_width(string(ui_rangesize)) * 0.5))*ui_top);
            var tx2 = ui_x + ui_padding_horizontal + (ui_height * 0.5) + ((ui_width - (ui_height))*(ui_value / ui_rangesize)) + (string_width(string(ui_rangesize)) * 0.5);
            var ty2 = ui_y + ui_padding_vertical + (((ui_height * 0.5) - (ui_height * 0.45) - (string_width(string(ui_rangesize)) * 0.5))*ui_top);
            var tx3 = ui_x + ui_padding_horizontal + (ui_height * 0.5) + ((ui_width - (ui_height))*(ui_value / ui_rangesize));
            var ty3 = ui_y + ui_padding_vertical + 2;
            draw_triangle_colour(tx1, ty1, tx2, ty2, tx3, ty3, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, false);
          }
          draw_set_alpha(1);
          draw_set_halign(fa_center);
          draw_set_halign(fa_middle);
          if(ui_shadow) draw_text_transformed_colour(ui_x + ui_padding_horizontal + (ui_height * 0.5) + ((ui_width - (ui_height))*(ui_value / ui_rangesize)), ui_y + ui_padding_vertical + (ui_height * 0.5) - (ui_height * 0.45) - 28, string(ui_value), ui_top, ui_top, 0, ui_inner_colour, ui_inner_colour, ui_inner_colour, ui_inner_colour, ui_top);
          draw_text_transformed_colour(ui_x + ui_padding_horizontal + (ui_height * 0.5) + ((ui_width - (ui_height))*(ui_value / ui_rangesize)), ui_y + ui_padding_vertical + (ui_height * 0.5) - (ui_height * 0.45) - 28, string(ui_value), ui_top, ui_top, 0, ui_inner_colour, ui_inner_colour, ui_inner_colour, ui_inner_colour, ui_top);
          draw_set_halign(fa_left);
          draw_set_halign(fa_top);
        }
      }
      else{
        draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical, ui_x + ui_width + ui_padding_horizontal, ui_y + (ui_height * 0.5) + ui_padding_vertical, 3, ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey));
        draw_circle_colour(ui_x + ui_padding_horizontal + (ui_height * 0.5) + ((ui_width - (ui_height))*(ui_value / ui_rangesize)), ui_y + ui_padding_vertical + (ui_height * 0.5), (ui_height * 0.5), ui_grey, ui_grey, false);
      }
      if(ui_focus){
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "debug_mode")){
            draw_set_alpha(0.25);
            draw_rectangle_colour(ui_x, ui_y, ui_x + ui_width + (ui_padding_horizontal * 2) + 1, ui_y + ui_height + (ui_padding_vertical * 2) + 1, ui_blue_grey, ui_blue_grey, ui_blue_grey, ui_blue_grey, true);
            draw_set_alpha(1);
          }
        }
      }
    }
    else{
      ui_debug_error(102, "ui_range_draw", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_range_draw", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_range_draw", object_get_name(object_index));
  return false;
}






#define ui_tab_create
if(argument_count == 5){
  if(ds_exists(ui_global_config, ds_type_map)){
    var ui_foreground_colour = ds_map_find_value(ui_global_config, "default_background_colour");
    var ui_background_colour = ds_map_find_value(ui_global_config, "default_foreground_colour");
    var ui_font = ds_map_find_value(ui_global_config, "default_text_font");
    var ui_effect = ds_map_find_value(ui_global_config, "enable_effect");
    var ui_effect_speed = max(ds_map_find_value(ui_global_config, "effect_speed") / 40, 0.1);
    var ui_shadow = ds_map_find_value(ui_global_config, "enable_shadow");
  }
  else{
    var ui_foreground_colour = ui_teal;
    var ui_background_colour = ui_white;
    var ui_font = ui_default;
    var ui_effect = true;
    var ui_effect_speed = 0.2;
    var ui_shadow = true;
  }
  var ui_control = ds_map_create();
  ds_map_add(ui_control, "ui_type", ui_type_tab);
  ds_map_add(ui_control, "ui_x", argument[0]);
  ds_map_add(ui_control, "ui_y", argument[1]);
  ds_map_add(ui_control, "ui_start_x", 0);
  ds_map_add(ui_control, "ui_start_y", 0);
  ds_map_add(ui_control, "ui_width", argument[2]);
  ds_map_add(ui_control, "ui_height", argument[3]);
  ds_map_add(ui_control, "ui_content_height", argument[4]);
  ds_map_add(ui_control, "ui_clicked", false);
  ds_map_add(ui_control, "ui_items", ds_list_create());
  ds_map_add(ui_control, "ui_selected", 0);
  ds_map_add(ui_control, "ui_background_colour", ui_background_colour);
  ds_map_add(ui_control, "ui_foreground_colour", ui_foreground_colour);
  ds_map_add(ui_control, "ui_focus", false);
  ds_map_add(ui_control, "ui_enable", true);
  ds_map_add(ui_control, "ui_active", true);
  ds_map_add(ui_control, "ui_font", ui_font);
  ds_map_add(ui_control, "ui_wave", false);
  ds_map_add(ui_control, "ui_wave_size", 1);
  ds_map_add(ui_control, "ui_padding_horizontal", 0);
  ds_map_add(ui_control, "ui_padding_vertical", 0); 
  ds_map_add(ui_control, "ui_effect", ui_effect);
  ds_map_add(ui_control, "ui_effect_speed", ui_effect_speed);
  ds_map_add(ui_control, "ui_shadow", ui_shadow);
  if(ds_exists(ui_global_controls, ds_type_list)){
    ds_list_add(ui_global_controls, ui_control);
  }
  return ui_control;
}
else{
  ui_debug_error(101, "ui_tab_create", object_get_name(object_index));
  return false;
}






#define ui_tab_get_surface
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_items")){
      var ui_items = ds_map_find_value(argument[0], "ui_items");
      if(ds_exists(ui_items, ds_type_list)){
        var ui_item_selected = ds_list_find_value(ui_items, argument[1]);
        ui_surface = ds_map_find_value(ui_item_selected, "ui_tab_surface");
        if(surface_exists(ui_surface)) return ui_surface;
        else{
          var ui_height = ds_map_find_value(argument[0], "ui_height");
          var ui_width = ds_map_find_value(argument[0], "ui_width");
          var ui_font = ds_map_find_value(argument[0], "ui_font");
          var ui_content_height = ds_map_find_value(argument[0], "ui_content_height");
          if(ui_width == ui_default) ui_width = 480;
          if(ui_height == ui_default) ui_height = string_height('|') + 16;
          if(ui_content_height == ui_default) ui_content_height = 320;
          var ui_surface = surface_create(ui_width, ui_content_height - ui_height);
          ds_map_replace(ui_item_selected, "ui_tab_surface", ui_surface);
          return ui_surface;
        }
      }
    }
    else{
      ui_debug_error(103, "ui_tab_get_surface", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_tab_get_surface", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_tab_get_surface", object_get_name(object_index));
  return false;
}






#define ui_tab_apply
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map) && ds_exists(argument[1], ds_type_map)){
    var ui_x = ds_map_find_value(argument[0], "ui_x");
    var ui_y = ds_map_find_value(argument[0], "ui_y");
    if(ui_x == undefined or ui_y == undefined){
      ui_debug_error(103, "ui_tab_apply", object_get_name(object_index));
      return false;
    }
    else{
      if(ds_map_exists(argument[1], "ui_start_x") && ds_map_exists(argument[1], "ui_start_y")){
        ds_map_replace(argument[1], "ui_start_x", ui_x);
        ds_map_replace(argument[1], "ui_start_y", ui_y);
        
        return true;
      }
      else{
        ui_debug_error(103, "ui_tab_apply", object_get_name(object_index));
        return false;
      }
    }
  }
  else{
    ui_debug_error(102, "ui_tab_apply", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_tab_apply", object_get_name(object_index));
  return false;
}






#define ui_tab_draw
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    var ui_type = ds_map_find_value(argument[0], "ui_type");
    if(ui_type == ui_type_tab){
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_start_x = ds_map_find_value(argument[0], "ui_start_x");
      var ui_start_y = ds_map_find_value(argument[0], "ui_start_y");
      var ui_width = ds_map_find_value(argument[0], "ui_width");
      var ui_height = ds_map_find_value(argument[0], "ui_height");
      var ui_content_height = ds_map_find_value(argument[0], "ui_content_height");
      var ui_clicked = ds_map_find_value(argument[0], "ui_clicked");
      var ui_items = ds_map_find_value(argument[0], "ui_items");
      var ui_selected = ds_map_find_value(argument[0], "ui_selected");
      var ui_surface = ui_default;
      var ui_text = "Default";
      if(ds_exists(ui_items, ds_type_list)){
        if(ds_list_size(ui_items) > 0){
          if(ds_list_find_value(ui_items, ui_selected) != undefined){ui_text = ds_list_find_value(ui_items, ui_selected);}
          var ui_item_selected = ds_list_find_value(ui_items, ui_selected);
          ui_surface = ds_map_find_value(ui_item_selected, "ui_tab_surface");
        }
      }
      var ui_background_colour = ds_map_find_value(argument[0], "ui_background_colour");
      var ui_foreground_colour = ds_map_find_value(argument[0], "ui_foreground_colour");
      var ui_enable = ds_map_find_value(argument[0], "ui_enable");
      var ui_active = ds_map_find_value(argument[0], "ui_active");
      var ui_focus = ds_map_find_value(argument[0], "ui_focus");
      var ui_font = ds_map_find_value(argument[0], "ui_font");
      var ui_wave = ds_map_find_value(argument[0], "ui_wave");
      var ui_wave_size = ds_map_find_value(argument[0], "ui_wave_size");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
      var ui_padding_vertical = ds_map_find_value(argument[0], "ui_padding_vertical");
      var ui_effect = ds_map_find_value(argument[0], "ui_effect");
      var ui_effect_speed = ds_map_find_value(argument[0], "ui_effect_speed");
      var ui_shadow = ds_map_find_value(argument[0], "ui_shadow");    
      if(font_exists(ui_font)) draw_set_font(ui_font);
      var ui_item_width = (ui_width + (ui_padding_horizontal * 2)) / ds_list_size(ui_items);
      if(ui_width == ui_default) ui_width = 480;
      if(ui_height == ui_default) ui_height = string_height('|') + 16;
      if(ui_content_height == ui_default) ui_content_height = 320;
      if(ui_enable){
        var ui_btn_control_colour = ui_background_colour;
        var ui_mouse_x = device_mouse_x(0) - ui_start_x;
        var ui_mouse_y = device_mouse_y(0) - ui_start_y;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "draw_on_gui")){
            ui_mouse_x = device_mouse_x_to_gui(0) - ui_start_x;
            ui_mouse_y = device_mouse_y_to_gui(0) - ui_start_y;
          }
        }
        if(ui_active && ((ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_width + (ui_padding_horizontal * 2) && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_height))){        
          if(device_mouse_check_button_pressed(0, mb_left)){
            ui_selected = (ui_mouse_x - ui_x) div ui_item_width;
            ds_map_replace(argument[0], "ui_selected", ui_selected);
            ui_wave = true;
            ds_map_replace(argument[0], "ui_wave", ui_wave);
            ui_wave_size = 0;
            ds_map_replace(argument[0], "ui_wave_size", ui_wave_size);
            ui_focus = true;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
          }
        }
        else{
          if(device_mouse_check_button_pressed(0, mb_left)){
            ui_focus = false;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
          }
        }
        if(surface_exists(ui_surface)){
          if(ui_shadow){
            draw_set_alpha(0.05);
            draw_rectangle_colour(ui_x, ui_y + ui_height + 2, ui_x + ui_width + (ui_padding_horizontal * 2) + 2, ui_y + ui_height + ui_content_height + (ui_padding_vertical * 2) + 2, ui_black, ui_black, ui_black, ui_black, true);
            draw_rectangle_colour(ui_x + 1, ui_y + ui_height - 1, ui_x + ui_width + (ui_padding_horizontal * 2) + 1, ui_y + ui_height + ui_content_height + (ui_padding_vertical * 2) + 1, ui_black, ui_black, ui_black, ui_black, true);
            draw_set_alpha(1);
          }
          draw_surface(ui_surface, ui_x + 1 + ui_padding_horizontal, ui_y + ui_height + ui_padding_vertical)
        }
        if(ui_shadow){
          draw_set_alpha(0.015);
          draw_roundrect_colour_ext(ui_x - 4, ui_y - 4, ui_x + ui_width + (ui_padding_horizontal * 2) + 4, ui_y + ui_height + 4, 4, 4, ui_black, ui_black, false);
          draw_roundrect_colour_ext(ui_x - 3, ui_y - 3, ui_x + ui_width + (ui_padding_horizontal * 2) + 3, ui_y + ui_height + 3, 4, 4, ui_black, ui_black, false);
          draw_roundrect_colour_ext(ui_x - 2, ui_y - 2, ui_x + ui_width + (ui_padding_horizontal * 2) + 2, ui_y + ui_height + 2, 4, 4, ui_black, ui_black, false);
          draw_roundrect_colour_ext(ui_x - 1, ui_y - 1, ui_x + ui_width + (ui_padding_horizontal * 2) + 1, ui_y + ui_height + 2, 4, 4, ui_black, ui_black, false);
          draw_roundrect_colour_ext(ui_x - 1, ui_y - 1, ui_x + ui_width + (ui_padding_horizontal * 2) + 1, ui_y + ui_height + 1, 4, 4, ui_black, ui_black, false);
          draw_set_alpha(0.2);
          draw_line_width_colour(ui_x, ui_y + ui_height + 2, ui_x + ui_width + (ui_padding_horizontal * 2), ui_y + ui_height + 2, 1, ui_black, ui_black);
          draw_line_width_colour(ui_x, ui_y + ui_height + 1, ui_x + ui_width + (ui_padding_horizontal * 2), ui_y + ui_height + 1, 1, ui_black, ui_black);
          draw_set_alpha(1);
        }
        draw_roundrect_colour_ext(ui_x, ui_y, ui_x + ui_width + (ui_padding_horizontal * 2), ui_y + ui_height, 4, 4, ui_background_colour, ui_background_colour, false);
        if(ui_wave){
          if(ui_effect){
            if(ui_wave_size < 1){
              ui_wave_size += ui_effect_speed;
              ui_wave_size = min(ui_wave_size, 1);
              ui_wave_size = min(ui_wave_size, 1);
              ds_map_replace(argument[0], "ui_wave_size", ui_wave_size);
            }
            else{
              ui_wave = false;
              ds_map_replace(argument[0], "ui_wave", ui_wave);
            }
          }
          else{
            ui_wave_size = 1;
            ds_map_replace(argument[0], "ui_wave_size", ui_wave_size);
            ui_wave = false;
            ds_map_replace(argument[0], "ui_wave", ui_wave);
          }
        }
        draw_set_alpha(ui_wave_size);
        draw_line_width_colour(ui_x + (ui_selected * ui_item_width), ui_y + ui_height-1, ui_x + (ui_selected * ui_item_width) + (ui_item_width*ui_wave_size), ui_y + ui_height-1, 2, ui_foreground_colour, ui_foreground_colour);
        draw_set_alpha(1);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        for(var ui_i = 0; ui_i < ds_list_size(ui_items); ui_i += 1){
          var ui_tab_item =  ds_list_find_value(ui_items, ui_i);
          if(ui_shadow) draw_text_colour(ui_x + (ui_item_width * ui_i) + (ui_item_width * 0.5), ui_y + (ui_height * 0.5) + 1, ds_map_find_value(ui_tab_item, "ui_tab_name"), ui_black, ui_black, ui_black, ui_black, 0.05);
          draw_text_colour(ui_x + (ui_item_width * ui_i) + (ui_item_width * 0.5), ui_y + (ui_height * 0.5), ds_map_find_value(ui_tab_item, "ui_tab_name"), ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1); 
        }
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
      }
      else{
        if(surface_exists(ui_surface)){
          if(ui_shadow){
            draw_set_alpha(0.05);
            draw_rectangle_colour(ui_x, ui_y + ui_height + 2, ui_x + ui_width + (ui_padding_horizontal * 2) + 2, ui_y + ui_height + ui_content_height + (ui_padding_vertical * 2) + 2, ui_black, ui_black, ui_black, ui_black, true);
            draw_rectangle_colour(ui_x + 1, ui_y + ui_height + 1, ui_x + ui_width + (ui_padding_horizontal * 2) + 1, ui_y + ui_height + ui_content_height + (ui_padding_vertical * 2) + 1, ui_black, ui_black, ui_black, ui_black, true);
            draw_set_alpha(1);
          }
          draw_surface(ui_surface, ui_x + 1 + ui_padding_horizontal, ui_y + ui_height + ui_padding_vertical);
        }
        if(ui_shadow){
          draw_set_alpha(0.015);
          draw_roundrect_colour_ext(ui_x - 4, ui_y - 4, ui_x + ui_width + (ui_padding_horizontal * 2) + 4, ui_y + ui_height + 4, 4, 4, ui_black, ui_black, false);
          draw_roundrect_colour_ext(ui_x - 3, ui_y - 3, ui_x + ui_width + (ui_padding_horizontal * 2) + 3, ui_y + ui_height + 3, 4, 4, ui_black, ui_black, false);
          draw_roundrect_colour_ext(ui_x - 2, ui_y - 2, ui_x + ui_width + (ui_padding_horizontal * 2) + 2, ui_y + ui_height + 2, 4, 4, ui_black, ui_black, false);
          draw_roundrect_colour_ext(ui_x - 1, ui_y - 1, ui_x + ui_width + (ui_padding_horizontal * 2) + 1, ui_y + ui_height + 2, 4, 4, ui_black, ui_black, false);
          draw_roundrect_colour_ext(ui_x - 1, ui_y - 1, ui_x + ui_width + (ui_padding_horizontal * 2) + 1, ui_y + ui_height + 1, 4, 4, ui_black, ui_black, false);
          draw_set_alpha(0.2);
          draw_line_width_colour(ui_x, ui_y + ui_height + 2, ui_x + ui_width + (ui_padding_horizontal * 2), ui_y + ui_height + 2, 1, ui_black, ui_black);
          draw_line_width_colour(ui_x, ui_y + ui_height + 1, ui_x + ui_width + (ui_padding_horizontal * 2), ui_y + ui_height + 1, 1, ui_black, ui_black);
          draw_set_alpha(1);
        }
        draw_roundrect_colour_ext(ui_x, ui_y, ui_x + ui_width + (ui_padding_horizontal * 2), ui_y + ui_height, 4, 4, ui_colour_lighter(ui_grey), ui_colour_lighter(ui_grey), false);
        draw_line_width_colour(ui_x + (ui_selected * ui_item_width), ui_y + ui_height - 1, ui_x + (ui_selected * ui_item_width) + (ui_item_width * ui_wave_size), ui_y + ui_height-1, 2, ui_grey, ui_grey);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        for(var ui_i = 0; ui_i < ds_list_size(ui_items); ui_i += 1){
          var ui_tab_item =  ds_list_find_value(ui_items, ui_i);
          draw_text_colour(ui_x + (ui_item_width * ui_i) + (ui_item_width * 0.5), ui_y + (ui_height * 0.5), ds_map_find_value(ui_tab_item, "ui_tab_name"), ui_grey, ui_grey, ui_grey, ui_grey, 1); 
        }
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
      }
      if(ui_focus){
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "debug_mode")){
            draw_set_alpha(0.25);
            draw_rectangle_colour(ui_x - 1, ui_y - 1, ui_x + ui_width + (ui_padding_horizontal * 2) + 2, ui_y + ui_height + ui_content_height + (ui_padding_vertical * 2) + 2, ui_blue_grey, ui_blue_grey, ui_blue_grey, ui_blue_grey, true);
            draw_set_alpha(1);
          }
        }
      }
    }
    else{
      ui_debug_error(102, "ui_tab_draw", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_tab_draw", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_tab_draw", object_get_name(object_index));
  return false;
}






#define ui_sidenav_create
if(argument_count == 4){
  if(ds_exists(ui_global_config, ds_type_map)){
    var ui_foreground_colour = ds_map_find_value(ui_global_config, "default_foreground_colour");
    var ui_background_colour = ds_map_find_value(ui_global_config, "default_background_colour");
    var ui_effect = ds_map_find_value(ui_global_config, "enable_effect");
    var ui_effect_speed = max(ds_map_find_value(ui_global_config, "effect_speed") / 20, 0.1);
    var ui_shadow = ds_map_find_value(ui_global_config, "enable_shadow");
  }
  else{
    var ui_foreground_colour = ui_white;
    var ui_background_colour = ui_white;
    var ui_effect = true;
    var ui_effect_speed = 0.4;
    var ui_shadow = true;
  }
  var ui_control = ds_map_create();
  var ui_content_width = argument[3];
  if(argument[3] == ui_default){ui_content_width = 256;}
  var ui_content_height = room_height;
  if(ds_exists(ui_global_config, ds_type_map)){
    if(ds_map_find_value(ui_global_config, "draw_on_gui")){ui_content_height = display_get_gui_height();}
  }
  ds_map_add(ui_control, "ui_type", ui_type_sidenav);
  ds_map_add(ui_control, "ui_x", argument[0]);
  ds_map_add(ui_control, "ui_y", argument[1]);
  ds_map_add(ui_control, "ui_start_x", 0);
  ds_map_add(ui_control, "ui_start_y", 0);
  ds_map_add(ui_control, "ui_size", argument[2]);
  ds_map_add(ui_control, "ui_content_width", ui_content_width);
  ds_map_add(ui_control, "ui_content_height", ui_content_height);
  ds_map_add(ui_control, "ui_clicked", false);
  ds_map_add(ui_control, "ui_open", false);
  ds_map_add(ui_control, "ui_controls", ds_list_create());
  ds_map_add(ui_control, "ui_surface", surface_create(ui_content_width, ui_content_height));
  ds_map_add(ui_control, "ui_foreground_colour", ui_white);
  ds_map_add(ui_control, "ui_background_colour", ui_background_colour);
  ds_map_add(ui_control, "ui_focus", false);
  ds_map_add(ui_control, "ui_enable", true);
  ds_map_add(ui_control, "ui_active", true);
  ds_map_add(ui_control, "ui_left", 0);
  ds_map_add(ui_control, "ui_padding_horizontal", 0);
  ds_map_add(ui_control, "ui_padding_vertical", 0); 
  ds_map_add(ui_control, "ui_effect", ui_effect);
  ds_map_add(ui_control, "ui_effect_speed", ui_effect_speed);
  ds_map_add(ui_control, "ui_shadow", ui_shadow);
  if(ds_exists(ui_global_controls, ds_type_list)){
    ds_list_add(ui_global_controls, ui_control);
  }
  return ui_control;
}
else{
  ui_debug_error(101, "ui_sidenav_create", object_get_name(object_index));
  return false;
}

#define ui_sidenav_apply
if(argument_count == 2){
  if(ds_exists(argument[0], ds_type_map) && ds_exists(argument[1], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_controls")){
      if(ds_exists(ds_map_exists(argument[0], "ui_controls"), ds_type_list)){
        ds_list_add(ds_map_exists(argument[0], "ui_controls"), argument[1]);
        return true;
      }
    }
    else{
      ui_debug_error(103, "ui_sidenav_apply", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_sidenav_apply", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_sidenav_apply", object_get_name(object_index));
  return false;
}






#define ui_sidenav_get_surface
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){
    if(ds_map_exists(argument[0], "ui_surface")){
      if(surface_exists(ds_map_find_value(argument[0], "ui_surface"))){return ds_map_find_value(argument[0], "ui_surface");}
      else{
        var ui_content_width = ds_map_find_value(argument[0], "ui_content_width");
        var ui_content_height = ds_map_find_value(argument[0], "ui_content_height");
        ds_map_replace(argument[0], "ui_surface", surface_create(ui_content_width, ui_content_height));
        return ds_map_find_value(argument[0], "ui_surface");
      }
    }
    else{
      ui_debug_error(103, "ui_sidenav_get_surface", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_sidenav_get_surface", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_sidenav_get_surface", object_get_name(object_index));
  return false;
}

#define ui_sidenav_draw
if(argument_count == 1){
  if(ds_exists(argument[0], ds_type_map)){    
    var ui_type = ds_map_find_value(argument[0], "ui_type");
    if(ui_type == ui_type_sidenav){
      var ui_x = ds_map_find_value(argument[0], "ui_x");
      var ui_y = ds_map_find_value(argument[0], "ui_y");
      var ui_start_x = ds_map_find_value(argument[0], "ui_start_x");
      var ui_start_y = ds_map_find_value(argument[0], "ui_start_y");
      var ui_size = ds_map_find_value(argument[0], "ui_size");
      var ui_content_width = ds_map_find_value(argument[0], "ui_content_width");
      var ui_content_height = ds_map_find_value(argument[0], "ui_content_height");
      var ui_clicked = ds_map_find_value(argument[0], "ui_clicked");
      var ui_open = ds_map_find_value(argument[0], "ui_open");
      var ui_controls = ds_map_find_value(argument[0], "ui_controls");
      var ui_surface = ds_map_find_value(argument[0], "ui_surface");
      var ui_background_colour = ds_map_find_value(argument[0], "ui_background_colour");
      var ui_foreground_colour = ds_map_find_value(argument[0], "ui_foreground_colour");
      var ui_focus = ds_map_find_value(argument[0], "ui_focus");
      var ui_enable = ds_map_find_value(argument[0], "ui_enable");
      var ui_active = ds_map_find_value(argument[0], "ui_active");
      var ui_left = ds_map_find_value(argument[0], "ui_left");
      var ui_padding_horizontal = ds_map_find_value(argument[0], "ui_padding_horizontal");
      var ui_padding_vertical = ds_map_find_value(argument[0], "ui_padding_vertical"); 
      var ui_effect = ds_map_find_value(argument[0], "ui_effect");
      var ui_effect_speed = ds_map_find_value(argument[0], "ui_effect_speed");
      var ui_shadow = ds_map_find_value(argument[0], "ui_shadow");
      if(ui_size == ui_default) ui_size = 24;
      if(ui_enable){
        var ui_mouse_x = device_mouse_x(0) - ui_start_x;
        var ui_mouse_y = device_mouse_y(0) - ui_start_y;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "draw_on_gui")){
            ui_mouse_x = device_mouse_x_to_gui(0) - ui_start_x;
            ui_mouse_y = device_mouse_y_to_gui(0) - ui_start_y;
          }
        }
        var keyboard_action = true;
        if(ds_exists(ui_global_config, ds_type_map)){
          if(!ds_map_find_value(ui_global_config, "keyboard_action")) keyboard_action = false;
        }
        if(ui_active && ((ui_mouse_x > ui_x && ui_mouse_x < ui_x + ui_size + (ui_padding_horizontal * 2) && ui_mouse_y > ui_y && ui_mouse_y < ui_y + ui_size + (ui_padding_vertical * 2)) or (ui_focus && keyboard_action && keyboard_check_pressed(vk_enter)))){
          if(device_mouse_check_button_pressed(0, mb_left)){
            ui_focus = true;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
            ui_open = true;
            ds_map_replace(argument[0], "ui_open", ui_open);
            for(var ui_i = 0; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
              var control = ds_list_find_value(ui_global_controls, ui_i);
              if(ds_exists(control, ds_type_map)){
                if(control != argument[0] && ds_list_find_index(ui_controls, control) == -1){ds_map_replace(control, "ui_active", false);}
              }
            }
            if(ds_exists(ui_keyboard, ds_type_map)){
              ds_map_replace(ui_keyboard, "ui_active", false);
            }
          }
        }
        else{
          if(device_mouse_check_button_pressed(0, mb_left)){
            ui_focus = false;
            ds_map_replace(argument[0], "ui_focus", ui_focus);
          }
        }
        if(ui_active && (!(ui_mouse_x > 0 && ui_mouse_x < ui_content_width && ui_mouse_y > 0 && ui_mouse_y < ui_content_height))){
          if(device_mouse_check_button_pressed(0, mb_left)){
            ui_open = false;
            ds_map_replace(argument[0], "ui_open", ui_open);
            for(var ui_i = 0; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
              var control = ds_list_find_value(ui_global_controls, ui_i);
              if(ds_exists(control, ds_type_map)){
                if(control != argument[0]){ds_map_replace(control, "ui_active", true);}
              }
            }
            if(ds_exists(ui_keyboard, ds_type_map)){
              ds_map_replace(ui_keyboard, "ui_active", true);
            }
          }
        }
        if(ui_shadow){
          draw_set_alpha(0.05);
          draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + (ui_size / 8) + ui_padding_vertical + 1, ui_x + ui_size + ui_padding_horizontal, ui_y + (ui_size / 8) + ui_padding_vertical, (ui_size / 8) + 1, ui_black, ui_black);
          draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + (ui_size * 0.5) + ui_padding_vertical + 1, ui_x + ui_size + ui_padding_horizontal, ui_y + (ui_size * 0.5) + ui_padding_vertical, (ui_size / 8) + 1, ui_black, ui_black);
          draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y - (ui_size / 8) +  ui_size + ui_padding_vertical + 1, ui_x + ui_size + ui_padding_horizontal, ui_y - (ui_size / 8) + ui_size + ui_padding_vertical, (ui_size / 8) + 1, ui_black, ui_black);
          draw_set_alpha(1);
        }
        draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + (ui_size / 8) + ui_padding_vertical, ui_x + ui_size + ui_padding_horizontal, ui_y + (ui_size / 8) + ui_padding_vertical, (ui_size / 8), ui_foreground_colour, ui_foreground_colour);
        draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + (ui_size * 0.5) + ui_padding_vertical, ui_x + ui_size + ui_padding_horizontal, ui_y + (ui_size * 0.5) + ui_padding_vertical, (ui_size / 8), ui_foreground_colour, ui_foreground_colour);
        draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y - (ui_size / 8) +  ui_size + ui_padding_vertical, ui_x + ui_size + ui_padding_horizontal, ui_y - (ui_size / 8) + ui_size + ui_padding_vertical, (ui_size / 8), ui_foreground_colour, ui_foreground_colour);
        if(ui_open){
          if(ui_effect){
            if(ui_left < 1){
              ui_left += ui_effect_speed;
              ui_left = min(ui_left, 1);
              ds_map_replace(argument[0], "ui_left", ui_left);
            }
          }
          else{
            ui_left = 1;
            ds_map_replace(argument[0], "ui_left", ui_left);
          }
        }
        else{
          if(ui_effect){
            if(ui_left > 0){
              ui_left -= ui_effect_speed;
              ui_left =  max(ui_left, 0);
              ds_map_replace(argument[0], "ui_left", ui_left);
            }
          }
          else{
            ui_left = 0;
            ds_map_replace(argument[0], "ui_left", ui_left);
          }
        }
        if(ui_open or ui_left > 0){
          if(surface_exists(ui_surface)){
            if(ui_shadow){
              if(ds_exists(ui_global_config, ds_type_map)){
                if(ds_map_find_value(ui_global_config, "draw_on_gui")){
                  draw_set_alpha(0.25);
                  draw_rectangle_colour(0, 0, display_get_gui_width(), display_get_gui_height(), ui_black, ui_black, ui_black, ui_black, false);
                }
              }
              draw_set_alpha(0.05);
              draw_line_width_colour(min((ui_content_width * ui_left) - ui_content_width, 0) + ui_content_width + 1, 0, min((ui_content_width * ui_left) - ui_content_width, 0) + ui_content_width + 1, ui_content_height, 2, ui_black, ui_black);
              draw_line_colour(min((ui_content_width * ui_left) - ui_content_width, 0) + ui_content_width, 0, min((ui_content_width * ui_left) - ui_content_width, 0) + ui_content_width, ui_content_height, ui_black, ui_black);
              draw_set_alpha(1);
            }
            if(ui_background_colour != -1){
              draw_rectangle_colour(min((ui_content_width * ui_left) - ui_content_width, 0), 0, min((ui_content_width * ui_left) - ui_content_width, 0) + ui_content_width - 2, ui_content_height, ui_background_colour, ui_background_colour, ui_background_colour, ui_background_colour, false);
            }
            draw_surface(ui_surface, min((ui_content_width * ui_left) - ui_content_width, 0), 0);
          }
        }
      }
      else{
        draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + (ui_size / 8) + ui_padding_vertical, ui_x + ui_size + ui_padding_horizontal, ui_y + (ui_size / 8) + ui_padding_vertical, ui_size / 8, ui_grey, ui_grey);
        draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y + (ui_size * 0.5) + ui_padding_vertical, ui_x + ui_size + ui_padding_horizontal, ui_y + (ui_size * 0.5) + ui_padding_vertical, ui_size / 8, ui_grey, ui_grey);
        draw_line_width_colour(ui_x + ui_padding_horizontal, ui_y - (ui_size / 8) +  ui_size + ui_padding_vertical, ui_x + ui_size + ui_padding_horizontal, ui_y - (ui_size / 8) + ui_size + ui_padding_vertical, ui_size / 8, ui_grey, ui_grey);
      }
      if(ui_focus){
        if(ds_exists(ui_global_config, ds_type_map)){
          if(ds_map_find_value(ui_global_config, "debug_mode")){
            draw_set_alpha(0.25);
            draw_rectangle_colour(ui_x - 1, ui_y - 1, ui_x + ui_size + (ui_padding_horizontal * 2) + 4, ui_y + ui_size + (ui_padding_vertical * 2) + 2, ui_blue_grey, ui_blue_grey, ui_blue_grey, ui_blue_grey, true);
            draw_set_alpha(1);
          }
        }
      }
    }
    else{
      ui_debug_error(102, "ui_sidenav_draw", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_sidenav_draw", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_sidenav_draw", object_get_name(object_index));
  return false;
}




#define ui_keyboard_draw
if(ds_exists(ui_keyboard, ds_type_map)){
  var ui_active = ds_map_find_value(ui_keyboard, "ui_active");
  var ui_target = ds_map_find_value(ui_keyboard, "ui_target");
  var ui_nav = ds_map_find_value(ui_keyboard, "ui_nav");
  var ui_nav_height = max(32, ds_map_find_value(ui_keyboard, "ui_nav_height"));
  var ui_height = max(128, ds_map_find_value(ui_keyboard, "ui_height"));
  var ui_show = ds_map_find_value(ui_keyboard, "ui_show");
  var ui_clicked = ds_map_find_value(ui_keyboard, "ui_clicked");
  var ui_time_entered = ds_map_find_value(ui_keyboard, "ui_time_entered");
  var ui_background_colour = ds_map_find_value(ui_keyboard, "ui_background_colour");
  var ui_foreground_colour = ds_map_find_value(ui_keyboard, "ui_foreground_colour");
  var ui_font = ds_map_find_value(ui_keyboard, "ui_font");
  var ui_top = ds_map_find_value(ui_keyboard, "ui_top");
  var ui_shift = ds_map_find_value(ui_keyboard, "ui_shift");
  var ui_fn = ds_map_find_value(ui_keyboard, "ui_fn");
  var ui_hold = ds_map_find_value(ui_keyboard, "ui_hold");
  var ui_effect = ds_map_find_value(ui_keyboard, "ui_effect");
  var ui_effect_speed = ds_map_find_value(ui_keyboard, "ui_effect_speed");
  var ui_shadow = ds_map_find_value(ui_keyboard, "ui_shadow");
  var ui_width = room_width;
  var ui_y = room_height - ui_height;
  var ui_mouse_x = device_mouse_x(0);
  var ui_mouse_y = device_mouse_y(0);
  var ui_block_width = (ui_width / 11);
  var ui_block_height = (ui_height / 4);
  var ui_char_list, ui_action_list;
  ui_char_list[0] = ds_list_create();
  ui_char_list[1] = ds_list_create();
  ui_char_list[2] = ds_list_create();
  ui_char_list[3] = ds_list_create();
  ui_char_list[4] = ds_list_create();
  ui_char_list[5] = ds_list_create();
  ui_action_list[0] = ds_list_create();
  ui_action_list[1] = ds_list_create();
  ui_action_list[2] = ds_list_create();
  ui_action_list[3] = ds_list_create();
  ui_action_list[4] = ds_list_create();
  var ui_ind_x = 0;
  var ui_ind_y = 0;
  var ui_key = 0;
  if(ui_fn){
      ds_list_add(ui_char_list[0], "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", chr(8));
      ds_list_add(ui_char_list[1], "@", "#", "$", "_", "&", "-", "+", "(", ")", "/", chr(12));
      ds_list_add(ui_char_list[2], "~", "\", "%", "*", '"', "'", ":", ";", "!", "?", "`");
      ds_list_add(ui_char_list[3], "ABC", "<", "", "", "", "", "", "", "", ">", "ABC");
      ds_list_add(ui_action_list[0], 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 8);
      ds_list_add(ui_action_list[1], "50", "51", "52", "189", "55", 189, "187", "57", "48", 191, 13);
      ds_list_add(ui_action_list[2], "192", 220, "53", "56", "222", 222, "186", 186, "49", "191", 192);
      ds_list_add(ui_action_list[3], "FN", "188", "", "", "", "", "", "", "", "190", "FN");
  }
  else{
    if(ui_shift){
      ds_list_add(ui_char_list[0], "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", chr(8));
      ds_list_add(ui_char_list[1], "A", "S", "D", "F", "G", "H", "J", "K", "L", chr(12));
      ds_list_add(ui_char_list[2], "", "Z", "X", "C", "V", "B", "N", "M", "!", "?", "");
    }
    else{
      ds_list_add(ui_char_list[0], "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", chr(8));
      ds_list_add(ui_char_list[1], "a", "s", "d", "f", "g", "h", "j", "k", "l", chr(8));
      ds_list_add(ui_char_list[2], "", "z", "x", "c", "v", "b", "n", "m", "!", "?", "");
    }
    ds_list_add(ui_char_list[3], "?123", ",", "", "", "", "", "", "", "", ".", "?123");
    ds_list_add(ui_action_list[0], "81", "87", "69", "82", "84", "89", "85", "73", "79", "80", 8);
    ds_list_add(ui_action_list[1], "65", "83", "68", "70", "71", "72", "74", "75", "76");
    ds_list_add(ui_action_list[2], "SHIFT", "90", "88", "67", "86", "66", "78", "77", "49", "191", "SHIFT");
    ds_list_add(ui_action_list[3], "FN", 188, "", "", "", "", "", "", "", 190, "FN");
    ds_list_add(ui_action_list[4], 49, 50, 51, 52, 53, 54, 55, 56, 57, 48);
  }
  ds_list_add(ui_char_list[5], "1", "2", "3", "4", "5", "6", "7", "8", "9", "0");
  var ui_desktop = true;
  if(os_type == os_winphone or os_type == os_ios or os_type == os_android or os_type == os_tizen or os_type == os_ps3 or os_type == os_ps4 or os_type == os_ps4 or os_type == os_psvita or os_type == os_xboxone or os_type == os_unknown){
    ui_desktop = false;
  }
  if(ds_exists(ui_global_config, ds_type_map)){
    if(ds_map_find_value(ui_global_config, "draw_on_gui")){
      ui_width = display_get_gui_width();
      ui_y = display_get_gui_height() - ui_height;
      ui_mouse_x = device_mouse_x_to_gui(0);
      ui_mouse_y = device_mouse_y_to_gui(0);
    }
  }
  if(font_exists(ui_font)) draw_set_font(ui_font);
  if(ui_show){
    if(ui_effect){
      if(ui_top < 1){
        ui_top += ui_effect_speed;
        ui_top = min(ui_top, 1);
        ds_map_replace(ui_keyboard, "ui_top", ui_top);
      }
    }
    else{
      ui_top = 1;
      ds_map_replace(ui_keyboard, "ui_top", ui_top);
    }
  }
  else{
    if(ui_effect){
      if(ui_top > 0){
        ui_top -= ui_effect_speed;
        ui_top = max(ui_top, 0);
        ds_map_replace(ui_keyboard, "ui_top", ui_top);
      }
    }
    else{
      ui_top = 0;
      ds_map_replace(ui_keyboard, "ui_top", ui_top);
    }
  }
  if(ui_show or ui_top > 0){
    if(!ui_nav){ui_nav_height = 0;}
    if(ui_shadow){
      draw_set_alpha(0.02);
      draw_rectangle_colour(0, ui_y - ui_nav_height - 2 + (ui_height - (ui_height * ui_top)), ui_width, ui_y - ui_nav_height + (ui_height - (ui_height * ui_top)), ui_black, ui_black, ui_black, ui_black, false);
      draw_line_colour(0, ui_y - ui_nav_height - 1 + (ui_height - (ui_height * ui_top)), ui_width, ui_y - ui_nav_height - 1 + (ui_height - (ui_height * ui_top)), ui_black, ui_black);
      draw_set_alpha(1);
    }
    draw_rectangle_colour(0, ui_y + (ui_height - (ui_height * ui_top)) - ui_nav_height, ui_width, ui_y + ui_height, ui_background_colour, ui_background_colour, ui_background_colour, ui_background_colour, false);
    if(ui_nav){
      draw_set_alpha(0.05);
      draw_rectangle_colour(0, ui_y - ui_nav_height + (ui_height - (ui_height * ui_top)), ui_width, ui_y + (ui_height - (ui_height * ui_top)), ui_black, ui_black, ui_black, ui_black, false);
      draw_line_colour(0, ui_y - 1 + (ui_height - (ui_height * ui_top)), ui_width, ui_y - 1 + (ui_height - (ui_height * ui_top)), ui_white, ui_white);
      draw_set_alpha(1);
    }
    var ui_add_effect = (ui_height - (ui_height * ui_top));
    if(ui_mouse_y < ui_y - ui_nav_height){
      if(!ui_get_entered(ui_target)){
        if(device_mouse_check_button_pressed(0, mb_left)){
          ui_show = false;
          ds_map_replace(ui_keyboard, "ui_show", ui_show);
        }
      }
    }
    else{
      ui_ind_y = (ui_mouse_y - ui_y) div ui_block_height ;
      ui_ind_x = ui_mouse_x div ui_block_width;
      if(ui_ind_y == 1 && (ui_mouse_x > (ui_block_width / 2) && ui_mouse_y < ui_width - ((ui_block_width / 2))) && !ui_fn){ui_ind_x = ((ui_mouse_x + (ui_block_width / 2)) div ui_block_width) - 1;}
      ui_key = ds_list_find_value(ui_action_list[ui_ind_y], ui_ind_x);
      ui_string = ds_list_find_value(ui_char_list[ui_ind_y], ui_ind_x);
      if(device_mouse_check_button(0, mb_left)){
        for(var ui_i = 0; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
          var control = ds_list_find_value(ui_global_controls, ui_i);
          if(ds_exists(control, ds_type_map)){
            ds_map_replace(control, "ui_active", false);
          }
        }
        if(ui_mouse_y > ui_y){
          if(ui_ind_y < 3){     
            if(ui_ind_y == 1 && !ui_fn){
              if(ui_ind_x < 10){draw_roundrect_colour_ext(ui_ind_x * ui_block_width + (ui_block_width / 2), ui_y + (ui_ind_y * ui_block_height), (ui_ind_x * ui_block_width) + ui_block_width + (ui_block_width / 2), ui_y + (ui_ind_y * ui_block_height) + ui_block_height, 2, 2, ui_colour_darker(ui_background_colour), ui_colour_darker(ui_background_colour), false);}
            }
            else{draw_roundrect_colour_ext(ui_ind_x * ui_block_width, ui_y + (ui_ind_y * ui_block_height), (ui_ind_x * ui_block_width) + ui_block_width, ui_y + (ui_ind_y * ui_block_height) + ui_block_height, 2, 2, ui_colour_darker(ui_background_colour), ui_colour_darker(ui_background_colour), false);}
          }
          else{
            if(ui_ind_x > 1 && ui_ind_x < 9){
              draw_roundrect_colour_ext(2 * ui_block_width, ui_y + (ui_ind_y * ui_block_height), (8 * ui_block_width) + ui_block_width, ui_y + (ui_ind_y * ui_block_height) + ui_block_height, 2, 2, ui_colour_darker(ui_background_colour), ui_colour_darker(ui_background_colour), false);
            }
            else{
              draw_roundrect_colour_ext(ui_ind_x * ui_block_width, ui_y + (ui_ind_y * ui_block_height), (ui_ind_x * ui_block_width) + ui_block_width, ui_y + (ui_ind_y * ui_block_height) + ui_block_height, 2, 2, ui_colour_darker(ui_background_colour), ui_colour_darker(ui_background_colour), false);
            }
          }
          if(ui_hold > 20){
            if(ui_clicked){
              if(ui_ind_y == 0 && !ui_fn){
                if(ui_ind_x < 10){
                  var ui_hold_key = ds_list_find_value(ui_action_list[4], ui_ind_x);
                  var ui_hold_string = ds_list_find_value(ui_char_list[5], ui_ind_x);
                  keyboard_key_press(ui_hold_key);
                  if(!ui_desktop){keyboard_string = ui_hold_string;}
                }
              }
              else if(ui_key == "SHIFT"){
                if(ui_shift == 2){
                  ui_shift = 0;
                  ds_map_replace(ui_keyboard, "ui_shift", ui_shift);
                }
                else{
                  ui_shift = 2;
                  ds_map_replace(ui_keyboard, "ui_shift", ui_shift);
                }
                io_clear();
                if(!ui_desktop){keyboard_string = "";}
              }
              ui_hold = 0;
              ds_map_replace(ui_keyboard, "ui_hold", ui_hold);
              ui_clicked = false;
              ds_map_replace(ui_keyboard, "ui_clicked", ui_clicked);
            }
          }
          else{
            if(ui_clicked){
              ui_hold += 1;
              ds_map_replace(ui_keyboard, "ui_hold", ui_hold);
            }
          }
        }
        else{
          if(ui_ind_x > 8 && ui_ind_x < 11 && ui_nav){
            draw_roundrect_colour_ext(ui_ind_x * ui_block_width, ui_y - ui_nav_height, (ui_ind_x * ui_block_width) + ui_block_width, ui_y, 2, 2, ui_colour_darker(ui_background_colour), ui_colour_darker(ui_background_colour), false);
          }
        }
      }
      if(device_mouse_check_button_pressed(0, mb_left)){
        ui_clicked = true;
        ds_map_replace(ui_keyboard, "ui_clicked", ui_clicked);
        if(ui_key == "SHIFT"){
          if(ui_hold < 20){
            if(!ui_fn){
              switch(ui_shift){
                case 0: ui_shift = 1;break;
                case 1: ui_shift = 0;break;
                case 2: ui_shift = 0;break;
              }
            }
            ds_map_replace(ui_keyboard, "ui_shift", ui_shift);
          }
        }
      }
      if(device_mouse_check_button_released(0, mb_left) && ui_clicked){
        if(ui_mouse_y > ui_y){
          if(ui_ind_y < 3){
            if(is_real(ui_key)){
              if(ui_hold < 20){
                keyboard_key_press(ui_key);
                if(!ui_desktop){keyboard_string = ui_string;}
              }
            }
            else{
              if(ui_fn or (!ui_fn && ui_ind_y == 2 && (ui_ind_x == 8 or ui_ind_x == 9))){keyboard_key_press(160);}
              if(!ui_fn){
                if(ui_shift > 0){keyboard_key_press(160);}
              }
              if(ui_hold < 20){keyboard_key_press(real(ui_key));}
              if(!ui_desktop){keyboard_string = ui_string;}
            }
            if(ui_shift == 1 && ui_key != "SHIFT" && !ui_fn){
              ui_shift = 0;
              ds_map_replace(ui_keyboard, "ui_shift", ui_shift);
              keyboard_key_release(160);
            }
          }
          else{
            if(ui_ind_x > 1 && ui_ind_x < 9){
              keyboard_key_press(32);
              if(!ui_desktop){keyboard_string = " ";}
            }
            else{
              if(is_real(ui_key)){
               keyboard_key_press(ui_key);
                if(!ui_desktop){keyboard_string = ui_string;}
              }
              else if(ui_key == "FN"){
                ui_fn = !ui_fn;
                ds_map_replace(ui_keyboard, "ui_fn", ui_fn);
                ui_shift = 0;
                ds_map_replace(ui_keyboard, "ui_shift", ui_shift);
              }
              else{
                if(ui_fn){keyboard_key_press(160);}
                keyboard_key_press(ui_key);
                if(!ui_desktop){keyboard_string = ui_string;}
              }
            }
          }
        }
        else{
          if(ui_nav){
            if(ui_ind_x == 9){
              keyboard_key_press(37);
              if(!ui_desktop){keyboard_key = 37;}
            }
            if(ui_ind_x == 10){
              keyboard_key_press(39);
              if(!ui_desktop){keyboard_key = 39;}
            }
          }
        }
        ui_time_entered = 1;
        ds_map_replace(ui_keyboard, "ui_time_entered", ui_time_entered);
        ui_hold = 0;
        ds_map_replace(ui_keyboard, "ui_hold", ui_hold);
        ui_clicked = false;
        ds_map_replace(ui_keyboard, "ui_clicked", ui_clicked);
      }
    }
    if(ui_time_entered > 0){
      ui_time_entered -= 1;
      ds_map_replace(ui_keyboard, "ui_time_entered", ui_time_entered);
    }
    else{
      if(!ui_clicked){
        if(ui_mouse_y > ui_y){
          if(ui_ind_y < 3){
            if(is_real(ui_key)){keyboard_key_release(ui_key);}
            else{
              if(ui_fn or (!ui_fn && ui_ind_y == 2 && (ui_ind_x == 8 or ui_ind_x == 9))){keyboard_key_release(160);}
              if(!ui_fn){
                if(ui_shift > 0){keyboard_key_release(160);}
              }
              keyboard_key_release(real(ui_key));
            }
          }
          else{
            if(ui_ind_x > 1 && ui_ind_x < 9){keyboard_key_release(32);}
            else{
              if(is_real(ui_key)){keyboard_key_release(ui_key);}
              else{
                if(ui_fn){keyboard_key_release(160);}
                keyboard_key_release(real(ui_key));
              }
            }
          }
        }
        else{
          if(ui_nav){
            if(ui_ind_x == 9){keyboard_key_release(37);}
            if(ui_ind_x == 10){keyboard_key_release(39);}
          }
        }
      }
      if(!ui_desktop){keyboard_string = "";}
    }
    if(device_mouse_check_button_released(0, mb_left)){
      ui_clicked = false;
      ds_map_replace(ui_keyboard, "ui_clicked", ui_clicked);
    }
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    if(ui_nav){
      draw_triangle_colour((9 * ui_block_width) + (ui_block_width/2) - 10, ui_y - ui_nav_height + (ui_nav_height / 2) + ui_add_effect, (9 * ui_block_width) + (ui_block_width/2) + 10, ui_y - ui_nav_height + (ui_nav_height / 2) - 10 + ui_add_effect, (9 * ui_block_width) + (ui_block_width/2) + 10, ui_y - ui_nav_height + (ui_nav_height / 2) + 10 + ui_add_effect, ui_colour_lighter(ui_foreground_colour), ui_colour_lighter(ui_foreground_colour), ui_colour_lighter(ui_foreground_colour), false);
      draw_triangle_colour((10 * ui_block_width) + (ui_block_width/2) - 10, ui_y - ui_nav_height + (ui_nav_height / 2) - 10 + ui_add_effect, (10 * ui_block_width) + (ui_block_width/2) - 10, ui_y - ui_nav_height + (ui_nav_height / 2) + 10 + ui_add_effect, (10 * ui_block_width) + (ui_block_width/2) + 10, ui_y - ui_nav_height + (ui_nav_height / 2) + ui_add_effect, ui_colour_lighter(ui_foreground_colour), ui_colour_lighter(ui_foreground_colour), ui_colour_lighter(ui_foreground_colour), false);
    }
    for(var ui_i = 0; ui_i < 11; ui_i += 1){
      if(ui_i < 10){
        if(ui_shadow){draw_text_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + (0 * ui_block_height) + ui_add_effect + (ui_block_height / 2) + 1, ds_list_find_value(ui_char_list[0], ui_i), ui_black, ui_black, ui_black, ui_black, 0.2);}
        draw_text_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + (0 * ui_block_height) + ui_add_effect + (ui_block_height / 2), ds_list_find_value(ui_char_list[0], ui_i), ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
        if(!ui_fn){draw_text_transformed_colour(ui_i * ui_block_width + (ui_block_width / 2) + string_width("X"), ui_y + (ui_block_height / 2) + (ui_height - (ui_height * ui_top)) - 16, ds_list_find_value(ui_char_list[5], ui_i), 0.6, 0.6, 0, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);}
      }
      else{
        if(ui_shadow){
          draw_set_alpha(0.2);
          draw_roundrect_colour_ext((ui_i * ui_block_width + (ui_block_width / 2)) - 6, (ui_y + ui_add_effect + (ui_block_height / 2)) - 10 + 1, (ui_i * ui_block_width + (ui_block_width / 2)) + 14, (ui_y + ui_add_effect + (ui_block_height / 2)) + 10 + 1, 2, 2, ui_black, ui_black, false);
          draw_triangle_colour((ui_i * ui_block_width + (ui_block_width / 2)) - 15, (ui_y + ui_add_effect + (ui_block_height / 2)) + 1 + 1, (ui_i * ui_block_width + (ui_block_width / 2)) - 5, (ui_y + ui_add_effect + (ui_block_height / 2)) - 9 + 1, (ui_i * ui_block_width + (ui_block_width / 2)) - 5, (ui_y + ui_add_effect + (ui_block_height / 2)) + 11 + 1, ui_black, ui_black, ui_black, false);
          draw_set_alpha(1);
        }
        draw_roundrect_colour_ext((ui_i * ui_block_width + (ui_block_width / 2)) - 6, (ui_y + ui_add_effect + (ui_block_height / 2)) - 10, (ui_i * ui_block_width + (ui_block_width / 2)) + 14, (ui_y + ui_add_effect + (ui_block_height / 2)) + 10, 2, 2, ui_colour_lighter(ui_foreground_colour), ui_colour_lighter(ui_foreground_colour), false);
        draw_triangle_colour((ui_i * ui_block_width + (ui_block_width / 2)) - 15, (ui_y + ui_add_effect + (ui_block_height / 2)) + 1, (ui_i * ui_block_width + (ui_block_width / 2)) - 5, (ui_y + ui_add_effect + (ui_block_height / 2)) - 9, (ui_i * ui_block_width + (ui_block_width / 2)) - 5, (ui_y + ui_add_effect + (ui_block_height / 2)) + 11, ui_colour_lighter(ui_foreground_colour), ui_colour_lighter(ui_foreground_colour), ui_colour_lighter(ui_foreground_colour), false);
        draw_line_width_colour((ui_i * ui_block_width + (ui_block_width / 2)) - 2, (ui_y + ui_add_effect + (ui_block_height / 2)) - 4, (ui_i * ui_block_width + (ui_block_width / 2)) + 7, (ui_y + ui_add_effect + (ui_block_height / 2)) + 5, 2, ui_background_colour, ui_background_colour);
        draw_line_width_colour((ui_i * ui_block_width + (ui_block_width / 2)) - 2, (ui_y + ui_add_effect + (ui_block_height / 2)) + 5, (ui_i * ui_block_width + (ui_block_width / 2)) + 7, (ui_y + ui_add_effect + (ui_block_height / 2)) - 4, 2, ui_background_colour, ui_background_colour);
      }
    }
    if(ui_fn){
      for(var ui_i = 0; ui_i < 11; ui_i += 1){
         if(ui_i < 10){
          if(ui_shadow){draw_text_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + (1 * ui_block_height) + ui_add_effect + (ui_block_height / 2) +  1, string_replace(ds_list_find_value(ui_char_list[1], ui_i), "#", "\#"), ui_black, ui_black, ui_black, ui_black, 0.2);}
          draw_text_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + (1 * ui_block_height) + ui_add_effect + (ui_block_height / 2), string_replace(ds_list_find_value(ui_char_list[1], ui_i), "#", "\#"), ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
        }
        else{
          if(ui_shadow){
            draw_set_alpha(0.2);
            draw_circle_colour(ui_block_width / 2 + ui_i * ui_block_width + 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2) + 1, 16, ui_black, ui_black, false);
            draw_set_alpha(1);
          }
          draw_circle_colour(ui_block_width / 2 + ui_i * ui_block_width + 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2), 16, ui_colour_lighter(ui_teal), ui_colour_lighter(ui_teal), false);
          draw_line_width_colour(ui_block_width / 2 + ui_i * ui_block_width + 8 - 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2), ui_block_width / 2 + ui_i * ui_block_width + 8 + 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2), 2, ui_white, ui_white);
          draw_line_width_colour(ui_block_width / 2 + ui_i * ui_block_width + 8 + 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2), ui_block_width / 2 + ui_i * ui_block_width + 8 + 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2) - 6, 2, ui_white, ui_white);
          draw_line_width_colour(ui_block_width / 2 + ui_i * ui_block_width + 8 - 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2), ui_block_width / 2 + ui_i * ui_block_width + 8 - 2, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2) - 5, 2, ui_white, ui_white)
          draw_line_width_colour(ui_block_width / 2 + ui_i * ui_block_width + 8 - 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2), ui_block_width / 2 + ui_i * ui_block_width + 8 - 2, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2) + 5, 2, ui_white, ui_white)
        }
      }
    }
    else{
      for(var ui_i = 0; ui_i < 10; ui_i += 1){
        if(ui_i < 9){
          if(ui_shadow){draw_text_colour(ui_i * ui_block_width + (ui_block_width), ui_y + (1 * ui_block_height) + ui_add_effect + (ui_block_height / 2) +  1, ds_list_find_value(ui_char_list[1], ui_i), ui_black, ui_black, ui_black, ui_black, 0.2);}
          draw_text_colour(ui_i * ui_block_width + (ui_block_width), ui_y + (1 * ui_block_height) + ui_add_effect + (ui_block_height / 2), ds_list_find_value(ui_char_list[1], ui_i), ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
        }
        else{
          if(ui_shadow){
            draw_set_alpha(0.2);
            draw_circle_colour(ui_block_width / 2 + ui_i * ui_block_width + (ui_block_width / 2) + 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2) + 1, 16, ui_black, ui_black, false);
            draw_set_alpha(1);
          }
          draw_circle_colour(ui_block_width / 2 + ui_i * ui_block_width + (ui_block_width / 2) + 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2), 16, ui_colour_lighter(ui_teal), ui_colour_lighter(ui_teal), false);
          draw_line_width_colour(ui_block_width / 2 + ui_i * ui_block_width + (ui_block_width / 2) + 8 - 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2), ui_block_width / 2 + ui_i * ui_block_width + (ui_block_width / 2) + 8 + 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2), 2, ui_white, ui_white);
          draw_line_width_colour(ui_block_width / 2 + ui_i * ui_block_width + (ui_block_width / 2) + 8 + 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2), ui_block_width / 2 + ui_i * ui_block_width + (ui_block_width / 2) + 8 + 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2) - 6, 2, ui_white, ui_white);
          draw_line_width_colour(ui_block_width / 2 + ui_i * ui_block_width + (ui_block_width / 2) + 8 - 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2), ui_block_width / 2 + ui_i * ui_block_width + (ui_block_width / 2) + 8 - 2, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2) - 5, 2, ui_white, ui_white)
          draw_line_width_colour(ui_block_width / 2 + ui_i * ui_block_width + (ui_block_width / 2) + 8 - 8, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2), ui_block_width / 2 + ui_i * ui_block_width + (ui_block_width / 2) + 8 - 2, ui_y + ui_block_height + ui_add_effect + (ui_block_height / 2) + 5, 2, ui_white, ui_white)
        }
      }
    }
    if(ui_fn){
      for(var ui_i = 0; ui_i < 11; ui_i += 1){
        if(ui_shadow){draw_text_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + (2 * ui_block_height) + ui_add_effect + (ui_block_height / 2) + 1, ds_list_find_value(ui_char_list[2], ui_i), ui_black, ui_black, ui_black, ui_black, 0.2);}
        draw_text_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + (2 * ui_block_height) + ui_add_effect + (ui_block_height / 2), ds_list_find_value(ui_char_list[2], ui_i), ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
      }
    }
    else{
      for(var ui_i = 0; ui_i < 11; ui_i += 1){
        if(ui_i > 0 and ui_i < 10){
          if(ui_shadow){draw_text_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + (2 * ui_block_height) + ui_add_effect + (ui_block_height / 2) + 1, ds_list_find_value(ui_char_list[2], ui_i), ui_black, ui_black, ui_black, ui_black, 0.2);}
          draw_text_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + (2 * ui_block_height) + ui_add_effect + (ui_block_height / 2), ds_list_find_value(ui_char_list[2], ui_i), ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
        }
        else{
          var ui_shift_colour0 = ui_grey;
          var ui_shift_colour1 = ui_grey;
          switch(ui_shift){
            case 0:
              ui_shift_colour0 = ui_grey;
              ui_shift_colour1 = ui_grey;
            break;
            case 1:
              ui_shift_colour0 = ui_colour_lighter(c_teal);
              ui_shift_colour1 = ui_grey;
            break;
            case 2:
              ui_shift_colour0 = ui_colour_lighter(c_teal);
              ui_shift_colour1 = ui_colour_lighter(c_teal);
            break;
          }
          if(ui_shadow){
            draw_set_alpha(0.2);
            draw_triangle_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2) - 12 + 1, ui_i * ui_block_width + (ui_block_width / 2) - 12, ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2) + 1, ui_i * ui_block_width + (ui_block_width / 2) + 12, ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2) + 1, ui_black, ui_black, ui_black, false);
            draw_rectangle_colour(ui_i * ui_block_width + (ui_block_width / 2) - 4, ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2) + 1, ui_i * ui_block_width + (ui_block_width / 2) + 4, ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2) + 6 + 1, ui_black, ui_black, ui_black, ui_black, false);
            draw_line_width_colour(ui_i * ui_block_width + (ui_block_width / 2) - 8, ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2) + 16 + 1, ui_i * ui_block_width + (ui_block_width / 2) + 8, ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2) + 16 + 1, 2, ui_black, ui_black);
            draw_set_alpha(1);
          }
          draw_triangle_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2) - 12, ui_i * ui_block_width + (ui_block_width / 2) - 12, ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2), ui_i * ui_block_width + (ui_block_width / 2) + 12, ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2), ui_shift_colour0, ui_shift_colour0, ui_shift_colour0, false);
          draw_rectangle_colour(ui_i * ui_block_width + (ui_block_width / 2) - 4, ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2), ui_i * ui_block_width + (ui_block_width / 2) + 4, ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2) + 6, ui_shift_colour0, ui_shift_colour0, ui_shift_colour0, ui_shift_colour0, false);
          draw_line_width_colour(ui_i * ui_block_width + (ui_block_width / 2) - 8, ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2) + 16, ui_i * ui_block_width + (ui_block_width / 2) + 8, ui_y + 2 * ui_block_height + ui_add_effect + (ui_block_height / 2) + 16, 2, ui_shift_colour1, ui_shift_colour1);
        }
      }
    }
    for(var ui_i = 0; ui_i < 2; ui_i += 1){
      if(ui_shadow){draw_text_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + (3 * ui_block_height) + ui_add_effect + (ui_block_height / 2) + 1, ds_list_find_value(ui_char_list[3], ui_i), ui_black, ui_black, ui_black, ui_black, 0.2);}
      draw_text_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + (3 * ui_block_height) + ui_add_effect + (ui_block_height / 2), ds_list_find_value(ui_char_list[3], ui_i), ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
    }
    draw_roundrect_colour_ext(2 * ui_block_width + 16, ui_y + 3 * ui_block_height + ui_add_effect + (ui_block_height / 2) - 12, 8 * ui_block_width + ui_block_width - 16,  ui_y + 3 * ui_block_height + ui_add_effect + (ui_block_height / 2) + 12, 2, 2, ui_colour_lighter(ui_foreground_colour), ui_colour_lighter(ui_foreground_colour), false);
    for(var ui_i = 9; ui_i < 11; ui_i += 1){
      if(ui_shadow){draw_text_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + (3 * ui_block_height) + ui_add_effect + (ui_block_height / 2) + 1, ds_list_find_value(ui_char_list[3], ui_i), ui_black, ui_black, ui_black, ui_black, 0.2);}
      draw_text_colour(ui_i * ui_block_width + (ui_block_width / 2), ui_y + (3 * ui_block_height) + ui_add_effect + (ui_block_height / 2), ds_list_find_value(ui_char_list[3], ui_i), ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, ui_foreground_colour, 1);
    }
    for(var ui_i = 0; ui_i < array_length_1d(ui_char_list); ui_i += 1){
      if(ds_exists(ui_char_list[ui_i], ds_type_list)){ ds_list_destroy(ui_char_list[ui_i]); }
    }
    for(var ui_i = 0; ui_i < array_length_1d(ui_action_list); ui_i += 1){
      if(ds_exists(ui_action_list[ui_i], ds_type_list)){ ds_list_destroy(ui_action_list[ui_i]); }
    }
  }
  if(!ui_show && ui_active){
    if(ds_exists(ui_target, ds_type_map)){
      ds_map_replace(ui_target, "ui_focus", false);
      ds_map_replace(ui_keyboard, "ui_target", ui_default);
    }
    ds_map_replace(ui_keyboard, "ui_fn", false);
    ds_map_replace(ui_keyboard, "ui_shift", 0);
    for(var ui_i = 0; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
      var control = ds_list_find_value(ui_global_controls, ui_i);
      if(ds_exists(control, ds_type_map)){
        ds_map_replace(control, "ui_active", true);
      }
    }
  }
}
else{
  ui_debug_error(105, "ui_keyboard_draw", object_get_name(object_index));
  return false;
}




#define ui_keyboard_get_shown
if(argument_count == 0){
  if(ds_exists(ui_keyboard, ds_type_map)){
    if(ds_map_exists(ui_keyboard, "ui_show")){
      return ds_map_find_value(ui_keyboard, "ui_show");
    }
    else{
      ui_debug_error(103, "ui_keyboard_get_shown", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(102, "ui_keyboard_get_shown", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_keyboard_get_shown", object_get_name(object_index));
  return false;
}

#define ui_keyboard_show
if(argument_count == 0){
  if(ds_exists(ui_keyboard, ds_type_map)){
    if(ds_map_exists(ui_keyboard, "ui_show")){
      ds_map_replace(ui_keyboard, "ui_show", true);
      if(ds_exists(ui_global_config, ds_type_map)){
        if(ds_map_find_value(ui_global_config, "enable_keyboard")){
          if(ds_exists(ui_global_controls, ds_type_list)){
            for(var ui_i = 0 ; ui_i < ds_list_size(ui_global_controls); ui_i += 1){
              var control = ds_list_find_value(ui_global_controls, ui_i);
              if(ds_map_find_value(control, "ui_focus")){
                ds_map_replace(ui_keyboard, "ui_target", control);
                break;
              }
            }
          }
          return true;
        }
        else{
          ui_debug_error(105, "ui_keyboard_show", object_get_name(object_index));
          return false;
        }
      }
      else{
        ui_debug_error(105, "ui_keyboard_show", object_get_name(object_index));
        return false;
      }
    }
    else{
      ui_debug_error(103, "ui_keyboard_show", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(105, "ui_keyboard_show", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_keyboard_show", object_get_name(object_index));
  return false;
}



#define ui_keyboard_hide
if(argument_count == 0){
  if(ds_exists(ui_keyboard, ds_type_map)){
    if(ds_map_exists(ui_keyboard, "ui_show")){
      ds_map_replace(ui_keyboard, "ui_show", false);
    }
    else{
      ui_debug_error(103, "ui_keyboard_hide", object_get_name(object_index));
      return false;
    }
  }
  else{
    ui_debug_error(105, "ui_keyboard_hide", object_get_name(object_index));
    return false;
  }
}
else{
  ui_debug_error(101, "ui_keyboard_hide", object_get_name(object_index));
  return false;
}