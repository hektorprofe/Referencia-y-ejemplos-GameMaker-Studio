## Logic Challenge

Los logic challenge son unos ejercicios de análisis que me he propuesto hacer a lo largo de mi aprendizaje en el desarrollo de videojuegos. Se trata de observar, analizar e investigar un tipo de juego concreto, y determinar si se puede, o mejor dicho, soy capaz de crear un concepto similar en Game Maker. 

# Logic Challenge 2: Tetris

Mi segundo logic challenge quiero dedicarlo a crear una versión propia Tetris en forma de tributo a este clásico juego de puzzles.

[![video](http://img.youtube.com/vi/QDGAN_kPkPI/0.jpg)](https://www.youtube.com/watch?v=QDGAN_kPkPI)

## Análisis Previo

Tetris es un juego de puzzle basado en una rejilla de 21x12 en la que al contornear los márgenes izquierdo, inferior y derecho queda un espacio libre de 20x10 cuadros que forma el espacio de juego.

El juego en sí consiste en piezas que aparecen en la parte superior y van descendiendo por la pantalla hasta quedar en el suelo o sobre otras piezas. Hay 7 piezas diferentes, todas formadas por 4 cuadros dispuestos de distantas maneras (tetris -> tetra = 4). 

La meta es formar el máximo posible de filas totalmente ocupadas por las piezas que caen. Para lograrlo es posible voltear las piezas 90º para darles la vuelta y adaptarlas para prograr la mejor composición. Cada fila formada correctamente puntuará una cantidad de puntos y el juego acaba cuando se acumulan tantas piezas malpuestas que ya no es posible continuar jugando.

### Trasladando el concepto

Ya que este juego se basa en una rejilla de cuadros, creo que lo plantearé entero sobre una grid.

Empezaré creando un sprite con bloques 32x32 de todos los colores que forman las diferentes formas, incluyendo las paredes:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img2.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img2.jpg)

La idea es que la rejilla tenga 21 filas y 12 columnas, dejando el margen izquierdo, derecho e inferior para crear unas paredes, tal como muestro en la siguiente imagen:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img1.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img1.png)

Al empezar el juego se inicializará la matriz (o grid) tablero, poniendo todo a -1 y las posiciones de las paredes a 0. A partir de aquí concordará el valor de la matriz con el sprite a dibujar, siendo -1 ninguno, 0 la pared y los demás números los otros colores.

En cuanto a las formas las gestionaré con un objeto llamado form que se encargará de inicializar una forma, con su posición inicial i,j en el centro de la sala y arriba. Y su estructura será definida con matrices. Por ejemplo el cuadrado 2x2 en forma matricial sería [(1,1),(1,1)]. 

En cada step el objeto form añadirá +1 a su posición j si y sólo si en el j+(altura de la forma)+1 relativa al tablero está vacía (en -1) para todas las posiciones del objeto. En cuanto al movimiento horizontal será parecido al vertical y si hay un valor -1 en el eje x-+1 no moveremos la forma.

A la hora de dibujar la forma, realmente lo que haremos es cambiar en la grid tablero el valor de cada celda, dejando a -1 la posición anterior y estableciendo el nuevo valor del sprite_index en cada posición. 

Como tendremos un juego totalmente guardado en una grid, dibujarlo en el evento Draw será tan fácil como recorrer todas las posiciones de la tabla e ir estableciendo los sprites en función del valor a una distancia i x 32 e j x 32, teniendo en cuenta el tamaño de cada sprite.

Y finalmente para simular la rotación crearé una variable llamada angle con valores 0,1,2,3 que a partir de un switch determinará la matriz a aplicar para cada rotación. Evidentemente antes de confirmar la rotación se comprobará que haya espacio en la grid para rotar.

### El objeto controlador (tablero)

```javascript
///Obj_controller: Create
global.tablero = ds_grid_create(room_width / 32, room_height / 32);
ds_grid_clear(global.tablero, -1);

// Inicialización de las paredes
global.min_i = 1;
global.max_i = 12;
global.min_j = 2;
global.max_j = 22;

for (var i=0;i<ds_grid_width(global.tablero);i++)
{
    for (var j=0;j<ds_grid_height(global.tablero);j++)
    {
        // pared izquierda
        if (i == global.min_i && j > global.min_j && j < global.max_j) global.tablero[#i,j] = 0;   
        // pared derecha
        if (i == global.max_i && j > global.min_j && j < global.max_j) global.tablero[#i,j] = 0;   
        // pared inferior
        if (j == global.max_j && i >= global.min_i && i <= global.max_i) global.tablero[#i,j] = 0; 
    }
}
```

