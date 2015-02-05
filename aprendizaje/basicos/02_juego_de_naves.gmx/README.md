## Juego de naves
### Detección de teclas con GML
* if(keyboard_check(vk_clave)) { // si es verdadero }
* [Listado de claves para las teclas](http://docs.yoyogames.com/source/dadiospice/002_reference/mouse,%20keyboard%20and%20other%20controls/keyboard%20input/)
```javascript
if(keyboard_check(vk_left)) hspeed -= 2;
if(keyboard_check(vk_right)) hspeed += 2;
if(keyboard_check(vk_up)) vspeed -= 2;
if(keyboard_check(vk_down)) vspeed += 2;
```

### Rectificación de velocidad máxima
```javascript
if (speed > 6)  speed = 6;
```

### Rectificación de posición si sale de la room
```javascript
x = min(x,room_width-16);
x = max(x, 16);
y = min(y,room_height-16);
y = max(y, 16);
```

### Crear ráfagas de disparos con 3 balas
```javascript
b1 = instance_create(x,y-16,obj_bullet);
b2 = instance_create(x,y-16,obj_bullet);
b3 = instance_create(x,y-16,obj_bullet);

// Modificamos la dirección de algunas balas
// Por defecto le dimos dirección arriba
b2.direction = 100;
b3.direction = 80;
```

### Detección de colisiones contra enemigos
```javascript
// conseguimos la id del enemigo colisionado 
enemy = instance_place(x,y,obj_enemy); 
if (enemy!= noone) // si hay una colisión
{
    instance_destroy(); // destruimos el enemigo
}
```

### Evitar spameo de ráfagas

Introducimos el código de la ráfaga en una alarma.

```javascript
// Llamamos la alarma cada 5 fps
if(alarm[0] = -1) alarm[0] = 5;
```


### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/02_juego_de_naves.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/02_juego_de_naves.gmx/captura.jpg)