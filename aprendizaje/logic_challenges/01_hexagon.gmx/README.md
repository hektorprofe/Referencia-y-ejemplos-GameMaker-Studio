## Logic Challenge

Los logic challenge son unos ejercicios de análisis que me he propuesto hacer a lo largo de mi aprendizaje en el desarrollo de videojuegos. Se trata de observar, analizar e investigar un tipo de juego concreto, y determinar si se puede, o mejor dicho, soy capaz de crear un concepto similar en Game Maker. 

# Logic Challenge 1: Hexagon

[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/GWBu5yDql6E/0.jpg)](http://www.youtube.com/watch?v=GWBu5yDql6E)

En este primer logic challenge quiero empezar fuerte y me he propuesto estudiar el juego Hexagon del desarrollador Terry Cavanagh. Este juego lo programó a principios de 2012 y le sirvió como prototipo para crear el famoso Super Hexagon.

A parte de la dificultad que tiene, lo primero que se te viene a la cabeza es que es geométricamente perfecto y que debido al tempo de la música y los efectos de zoom da una sensación perfecta de equilibrio con la música, algo que lo hace tremendamente adictivo.

En cuanto a la categoría diría que es básicamente un juego casual de reflejos y mucha coordinación.

## Análisis Previo

Un análisis superficial del gameplay nos revela que estamos ante un juego creado básicamente con polígonos rotando entorno al punto central de la pantalla y cuenta con los siguientes elementos:

* Un fondo creado con seis triángulos que convergen en el centro de la pantalla.
* Sobre ellos y justo en el centro de la pantalla está el jugador representado por un hexágono y un pequeño triángulo que indica la mira de la dirección.
* Por último encontramos una especie de "trapecios" que juntos forman el contorno de unos hexágonos mientras se aproximan hacia el centro y disminuyen su tamaño sin salirse de los triángulos de fondo hasta acabar desapareciendo. Algunos de ellos se esconden paulatinamente para ir formando un camino dónde el jugador tiene que ir moviendo el punto de mira y evitar chocar para no finalizar el juego.

Éstos son todos los componentes del juego (sin contar las pantallas de título y menús).

## Trasladando el concepto 

La primera duda que me viene a la mente es si en este juego es realmente necesario utilizar sprites o si es posible dibujar estos polígonos directamente sobre el fondo.

Esta duda me surge por la razón que estos "trapecios" cambian de una forma dinámic, tanto se encogen como se hacen más grandes y van cambiando de forma suave. Incluso en la versión de Super Hexagon todo el concepto varía cuando en lugar de una estructura de hexágonos esta varía a una de cuadrados tan suavemente que da gusto verlo.

Algo que se me pasa por la cabeza es que por ejemplo cuando trabajas con canvas y javascript es posible crear polígonos utilzando una serie de coordenadas. Por tanto lo primero que me pongo a investigar es si es posible dibujar polígonos en Game Maker de una forma similar, y resulta que es posible hacerlo utilizando [el dibujo de primitivas](http://docs.yoyogames.com/source/dadiospice/002_reference/drawing/drawing%20primitives/draw_primitive_begin_texture.html).

### Dibujando un triángulo

Lo primero que intento es dibujar un triángulo equilatero en medio de la pantalla. Creo una textura blanca sobre un fondo negro y un objeto controller con todo el código:

### Obj_controller: Create
```javascript
texid = background_get_texture(back); // Cargo la textura
```

### Obj_controller: Draw
El triángulo tendrá tres lados iguales de 320px:  
```javascript
draw_set_color(c_white); // Color del polígono
draw_primitive_begin_texture(pr_trianglefan, texid); 
draw_vertex_texture(320, 120, 0, 0); // Vértice superior
draw_vertex_texture(160, 360, 0, 0); // Vértice inferior izquierdo
draw_vertex_texture(480, 360, 0, 0); // Vértice inferior derecho
draw_primitive_end(); // Pintamos la primitiva
draw_set_color(0); // Reiniciamos el color
```

[Documentación de las primitivas](http://docs.yoyogames.com/source/dadiospice/002_reference/drawing/drawing%20primitives/draw_primitive_begin.html)

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img1.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img1.jpg)

Ahora que sé que es posible crear un polígono en Game Maker lo útil sería contar con una función propia capaz de crear un polígono a partir de una coordenada, un radio y un número de vértices. Esta función se puede encontrar por [internet](http://stackoverflow.com/questions/3436453/calculate-coordinates-of-a-regular-polygons-vertices) y lo único que hago es adaptarla a Game Maker:

### scr_polygon(x,y,radius,edges,color)
```javascript
// Creado por Héctor Costa Guzmán

// Script polígono: Dibuja un polígono en una coordenada.
// Utiliza una coordenada x-y, un radio y un número de lados.

// argument0 = x 
// argument1 = y
// argument2 = radius
// argument3 = edges
// argument4 = color

draw_set_color(argument4);
draw_primitive_begin_texture(pr_trianglefan,background_get_texture(back)) 

for (var i=0; i<argument3; i++) 
{

    var edgeX = argument0 + argument2 * cos(2 * pi * i / argument3);
    var edgeY = argument1 + argument2 * sin(2 * pi * i / argument3);

    draw_vertex_texture(edgeX, edgeY, 1, 1);
}

draw_primitive_end();
draw_set_color(0);
```

### Utilización:
```javascript
scr_polygon(room_width/2, room_height/2, 225, 4, c_green); // cuadrado con 225px de radio
scr_polygon(room_width/2, room_height/2, 180, 3, c_blue);  // triángulo con 180px de radio
scr_polygon(room_width/2, room_height/2, 50, 6, c_red);    // hexagono con 35px de radio
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img2.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img2.jpg)

El próximo paso es conseguir aplicar una rotación al polígono. Para hacerlo debemos saber varias cosas:
* Coordenada sobre la cual queremos rotar.
* Ángulo en radianes que vamos a rotar. 

El cálculo de las nuevos coordenadas se consigue utilizando la fórmula de rotación de matrices y aplicarla sobre cada punto tal como se explica [en este enlace](http://stackoverflow.com/questions/9043391/html5-canvas-calculating-a-x-y-point-when-rotated?answertab=active#tab-top).

Modificando ligeramente nuestra función podemos pasarle además un ángulo de rotación inicial:

### Utilización:
```javascript
// Creado por Héctor Costa Guzmán

// Script polígono: Dibuja un polígono en una coordenada.
// Utiliza una coordenada x-y, un radio y un número de lados.
// Además se puede indicar el ángulo de rotación respecto al centro.

// argument0 = x 
// argument1 = y
// argument2 = radius
// argument3 = edges
// argument4 = color
// argument5 = angle in degrees

var rads = degtorad(argument5); // A radianos

draw_set_color(argument4);
draw_primitive_begin_texture(pr_trianglefan,background_get_texture(back)) 

for (var i=0; i<argument3;i++) 
{
    var edgeX = argument0  + argument2 * cos(2 * pi * i / argument3);
    var edgeY = argument1  + argument2 * sin(2 * pi * i / argument3);
    
    // La rotación determina el nuevo punto (dx,dy) = (x2-x1, y2-y1)
    var newX = edgeX - argument0;
    var newY = edgeY - argument1;
    
    edgeX = newX * cos(rads) - newY * sin(rads);
    edgeY = newX * sin(rads) + newY * cos(rads);
    
    // Sumamos la distancia hasta el centro
    edgeX = edgeX + argument0;
    edgeY = edgeY + argument1;
    
    draw_vertex_texture(edgeX , edgeY, 1, 1);
    //draw_text(room_width-150,(100+(i*15)) , string(round(argument5)) + " - " +string(round(edgeX)) + "," + string(round(edgeY)) );
}

draw_primitive_end();
draw_set_color(0);
```

### Utilización:
```javascript
scr_polygon(room_width/2, room_height/2, 225, 6, c_green, 50); // hexágono con 225px de radio rotado 45º
scr_polygon(room_width/2, room_height/2, 180, 3, c_blue, 0);   // triángulo con 180px de radio rotado 0º
scr_polygon(room_width/2, room_height/2, 50, 4, c_red, 280);   // cuadrado con 50px de radio rotado 280º
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img3.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img3.jpg)

A continuación vamos a intentar dibujar el fondo con los 6 triángulos. No será muy difícil ya que Game Maker trae consigo una versión específica de nuestra función polígono pero para dibujar triángulos.

Lo que haremos es generar un bucle for y crear 6 puntos que determinarán el lugar de cada nuevo triágulo, compartiendo todos ellos el vértice central en medio de la sala:
* i == 0
* i == 60
* i == 120
* i == 180
* i == 240
* i == 300

En cada caso tomaremos la i como el ángulo y utilizando las funciones coseno y seno generaremos las otras dos coordenadas, tomando que los costados de los triángulos sean de 800px de largo, lo suficiente para verse en la pantalla todo el rato. 

Aprovecharemos además para sumar 1 grado a una variable angle en cada Draw, de manera que generaremos el efecto de rotación. Para rotar nuestros triángulos desde el vértice del centro, simplemente sumaremos esa variable ángulo en radianes a los cálculos del coseno y el seno.

Por último una condición nos permitirá cambiar el color de cada triángulo de manera que no queden dos iguales seguidos y además añadiremos un pequeño hexágono que rotará a la par que nuestros triángulos, utilizando nuestra función de polígonos y pasándole la misma variable angle.

### obj_controller: Draw
```javascript
angle += 1.5; // Incremento del ángulo en grados en cada Draw
if (angle > 360) angle = 0;

// Dibujamos los triángulos de fondo, con unos costados de 800px
var size = 800;
var firstColor = make_color_rgb(250, 250, 250);
var secondColor = make_color_rgb(24, 201, 245);
var currentColor = firstColor;

for(var i = 0; i < 360; i += 360 / 6) {

    // Determinamos el color
    if(i mod 2 == 0) {
        if (currentColor == firstColor) currentColor = secondColor;
        else currentColor = firstColor;
    }
    draw_set_color(currentColor);
    
    // Generamos las coordenadas triángulo y le sumamos el ángulo de rotación deseado (en radianes)
    var posX = room_width/2 + cos( degtorad(i - 360 / 6) + degtorad(angle) ) * size;
    var posY = room_height/2 + sin( degtorad(i - 360 / 6) + degtorad(angle) ) * size;;
    
    var maxX = room_width/2 + cos( degtorad(i) + degtorad(angle) ) * size;
    var maxY = room_height/2 + sin( degtorad(i) + degtorad(angle) ) * size;

    // Dibujamos el triángulo, necesitamos tres puntos
    // Partimos que el triángulo empieza justo en medio de la pantalla
    draw_triangle(room_width/2,room_height/2,posX,posY,maxX,maxY,false);
    
}
   
// Creamos un pequeño hexágono en el centro y encima de los triángulos
scr_polygon(room_width/2, room_height/2, 35, 6, c_orange, angle);
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img4.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img4.jpg)

Ya tenemos el fondo y nuestro personaje girando parejos (más o menos). Ahora es el momento de investigar como crear esos trapecios que tanto trabajo nos van a dar...

Voy a empezar creando un trapecio. Un trapecio es una figura geométrica parecida a un rectángulo pero en la que uno de sus costados es más pequeño que su opuesto. Es precisamente esta peculiaridad la que no nos permite crear el trapecio con la función draw_rectangle, ya que ésta solo necesita dos coordenadas opuestas para formar el rectángulo perfecto. 

La función de polígono tampoco nos sirve en este caso, ya que necesitamos crear el trapecio a partir de 4 coordenadas en lugar de generarlo alrededor de una circunferencia.

Así que vamos a crear una función para crear nuestro trapecio pasándole las cuatro coordenadas, de una forma similar a los polígonos y utilizando primitivas. Realmente nos serviría para cualquier figura geométrica con 4 costados.

### scr_quad():
```javascript
// Creado por Héctor Costa Guzmán

// Script quad: Dibuja un polígono de 4 costados
// a partir de cuatro coordenadas usando primitivas.

// argument0 = c1x 
// argument1 = c1y
// argument2 = c2x 
// argument3 = c2y
// argument4 = c3x 
// argument5 = c3y
// argument6 = c4x 
// argument7 = c4y
// argument8 = color

draw_set_color(argument8);
draw_primitive_begin_texture(pr_trianglefan,background_get_texture(back));

draw_vertex_texture(argument0, argument1, 1, 1);
draw_vertex_texture(argument2, argument3, 1, 1);
draw_vertex_texture(argument4, argument5, 1, 1);
draw_vertex_texture(argument6, argument7, 1, 1);

draw_primitive_end();
draw_set_color(0);
```

Voy a probar de dibujar un trapecio empezando en medio de la room.

```javascript
var x1 = room_width/2;
var y1 = room_height/2;

var x2 = room_width/2 + 50;
var y2 = room_height/2 - 150;

var x3 = room_width/2 + 150;
var y3 = room_height/2 - 150;

var x4 = room_width/2 + 200;
var y4 = room_height/2;

scr_quad(x1, y1, x2, y2, x3, y3, x4, y4, make_color_rgb(219, 3, 17));

draw_set_color(c_white);
draw_text(room_width/2 - 150,room_height/2, "("+string(x1)+","+string(y1)+")");
draw_text(room_width/2 - 150,room_height/2+30, "("+string(x2)+","+string(y2)+")");
draw_text(room_width/2 - 150,room_height/2+60, "("+string(x3)+","+string(y3)+")");
draw_text(room_width/2 - 150,room_height/2+90, "("+string(x4)+","+string(y4)+")");
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img5.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img5.jpg)

###

Ahora la cuestión es, ¿cómo crear automáticamente un trapecio en una posición que concuerde en anchura con la anchura de uno de los triángulos que dan la vuelta? Y todavía más importante, ¿qué hay acerca de la rotación de estos trapecios?

Vamos por partes... Teniendo en cuenta que el punto de rotación de estos trapecios es el centro de la room, podría indicar esta coordenada como offset y aplicar una rotación de la misma manera que lo hicimos con los pólígonos. De manera que tendríamos que crear el trapecio con la forma deseada en base a la distancia que estamos del centro.

Por ejemplo, un trapecio con origen a 150,150 del centro, con altura de 35px y anchura determinada las razones trigonométricas y utilizando un ángulo de 60º, el mismo que tienen los 6 triángulos de fondo y que multiplicado por 6 nos daría una vuelta completa:

```javascript
// Creamos un trapecio
var offset_x = room_width/2;
var offset_y = room_height/2;
var distance = 150;
var height = 35;

angle = 0; // Si lo incremetamos la figura irá rotando alrededor del centro

var x1 = offset_x + cos(degtorad(angle)) * distance ;
var y1 = offset_y + sin(degtorad(angle)) * distance ;

var x2 = offset_x + cos(degtorad(angle + (360 / 6))) * distance;
var y2 = offset_y + sin(degtorad(angle + (360 / 6))) * distance;

var x3 = offset_x + cos(degtorad(angle + (360 / 6))) * (distance + height);
var y3 = offset_y + sin(degtorad(angle + (360 / 6))) * (distance + height);

var x4 = offset_x + cos(degtorad(angle)) * (distance + height);
var y4 = offset_y + sin(degtorad(angle)) * (distance + height);

scr_quad(x1, y1, x2, y2, x3, y3, x4, y4, make_color_rgb(219, 3, 17));
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img6.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img6.jpg)

¿Pero como se ha conseguido este resultado?

### Repaso trigonométrico

Aquí hay unos apuntes sobre [las razones trigonométricas](http://www.vitutor.com/al/trigo/tri_2.html) por si hay que repasar.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img7.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img7.jpg)

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img8.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img8.jpg)

### Los 6 trapecios

Para crear estas figuras de una forma más o menos consecutiva simplemente tenemos que incrementar el ángulo 60º al crear cada una de ellas. 

Como no quiero acabar con mil líneas de código creo que me haré una función que me dibuje las 6 figuras consecutivamente. Como estas 6 figuras son como las ráfagas que más tarde tendremos que esquivar llamaré al script scr_burst (burst = ráfaga).

### scr_burst()

```javascript
// Creado por Héctor Costa Guzmán

// Script burst: Crea una ráfaga de 6 trapecios

// argument0 = offset_x 
// argument1 = offset_y
// argument2 = angle 
// argument3 = distance
// argument4 = height
// argument5 = color 

var angle = argument2;

for (var i=0;i<6;i++)
{   
    angle = 60*i + argument2;

    var x1 = argument0 + cos(degtorad(angle)) * argument3 ;
    var y1 = argument1 + sin(degtorad(angle)) * argument3 ;
    
    var x2 = argument0 + cos(degtorad(angle + (360 / 6))) * argument3;
    var y2 = argument1 + sin(degtorad(angle + (360 / 6))) * argument3;
    
    var x3 = argument0 + cos(degtorad(angle + (360 / 6))) * (argument3 + argument4);
    var y3 = argument1 + sin(degtorad(angle + (360 / 6))) * (argument3 + argument4);
    
    var x4 = argument0 + cos(degtorad(angle)) * (argument3 + argument4);
    var y4 = argument1 + sin(degtorad(angle)) * (argument3 + argument4);
    
    scr_quad(x1, y1, x2, y2, x3, y3, x4, y4, argument5);
}
```

```javascript
// Creamos una ráfaga
scr_burst(room_width/2, room_height/2, angle, 180, 30, make_color_rgb(219, 3, 17) );
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img9.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img9.jpg)

