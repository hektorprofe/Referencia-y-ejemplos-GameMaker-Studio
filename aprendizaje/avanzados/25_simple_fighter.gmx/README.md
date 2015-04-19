# Simple Fighter

Después de mucho buscar como plantear el desarrollo de un juego de lucha tipos street fighter he dado con el tutorial de [2D Fighter de Jamjam](http://jamjamtutorials.blogspot.ca/2012/08/making-your-first-2d-fighter.html). Realmente no tiene desperdicio, así que utilizándolo como base voy a intentar crear mi propia implementación de un juego de lucha, just for fun (todos los sprites son propiedad de Capcom).

## Parte 1: Backgrounds y sprites

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

### Creando las animaciones

He creado varias animaciones para el personaje Ryu utilizando unos sprites que he encontrado en [Internet](http://www.deviantart.com/morelikethis/297399988):

* **Stand**: animación de pié en espera.
* **Walk**: animación caminando/corriendo.
* **Jump**: animación de salto.
* **Jab**: animación de puñetazo.
* **Knee**: animación de rodillazo.
* **High kick**: animación de patada alta.
* **Flying kick**: animación de patada voladora.
* **Hit**: animación al recibir un ataque.
* **Win**: animación al ganar un combate.
* **Defeat**: animación de derrota.

Todos tendrán el centro en medio y justo debajo de los pies.

### Creando script de ataque del jugador

Como tendremos muchos ataques vamos a organizar el código de una forma entendible. Para ello crearemos un script drawplayer que se encargará de dibujar el sprite en cada caso:

```javascript
draw_sprite_ext(sprite_index, image_index, x,y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
```

A parte del script para dibujar al jugador, por ahora vamos a crear otro script para dibujar el ataque llamado drawattack:

```javascript
var key, spr_base, spr_atk;
key = argument0
spr_base = argument1
spr_atk = argument2

// si no estamos atacando y se presiona un ataque
// cambiamos al sprite de ataque
if keyboard_check_pressed(key) and !action
    {if sprite_index != spr_atk
        {image_index = 0; //establecemos el inicio de la animación
        sprite_index = spr_atk; 
        action = true}
    }
    
// luego comprobaremos que la animación se ha ejecutado del todo
// a partir de la subimage actual y el número total de subimages
// y si ha acabado volveremos a otorgar el sprite base
if sprite_index == spr_atk//if currently attacking
    {if image_index == image_number - 1//check if animation finished
        {sprite_index = spr_base; //if animation finished return to base
         action = false}
    }
```

Para crear los ataques lanzaremos el script al apretar una tecla y pasaremos como argumentos: la tecla, el sprite base (de pié) y el sprite de ataque. Podemos llamar el script tantas veces como ataques queramos definir. 

## Parte 2: Físicas de movimiento y animaciones onHit

Para hacer que se mueva nuestro personaje utilizaremos físicas de movimiento en horizontal y en vertical, así como una aceleración y una fricción con un "suelo".

### Crear el script de movimiento

A partir de las teclas izquierda y derecha, este script se encargará de añadir un movimiento horizontal y moverá nuestro sprite por la pantalla.

```javascript
var right, up, left, down, spdinc, maxhspd;
right = argument0;
up = argument1;
left = argument2;
spdinc = 5;
maxhspd = 10;

if abs(hspeed) > 0 and !action {walking = true}
else {walking = false}

{if hspeed < -maxhspd{hspeed = -maxhspd}
if hspeed >= maxhspd{hspeed = maxhspd}}//límite de velocidad máxima

if action{hspeed = 0}

if abs(hspeed) < maxhspd// si vamos más lentos que la velocidad máxima
    {if keyboard_check(left)
        {motion_add(180, spdinc)}

    if keyboard_check(right)
        {motion_add(0, spdinc)}
    }   
    
if abs(hspeed) >= maxhspd// si vamos más rápidos que la velocidad máxima
    {if hspeed > 0{//si vamos a la derecha
        if keyboard_check(left)
            {motion_add(180, spdinc)}}
            
     if hspeed < 0{//si vamos a la izquierda
        if keyboard_check(right)
            {motion_add(0, spdinc)}}
     }
```

Los tres argumentos son las tres teclas de movimiento izquierda, salto o derecha.

### Creando script de fricción

El problema que tenemos al añadir movimiento horizontal es que no nos dejaremos de mover, por lo que vamos a añadir un nuevo script que detecte si la velocidad horizontal es diferente de 0 y poco a poco la deje a 0, simulando fricción contra el suelo.

```javascript
var fric;
fric = 1
if hspeed > 0
    {if hspeed -fric > 0 {hspeed -=fric} else {hspeed = 0}}
  
if hspeed < 0
    {if hspeed +fric < 0 {hspeed +=fric} else {hspeed = 0}}
```

### Script de cambio de sprite

Aprovechando las variables walking y action que quedan establecidas en el jugador podemos cambiar dinámicamente el sprite entre estar caminando y estar quieto utilizando un script change_sprite:

```javascript
if walking and !action
    {sprite_index = spr_ryu_walk}
if !walking and !action
    {sprite_index = spr_ryu_stand}
```

### Crear los hitboxes para los ataques

Los hitboxes son las áreas de colisión entre un ataque y el sprite del jugador, eso significa que cada animación de ataque (sprite) tiene unas áreas de colisión diferentes allá donde recaerá el golpe, ya sea con el pié, el puño, etc. Sin embargo la máscara de colisión queda establecida en la figura del personaje y en todo su contorno, por lo que esta forma no nos sirve.

La técnica utilizada es muy simple: crear una copia de la animación de ataque y borrar todo el contenido de los sprites excepto el puño durante el puñetazo, o la rodilla si es un rodillazo. A continuación activar las máscaras de colisión precisas y separadas para cada subimagen del sprite.

### Importar el script que detecta colisiones entre sprites

Dado que es un poco difícil detectar las colisiones entre sprites con máscaras precisas podemos utilizar [esta librería](http://gmc.yoyogames.com/index.php?showtopic=389110) publicada en los foros de yoyo para determinar colisiones entre dos instancias. 

### El script de detección de golpes y animación de golpe

Vamos a utilizar la librería anterior en un nuevo script col_attackbox que nos permitirá saber en todo momento del evento Step si hay una colisión entre dos objetos.

```javascript
if other.owner == self.id
    {exit}
if CollisionPointIDs(self.id, other.id, noone, noone, noone, noone , noone)
    {damaged = true}
with (other.id) {instance_destroy()}
```

Si hay una colisión entonces establecemos damaged a true y en el script change_sprite añadiremos el siguiente bloque para cambiar la animación como si nos hubieran pegado:

```javascript
if damaged and sprite_index != spr_ryu_hit
    {sprite_index = spr_ryu_hit;
      action = true
      image_index = 0}
```

### Creando una instancia de hitbox

Ahora crearemos un nuevo objeto llamado attackbox sin nada dentro y modificaremos nuestro script drawattack para crear una instancia del attackbox en el momento del ataque y en el que añadiremos el sprite del golpe relacionado (que pasamos como cuarto argumento):

```javascript
var key, spr_base, spr_atk;
key = argument0
spr_base = argument1
spr_atk = argument2
spr_atk_hitbox = argument3//nuevo argumento

if sprite_index == spr_atk//if currently attacking
    {if image_index == image_number - 1//check if animation finished
        {sprite_index = spr_base; //if animation finished return to base
         action = false}}

//esta sección es nueva
if action{exit}
if keyboard_check_pressed(key)
    {var atkbox;
    atkbox = instance_create(x, y, obj_attackbox)
    atkbox.owner = self.id
    atkbox.sprite_index = spr_atk_hitbox
    atkbox.image_index = 0
    }

if keyboard_check_pressed(key)
    {if sprite_index != spr_atk
        {image_index = 0;
        sprite_index = spr_atk; 
        action = true}
    }
```

A continuación abrimos de nuevo el attackbox, desactivamos su visibilidad y en el evento step añadimos:

```javascript
x = owner.x
image_index = owner.image_index
if image_index == image_number-1
    {instance_destroy()}
```

En su Draw añadimos el drawplayer y añadimos un evento de colisión entre el jugador y el obj_attackbox, estando seguros también que el jugador2 tiene un evento step con su change_sprite para que cambie al ser golpeado.

Por último para evitar que al recibir un ataque la animación se repita hasta el infinito añadiremos una condición para desactivar el estado damaged y la acción en el change_sprite:

```javascript
if sprite_index == spr_ryu_hit{
     {if image_index >= image_number -1
            {action = false; damaged = false}}}
```

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

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/anim1.gif)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/anim1.gif)

### Crear las barras de vida, añadir las variables curhp, maxhp y el scr_healthbar en el draw de los jugadores

### Crear un obj_hud y llamar scr_healthbar en su draw, poner en la room el hud

### Añadir control de daños. En el scr_col_attackbox restar vida en el CollisionPointsIds == true

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/img11.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/img11.png)

