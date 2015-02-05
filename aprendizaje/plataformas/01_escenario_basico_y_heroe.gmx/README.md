## Escenario básico y héroe
### Elementos básicos
* Escenario (room)
* Paredes (wall object)
* Héroe (hero object)

### Variables iniciales del héroe
* grav: gravedad
* hsp: velocidad horizontal
* vsp: velocidad vertical
* movespeed: velocidad de movimiento
* jumpspeed: velocidad de salto


### Eventos de movimiento del héroe
```javascript
key_right = keyboard_check(vk_right);     //  0 o 1
key_left = -keyboard_check(vk_left);      // -1 o 0
key_jump = keyboard_check_pressed(vk_up); //  0 o 1
```

### Establecemos los cambios de movimiento
```javascript
move = key_left + key_right; // será -1, 0 o 1
hsp = move * movespeed;		 // será -movespeed o +movespeed
if (vsp < 10) vsp += grav;   // máximo será 10
```

### Detección del salto
```javascript
// si hay colisión con pared 1 pixel debajo del heroe
if (place_meeting(x,y+1,obj_wall))
{
	// establecemos una velocidad vertical en función de key_jump
    vsp = key_jump * -jumpspeed; // será 0 si no hay salto o un
    							 // valor negativo (salto hacia arriba)
}
```

### Colisión horizontal y rectificación
```javascript
// si hay una pared en la dirección que nos movemos en la distancia hsp
if (place_meeting(x+hsp,y,obj_wall))
{
    // rectificaremos la posición del héroe para quedarnos pegados a ella
    // la función sign(número) devuelve el signo de un número: -1, 0 o 1
    while(!place_meeting(x+sign(hsp),y,obj_wall))
    {
        x += sign(hsp);
    }
    hsp = 0; // y establecemos a 0 la velocidad de movimiento horizontal
}
```


### Colisión vertical y rectificación
```javascript
if (place_meeting(x,y+vsp,obj_wall))
{
    while(!place_meeting(x+sign(hsp),y,obj_wall))
    {
    	y += sign(vsp);
    } 
    vsp = 0;
}
```

### Movimiento final del objeto héroe
```javascript
x += hsp;
y += vsp;
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/01_escenario_basico_y_heroe.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/01_escenario_basico_y_heroe.gmx/captura.jpg)