Parece que lo tenemos bien encaminado. Ahora si añadimos una distancia variable que decremente un poco en cada Draw y hacemos que esta vuelva al máximo cuando sea muy pequeña ¡tendremos el efecto hacia adentro!

```javascript
// En el create
distance = 350;
```

```javascript
// En el step
distance -= 5;
if (distance <= 30) distance = 350;

// Llamo la función burst con distancia variable
scr_burst(room_width/2, room_height/2, angle, distance, 30, make_color_rgb(219, 3, 17) );
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img10.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img10.jpg)

¿Genial verdad? Entonces es cuando pienso que quizá creando 3 ráfagas diferentes, cada una un poco más lejos de la otra podemos crear el efecto del juego original.

```javascript
// Creamos una ráfaga
scr_burst(room_width/2, room_height/2, angle, distance, 30, make_color_rgb(219, 3, 17) );
scr_burst(room_width/2, room_height/2, angle, distance*3, 30, make_color_rgb(219, 3, 17) );
scr_burst(room_width/2, room_height/2, angle, distance*6, 30, make_color_rgb(219, 3, 17) );
```
Pero el resultado no es para nada el esperado y las ráfagas acaban todas en el centro en el mismo instante...

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img11.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img11.jpg)

¿Por qué ocurre este efecto? Pues, porque todas las ráfagas estan compartiendo algo que no deberían, y me estoy refiriendo a la distancia.

### Ráfagas de trapecios en memoria

La idea entonces es guardar de alguna forma todas las ráfagas, o mejor dicho, todos los trapecios que forman cada ráfaga y que hay que pintar en la pantalla en cada draw. 

Cada uno de estos trapecios tendrá su ángulo y distancia variable. Entonces en lugar de tener una distancia global iremos restando la propia distancia de cada ráfaga y en cuanto ésta sea menor de 30 (por ejemplo), borraremos la ráfaga... bueno, los trapecios con distancia menor de 30.

Hay varias formas de utilizar la memoria, por ejemplo usando arrays o listas. Si estuviera en Python o Javascript lo más cómodo sería crear un objeto y meterlo en una lista. Pero como estoy en Game Maker tengo la alternativa de utilizar grids (matrices), o varios arreglos para cada propiedad, lo cual sería óptimo. 

Sin embargo ya que existien los objetos me voy a aventurar a hacer un experimento. Voy a replantear todo el juego utilizando los objetos de Game Maker y de paso haré un poco de limpieza.

### Replanteado el juego con objetos

Los objetos que voy a crear son básicamente los que me permiten dibujar el juego:

* obj_background: Para dibujar los triángulos del fondo.
* obj_trapezoid: Para dibujar las ráfagas de trapecios.
* obj_player: Para dibujar el jugador.
* obj_controller: Para gestionar todo el juego.

Los scripts con los que cuento son:

* scr_polygon: Dibuja un polígono de n lados a partir de una coordenada central utilizando una circunferencia.
* scr_quad: Dibuja un polígono de 4 costados a partir de 4 coordenadas.
* scr_rotate_coord: Toma una coordenada y le aplica una rotación en grados.
* scr_burst: Genera varios trapecios para crear una ráfaga.

De forma común voy a gestionar varias variables globales que me permitirán tener una referencia del ángulo de rotación general, de la distancia de los trapecios y de la velocidad de éstos.

En Game Maker los objetos también pueden tener variables internas, es eso lo que me resulta útil en este caso. La parte inútil del montaje es que al instanciar un nuevo objeto también es necesario darle una coordenada para indicar dónde se van a crear dentro de la room. Como realmente no van a tener un sprite lo único que haré es crearlos fuera de la room y listo.

En cuanto al obj_controller ahora se crean unas variables nuevas y el objeto queda así:

```javascript
// obj_controller: Create
global.spd = 4;
global.distance = 600;
global.height = 35;
global.angle = 0;
burst = true; // indica si pintar una oleada de trapecios
```

```javascript
// obj_controller: Draw Begin
global.angle += 1.5;
if (global.angle > 360) global.angle = 0;
// Creamos una ráfaga cada 2 segundos
if (burst)
{
    scr_burst();
    burst = false;
    alarm[0] = 60;
}
```

```javascript
// obj_controller: Alarm 0
burst = true;
```

El objeto player sólo tendría un evento Draw y tendría una profunidad de 0:

```javascript
// obj_player: Draw End
scr_polygon(room_width/2, room_height/2, 35, 6, make_color_rgb(255, 255, 255), global.angle);
```

El nuevo objeto background se encargará de los triángulos de fondo y también tendrá sólo un evento Draw. La profundidad deberá ser muy grande, por ejemplo 9999:

```javascript
// obj_background: Draw
var size = 800;
var firstColor = make_color_rgb(115, 25, 25);
var secondColor = make_color_rgb(75, 15, 15);
var currentColor = firstColor;

