/*************************************************
 **  Usage example
 **  Having declared 'keyboard' as < 0 before!
 **
  
    if mouse_check_button_pressed(mb_left) {
        keyboard = open_keyboard(0, email);
    }
    if instance_exists(keyboard) {
        if keyboard.children == 0 {
            email = keyboard.keystroke;
        }
    }

*************************************************/

obj = instance_create(0,0,keyboard_obj);
obj.children = argument0;
obj.keystroke = argument1;
return (obj);
