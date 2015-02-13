## Logic Challenge

Los logic challenge son unos ejercicios de análisis que me he propuesto hacer a lo largo de mi arendizaje en el desarrollo de videojuegos. Se trata de observar, analizar e investigar un tipo de juego concreto, y determinar si se puede, o mejor dicho, soy capaz de crear un concepto similar en Game Maker. 

# Logic Challenge 1: Hexagon

[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/GWBu5yDql6E/0.jpg)](http://www.youtube.com/watch?v=GWBu5yDql6E)

En este primer logic challenge quiero empezar fuerte y me he propuesto estudiar el juego Hexagon del desarrollador Terry Cavanagh. Este juego lo programó en un sólo un día a principios de 2012 y le sirvió como prototipo para crear el famoso Super Hexagon.

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

Aquí hay unos apuntos sobre [las razones trigonométricas](http://www.vitutor.com/al/trigo/tri_2.html) por si hay que repasar.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img7.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img7.jpg)

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img8.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img8.jpg)