for(var i = 0; i < 360; i += 360 / 6) {

    // Determinamos el color
    if(i mod 2 == 0) {
        if (currentColor == firstColor) currentColor = secondColor;
        else currentColor = firstColor;
    }
    draw_set_color(currentColor);
   
    // Generamos los 6 triángulos, sumando el ángulo de rotación deseado
    var posX = room_width/2 + cos( degtorad(i - 360 / 6) + degtorad(global.angle) ) * size;
    var posY = room_height/2 + sin( degtorad(i - 360 / 6) + degtorad(global.angle) ) * size;
    
    var maxX = room_width/2 + cos( degtorad(i) + degtorad(global.angle) ) * size;
    var maxY = room_height/2 + sin( degtorad(i) + degtorad(global.angle) ) * size;;
   
    // Dibujamos el triángulo
    draw_triangle(room_width/2,room_height/2,posX,posY,maxX,maxY,false);
    
}
```

El cambio más importante ocurre en el nuevo objeto trapezoid, encargado de definir y dibujar cada trapecio. Este objeto debe tener una profundidad inferior al background y mayor que el player:

```javascript
// obj_trapezoid: Create
angle = 0;
distance = global.distance;
height = global.height;
spd = global.spd;
````

```javascript
// obj_trapezoid: Draw
var offset_x = room_width/2;
var offset_y = room_height/2;

var x1 = offset_x + cos(degtorad(angle+global.angle)) * distance;
var y1 = offset_y + sin(degtorad(angle+global.angle)) * distance;

var x2 = offset_x + cos(degtorad(angle+global.angle + (360 / 6))) * distance;
var y2 = offset_y + sin(degtorad(angle+global.angle + (360 / 6))) * distance;

var x3 = offset_x + cos(degtorad(angle+global.angle + (360 / 6))) * (distance + height);
var y3 = offset_y + sin(degtorad(angle+global.angle + (360 / 6))) * (distance + height);

var x4 = offset_x + cos(degtorad(angle+global.angle)) * (distance + height);
var y4 = offset_y + sin(degtorad(angle+global.angle)) * (distance + height);

scr_quad(x1, y1, x2, y2, x3, y3, x4, y4, make_color_rgb(219, 3, 17));

distance -= global.spd;

// si la distancia es menor que 1 borramos el objeto haciéndo que desaparezca
if (distance < 1) instance_destroy();
````

Los trapecios se crean cada 2 segundos (60 steps por ejemplo) en la alarm[0] de controller y se crean al llamar el nuevo script burst:

```javascript
// scr_burst()
// Creado por Héctor Costa Guzmán

