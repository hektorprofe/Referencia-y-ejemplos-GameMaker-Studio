### Transición usando superficies

Ejemplo creado siguiendo el videotutorial de [ElHacerDeJuegos](https://www.youtube.com/watch?v=0Sf-j3ngci8).

Empezamos creando un objeto transition para manejar la transición entre rooms. Debe tener una profundidad bastante baja y ser persistente.

```javascript
/// Obj_transition(): Create

// Estados
FadeOut = 0;
FadeIn = 1;
ChangeRoom = 2;

TargetRoom = -1;
State = FadeOut;

// Prevenimos que exista más de una instancia de este objeto
if ( instance_number(self) <= 1)
{
    alpha_level = 0;
    alpha_increment = 0.03;

    // Tomamos una captura del juego    
    screenshot = surface_create(view_wport + view_xview[0],
                                view_hport + view_yview[0]);
    
    // Renderizamos la superficie con la captura
    surface_set_target(screenshot);
    
    // Borramos el contenido de la superficie, por si acaso
    draw_clear_alpha(c_black, 0); 
    
    // Para todos los objetos del juego
    with(all)
    {
        // que sean visibles
        if (visible)
            // los dibujamos en la superficie (asi creamos realmente la captura)
            event_perform(ev_draw, 0);
    }
    
    // Reactivamos la superficie general de game maker
    surface_reset_target();
    
    // Desactivamos todas las instancias
    instance_deactivate_all(true);
    
}
else instance_destroy();
```

```javascript
/// Obj_transition(): Step

// Qué hacer en cada estado
switch(State)
{
    case FadeOut:
        // Transición de salida, incrementamos la opacidad del rectangulo oscuro
        alpha_level += alpha_increment;
        // hasta el máximo y cambiamos el estado
        if (alpha_level >=1) State = ChangeRoom;
        break;
    
    case ChangeRoom:
        // Cambio a la siguiente room
        room_goto(TargetRoom);
    
        // Activamos todas las instancias
        instance_activate_all();
        
        // Renderizamos la superficie con la captura
        surface_set_target(screenshot);
        
        // Borramos el contenido de la superficie, por si acaso
        draw_clear_alpha(c_black, 0);
        
        // Para todos los objetos del juego
        with(all)
        {
            // que sean visibles
            if (visible)
                // los dibujamos en la superficie (asi creamos realmente la captura)
                event_perform(ev_draw, 0);
        }
        
        // Reactivamos la superficie general de game maker
        surface_reset_target();
        
        // Desactivamos todas las instancias
        instance_deactivate_all(true);
        
        // Cambiamos al último estado
        State = FadeIn;
        break;
    
    case FadeIn:
        // Transición de entrada, decrementamos la opacidad del rectangulo oscuro
        alpha_level -= alpha_increment;
        // hasta el mínimo y destruimos el objeto transition
        if (alpha_level <= 0)
        {
            instance_activate_all();
            instance_destroy();
        }
        break;

}
```

```javascript
/// Obj_transition(): Draw

// Dibujamos la superficie y le damos la transparencia
draw_set_alpha(1);
draw_surface(screenshot, 0, 0);
draw_set_alpha(alpha_level);
draw_set_color(c_black);
// Y encima le dibujamos el rectángulo negro que ocupa toda la room
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1);
```

Para ponerlo a prueba podemos crear un objeto que capture un clic en la pantalla para crear la transición. Necesitaremos dos rooms con un objeto change_room.

```javascript
/// Obj_changeRoom(): Left Button
tran = instance_create(0,0,obj_transition);
tran.TargetRoom = TargetRoom;
```

En cada objeto de éstos al crearlos podemos añadie el código el siguiente código de creación para establecer la siguiente room.

```javascript
TargetRoom = rm_2; // O la room que sea el destino
```

Finalmente añadimos un sencillo sprite en cada room para apreciar mejor el efecto. Es MUY importante dibujar el objeto manualmente o éste desaparecerá, ya que estamos llamando a su Draw desde el objeto transition.

```javascript
/// Obj_box(): Create
// Le damos una velocidad inicial
hspeed = 2;
```

```javascript
/// Obj_box(): Draw
// Es muy importante este draw, sinó desaparecerá al empezar la transicion
draw_self(); 
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/19_transicion_con_superficies.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/19_transicion_con_superficies.gmx/captura.jpg)