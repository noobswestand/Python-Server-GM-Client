///Draw rectangle as header background

var col = ds_map_find_value(ui_global_config, "default_background_colour");
draw_rectangle_colour(0, 0, display_get_gui_width(), 64, col, col, col, col, false);
