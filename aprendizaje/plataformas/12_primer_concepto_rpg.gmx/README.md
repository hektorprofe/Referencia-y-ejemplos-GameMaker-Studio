## Primer concepto de RPG

El ejemplo original en inglés se puede encontrar en [Youtube](https://www.youtube.com/watch?v=FqYS-4_oSRw) y fue creado por el usuario [Heartbeast](https://www.youtube.com/channel/UCrHQNOyU1q6BFEfkNq2CYMA). 

### Parte 1: Terreno 2D y personaje

Utilizando una pequeña técnica de perspectiva se puede crear un efecto de superposición con un rectángulo de dos colores, añadiendo el punto de anclaje vertical en medio (0,24) para sprite (32,48) y la máscara de colisión sólo al rectángulo inferior.

Luego utilizando un Script se establece automáticamente la profundidad de las paredes dándoles más a aquellas que estan más arriba en la room:

```javascript
{
	/// scr_find_depth()
    // Cuanto más arriba más atrás
    depth = y*-1;   
}
```

Este script se llama en el create de las paredes y en cada Step del jugador para ponerlo en todo momento al mismo nivel que las paredes. Evidentemente la máscara de colisión y el anclaje vertical también es el mismo que las paredes.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/12_primer_concepto_rpg.gmx/captura.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/12_primer_concepto_rpg.gmx/captura.png)

### Parte 2: Estadísticas de personaje

En todo RPG nuestro personaje tiene una serie de variables tales como el nivel, la experiencia, la vida, los puntos de ataque, etc. Vamos a comenzar creando un objeto para manejar todas las variables de personaje:

```javascript
/// Obj globals: Create
{
    global.level = 1;
    global.hp = 10;
    global.maxhp = 10;
    global.expr = 0;
    global.maxexpr = 2;
}
```

Para probar estad estadísticas vamos a crear un objeto llamado experiencia (una bolita) que al colisionar con el personaje le otorgarán un punto de experiencia:

```javascript
/// Obj player: Collision with obj_expr
{
    global.expr++;
    with(other) instance_destroy();
}
```

A continuación manejaremos la experiencia del personaje para hacer que suba de nivel cuando se alcance la experiencia necesaria, aumentando la vida y otorgando un nuevo valor a la experiencia necesaria para alcanzar el próximo nivel:

```javascript
/// Obj globals: Step
{
    if(global.expr >= global.maxexpr)
    {
        global.level+=1;
        global.hp+=5;
        global.maxhp+=5;
        // La experiencia actual será la resta de la experiencia actual del nivel menos la experiencia actual
        global.expr = global.expr-global.maxexpr;
        // La experiencia máxima para alcanzar el próximo nivel pasará a ser el doble que la del nivel actual
        global.maxexpr *= 2;
    }   
}
```

### Parte 3: Enemigos con IA

Empezaremos duplicando el sprite del jugador para crear uno de enemigo. A continuación crearemos el objeto enemy y le añadiremos el sprite.

Para cada Step comprobaremos la profunidad con nuestro script y además llamaremos a un nuevo script llamado scr_ai que manejará el movimiento del enemigo. Éste solo se moverá hacia el jugador cuando no haya una pared en medio y haya un mínimo de distancia. Además añadiremos una comprobación en las colisiones con la pared, el jugador y otros enemigos para añadir un efecto de rebote y disminuir la velocidad.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/12_primer_concepto_rpg.gmx/captura2-5.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/12_primer_concepto_rpg.gmx/captura2-5.png)

```javascript
/// scr_ai()
{
    if ( instance_exists(obj_player) )
    {
        // Si no hay una pared y el jugador está a menos de 256px
        if (distance_to_point(obj_player.x,obj_player.y) <= 256 && !collision_line(x,y,obj_player.x,obj_player.y,obj_wall,false,true))
        {
            // Eliminamos la fricción y añadimos 1 de speed hacia la dirección del jugador
            friction = 0;
            motion_add( point_direction(x,y,obj_player.x,obj_player.y), 1 );
            if(speed>=4) speed = 4;
        } 
        // Si hay una pared paramos el movimiento
        else
        {
            friction = 1;
        }
    }
}
```

```javascript
/// Obj Enemy: Collision Wall/Enemy/Player
{
    // Activamos el rebote
    move_bounce_all(true);
    // Decrementamos la velocidad
    if(speed > 2) speed = speed/2;
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/12_primer_concepto_rpg.gmx/captura3.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/12_primer_concepto_rpg.gmx/captura3.png)

### Parte 4: Animación básica del personaje

Primero dibujamos un par de sprites, uno cuando el personaje está parado y otro en movimiento. Al que está en movimiento le añadimos varias imágenes consecutivas creando el efecto deseado.

Para añadir la animación fácilmente añadiremos el código que cambiará de sprite y la velocidad de la animación en el mismo momento que movemos al jugador:

```javascript
/// Obj player: Step
{
    // movemos a la derecha si podemos hacerlo
    if (keyboard_check(vk_right) && place_free(x+4,y))
    {
        x+=4;
        sprite_index = spr_player_run;
        image_speed = .2;
        image_xscale = 1;
    }
    // movemos a la izquierda si podemos hacerlo
    if (keyboard_check(vk_left) && place_free(x-4,y))
    {
        x-=4;
        sprite_index = spr_player_run;
        image_speed = .2;
        image_xscale = -1;
    }
    // movemos a la izquierda si podemos hacerlo
    if (keyboard_check(vk_up) && place_free(x,y-4))
    {
        y-=4;
        sprite_index = spr_player_run;
        image_speed = .2;
    }
    // movemos a la izquierda si podemos hacerlo
    if (keyboard_check(vk_down) && place_free(x,y+4))
    {
        y+=4;
        sprite_index = spr_player_run;
        image_speed = .2;
    }
    
    // 
    if (!keyboard_check(vk_right) && !keyboard_check(vk_left)&& 
        !keyboard_check(vk_up)&& !keyboard_check(vk_down))
    {
        image_speed = 0;
        sprite_index = spr_player_stand;
    }   
    
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/12_primer_concepto_rpg.gmx/captura4.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/12_primer_concepto_rpg.gmx/captura4.png)