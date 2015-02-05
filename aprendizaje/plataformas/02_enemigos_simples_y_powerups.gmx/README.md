## Enemigos simples y powerups
### Elementos básicos
* Enemigo (enemy object)
* Powerup (powerup object)

### Variables iniciales del enemigo
* dir: dirección -1 izquierda, 1 derecha
* grav: gravedad
* hsp: velocidad horizontal
* vsp: velocidad vertical
* movespeed: velocidad de movimiento

### Movimiento del enemigo
```javascript
hsp = dir * movespeed;
vsp += grav;
```

### Colisión horizontal, rectificación y cambio de dirección
```javascript
if (place_meeting(x+hsp,y,obj_wall))
{
    // rectificación de la colisión
    while(!place_meeting(x+sign(hsp),y,obj_wall))
    {
        x += sign(hsp);
    }
    hsp = 0;
    
    // cambio de dirección si ha habido colisión
    dir *= -1;
}
```

### Colisión vertical y rectificación
```javascript
if (place_meeting(x,y+vsp,obj_wall))
{
    while(!place_meeting(x,y+sign(vsp),obj_wall))
    {
        y += sign(vsp);
    }
    vsp = 0;
}
```

### Detección de la colisión contra el héroe
```javascript
if(place_meeting(x,y,obj_hero))
{
    // si hay colisión y el héroe está por encima del enemigo
    if(obj_hero.y < y-16) 
    {
        with(obj_hero) vsp = -jumpspeed; // hacemos saltar al héroe 
        instance_destroy(); // borramos la instancia del enemigo
    }
    // si el héroe no está por encima, reiniciamos el juego
    else 
    {
        game_restart();
    }
}
```

### Finalmente movemos el enemigo
```javascript
x += hsp;
y += vsp;
```

## Para el powerup (poder de salto incrementado temporalmente) 
### Añadimos unas nuevas variables al héroe
```javascript
jumpspeed_normal = 5;
jumpspeed_powerup = 10;
jumpspeed = jumpspeed_normal;
```

### Creamos la colisión del powerup contra el héroe
```javascript
with(obj_hero)
{
    jumpspeed = jumpspeed_powerup;
    sprite_index = spr_hero_b; // podemos cambiar el sprite del heroe
    alarm[0] = 300; 
}
// borramos el objeto powerup
instance_destroy();
```

### Al rato la alarma cambia de nuevo el jumpspeed del héroe
```javascript
jumpspeed = jumpspeed_normal;
sprite_index = spr_hero; // y el sprite si es necesario
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/02_enemigos_simples_y_powerups.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/02_enemigos_simples_y_powerups.gmx/captura.jpg)