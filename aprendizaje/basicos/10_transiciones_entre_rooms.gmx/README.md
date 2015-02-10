## Transiciones entre rooms
Utilizando un truco de crear un rectangulo negro persistente entre dos room que cubra toda la view, es posible crear un efecto "fadeIn/fadeOut" regulando su transparencia.

### Obj_fade: Create
```javascript
// Importante! Dejar este objeto como Persistent y depth grande
a = 0;    // En esta variable iremos guardando la transparencia
fade = 1; // Empezamos con transparencia al máximo: 1 = desaparecer, -1 = aparecer
```

### Obj_fade: Draw
```javascript
// En cada Draw vamos aumentando/decrementando un poco la transparencia
// Nos aseguramos que el valor esté siempre entre 0 y 1 con clamp()
a = clamp(a + (fade * 0.05),0,1);

// Si no hay transparencia, entonces nos movemos de room  
if (a == 1)
{
    room_goto_next();
    // Cambiamos fade a negativo para indicar que se "ha de aparecer"
    fade = -1;
}

// Si estamos en modo aparecer y la transparencia está al mínimo, hemos acabado
if (a == 0) && (fade == -1)
{
    instance_destroy(); // Destruimos el objeto
}

// Después de las comprobaciones creamos un rectangulo negro que ocupe toda la view
// Y le damos la transparencia variable que tenemos almacenada en a
draw_set_color(c_black);
draw_set_alpha(a);
draw_rectangle(
    view_xview[0], 
    view_yview[0], 
    view_xview[0] + view_wview[0],
    view_yview[0] + view_hview[0],
    0
);

// Importante desactivar la transparencia de nuevo
draw_set_alpha(1);
```