```javascript
///Obj_controller: Draw
draw_clear(c_black);

for (var i=0;i<ds_grid_width(global.tablero);i++)
{
    for (var j=0;j<ds_grid_height(global.tablero);j++)
    {
        if (global.tablero[#i,j] > -1) draw_sprite(spr_block,global.tablero[#i,j],32*i+16,32*j+16);
    }
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img3.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img3.jpg)


### El objeto figura
Voy a empezar probando de crear un cuadrado 2x2.

```javascript
///Obj_figure: Create
show_debug_message("Created");

// Determinar el tipo de forma
f_type = 0;
f_angle = 0;
f_grid = noone;
offset_i = 0;
offset_j = 3;
destroy = false;

f_grid = ds_grid_create(2,2);
ds_grid_clear(f_grid, -1);

// Cuadrado 2x2
f_grid[#0,0] = 1;
f_grid[#1,0] = 1;
f_grid[#0,1] = 1;
f_grid[#1,1] = 1;

// Iniciamos el movimiento
alarm[0] = room_speed;
```

```javascript
///Obj_figure: Alarm 0
offset_j += 1; // movemos una posición abajo la figura
alarm[0] = room_speed/50; // esto es para que caiga muy rápido
```

```javascript
///Obj_figure: Step
/// Comprobar si debajo en el global grid hay algun elemento diferente a -1

// Detección de movimiento horizntal
if keyboard_check_pressed(vk_right) 
{
    // form_position_i + spawn_point_i + min_i < max_i + form_width
    if (offset_i + round(10/(ds_grid_width(f_grid))) + global.min_i < global.max_i-ds_grid_width(f_grid)) offset_i+=1;
}
if keyboard_check_pressed(vk_left)
{
    // form_position_i + spawn_point_i > min_i
    if (offset_i + round(10/(ds_grid_width(f_grid))) > global.min_i) offset_i-=1;
}
//if (offset_i > global.max_i-1) offset_i = global.max_i;

// Detección del bloque
for (var i=0;i<ds_grid_width(f_grid);i++)
{
    for (var j=0;j<ds_grid_height(f_grid);j++)
    {
    
        var new_i = i + offset_i+round(10/(ds_grid_width(f_grid)))+global.min_i;
        var new_j = j + offset_j + 1; //+1 por debajo
        
        // Si por debajo en el tablero hay algo
        if (global.tablero[#new_i,new_j] > -1) 
        {
            // Y si y solo si en esta posicion del grid hay algo
            if (f_grid[#i,j] > -1) 
            {
                destroy = true;
            }
        }
    }
}

// Si hay colision dibujaremos eso en el tablero
if (destroy)
{
    for (var i=0;i<ds_grid_width(f_grid);i++)
    {
        for (var j=0;j<ds_grid_height(f_grid);j++)
        {
            show_debug_message("CONTADOR");
    
            var new_i = i + offset_i+round(10/(ds_grid_width(f_grid)))+global.min_i;
            var new_j = j + offset_j;
            
            if (f_grid[#i,j] > -1) 
            {
                global.tablero[#new_i,new_j] = f_grid[#i,j];
                destroy = true;
            }
        }
    }
    global.new_form = true;
    // si no nos hemos movido
    if(offset_j==3) game_restart();
    instance_destroy();
}
```

```javascript
///Obj_figure: Draw
for (var i=0;i<ds_grid_width(f_grid);i++)
{
    for (var j=0;j<ds_grid_height(f_grid);j++)
    {
    
        var new_i = i + offset_i+round(10/(ds_grid_width(f_grid)))+global.min_i;
        var new_j = j + offset_j;
        
        if (f_grid[#i,j] > -1) 
        {
            show_debug_message(string(f_grid[#i,j]));
            draw_sprite(spr_block,f_grid[#i,j],32*new_i+16,32*new_j+16);
        }
        show_debug_message("END");
    }
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img4.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img4.jpg)