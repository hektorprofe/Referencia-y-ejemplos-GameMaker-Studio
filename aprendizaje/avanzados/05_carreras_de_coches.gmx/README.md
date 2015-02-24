### Juego de carreras vertical simple

Juego creado siguiendo el videotutorial [Race Car](https://www.youtube.com/playlist?list=PLKLQDZRSzF23cvfI9BCexZxItLtk7hJ8x) de [yak moon](https://www.youtube.com/channel/UCtcZ5U_LIsYigzW7Eid0A7A).

Este juego es muy sencillo. Consiste en un background, diferentes sprites de coches y un sprite de meta.

El background tiene una velocidad vertical de 18 pixeles por step en la room, generando todo el efecto de movimiento.

Luego tenemos los objetos player y enemy que dibujan los coches moviéndose a una velocidad vertical constante de 4. Cuando se mueven se les cambia el ángulo para generar el efecto de giro.

El player puede moverse a los lados para evitar los coches enemigos que iran saliendo cada cierto tiempo (una alarma) en una posición aleatoria del camino sin salirse de los límites.

Cuando el jugador choca contra un enemigo se para el juego. Si pasan 10 segundos y no ha habido choque una alarma se encargará de generar una instancia del objeto finish que dibujará la meta en el suelo.

obj_player:

```javascript
// Create
global.allow = 1  // si el juego está en marcha
global.bg = 18;  // velocidad del fondo
sp = 4;  // velocidad constante del coche
carspeed = 0  // velocidad actual del coche
```

```javascript
// Step
if global.allow == 1
{
    // movimientos
    leftkey = keyboard_check_pressed(vk_left);
    rightkey = keyboard_check_pressed(vk_right);
    releaseleft = keyboard_check_released(vk_left)  
    releaseright = keyboard_check_released(vk_right)    
    
    if leftkey
    {
        hspeed = -4;
        image_angle = 5;
    }
    if rightkey
    {
        hspeed = 4;
        image_angle = -5;
    }
    if leftkey && rightkey
    {
        hspeed = 0;
        image_angle = 0;
    }
    if releaseleft || releaseright
    {
        hspeed = 0;
        image_angle = 0;
    }

    // Colisiones
    
    if place_meeting(x,y,obj_enemy)
    {
        game_restart(); // si chocamos reiniciamos el juego
        /* global.allow = 0;
        with (obj_enemy)
        {
            hspeed = 0;
            carspeed = 0;
        }
        background_vspeed[0] = 0;
        hspeed = 0; */
        
    }

}
```

obj_enemy:

```javascript
// Create
carspeed = random_range(6,12); // generamos una velocidad aleatoria
carsprite = choose(sp_1, sp_2, sp_3); // escogemos un sprite aleatorio de coche
horspeed = choose(2,0,3,0,-2,0,-3); // le damos una velocidad horizontal aleatoria
sprite_index = carsprite; // le asignamos el sprite aleatorio
```

```javascript
// Step
if global.allow == 1
{ 
    y+= carspeed;
    hspeed = horspeed;
    
    if hspeed == 0
    {
        image_angle = 0;
    }
    if hspeed > 0
    {
        image_angle = -3;
    }
    if hspeed < 0
    {
        image_angle = 3;
    }
    
    if y > 550 instance_destroy();
    
    if x < 130 x = 130;
    if x > 385 x = 385;
    
    // Colisión
    if place_meeting(x+40, y+100, obj_enemy)
    {
        hspeed = 0;
        with(other) carspeed = 4;
    }
    
    if place_meeting(x-40, y+100, obj_enemy)
    {
        hspeed = 0;
        with(other) carspeed = 4;
    }

}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/05_carreras_de_coches.gmx/captura1.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/05_carreras_de_coches.gmx/captura1.jpg)

El obj_generador nos permitirá añadir nuevos enemigos cada cierto tiempo.

```javascript
// Create
if global.allow == 1
{
    alarm[0] = 100;
}
```

```javascript
// Alarm 0
a = random_range(130, 385); // Generamos una posición aleatoria horizontal
b = random_range(25, 150);  // Generamos un timeout aleatorio

if global.allow == 1
{
    alarm[0] = b;
    instance_create(a, -150, obj_enemy); // creamos el auto enemigo
}
```

Para dibujar la meta utilizaremos dos objetos, el que dibujará el sprite obj_finish y el que contendrá el timeout y creará la meta a los 10 segundos.

obj_finish // el del sprite

```javascript
// Create
vspeed = global.bg;
stop = 0;
```

```javascript
// Step
if place_meeting(x,y,obj_player) stop = 1; // al chocar el jugador paramos el juego
if stop == 1
{
    global.allow = 0;    
    background_vspeed[0] = 0;
    vspeed = 0
    // tanto el jugador como los enemigos seguirán constantes hasta salirse de la room
    with (obj_player)
    {
        vspeed = -global.bg;
        image_angle = 0;
        
    }
    with (obj_enemy)
    {
        vspeed = -global.bg;
        image_angle = 0;
        
    }
}
```

obj_finish // el del timeout

```javascript
// Create
alarm[0] = 300;
```

```javascript
// Alarm 0
if global.allow == 1
{
    // creamos el objeto con la meta
    instance_create(room_width/2, -200, obj_finish);
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/05_carreras_de_coches.gmx/captura2.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/05_carreras_de_coches.gmx/captura2.jpg)