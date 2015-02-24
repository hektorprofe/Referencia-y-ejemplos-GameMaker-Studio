### Infinite Runner Horizontal

Juego creado siguiendo el videotutorial [RunBro](https://www.youtube.com/watch?v=CxhECktrntg) de [yak moon](https://www.youtube.com/channel/UCtcZ5U_LIsYigzW7Eid0A7A).

Empezamos creando los sprite run, jump, fall y dead. Con el ancla en la parte inferior.

Creamos el objeto player , con run sprite por defecto. Añadimos los eventos Create y Step, dónde definimos la detección de teclas, las colisiones, el salto y las animaciones:

```javascript
// obj_Player: Create
grav=2;
hsp=0;
vsp=0;
grounded=0;
jumping=-20;
image_speed=.4;
```

```javascript
// obj_Player: Step
///Key detect
key_jump = keyboard_check_pressed(vk_up);


// Vertical collision
if place_meeting(x,y+vsp, obj_block)
{
    while (!place_meeting(x,y+sign(vsp), obj_block)) y+=sign(vsp);
    if (sign(vsp) == 1)
    {   
        grounded = 1;
    }
    vsp = 0;
} 
else
{
    grounded = 0;
}
y += vsp;


// Horizontal collision
if place_meeting(x+hsp,y,obj_block)
{
    while (!place_meeting(x+sign(hsp), y, obj_block)) x+=sign(hsp);
    hsp = -10;
    sprite_index = sp_dead
}
x += hsp;

// Gravedad
vsp += grav;

// Salto
if (key_jump) && (grounded)
vsp = jumping;

// Animación
if sprite_index != sp_dead // si no estamos muertos
{
    if grounded sprite_index = sp_run // y tocamos el suelo corremos
    else // si estamos en el aire
    {
        if vsp < 0 sprite_index = sp_jump // si la velocidad vertical es menor a 0 saltamos
        else sprite_index = sp_fall // si es mayor que 0 estamos cayendo
    }
}
    
if (obj_Player.x < -50) game_restart();
```

Creamos el objeto block utilizando los 4 posibles sprites ground, con los evenos create y step y el script spd:
```javascript
// obj_Block: Create
randomize();
image_speed = 0;
image_index = irandom(3);
```

```javascript
// obj_Block: Step
spd();
if x<-1400 instance_destroy();
```

```javascript
// spd()
x+=global.mov
```

Creamos los objetos box y hp (cajas y escaleras), con sus respectivos sprites y los eventos create, step (vacío), end step y draw. Ambos son hijos de block.

```javascript
// obj_Box: Create
Y=y-sprite_height;
sprite_index = -1;
```

```javascript
// obj_Box: Step
/// nothing
```

```javascript
// obj_Box: End Step
spd();
if x<-100 instance_destroy();
if object_exists(obj_Player)
{
    // hablitamos la máscara de colisión sólo cuando el player esté por encima (para no chocar)
    if Y<obj_Player.y mask_index = -1
    else mask_index = sp_box
}
```

```javascript
// obj_Box: Draw
draw_sprite(sp_box,0,x,y);
```

```javascript
// obj_Hp: Create
Y=y-sprite_height
sprite_index = -1
```

```javascript
// obj_Hp: Step
/// nothing
```

```javascript
// obj_Hp: End Step
spd()
if x<-300 instance_destroy();
if object_exists(obj_Player)
{
    if Y<obj_Player.y mask_index = -1
    else mask_index = sp_hp
}
```

```javascript
// obj_Hp: Draw
draw_sprite(sp_hp,0,x,y);
```

Creamos el generador de plataformas obj_generator con un evento create y un alarm[0], en ambos llamamos el script scr0:

```javascript
// scr0()
alarm[0] = 140;
global.mov=-10;
instance_create(room_width, 336, obj_block);
script_execute(choose(co_1, co_2, co_3), irandom(1));
```
Creamos los objetos coin y coin5 (éste último nos servirá para poner las monedas flotando sobre una plataforma que no es el suelo). Son prácticamente iguales menos una diferencia que no comprobará si debajo hay suelo. Añadiremos una colisión con Player que destruirá la moneda y sumará uno en el marcador.

```javascript
// obj_coin: Step
spd();
if x<-64 or place_empty(x,y+36) instance_destroy();
```

```javascript
// obj_coin_5: Step
spd();
if x<-64 instance_destroy();
```

```javascript
// obj_coin & obj_coin_5: Player Collision
global.current_score+=1;
instance_destroy();
```

A continuación creamos los 3 posibles scripts para generar monedas:

```javascript
// co_1()
position = 5;

for (var i=0;i<15;i++)
{
    instance_create(room_width+(position*32), 336, obj_coin);
    position+=2;
}
```

```javascript
// co_2()
n=336;
instance_create( room_width + (4*32), n-96, obj_coin_5 );
instance_create( room_width + (5*32), n-96, obj_coin_5 );

instance_create( room_width + (7*32), n, obj_coin );

instance_create( room_width + (9*32), n-(5*32), obj_coin_5 );
instance_create( room_width + (10*32), n-(5*32), obj_coin_5 );
instance_create( room_width + (11*32), n-(5*32), obj_coin_5 );
instance_create( room_width + (12*32), n-(5*32), obj_coin_5 );
instance_create( room_width + (13*32), n-(5*32), obj_coin_5 );
instance_create( room_width + (14*32), n-(5*32), obj_coin_5 );
instance_create( room_width + (15*32), n-(5*32), obj_coin_5 );

instance_create( room_width + (17*32), n, obj_coin);
instance_create( room_width + (19*32), n, obj_coin);
instance_create( room_width + (21*32), n, obj_coin);
instance_create( room_width + (23*32), n, obj_coin);
instance_create( room_width + (25*32), n, obj_coin);
instance_create( room_width + (27*32), n, obj_coin);
instance_create( room_width + (29*32), n, obj_coin);
instance_create( room_width + (31*32), n, obj_coin);
instance_create( room_width + (33*32), n, obj_coin);

instance_create( room_width + (7*32), n, obj_hp);
instance_create( room_width + (3*32), n, obj_box);
```

```javascript
// co_3()
n = 336
o = 318

position = 5;
for (var i=0;i<15;i++)
{
    instance_create(room_width+(position * 32), n, obj_coin);
    position+=2;
}

position = 6;
for (var i=0;i<14;i++)
{
    instance_create(room_width+(position * 32), o, obj_coin);
    position+=2;
}
```

Creamos una room, establecemos dos fondos b0 y b1 con un movimiento tal como se indica en las imágenes y les creamos instancias de Player, generador y un bloque ground inicial con el creation code:

```javascript
image_index = 0
image_speed = 0
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/03_infinite_runner_horizontal.gmx/captura2.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/03_infinite_runner_horizontal.gmx/captura2.jpg)

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/03_infinite_runner_horizontal.gmx/captura3.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/03_infinite_runner_horizontal.gmx/captura3.jpg)

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/03_infinite_runner_horizontal.gmx/captura1.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/03_infinite_runner_horizontal.gmx/captura1.jpg)

Añadimos un evento en el generador para reiniciar el juego si se apreta la tecla R.

A continuación creamos un objeto score con los eventos create, draw y step:

```javascript
// obj_score: Create
global.current_score = 0
a=0
b=0
```

```javascript
// obj_score: Step

// Distancia que corre el jugador
if obj_Player.hsp == 0
{
    // Se incrementa cada 10 step
    a++;
    a%=10;
    if a==9 b+=1; 
}
```

```javascript
// obj_score: Draw
draw_self();

draw_set_font(font0);
draw_set_valign(fa_center);
draw_set_halign(fa_left);

// shadow effect
draw_text_color(x+58, y+20, string(global.current_score) + "   coins" , c_gray, c_gray, c_gray, c_gray, 1);
draw_text_color(x+59, y+21, string(global.current_score) + "   coins" , c_white, c_white, c_white, c_white, 1);

draw_text_color(x+58, y+40, string(b) + "   meters" , c_gray, c_gray, c_gray, c_gray, 1);
draw_text_color(x+59, y+41, string(b) + "   meters" , c_white, c_white, c_white, c_white, 1);
```

Y finalmente añadimos el marcador en la room en la parte superior derecha de la view.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/03_infinite_runner_horizontal.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/03_infinite_runner_horizontal.gmx/captura.jpg)