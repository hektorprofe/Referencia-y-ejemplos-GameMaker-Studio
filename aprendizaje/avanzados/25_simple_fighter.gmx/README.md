# Simple Fighter

Después de mucho buscar como plantear el desarrollo de un juego de lucha tipos street fighter he dado con el tutorial de [Jamjam](http://jamjamtutorials.blogspot.ca/2012/08/making-your-first-2d-fighter.html). Realmente no tiene desperdicio, así que utilizándolo como base voy a intentar crear mi propia implementación de un juego de lucha, just for fun :)

### Creando un background animado

Empezaré con un background que he conseguido formado por 24 imágenes [aquí](http://twistedsifter.com/2013/05/animated-gifs-of-fighting-game-backgrounds/), con un tamaño de 800x336. Para crear la animación tengo la idea de 24 backgrounds, uno para cada animación y luego cambiar con una alarma el fondo cada pocas fracciones de segundo para recrear el efecto. 

Una vez tengo los backgrounds preparados creo el objeto para controlar la animación del escenario, obj_scenario_1 (de acuerdo con mi primer escenario):

```javascript
///obj_scenario_1: Create

frame[1]=G440000;
frame[2]=G440001;
frame[3]=G440002;
frame[4]=G440003;
frame[5]=G440004;
frame[6]=G440005;
frame[7]=G440006;
frame[8]=G440007;
frame[9]=G440008;
frame[10]=G440009;
frame[11]=G440010;
frame[12]=G440011;
frame[13]=G440012;
frame[14]=G440013;
frame[15]=G440014;
frame[16]=G440015;
frame[17]=G440016;
frame[18]=G440017;
frame[19]=G440018;
frame[20]=G440019;
frame[21]=G440020;
frame[22]=G440021;
frame[23]=G440022;
frame[24]=G440023;

current_frame=1;

alarm[0]=room_speed/7;
```

La alarma irá recorriendo el arreglo y otorgando el nuevo background, sépase que G44GEN es una copia de G440000 sobre la que iré substituyendo el fondo:

```javascript
///obj_scenario_1: Alarm 0
current_frame+=1;
if (current_frame==24) current_frame = 1;
background_assign(G44GEN,frame[current_frame]);
alarm[0]=room_speed/7;
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/img1.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/img1.png)

### Creando animaciones de ataque

### Creando script de dibujo del jugador

### Creando script de movimiento del jugador

### Creando script de fricción del jugador

### Añadir físicas de movimiento y cambiar el sprite en movimiento

### Cambiar el sprite en movimiento

### Crear los hitboxes para los ataques

### Importar el script que detecta colisiones entre sprites
I remember having this problem. It's due to an error in the way the original author of CollisionPointIDs made his script. Go to "resources" --> "global game settings" --> Errors and UNcheck "throw an error when arguments aren't initialised correctly." .... EN GMS: poner noone en los argumentos y au.

### Añadir la animación de golpeado + change_sprite

### Crear el objeto obj_attackbox y modificar script scr_drawattack para crear el ostiazo xD (añadir nuevo argumento con el sprite del puño/patada)

### Crear el objeto obj_attackbox

### Añadir las colisiones en p1 y p2 contra obj_attackbox

### Añadir al P2 un step y el script de cambiar el sprite

### Arreglar la animacion infinita al atacar al enemigo en scr_change_sprite
if sprite_index == spr_ryu_hit{
     {if image_index >= image_number -1
            {action = false; damaged = false}}}

### Arreglar ostiazos
Es por darle la vuelta al objeto con xscale... hay que hacer lo mismo al crear el objeto de los ostiazos.
// En scr_drawattack
// Get current xscale and set it to the attack 
atkbox.image_xscale = image_xscale;

### Corrección de Y para evitar distorsion de sprite
/// Fix Y position
y = floor(y);

### Cambiar xscale dependiendo del movimiento en drawplayer
if hspeed > 0 image_xscale = -1;
else if hspeed < 0  image_xscale = 1;

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/img10.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/img10.png)

### Añadir las variables de suelo en los jugadores, tecla de saltar en move, el script de gravedad y añadirlo al end step de los jugadores.

### Añadir animación de salto y modificar scr_change_sprite para mostrarla cuando no está tocando el suelo

### Añadir efectos especiales en ataques, importar sprites y crear el objeto obj_specialeffect con un animation end -> instance_delete

### Crear un obj_specialeffect dentro de col_attackbox cuando CollisionPointIDs == true

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/anim1.gif))](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/anim1.gif)
