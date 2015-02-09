// Nombre: Script Texto
// Descripción: Muestra un texto dentro una caja creada dinámicamente
// a partir del tamaño del texto, y lo muestra poco a poco.
// Uso: scr_text("Text",speed,x,y);

// Creamos una instancia del objeto textbox
txt_box = instance_create(argument2,argument3,obj_textbox);
with(txt_box)
{
    padding = 16;               // Establecemos un margen interior
    maxlength = view_wview[0];  // Establecemos una longitud máxima
    text = argument0;           // Establecemos el texto del primer argumento
    spd = argument1;            // Establecemos la velocidad del segundo argumento
    font = fnt_default;         // Establecemos una fuente
    
    text_length = string_length(text); // Longitud del texto
    font_size = font_get_size(font);   // Tamaño de la fuente
    
    // Establecemos la fuente
    draw_set_font(font);
    
    // Tamaño aproximado del texto w y h
    text_width = string_width_ext(text, font_size + (font_size/2), maxlength);
    text_height = string_height_ext(text, font_size + (font_size/2), maxlength);
    
    // Le sumamos los márgenes interiores (paddings)
    boxwidth = text_width + (padding*2);
    boxheight = text_height + (padding*2);   
}

// Restauramos la transparencia para que no se herede
draw_set_alpha(1);
