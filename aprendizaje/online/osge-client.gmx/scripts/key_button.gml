// button(x, y, w, h, char, cola, colb, add to key string?)

var ret;
ret = -1;
/*
for (ii=0; ii<4; ii+=1) {
    if in_rectangle_device(argument0, argument1, argument0+argument2, argument1+argument3, ii) {
        if device_mouse_check_button(ii, mb_left) {
            ret = 0;
        }
        if device_mouse_check_button_pressed(ii, mb_left) {
            ret = 1;
        }
        if device_mouse_check_button_released(ii, mb_left) {
            ret = 2;
            if (argument7 == true)
                keyboard_obj.keystroke += argument4;
        }
    }
}
*/
if in_rectangle(argument0, argument1, argument0+argument2, argument1+argument3) {
    if mouse_check_button( mb_left) {
        ret = 0;
    }
    if mouse_check_button_pressed( mb_left) {
        ret = 1;
    }
    if mouse_check_button_released( mb_left) {
        ret = 2;
        if (argument7 == true)
            keyboard_obj.keystroke += argument4;
    }
}

draw_set_alpha(1*ease_fase)
draw_rectangle_color(argument0, argument1, argument0+argument2, argument1+argument3, argument5, argument5, argument6, argument6, 0);
if ret != -1 {
    draw_rectangle_color(argument0, argument1, argument0+argument2, argument1+argument3, highlight_a, highlight_a, highlight_b, highlight_b, 0);
}

draw_set_alpha(0.5*ease_fase)
draw_line_width_color(argument0, argument1, argument0+argument2, argument1, 1, c_white, c_white);
draw_line_width_color(argument0, argument1+argument3, argument0+argument2, argument1+argument3, 1, c_black, c_black);
draw_set_alpha(1*ease_fase)

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if argument4 == "SHIFT" {
    sc = min(argument2, argument3)/64;
    draw_sprite_ext(special_keys_spr, 0, argument0+(argument2/2), argument1+(argument3/2), sc, sc, 0, c_white, ease_fase)
}
else if argument4 == "BACKSPACE" {
    sc = min(argument2, argument3)/64;
    draw_sprite_ext(special_keys_spr, 1, argument0+(argument2/2), argument1+(argument3/2), sc, sc, 0, c_white, ease_fase)
}
else {
    draw_text_color(argument0+(argument2/2), argument1+(argument3/2), argument4, c_white, c_white, c_white, c_white, 1*ease_fase);
}

if (argument7 == true && ret != -1 && argument4 != " ") {
    draw_sprite_ext(key_highlight_spr, 0, argument0+(argument2/2), argument1, global_dpi, global_dpi, 0, c_white, 1*ease_fase);
    draw_text_color(argument0+(argument2/2), argument1-(40*global_dpi), argument4, c_white, c_white, c_white, c_white, 1*ease_fase);
}

return (ret);