// Script burst: Crea una ráfaga de trapecios
for (var i=0;i<6;i++)
{   
    trapezoid = instance_create(0, 0, obj_trapezoid); // no importa dónde lo creamos
    with(trapezoid)
    {
        angle = i * 60; // a cada trapecio le damos 60º más de ángulo
    }
    
}
````

Con todo ésto y poniendo los objetos en la room tenemos un primer concepto del juego ya muy parecido al original.

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img12.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img12.jpg)

Sin duda el juego está muy encaminado pero que un juego sea realmente un juego se necesita un que el jugador interactúe de alguna forma.

### Creando el cursor del jugador

Para crear el pequeño cursor del jugador se me ocurren varias cosas, pero creo que me voy a inclinar por dibujar un sencillo triángulo. Luego lo rotaré conjuntamente con el centro utilizando mi función de rotar coordenadas.

Empezaré creando el triángulo en el evento Draw del jugador. El concepto para dibujarlo es el mismo que el que usé con los trapecios, ya que se basa en determinar un punto a cierta distancia del centro utilizando las razones trigonométricas y utilizando el ángulo de rotación global para crear el efecto de movimiento contínuo.

```javascript
// Dibujamos el hexágono central
scr_polygon(room_width/2, room_height/2, 35, 6, make_color_rgb(255, 255, 255), global.angle);

// Dibujamos el triángulo a 60px del centro
var posX = room_width/2 + cos( degtorad(global.angle) ) * 60;  // distancia X
var posY = room_height/2 + sin( degtorad(global.angle) ) * 60; // distancia Y
draw_set_color(c_white);
draw_triangle(posX,posY-6,posX,posY+6,posX+12,posY,false);
draw_text(100,175, "Global: " + string(global.angle) );
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img13.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img13.jpg)

Por ahora el triángulo aparece bien y rota junto con el fondo pero... no sobre si mismo.

Es un buen momento para usar mi función de scr_rotate_coord para añadir la rotación global, así que voy a calcular las nuevas tres coordenadas después de aplicarles la rotación. ¡Ah! Y esta vez la rotación no se debe hacer sobre el punto central de la room, sinó sobre el propio triángulo.

```javascript
// Dibujamos el hexágono central
scr_polygon(room_width/2, room_height/2, 35, 6, make_color_rgb(255, 255, 255), global.angle);

