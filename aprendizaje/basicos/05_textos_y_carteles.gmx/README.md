## Textos y carteles
En este ejemplo se dibuja un texto cuando el personaje pasa por encima de un cartel, recreando la posibilidad de leerlo.

### Al crear el objeto cartel
```javascript
// Creamos una variable para ver si hemos de mostrar el texto
show_text = false;
```

### En el evento Step
```javascript
// Detectamos si el héroe está encima del cartel
if (place_meeting(x,y,obj_hero))
{
    show_text = true;
}
else
{
    show_text = false;
}
```

### En el evento Draw
```javascript
// Dibujamos el propio sprite
draw_self();

// Comprobamos si mostrar el cartel
if (show_text){
    
    // Vamos a recrear un efecto de sombreado

    // Primero dibujamos el texto de sombra
    draw_set_alpha(0.5);        // Transparente
    draw_set_color(c_black);    // Negro
    draw_set_halign(fa_center); // Centrado
    draw_set_font(fnt_default);
    // Un poco por encima de la posición del cartel
    draw_text(x+1,y-100,"Hola!#Esto es un ejemplo!");
    
    // Luego el texto normal
    draw_set_alpha(1);          // Sin transparencia
    draw_set_color(c_white);    // Blanco
    draw_set_halign(fa_center); // Centrado
    draw_set_font(fnt_default);
    // Un poco por encima de la posición del cartel
    draw_text(x,y-100,"Hola!#Esto es un ejemplo!");
}

// IMPORTANTE: Hay siempre que dejar la transparencia a 1
// o el juego se nos volverá totalmente transparente, ya
// que sinó se heredaría la transparencia al dibujar todo
```

### Tips
En una futura implementación se podría extender el método draw para dibujar un texto contenido en una variable del texto_cartel, establecida en el propio código del objeto utilizando clic derecho "Creation Code". 

También sería interesante comprobar la longitud de este texto y pasarle una variable con los saltos de línea para poder graduar la posición vertical del texto, así como cambiar la justificación del texto si nos encontramos cerca del margen derecho de la room.


### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/05_textos_y_carteles.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/05_textos_y_carteles.gmx/captura.jpg)