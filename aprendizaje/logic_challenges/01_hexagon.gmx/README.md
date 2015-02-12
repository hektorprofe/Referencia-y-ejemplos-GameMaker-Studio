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
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/logic_challenges/01_hexagon.gmx/docs/img1.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/01_hexagon.gmx/docs/img1.jpg)