### Crear unas gradients (en sprites) para las nuevas barras de vida

### Crear un script scr_draw_spritebar y las nuevas variables en scr_ini_player para manegar el damage

### Modificar el script scr_healthbar con las nuevas barras

### Modificar el scr_coll_attackbox para guardar el daño del último ataque y un timer para esconderlo dentro de CollisionPointsIDs == true

### Añadir juggling
Juggling es la capacidad de encadenar combos y dejar al enemigo en el aire. Para hacerlo tenemos que dejar al enemigo en el aire cada vez que recibe un ataque.

### Substituir los ataques del step por un sólo script scr_attack

### Editamos el scr_drawattack para añadir un daño y un tipo de ataque

### Editamos scr_col_attackbox para aplicar el daño especifico del ataque y si es de tipo juggling aplicamos un motion

### Editamos el scr_gravity para que le afecte los ostiazos verticales al jugador

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/anim2.gif)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/anim2.gif)

### Añadir un timeout de "KO" mientras un jugador está en el aire para previnir sus ataques. Creamos la variable juggle_timer en el scr_ini_player y en el scr_attackbox lo establecemos a 10

### Creamos el scr_timer y lo añadimos al step de cada jugador

### Creamos el scr_preventattack, editamos el scr_drawattack y lo modificamos para añadir if scr_preventattack(){exit} en lugar de sólo if action{exit}

