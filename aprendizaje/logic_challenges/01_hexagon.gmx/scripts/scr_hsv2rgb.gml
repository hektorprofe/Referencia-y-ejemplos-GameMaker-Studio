/* HSV to RGB
arg0: Hue
arg1: Sat
arg2: Val */

col=make_color_hsv(argument0,argument1,argument2)
red=color_get_red(col)
green=color_get_green(col)
blue=color_get_blue(col)
