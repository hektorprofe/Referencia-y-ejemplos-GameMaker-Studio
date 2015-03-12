// Nombre: Script Ventana
// Descripción: Muestra un texto dentro una caja creada dinámicamente
// a partir del tamaño del texto, y lo muestra poco a poco.
// Uso: scr_text("Text",speed,origin_object);
var window = instance_create(argument2.x,argument2.y,obj_Window_Base);
with (window){
    
    origin_object = argument2;

    padding = 16;
    maxlength = view_wview[0];
    text = argument0;           // Establecemos el texto del primer argumento
    spd = argument1;            // Establecemos la velocidad del segundo argumento
    font = fnt_Window;         // Establecemos una fuente

    text_length = string_length(text); // Longitud del texto
    font_size = font_get_size(font);   // Tamaño de la fuente

    // Establecemos la fuente
    draw_set_font(font);

    // Tamaño aproximado del texto w y h
    text_width = string_width_ext(text, font_size + (font_size/2), maxlength);
    text_height = string_height_ext(text, font_size + (font_size/2), maxlength);

    // Le sumamos los márgenes interiores (paddings)
    box_width = text_width + (padding*2);
    box_height = text_height + (padding*2);   
    
    // Relocate window position
    x = x-box_width/2;
    y = y-box_height/2 - 60; // negative offset top

    // Calculamos el redimensionamiento de escalado, por defecto 48x48 equivale 1x1
    image_xscale = 1 * box_width / (48+padding);
    image_yscale = 1 * box_height / (48+padding+6);
    
    // Llamamos al evento que dibujará la ventana    
    event_user(0);
}   
    
// return id
return window; 