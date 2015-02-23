### Infinite Runner Vertical

Juego creado siguiendo el videotutorial [Shy Copter](https://www.youtube.com/playlist?list=PLKLQDZRSzF21jsQf5svQJoGHz3V2RTiz8) de [yak moon](https://www.youtube.com/channel/UCtcZ5U_LIsYigzW7Eid0A7A).

Empezamos creando los 4 sprites del jugador, las plataformas, el terreno, el martillo, la moneda y el fondo y sus respectivos objetos.

Creamos el objeto solid y lo hacemos padre de los objetos left, right y hummer, por ahora sólo les configuramos el sprite. En una nueva room añadimos el fondo, el terreno y el jugador.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_infinite_runner_vertical.gmx/captura1.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_infinite_runner_vertical.gmx/captura1.jpg)

Creamos un script que moverá el objeto actual verticalmente y lo borrará si se sale de la room:

scr0():
```javascript
y+=global.spd
if y > 1000 instance_destroy();
```

Configuramos los eventos de obj_player:

```javascript
// Create
spd = 18 // velocidad máxima
face = 2 // lado al que nos movemos 2 = ninguno
sp = 0   // aceleración
bsp = 0  // velocidad del fondo

global.allow = 0 // cuando es 1 el juego empieza a moverse verticalmente
global.spd = 10; // velocidad global

image_speed = 0  // la animación inicial está parada
```

```javascript
// Step
// Velocidad horizontal
hspeed = sp

// velocidad del fondo
if face < 2 bsp+=.3;
if bsp>8 bsp = 9;
background_vspeed[1]=bsp;

// Dirección izquierda
if face == 1 
{
    image_xscale = 1  // damos la vuelta al sprite
    image_angle++;    // incrementamos el ángulo
    sp-=2             // aceleramos a la izquierda
}

// Dirección derecha
if face == -1
{
    image_xscale = -1 // damos la vuelta al sprite
    image_angle--;    // incrementamos el ángulo
    sp+=2             // aceleramos a la derecha
}

// Rectificamos las velocidades
if sp > spd sp = spd;
if sp < -spd sp = -spd;

// Rectificamos los ángulos
if image_angle > 10 image_angle = 10
if image_angle < -10 image_angle = -10


// Cuando el jugador se sale de la pantalla
if x<20 or x>550
{
    instance_create(x,y,obj_explode);
    instance_destroy();
}
```

```javascript
// Global Left Button
if face>1 // empezamos a generar los elementos
{
    global.allow = 1;
    instance_create(0,0,obj_generator); // creamos un generador
    face = -1;        // empezamos a movernos hacia la izquierda
    image_speed = 1;  // activamos la animación
}
```

```javascript
// Global Left Pressed

face *= -1; // Cambiamos la dirección de player
```

```javascript
// Colisión con Solid
instance_destroy();
instance_create(x,y,obj_explode); // al chocar creamos una animación de explosión
```

Creamos el obj_generator que irá generando los obstáculos.

```javascript
// Create
alarm[0] = 50
```

```javascript
// Alarm 0
alarm[0] = 50;
p = choose(64,512); // posición de la moneda
instance_create(p, -400, obj_coin)

h = choose(170, 190, 210, 230, 250, 270, 290, 310, 330, 350, 370, 390, 410); // posición de los otros elementos

// posicion de las plataformas
instance_create(h-140, -150, obj_left);
instance_create(h+140, -150, obj_right);

// primer martillo
instance_create(h-160, -150, obj_hummer);
// segundo martillo
instance_create(h+160, -150, obj_hummer);

// marcador arriba (al colisionar contra este objeto se incrementará un punto)
instance_create(h, -200, obj_scoreup);
```

El obj_coin tendrá un evento step que ejecutará el código scr0 y una colisión con player que sumará una moneda al marcador y eliminará el objeto:

```javascript
// Colisión con Player
instance_destroy();
global.gold+=1;
```

El obj_scoreup será invisible y saldrá justo entre el espacio superior de las dos plataformas de manera que al chocar contaremos un punto al jugador por haber pasado un obstáculo. Tendrá el mismo scr0 en Step y en la colisión sumará 1 punto al marcador antes de borrarlo:

```javascript
// Colisión con Player
global.current_score += 1;
instance_destroy();
```

El obj_ground con el terreno de fondo tendrá el siguiente código:

```javascript
// Create
x=room_width/2;
y=room_height-233;
```

```javascript
// Step
if global.allow == 1 scr0(); // si el juego empieza se moverá verticalmente
```

Ahora crearemos un obj_score que manejará el marcador de puntos y monedas y los mostrará en medio de la pantalla:

```javascript
// Create
global.current_score = 0;
global.gold = 0;
```

```javascript
// Draw

// Marcador de puntos
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_font(font0);
draw_set_color(c_black);
draw_text((room_width/2)+2, 202, string(global.current_score));
draw_set_color(c_white);
draw_text(room_width/2, 200, string(global.current_score));

// Marcador de monedas
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_font(font0);
draw_set_color(c_black);
draw_text((room_width/2)+2, 102, string(global.gold));
draw_set_color(c_yellow);
draw_text(room_width/2, 100, string(global.gold));
```

Nos falta los últimos retoques en el obj_hummer, el cual cambiará su rotación cuando el ángulo sea -45º o +45º y evidentemente se moverá junto con la sala:

```javascript
// Create
s = 1.5
```

```javascript
// Step
scr0();
// Rotación del martillo
image_angle += s;
if (image_angle > 44 ) s*=-1;
if (image_angle < -44 ) s*=-1;
```

Y por último el obj_explode que nos permitirá añadir la animación de explosión al chocar el jugador con un objeto solid (left, right o hummer):
```javascript
// Create
image_speed = 0.5;
```

```javascript
// Step
scr0();
```

```javascript
// Animation End
instance_destroy(); // borramos el objeto cuando se acabe la animación de explosión
```

Importante: Activar la detección precisa de colisión en el player y en hummer.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_infinite_runner_vertical.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_infinite_runner_vertical.gmx/captura.jpg)