// Calculamos las coordenadas del triángulo a 60px del centro
var posX = room_width/2 + cos( degtorad(global.angle) ) * 60;  // distancia X
var posY = room_height/2 + sin( degtorad(global.angle) ) * 60; // distancia Y

// Rotación del triángulo sobre si mismo posX,posY
var c1 = scr_rotate_coord(posX, posY-6,posX,posY, global.angle);
var c2 = scr_rotate_coord(posX, posY+6,posX,posY, global.angle);
var c3 = scr_rotate_coord(posX+12, posY,posX,posY, global.angle);

// Lo dibujamos en las nuevas coordenadas rotadas
draw_set_color(c_white);
draw_triangle(c1[0], c1[1], c2[0], c2[1], c3[0], c3[1], false);
draw_text(100,175, "Global: " + string(global.angle) );
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img14.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img14.jpg)

Ya tengo el triangulito rotando en perfecta posición acompañando el fondo, pero no tiene mucho sentido si no podemos moverlo, así que voy a añadir un evento step para añadir rotación cuando se apreten las teclas izquierda y derecha y hacer el efecto de movimiento.

Como lo que haremos realmente es sumar una rotación estática a la rotación global, me voy a crear una nueva variable interna de jugador llamada angle y le iré sumando y restando 10 todo el rato mientras se apretan las teclas.

```javascript
// obj_player: Create
angle = 0;
```

```javascript
// obj_player: Step
if keyboard_check(vk_left)
{
    angle -= 10;
}
else if keyboard_check(vk_right)
{
    angle += 10; 
}

// Reiniciamos el ángulo si nos pasamos
if (angle == 360) angle = 0;
if (angle == -360) angle = 0;
```

Seguidamente haré una modificación en el draw para sumar este ángulo al ángulo global.

