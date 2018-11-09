/// @description Init

global.gui_width=1280/2;
global.gui_height=720/2;


if (parameter_count() == 3) {//3,6
    shell_execute(parameter_string(0),
        parameter_string(1) + " " +
        parameter_string(2) + " " +
        parameter_string(3) + " -secondary")
    window_set_position(window_get_x() - global.gui_width div 2 - 8, window_get_y())
    // <primary instance>
    window_set_caption("P1")
}
if (parameter_count() == 4) {//4,10
    window_set_position(window_get_x() + global.gui_width div 2 + 8, window_get_y())
    // <secondary instance>
    window_set_caption("P2")  
}


room_goto_next()


