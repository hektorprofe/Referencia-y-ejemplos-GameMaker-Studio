// Creado por Héctor Costa Guzmán

// Script darken_color: 
// argument0 = color rgb
// argument1 = porcetaje a oscurecer

// Transformamos el color a hsv
var hue=color_get_hue(argument0);
var sat=color_get_saturation(argument0);
var val=color_get_value(argument0);

val -= argument1*255/100;

var hsv = make_color_hsv(hue,sat,val);

var red = color_get_red(hsv);
var green = color_get_green(hsv);
var blue = color_get_blue(hsv);

return make_color_rgb(red,green,blue);