```javascript
// Dibujamos el hexágono central
scr_polygon(room_width/2, room_height/2, 35, 6, make_color_rgb(255, 255, 255), global.angle);

// Ángulo final
var tangle = angle + global.angle;

// Calculamos las coordenadas del triángulo a 60px del centro
var posX = room_width/2 + cos( degtorad(tangle) ) * 60;  // distancia X
var posY = room_height/2 + sin( degtorad(tangle) ) * 60; // distancia Y

// Rotación del triángulo sobre si mismo posX,posY
var c1 = scr_rotate_coord(posX, posY-6,posX,posY, tangle);
var c2 = scr_rotate_coord(posX, posY+6,posX,posY, tangle);
var c3 = scr_rotate_coord(posX+12, posY,posX,posY, tangle);

// Lo dibujamos en las nuevas coordenadas rotadas
draw_set_color(c_white);
draw_triangle(c1[0], c1[1], c2[0], c2[1], c3[0], c3[1], false);
```

Y así es como queda el resultado cuando lo movemos con las flechas de dirección.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img15.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img15.jpg)

ACTUALIZADO: Para añadir movimiento en dispositivos móviles he implementado el siguiente código que tiene en cuenta incluso cuando se pulsa la pantalla con varios dedos sin que se bloquee.

```javascript
// Controles móviles hasta 3 dedos (no se bloquea)
var mouse_pressed = 0;

if device_mouse_check_button(0, mb_any)
{
    if (device_mouse_x(0) < room_width/2) mouse_pressed = 1;
    else mouse_pressed = -1;
}

if device_mouse_check_button(1, mb_any)
{
    if (device_mouse_x(1) < room_width/2) mouse_pressed = 1;
    else mouse_pressed = -1;
}
  
if device_mouse_check_button(3, mb_any)
{
    if (device_mouse_x(2) < room_width/2) mouse_pressed = 1;
    else mouse_pressed = -1;
}

// Controles PC

if keyboard_check(vk_left) || mouse_pressed == -1
{
    angle -= 10;
}
else if keyboard_check(vk_right) || mouse_pressed == 1
{
    angle += 10; 
}

if (angle == 360) angle = 0;
if (angle == -360) angle = 0;
```

### Colisiones

Ya es hora de hacer que el jugador choque contra las ráfagas. Hacerlo es realmente sencillo sin tenemos en cuenta lo siguiente:

* El jugador siempre está a una distancia fija del centro.
* Los trapecios se van aproximando a una distancia variable del centro.
* En el momento del choque, el trapecio estará a la misma distancia que el jugador del centro y el ángulo del jugador deberá estar compreso entre el mínimo ángulo del trapecio y su máximo ángulo.

Para determinar si el ángulo del jugador se encuentra dentro del trapecio podemos dividir ambos ángulos por 60 y utilizar la función floor para saber si comparten la fracción. Ésto lo hacemos en el mismo draw del obj_trapezoid.

```javascript
// Detectamos colisiones, sólo múltiplos de 60
var p_angle = floor(obj_player.angle / 60) * 60;
var c_angle = floor(angle / 60) * 60;

if (p_angle < 0 ) p_angle = p_angle + 360; // si es negativo

// Si el trapecio está a la misma distancia del centro que el jugador
if(distance <= 80 && distance >= 70) {
    // Si tienen el mismo ángulo reiniciamos el juego
    if (c_angle == p_angle) room_restart();
}

// Restamos spd de la distancia
distance -= global.spd;
if (distance < 1) instance_destroy();
```

Fijaros que es importante rectificar el ángulo del jugador sumándole 360 si es negativo, ya que sinó al desplazarnos a la izquierda y ser éste negativo, nunca nos daría el mismo valor y no habría colisión.

### Ráfagas aleatorias

Todo muy bien, pero ¿cómo vamos a probar el juego si no paran de salir ráfagas de 6 trapecios y no dejan sitio para esquivarlas?

Por ahora para probar el juego voy a modificar el código del scr_burst para evitar crear algunos trapecios. Simplemente le haré un random(1) y si es cierto crearé el objeto:

```javascript
// Creado por Héctor Costa Guzmán

// Script burst: Crea una ráfaga de trapecios aleatoria

for (var i=0;i<6;i++)
{   
    if (round(random(1)) )
    {
        trapezoid = instance_create(0, 0, obj_trapezoid);
        with(trapezoid)
        {
            angle = i * 60; 
        }
    
    }
    
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img16.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img16.jpg)

Como se puede apreciar el concepto del juego está prácticamente hecho a falta de mejorar algunos detalles. Uno de ellos es el efecto zoom de pulsación constante que añade al juego algo más de movimiento y lo pone en sincronía con el sonido.

### Zoom

El efecto zoom que voy a recrer es muy sencillo de hacer en Game Maker y consiste simplemente en acerca un poco la cámara y alejarla. Eso se consigue configurando bien las vistas de la room y posteriormente utilizando un código tal como explican en [este vídeo de Youtube](https://www.youtube.com/watch?v=FIRr-BSko4Y).

Voy a ir a la room y le añadiré una view tal como muestro en la siguiente imagen, teniendo en cuenta que la resolución del juego será 800x480 y el obj_controller estará en el punto 400,240.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img17.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img17.jpg)

A continuación creo un objeto zoom y lo pongo en la room:

```javascript
// Obj_zoom: Create
zoom_factor = 1;
zoom_pulse = 0;
```

```javascript
// Obj_zoom: Step
if (zoom_factor >= 1) zoom_pulse = -0.01;
if (zoom_factor < 0.95)  zoom_pulse = 0.01;
zoom_factor += zoom_pulse;

