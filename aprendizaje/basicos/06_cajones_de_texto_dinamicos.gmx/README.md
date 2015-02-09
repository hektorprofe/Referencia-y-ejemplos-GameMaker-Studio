## Cajones de texto dinámicos
Script y objeto que crean un cajón con un texto adaptándose al texto que contienen.

### Script scr_text
```javascript
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
```

### Objeto obj_textbox: Create
```javascript
alpha = 0;  // La transparencia será el máximo
print = ""; // Texto que se va a ir mostrando
time = 0;   // Tiempo en que se irá mostrando el texto
depth = depth - instance_number(obj_textbox); // Profundidad
```

### Objeto obj_textbox: Draw Parte 1
```javascript
/// Añadimos las letras poco a poco
// Mostraremos letra a letra cada mientras el contador de tiempo
// sea menos que la longitud del texto, iremos mostrando cada vez 
// más letras del texto hasta el final 
if (time < text_length)
{   
    time += spd; // Sumamos al tiempo la velocidad que graduamos nosotros
    print = string_copy(text,0,time); // E iremos añadiendo poco a poco el texto
}
```

### Objeto obj_textbox: Draw Parte 2
```javascript
/// Dibujamos la caja de texto y el texto
draw_set_alpha(alpha);
// Crearemos un efecto de transición fadeIn poco a poco
if (alpha < 1) alpha += spd/10; else alpha = 1; 

// Primero creamos la caja que contendrá el texto
draw_set_font(fnt_default);
draw_set_color(c_gray);
draw_rectangle(x,y,x+boxwidth,y+boxheight,0);
draw_set_color(c_black);
draw_rectangle(x,y,x+boxwidth,y+boxheight,1);

// A continuación creamos el texto por encima
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_ext(
    x + padding,               // Dentro del margen interior horizontal
    y + padding,               // Dentro del margen interior vertical
    print,                     // El texto a escribir
    font_size + (font_size/2), // Distancia en px entre cada línea
    maxlength                  // Ancho máximo en px antes de cada salto de línea
);

```

### Generador de textos al hacer clic en la pantalla: Step
```javascript
// Generador de cajas de texto al hacer clic
if (mouse_check_button_released(mb_left))
{

    var str;
    switch(irandom(4))
    {
        case 0: 
            str = "Lorem ipsum dolor sit amet,#consectetur adipiscing elit.#Aliquam ultricies imperdiet augue.#Ut cursus lacus dui.";
            break
        case 1: 
            str = "Aliquam ultricies imperdiet augue.#Ut cursus lacus dui.";
            break
            
        case 2: 
            str = "In posuere diam quis massa accumsan rhoncus id in est.";
            break
            
        case 3: 
            str = "Donec vel est feugiat.";
            break
            
        default: 
            str = "Etiam in justo nisl.";
            break
    }
    
    scr_text(str,1,mouse_x,mouse_y);

}
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/06_cajones_de_texto_dinamicos.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/06_cajones_de_texto_dinamicos.gmx/captura.jpg)