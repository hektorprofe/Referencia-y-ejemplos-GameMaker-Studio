## Efecto con superficies

Para estos ejemplo he utilizado como base el del usuario [nocturne](http://nocturnegames.webs.com/surfaceeffects.htm) llamado Surface Magnify and Reveal Effect.

Antes de empezar es importante remarcar que en ocasiones las superficies desaparecen y es necesario comprobar si existen antes de utilizarlas, por ello se añade el código de creación otra vez después de una comprobación en el propio Draw:

```javascript
// Si no existe la superficie la creamos (al cambiar a fullscreen desaparece)
if !surface_exists(global.surf)
{
    global.surf = surface_create(room_width,room_height);
    surface_set_target(global.surf);
    draw_clear_alpha(c_black,0);
    surface_reset_target();
}
```

### Efecto revelar fondo

Consiste en utilizar dos backgrounds diferentes. Primero se crea una nueva pequeña superficie. Se dibuja el fondo oculto justo en la posición del puntero en un espacio limitado (el que se va a revelar), se aplica la máscara de una elipse y se dibuja encima el sprite de la lupa:

```javascript
// Hacemos que la lupa se mueva con el ratón
x=mouse_x;
y=mouse_y;

// Establecemos la superficie de dibujo
surface_set_target(surf);
// Dibujamos el background de fondo, pero justo el trozo
// que ocupa el espacio del cuadrado de la lupa
draw_background(background0,-x+32,-y+32);
// Y sobre ese fondo le añadimos la máscara del sprite
draw_sprite(spr_Mask,0,32,32);

// Reiniciamos la superficie
surface_reset_target();

// Si el sprite existe lo borramos
if sprite_exists(spr) sprite_delete(spr);
// Creamos un sprite a partir de la superficie que hemos dibujado
spr=sprite_create_from_surface(surf,0,0,64,64,1,0,32,32);
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/17_efectos_revelar_fondo_y_zoom_con_superficies.gmx/captura.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/17_efectos_revelar_fondo_y_zoom_con_superficies.gmx/captura.png)

## Efecto zoom

Es prácticamente igual que el ejemplo anterior, pero en lugar de dibujar el background de fondo en la superficie, lo que se hace es escalar una segunda superficie y dibujar ese trozo escalado:

```javascript
// Hacemos que la lupa se mueva con el ratón
x=mouse_x;
y=mouse_y;

// Creamos otra superficie de dibujo
var t_surf;
t_surf=surface_create(64,64);

// Establecemos la superficie de dibujo
surface_set_target(surf);

// Dibujamos el background de fondo, pero justo el trozo
// que ocupa el espacio del cuadrado de la lupa
draw_background(background0,-x+32,-y+32);

// Ahora en la nueva superficie añadiremos el efecto zoom
surface_set_target(t_surf);
// Le añadimos un efecto de escalado 200%
draw_surface_ext(surf,-16,-16,2,2,0,c_white,1);
// Encima le añadimos la máscara (la redonda)
draw_sprite(spr_Mask,0,32,32);

// Si el sprite existe lo borramos
if sprite_exists(spr) sprite_delete(spr);

// Creamos un sprite a partir de la superficie que hemos dibujado
spr=sprite_create_from_surface(t_surf,0,0,64,64,1,0,32,32);
surface_free(t_surf);

// Reiniciamos la superficie de nuevo
surface_reset_target();
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/17_efectos_revelar_fondo_y_zoom_con_superficies.gmx/captura2.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/17_efectos_revelar_fondo_y_zoom_con_superficies.gmx/captura2.png)