view_wview[0] = room_width * zoom_factor;
view_hview[0] = room_height * zoom_factor;
```

Lo que hago es incrementar y decrementar el zoom cada ciertos instantes para crear el efecto de pulso. Lo haré utilizando una variable llamada zoom_pulse con la cantidad de zoom por step y otra zoom_factor con el zoom final.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img18.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img18.jpg)

### Música maestro

Sin duda lo más divertido del juego es que se puede lograr una sincronía perfecta con la música de fondo.

El juego original utiliza una mezcla de música 8-bits con dubstep pero no puedo utilizarla porque está licenciada bajo costes de reutilización. Alternativamente hay muchisimos autores que ofrecen su música con licencias creative commons y dejan que las podamos reutilizar citando la fuente.

La canción que he descargado para este Logic Challenge es de [teknoaxe](https://www.youtube.com/user/teknoaxe) y se llama [Beat Timed Grime Remastered](https://www.youtube.com/watch?v=ptQcEe30JEs), la cual deja utilizar bajo Licencia Atribución de Creative Commons (reutilización permitida).

Para introducir la música en el juego es tan sencillo como añadir un sonido, seleccionar el fichero mp3, bajarle un poco la calidad y en el objeto controller, añadir dos eventos; room start y room end iniciando y parando el fichero de audio.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img19.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img19.jpg)

El resultado ya es genial y aún nos faltan los últimos detalles. ¡Gracias por la música mestro! :)

### Mejorando las ráfagas

Todo muy bonito pero hay un problema en el código, y es que en ocasiones aparece una ráfaga de 6 trapecios imposible de esquivar... y cuando se encuentran este tipo de problemas significa que hay mejores formas de hacerlo. 

El caso es que después de pensar un rato he ideado una forma de incrementar mucho la jubalidad y acabar con ese bug que os comentaba.

Se trata de crear pre-plantillas de las ráfagas, dependiendo si tienen 2, 3, 4 o 5 trapecios, cada una con una forma distinta.

Para hacerme una idea he creado una imagen ilustrativa de las posibilidades:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img20.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img20.jpg)

Así que sin contar la primera he ideado 4 formas de crear las ráfagas y lo que haré es que mi script burst elija de forma aleatoria cuáles crear. Además he añadido una quinta similar a la primera forma que varía la altura de los trapecios y la decrementa 5 puntos en cada nuevo trapecio.

```javascript
// Creado por Héctor Costa Guzmán

// Script burst: Crea una ráfaga de trapecios aleatoria

var rand = round(random(4));
var nrand = round(random(5)); // 0 al 6

switch(rand)
{
    case 0:
        // rand = 0 , 1 camino
        if (nrand > 3) nrand -= 4;
    
        for (var i=0;i<6;i++)
        {   
            if (nrand != i)
            {
        
                trapezoid = instance_create(0, 0, obj_trapezoid);
                with(trapezoid)
                {
                    angle = i * 60;  
                }
            } 
        }
        
        break;
        
    case 1:
        // rand = 1 , 2 caminos v1
        if (nrand > 2) nrand-=3;
    
        for (var i=0;i<6;i++)
        {   
            if (nrand != i && nrand+3 != i)
            {
                trapezoid = instance_create(0, 0, obj_trapezoid);
                with(trapezoid)
                {
                    angle = i * 60; 
                }
            }
        }
        
        break;
        
    case 2:
        // rand = 2 , 2 caminos v2
        if (nrand > 2) nrand-=2;
        
        for (var i=0;i<6;i++)
        {   
            if (nrand != i && nrand+2 != i)
            {
                trapezoid = instance_create(0, 0, obj_trapezoid);
                with(trapezoid)
                {
                    angle = i * 60; 
                }
            }
        }
        
        break;
        
    case 3:
        // rand = 3 , 3 caminos
        if (nrand > 2) nrand-=4;
        
        for (var i=0;i<6;i++)
        {   
            if (nrand != i && nrand+2 != i && nrand+4 != i) 
            {
                trapezoid = instance_create(0, 0, obj_trapezoid);
                with(trapezoid)
                {
                    angle = i * 60; 
                }
            }
            
        }
        
        break;
        
    default:
        // rand = 0 , 1 camino
        if (nrand > 3) nrand -= 4;
        
        var resize = false;        
        if (round(random(2) == 0)) resize = true;
    
        for (var i=0;i<6;i++)
        {   
            if (nrand != i)
            {
                trapezoid = instance_create(0, 0, obj_trapezoid);
                with(trapezoid)
                {
                    angle = i * 60; 
                    height = 77 - (i*7);   
                }
            }
        }

        break;
        
}
```

Evidentemente el juego original mezcla muchos más conceptos, como por ejemplo la velocidad de las ráfagas y además tiene en cuenta la música para generar los caminos que van saliendo por pantalla. Yo no quiero llegar tan lejos y con unos pocos ajustes dejaré por zancado este Logic Challenge :)

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img21.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img21.jpg)

### Colores aleatorios, cambio de dirección y contador de tiempo

Algo que quiero añadir es un cambio de dirección de la dirección global en un momento aleatorio. Debería ser tan fácil como poner una alarma con un multiplicador negativo o postivo y llamarla de forma aleatoria a si misma a lo largo del juego.

```javascript
// obj_controller: Create
global.spd = 7;
global.distance = 600;
global.height = 35;
global.angle = 0;
global.angle_inc = 2;
global.multi = 1;
burst = true;

alarm[1] = round(random_range(room_speed * 4, room_speed * 8));
```

```javascript
// obj_controller: Alarm 1
global.multi  = global.multi * (-1);
global.spd += 0.25;
global.angle_inc += 0.125;

alarm[1] = round(random_range(room_speed * 4, room_speed * 8)); // 4 a 8 segundos
```

```javascript
// obj_controller: Draw Begin
global.angle += (global.angle_inc*global.multi);
if (global.angle > 360) global.angle = 0;
if (global.angle < 0) global.angle += 360;
```

Luego para dibujar el contador y los elementos de la interfaz voy a crear un objeto gui que llamaré cada 1 step y dibujará el contador.

```javascript
// obj_gui: Create
timer_sec = 0;
timer_msec = 1;