### Para implementar sacudidas de cámara al golpear hay que activar las views y creamos el obj_camera con su create y step

### Ahora creamos un scr_quake para generar un movimiento en la cámara

### Añadimos la camara a la room y en el scr_col_attackbox llamamos al scr_quake cuando hay un golpe (por ejemplo patada alta que manda volar al otro jugador)

### Para añadir efectos SFX de salto y carrera creamos los sprites y un script create_sfx que llamaremos en el scr_move justo al saltar o correr

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/anim3.gif)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/anim3.gif)

## Parte 7: Animaciones de derrota y victoria

* Empezamos creando las dos animaciones con sus respectivos sprites.
* Añadimos la variable dead = false en scr_ini_player
* Creamos un disparador que nos avise cuando el jugador es derrotado en scr_col_attackbox: if curhp <= 0 {dead = true}
* En el scr_change_sprite añadimos el código para dibujar la animación de derrota y dejarla parada al final (ryu tirado en el suelo).
* Añadir al scr_preventattack un "or dead" para evitar que el jugador pueda atacar.
* Lo mismo en scr_move para evitar que se pueda mover.
* Para la animación de victoria tenemos que saber que jugador es cada personaje, guardaremos sus id en el create para poder comprobar cuando el enemigo ha sido derrotado y mostrar el nuevo sprite al principio del scr_change_sprite.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/img12.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/img12.png)

### Detalles propios

* Hacer que no se salga de las paredes (si x < 0 o x > room_width)
* Añadir un push effect a los golpes con motion_add (se acumula con el motion_set de la patada arriba) dependiendo del lado al que tenemos al jugador que pega moveremos un poco al jugador pegado.
* Hacer que el jugador 2 mire automáticamente hacia donde esté el jugador 1 (tipo CPU).
* Hacer que un jugador no pueda pasar a través de otro y se quede parado utilizando place_meeting(x+hspeed,y,other_player).
* Cambiar el lado de la animación de derrota dependiendo del image_xscale (-1 o 1).

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/anim4.gif)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/25_simple_fighter.gmx/docs/anim4.gif)












