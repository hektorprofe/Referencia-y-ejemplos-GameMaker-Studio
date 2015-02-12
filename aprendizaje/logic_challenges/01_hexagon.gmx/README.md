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

// Script polígno: Dibuja un polígono en una coordenada.
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

// Script polígno: Dibuja un polígono en una coordenada.
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