alarm[1] = room_speed/33;
```

```javascript
// obj_gui: Alarm 0
timer_msec = timer_msec + 3.333;

if (timer_msec > 99)
{
    timer_msec = 1;
    timer_sec += 1;

}
alarm[1] = room_speed / 33;
```

```javascript
// obj_gui: Draw GUI
var secs = "0";
var msecs = "0";

if (timer_sec < 10) secs = secs + string(timer_sec);
else secs = string(timer_sec);

if (timer_msec < 10) msecs = msecs + string(round(timer_msec));
else msecs = string(round(timer_msec));

draw_set_font(fnt_timer);
draw_set_halign(fa_left);
draw_text(25, 15, "TIME:  " + secs + ":" + msecs);
draw_set_halign(fa_right);
draw_text(room_width-25, 15, "MULTI:  " + string(global.spd));
```

¡Ah! Para evitar que se nos escale incorrectamente la GUI, hay que establecer el tamaño de la pantalla, por ejemplo al crear el controlador:

```javascript
// obj_controller: Create
display_set_gui_size(room_width, room_height);
```

Finalmente para cambiar los colores hay que conocer como funciona el sistema RGB y el sistema HSV. 

En cuanto a [RGB](http://es.wikipedia.org/wiki/RGB), representa que a partir de tres colores, rojo, verde y azul (Red, Green, Blue) es posible crear todos los demás mezclándolos. Tenemos 256 valores para cada uno de esos tres colores (0 a 255), representando el 0-0-0 la ausencia de color (negro) y el 255-255-255 el blanco. El rojo quedaría como 255-0-0, el verde 0-255-0 y el azul 0-0-255.

Teniendo lo anterior en cuenta, nuestro juego utiliza básicamente tres colores. Dos para el fondo más oscuros y uno base para las ráfagas, en conclusión podemos llegar a generar los dos del fondo a partir del color base.

Para hacerlo bien entra en juego el sistema [HSV](http://es.wikipedia.org/wiki/Modelo_de_color_HSV) que permite definir un color a partir de su matriz, saturación y brillo (Hue, Saturation, Value). Es precisamente jugando con la saturación y el brillo que podemos lograr correctamente oscurecer un color de base.

Así que la idea es generar nuestro color con RGB y convertirlo a HSV, oscurecerlo y convertirlo de vuelta a RGB para utilizarlo en Game Maker. Para ello utilizaré un par de códigos que he encontrado en el foro de [Yoyo Games](http://gmc.yoyogames.com/index.php?showtopic=321995) y me permitirán hacer las conversiones. 

```javascript
/* HSV to RGB
arg0: Hue
arg1: Sat
arg2: Val */

col=make_color_hsv(argument0,argument1,argument2)
red=color_get_red(col)
green=color_get_green(col)
blue=color_get_blue(col)
```

/* RGB to HSV
arg0: Red
arg1: Green
arg2: Blue */

col=make_color_rgb(argument0,argument1,argument2)
hue=color_get_hue(col)
sat=color_get_saturation(col)
val=color_get_value(col)
```

La cuestión es si generar colores aleatorios o partir de una paleta previa... Supongo que es mejor que prepare yo mismo unos cuantos colores de base. Por ahora iré a lo fácil (valores encontrados en la wikipedia):
* Rojo: 230-0-38
* Naranja: 230-95-0
* Verde: 0-145-80
* Azul:  0-112-184

Iré alternando estos 5 colores aleatoriamente cada vez que cambiamos de dirección, no sé como quedará pero me la voy a jugar.

La verdad no sé como empezar, supongo que debería crear un script que me devuelva uno de estos 3 colores aleatoriamente:

```javascript
// Creado por Héctor Costa Guzmán

// Script rand_color: Devuelve un color aleatorio de mi paleta de colores.

        //rojo     //naranja   //verde     //azul
var r;  r[0]=215;  r[1]=215;   r[2]=35;    r[3]=35;  
var g;  g[0]=35;   g[1]=145;   g[2]=215;   g[3]=145;
var b;  b[0]=35;   b[1]=35;    b[2]=35;    b[3]=215;

randomize();
var i = round(random(array_length_1d(r) - 1));

return make_color_rgb(r[i],g[i],b[i]);
```

Una vez tengo el color primario necesito oscurecerlo de forma variable y generar dos colores de fondo, uno más oscuro que el otro. Para ello me voy a crear una función que oscurezca un color rgb, lo transforme a hsv, le quite un porcentaje de brillo y lo devuelva de nuevo como rgb.

```javascript
// Creado por Héctor Costa Guzmán

// Script darken_color: 
// argument0 = color rgb
// argument1 = porcetaje a oscurecer

// Transformamos el color a hsv
var hue=color_get_hue(argument0);
var sat=color_get_saturation(argument0);
var val=color_get_value(argument0);

val -= argument1*255/100;

var hsv = make_color_hsv(hue,sat,val);

var red = color_get_red(hsv);
var green = color_get_green(hsv);
var blue = color_get_blue(hsv);

return make_color_rgb(red,green,blue);
```

Para utilizarlo básicamente lo que haré es esbalecer unos colores de inicio en el create del controlador y alternar los colores en el alarm 1 (al cambiar la rotación), asegurándome que siempre se devuelva uno nuevo.

```javascript
// obj_controller: Create
global.color = scr_rand_color();
global.bg_color_1 = scr_darken_color(global.color, 40); // lo oscurezco un 40%
global.bg_color_2 = scr_darken_color(global.color, 50); // lo oscurezco un 5%
```

```javascript
// obj_controller: Alarm 1
var new_color = scr_rand_color();
while(global.color == new_color) new_color = scr_rand_color();
global.color = new_color;
global.bg_color_1 = scr_darken_color(global.color, 40);
global.bg_color_2 = scr_darken_color(global.color, 50);
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img22.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img22.jpg)

