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

### Generar formas diferentes aleatoriamente

```javascript
///Obj_figure: Create
// Determinar el tipo de forma
randomize();
f_type = irandom(6); // generamos un numero aleatorio
f_grid = noone;
offset_i = 0;
offset_j = 3;
destroy = false;
switch f_type
{
    case 0:

        /// FIGURE 1  [][]
        ///           [][]
        f_grid = ds_grid_create(2,2);
        ds_grid_clear(f_grid, -1);
        f_grid[#0,0] = 1;
        f_grid[#1,0] = 1;
        f_grid[#0,1] = 1;
        f_grid[#1,1] = 1;
        break;
        
    case 1:

        /// FIGURE 2  []
        ///           [][][]
        f_grid = ds_grid_create(3,2);
        ds_grid_clear(f_grid, -1);
        f_grid[#0,0] = 7;
        f_grid[#0,1] = 7;
        f_grid[#1,1] = 7;
        f_grid[#2,1] = 7;
        offset_i = 1;
        break;
        
    case 2:
    
        /// FIGURE 3      []
        ///           [][][]
        f_grid = ds_grid_create(3,2);
        ds_grid_clear(f_grid, -1);
        f_grid[#1,0] = 6;
        f_grid[#0,1] = 6;
        f_grid[#1,1] = 6;
        f_grid[#2,1] = 6;
        offset_i = 2;
        break;
        
    case 3:

        /// FIGURE 4    []  
        ///           [][][]
        f_grid = ds_grid_create(3,2);
        ds_grid_clear(f_grid, -1);
        f_grid[#2,0] = 5;
        f_grid[#0,1] = 5;
        f_grid[#1,1] = 5;
        f_grid[#2,1] = 5;
        offset_i = 1;
        break;
        
    case 4:

        /// FIGURE 5      
        ///           [][][][]
        f_grid = ds_grid_create(4,1);
        ds_grid_clear(f_grid, -1);
        f_grid[#0,0] = 2;
        f_grid[#1,0] = 2;
        f_grid[#2,0] = 2;
        f_grid[#3,0] = 2;
        offset_i = 2;
        break;
        
    case 5:

        /// FIGURE 6    []  
        ///           [][]
        ///           []
        f_grid = ds_grid_create(2,3);
        ds_grid_clear(f_grid, -1);
        f_grid[#1,0] = 4;
        f_grid[#0,1] = 4;
        f_grid[#1,1] = 4;
        f_grid[#0,2] = 4;
        break;
        
    case 6:

        /// FIGURE 7  []  
        ///           [][]
        ///             []
        f_grid = ds_grid_create(2,3);
        ds_grid_clear(f_grid, -1);
        f_grid[#0,0] = 3;
        f_grid[#0,1] = 3;
        f_grid[#1,1] = 3;
        f_grid[#1,2] = 3;
        break;
        
}

// Iniciamos el movimiento
alarm[0] = room_speed;
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img5.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img5.jpg)

### Botón de desplazamiento instantáneo

```javascript
///Obj_figure: Step
// Comprobamos el movimiento horizontal
var x_move = 0;
var h_move = true;
var r_times = 1;

// Detección de movimiento horizntal contra las paredes
if keyboard_check_pressed(vk_right) 
{
    // form_position_i + spawn_point_i + min_i < max_i + form_width
    if (offset_i + round(10/(ds_grid_width(f_grid))) + global.min_i < global.max_i-ds_grid_width(f_grid))
    {
        //offset_i+=1;
        x_move=1;
    }
}

if keyboard_check_pressed(vk_left)
{
    // form_position_i + spawn_point_i > min_i
    if (offset_i + round(10/(ds_grid_width(f_grid))) > global.min_i)
    {
        //offset_i-=1;
        x_move=-1;
    }
}

if keyboard_check_pressed(vk_down)
{
    r_times = 20;
}


// Repeat X times
for(var k=0;k<r_times;k++)
{
    /// Comprobaremos si hay bloques a los lados (si hay movimiento) o debajo
    for (var i=0;i<ds_grid_width(f_grid);i++)
    {
        for (var j=0;j<ds_grid_height(f_grid);j++)
        {
            
            var new_i = i + offset_i+round(10/(ds_grid_width(f_grid)))+global.min_i;
            var new_j = j + offset_j + 1; //+1 por debajo
             
            // Si en la nueva posición  horizontal hay algo
            if (global.tablero[#new_i+x_move,new_j] > -1)
            {
                // Y si y solo si en esta posicion de la forma hay algo
                if (f_grid[#i,j] > -1) 
                {
                    // Entonces no podemos movernos
                    h_move = false;
                }
            }
            
            // Si por debajo en el tablero hay algo
            if (global.tablero[#new_i,new_j] > -1) 
            {
                // Y si y solo si en esta posicion del grid hay algo
                if (f_grid[#i,j] > -1) 
                {
                    // Marcamos para destruir
                    destroy = true;
                }
            }
        }
    }
    
    // Si podemos movernos horizontalmente lo hacemo
    if(h_move) offset_i+=x_move;
    
    // Si hay colision dibujaremos la forma en el tablero y la borraremos
    if (destroy)
    {
        for (var i=0;i<ds_grid_width(f_grid);i++)
        {
            for (var j=0;j<ds_grid_height(f_grid);j++)
            {
                //show_debug_message("CONTADOR");
        
                var new_i = i + offset_i+round(10/(ds_grid_width(f_grid)))+global.min_i;
                var new_j = j + offset_j;
                
                //show_debug_message("Check if destroy:" + string(f_grid[#i,j] > -1));
                if (f_grid[#i,j] > -1) 
                {
                    global.tablero[#new_i,new_j] = f_grid[#i,j];
                    destroy = true;
                    r_times = 0; // Aunque luego rompamos la instancia se acaban de repetir, por eso hay que sacaros ya
                }
            }
        }
        
        // Si no nos hemos movido
        if(offset_j==3) game_restart();
        
        global.new_form = true;
        instance_destroy();
    }
    
    if (r_times>1) offset_j+=1;
    
}
```

### Detectar y eliminar las filas completadas

```javascript
/// Obj_controller: Step

// Lista para guardar las filas completadas
var completadas = ds_list_create();

//// RECORREMOS LA GRID DE FORMA INVERSA FILAS->COLUMNAS, ACCEDEMOS CON J,I
for (var i=0;i<ds_grid_height(global.tablero);i++)
{
    var bloques_por_fila = 0;
    
    for (var j=0;j<ds_grid_width(global.tablero);j++)
    {
        if (global.tablero[#j,i] > 0 ) bloques_por_fila++;
    }
    
    if (bloques_por_fila == 10) ds_list_add(completadas, i);
    
}

//// RECORREMOS LA GRID DE FORMA INVERSA FILAS->COLUMNAS, ACCEDEMOS CON J,I
for(var k=0;k<ds_list_size(completadas);k++)
{
    // Sacamos una fila de la lista
    // Primero las filas más arriba (antes introducidas en la lista)
    var fila = ds_list_find_value(completadas, k); 
    
    // Buscamos la fila dentro de la grid
    for (var i=0;i<ds_grid_height(global.tablero);i++)
    {
        for (var j=0;j<ds_grid_width(global.tablero);j++)
        {
            // Borramos toda la fila menos sus paredes
            if(i == fila && global.tablero[#j,i] != 0 )
            {
                global.tablero[#j,i] = -1;
            }
        
        }
    }
    
    // Bajamos el valor de todos los elementos por encima de la fila borrada (menos las filas offset)
    for (var i=fila;i>=global.min_j;i--) // Vamos de la fila hacia arriba bajando los valores
    {
        for (var j=0;j<ds_grid_width(global.tablero);j++)
        {
            if(j >= global.min_j && j <= global.min_j+10 && global.tablero[#j,i] != 0 )
            {
                global.tablero[#j,i] =global.tablero[#j,i-1];  
                global.tablero[#j,i-1] = -1;
            }      
        }
    }
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img7.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img7.jpg)

### Rotar las figuras
Sólo podemos rotar una figura si esta no tiene colisiones al rotarla. Lo que haré es sencillo. 

* Crear la grid de todas las figuras rotadas con sus 4 ángulos en un script que modificará la grid actual de la figura a partir del ángulo.
* Detectar si queremos rotar la figura apretando algún botón.
* Si queremos rotar, rotamos a la posición.
* Comprobamos si no hay colisiones, lo haré en un nuevo script.
* Si no hay colisiones dejamos la figura rotada.
* Si hay colisiones deshacemos la rotación.

Script de rotación de figura:

```javascript
// scr_rotate_figure(): A partir del f_type y el f_angle establece la nueva grid de la figura rotada
// También se establece un offset i de figura para alinear horizontalmente la nueva figura rotada
if (f_type == 0)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 1  [][]
            ///           [][]
            f_grid = ds_grid_create(2,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 1;
            f_grid[#1,0] = 1;
            f_grid[#0,1] = 1;
            f_grid[#1,1] = 1;
            figure_offset_i = 0;
            break;
            
        case 1: // 90º

            /// FIGURE 1  [][]
            ///           [][]
            f_grid = ds_grid_create(2,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 1;
            f_grid[#1,0] = 1;
            f_grid[#0,1] = 1;
            f_grid[#1,1] = 1;
            figure_offset_i = 0;
            break;
            
        case 2: // 180º

            /// FIGURE 1  [][]
            ///           [][]
            f_grid = ds_grid_create(2,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 1;
            f_grid[#1,0] = 1;
            f_grid[#0,1] = 1;
            f_grid[#1,1] = 1;
            figure_offset_i = 0;
            break;            
            
        case 3: // 270

            /// FIGURE 1  [][]
            ///           [][]
            f_grid = ds_grid_create(2,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 1;
            f_grid[#1,0] = 1;
            f_grid[#0,1] = 1;
            f_grid[#1,1] = 1;
            figure_offset_i = 0;
            break;
    }
            
}    
if (f_type == 1)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 2  []
            ///           [][][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 7;
            f_grid[#0,1] = 7;
            f_grid[#1,1] = 7;
            f_grid[#2,1] = 7;
            figure_offset_i = 1;
            break;
            
        case 1: // 90º

            /// FIGURE 2    []
            ///             []
            ///           [][]
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 7;
            f_grid[#1,1] = 7;
            f_grid[#1,2] = 7;
            f_grid[#0,2] = 7;
            figure_offset_i = 0;
            break;
            
        case 2: // 180º

            /// FIGURE 2  [][][]
            ///               []
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 7;
            f_grid[#1,0] = 7;
            f_grid[#2,0] = 7;
            f_grid[#2,1] = 7;
            figure_offset_i = 1;
            break;
            
        case 3: // 270

            /// FIGURE 2  [][]
            ///           []
            ///           []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 7;
            f_grid[#1,0] = 7;
            f_grid[#0,1] = 7;
            f_grid[#0,2] = 7;
            figure_offset_i = 0;
            break;
    }
}    
if (f_type == 2)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 3      []
            ///           [][][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#2,0] = 6;
            f_grid[#0,1] = 6;
            f_grid[#1,1] = 6;
            f_grid[#2,1] = 6;
            figure_offset_i = 1;
            break
            
        case 1: // 90º

            /// FIGURE 3  [][]
            ///             []
            ///             []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 6;
            f_grid[#1,0] = 6;
            f_grid[#1,1] = 6;
            f_grid[#1,2] = 6;
            figure_offset_i = 0;
            break;
            
        case 2: // 180º

            /// FIGURE 3  [][][]
            ///           []
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 6;
            f_grid[#1,0] = 6;
            f_grid[#2,0] = 6;
            f_grid[#0,1] = 6;
            figure_offset_i = 1;
            break;
            
        case 3: // 270

            /// FIGURE 3  []   
            ///           []
            ///           [][]
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 6;
            f_grid[#0,1] = 6;
            f_grid[#0,2] = 6;
            f_grid[#1,2] = 6;
            figure_offset_i = 0;
            break;
    }
        
}    
 
if (f_type == 3)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 4    []  
            ///           [][][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 5;
            f_grid[#0,1] = 5;
            f_grid[#1,1] = 5;
            f_grid[#2,1] = 5;
            figure_offset_i = 1;
            break;
            
        case 1: // 90º

            /// FIGURE 4    []  
            ///           [][]
            ///             []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 5;
            f_grid[#0,1] = 5;
            f_grid[#1,1] = 5;
            f_grid[#1,2] = 5;
            figure_offset_i = 0;
            break;
            
        case 2: // 180º

            /// FIGURE 4  [][][]
            ///             []
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 5;
            f_grid[#1,0] = 5;
            f_grid[#2,0] = 5;
            f_grid[#1,1] = 5;
            figure_offset_i = 1;
            break;
            
        case 3: // 270

            /// FIGURE 4    []  
            ///             [][]
            ///             []  
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 5;
            f_grid[#0,1] = 5;
            f_grid[#1,1] = 5;
            f_grid[#0,2] = 5;
            figure_offset_i = 0;
            break;
    }
}

if (f_type == 4)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 5      
            ///           [][][][]
            f_grid = ds_grid_create(4,1);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 2;
            f_grid[#1,0] = 2;
            f_grid[#2,0] = 2;
            f_grid[#3,0] = 2;
            figure_offset_i = 2;
            break;
            
        case 1: // 90º

            /// FIGURE 5      
            ///           []
            ///           []
            ///           []
            ///           []
            f_grid = ds_grid_create(1,4);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 2;
            f_grid[#0,1] = 2;
            f_grid[#0,2] = 2;
            f_grid[#0,3] = 2;
            figure_offset_i = -4;
            break;
            
        case 2: // 180º

            /// FIGURE 5      
            ///           [][][][]
            f_grid = ds_grid_create(4,1);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 2;
            f_grid[#1,0] = 2;
            f_grid[#2,0] = 2;
            f_grid[#3,0] = 2;
            figure_offset_i = 2;
            break;
            
        case 3: // 270

            /// FIGURE 5      
            ///           []
            ///           []
            ///           []
            ///           []
            f_grid = ds_grid_create(1,4);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 2;
            f_grid[#0,1] = 2;
            f_grid[#0,2] = 2;
            f_grid[#0,3] = 2;
            figure_offset_i = -4;
            break;
    }
}

if (f_type == 5)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 6    []  
            ///           [][]
            ///           []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 4;
            f_grid[#0,1] = 4;
            f_grid[#1,1] = 4;
            f_grid[#0,2] = 4;
            figure_offset_i = 0;
            break;
            
        case 1: // 90º

            /// FIGURE 6  [][]  
            ///             [][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 4;
            f_grid[#1,0] = 4;
            f_grid[#1,1] = 4;
            f_grid[#2,1] = 4;
            figure_offset_i = 1;
            break;
            
        case 2: // 180º

            /// FIGURE 6    []  
            ///           [][]
            ///           []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 4;
            f_grid[#0,1] = 4;
            f_grid[#1,1] = 4;
            f_grid[#0,2] = 4;
            figure_offset_i = 0;
            break;
            
        case 3: // 270

            /// FIGURE 6  [][]  
            ///             [][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 4;
            f_grid[#1,0] = 4;
            f_grid[#1,1] = 4;
            f_grid[#2,1] = 4;
            figure_offset_i = 1;
            break;
    }
}    

if (f_type == 6)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 7  []  
            ///           [][]
            ///             []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 3;
            f_grid[#0,1] = 3;
            f_grid[#1,1] = 3;
            f_grid[#1,2] = 3;
            figure_offset_i = 0;
            break;
            
        case 1: // 90º

            /// FIGURE 7    [][]  
            ///           [][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 3;
            f_grid[#2,0] = 3;
            f_grid[#0,1] = 3;
            f_grid[#1,1] = 3;
            figure_offset_i = 1;
            break;
            
        case 2: // 180º

            /// FIGURE 7  []  
            ///           [][]
            ///             []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 3;
            f_grid[#0,1] = 3;
            f_grid[#1,1] = 3;
            f_grid[#1,2] = 3;
            figure_offset_i = 0;
            break;
            
        case 3: // 270

            /// FIGURE 7    [][]  
            ///           [][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 3;
            f_grid[#2,0] = 3;
            f_grid[#0,1] = 3;
            f_grid[#1,1] = 3;
            figure_offset_i = 1;
            break;
    }  
} 
```
Script de detección de colisiones:

```javascript
// scr_check_collision(offset_i+figure_offset_i, offset_j, x_move)
// Devuelve true/false

/// Comprobaremos si hay bloques a los lados (si hay movimiento) o debajo
for (var i=0;i<ds_grid_width(f_grid);i++)
{
    for (var j=0;j<ds_grid_height(f_grid);j++)
    {
        
        var new_i = i + argument0+round(10/(ds_grid_width(f_grid)))+global.min_i;
        var new_j = j + argument1 + 1; //+1 por debajo
         
        // Si en la nueva posición  horizontal hay algo
        if (global.tablero[#new_i+argument2,new_j] > -1)
        {
            // Y si y solo si en esta posicion de la forma hay algo
            if (f_grid[#i,j] > -1) 
            {
                // Entonces no podemos movernos
                return true;
            }
        }
        
        // Si por debajo en el tablero hay algo
        if (global.tablero[#new_i,new_j] > -1) 
        {
            // Y si y solo si en esta posicion del grid hay algo
            if (f_grid[#i,j] > -1) 
            {
                // Entonces no podemos movernos
                return true;
            }
        }
    }
}

return false;
```

La rotación entonces la haremos en el step del objeto figura, además tendremos que modificar todos los offset_i por figure_offset_i + offset_i para tener en cuenta esta nueva posición horizontal en todo el evento Step.

```javascript
/// Obj_figure: Step

// Comprobar si queremos rotar el objeto
if keyboard_check_pressed(vk_up)
{
	// Cambiamos el ángulo (sentido horario hacia atrás)
    f_angle -= 1;
    if(f_angle<0) f_angle = 3;
    
    // Rotamos la figura
    scr_rotate_figure();
    
    // Si hay un choque en la nueva posición rectificamos
    if scr_check_collision(figure_offset_i+offset_i,offset_j,x_move)
    {
        f_angle += 1;
        if(f_angle>3) f_angle = 0;
        // Y rectificamos
        scr_rotate_figure();
    }
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img6.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img6.jpg)

### Determinar la próxima figura y mostrarla

Una de las cosas que tiene Tetris es que puedes ver la próxima figura que va a salir. Para hacer esto voy a crear una variable f_next (siguiente).

Al principio del juego la pondré aleatoria de 0-6 y luego en el create de la figura lo que iré haciendo es indicar que f_type es f_next y luego conseguir otro valor random para f_next, de manera que podré dibujar la figura siguiente a partir del valor de f_next.

```javascript
/// Obj_controller: Create
global.f_next = irandom(6);
```

```javascript
/// Obj_figure: Create
f_type = global.f_next;
global.f_next = irandom(6);
f_next_grid = noone;

switch global.f_next
{
    case 0:

        /// FIGURE 1  [][]
        ///           [][]
        f_next_grid = ds_grid_create(2,2);
        ds_grid_clear(f_next_grid, -1);
        f_next_grid[#0,0] = 1;
        f_next_grid[#1,0] = 1;
        f_next_grid[#0,1] = 1;
        f_next_grid[#1,1] = 1;
        break;
        
    case 1:

        /// FIGURE 2  []
        ///           [][][]
        f_next_grid = ds_grid_create(3,2);
        ds_grid_clear(f_next_grid, -1);
        f_next_grid[#0,0] = 7;
        f_next_grid[#0,1] = 7;
        f_next_grid[#1,1] = 7;
        f_next_grid[#2,1] = 7;
        break;
        
    case 2:
    
        /// FIGURE 3      []
        ///           [][][]
        f_next_grid = ds_grid_create(3,2);
        ds_grid_clear(f_next_grid, -1);
        f_next_grid[#2,0] = 6;
        f_next_grid[#0,1] = 6;
        f_next_grid[#1,1] = 6;
        f_next_grid[#2,1] = 6;
        break;
        
    case 3:

        /// FIGURE 4    []  
        ///           [][][]
        f_next_grid = ds_grid_create(3,2);
        ds_grid_clear(f_next_grid, -1);
        f_next_grid[#1,0] = 5;
        f_next_grid[#0,1] = 5;
        f_next_grid[#1,1] = 5;
        f_next_grid[#2,1] = 5;
        
        break;
        
    case 4:

        /// FIGURE 5      
        ///           [][][][]
        f_next_grid = ds_grid_create(4,1);
        ds_grid_clear(f_next_grid, -1);
        f_next_grid[#0,0] = 2;
        f_next_grid[#1,0] = 2;
        f_next_grid[#2,0] = 2;
        f_next_grid[#3,0] = 2;
        break;
        
    case 5:

        /// FIGURE 6  [][]  
        ///             [][]
        f_next_grid = ds_grid_create(3,2);
        ds_grid_clear(f_next_grid, -1);
        f_next_grid[#0,0] = 4;
        f_next_grid[#1,0] = 4;
        f_next_grid[#1,1] = 4;
        f_next_grid[#2,1] = 4;
        break;
        
    case 6:

        /// FIGURE 7    [][]  
        ///           [][]
        f_next_grid = ds_grid_create(3,2);
        ds_grid_clear(f_next_grid, -1);
        f_next_grid[#1,0] = 3;
        f_next_grid[#2,0] = 3;
        f_next_grid[#0,1] = 3;
        f_next_grid[#1,1] = 3;
        break;
        
}
```

```javascript
/// Obj_figure: Draw
// Dibujamos la próxima figura en la esquina superior izquierda
for (var i=0;i<ds_grid_width(f_next_grid);i++)
{
    for (var j=0;j<ds_grid_height(f_next_grid);j++)
    {
        
        if (f_next_grid[#i,j] > -1) 
        {
            draw_sprite(spr_block,f_next_grid[#i,j],32*i+24,32*j+24);
        }
        //show_debug_message("END");
    }
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img8.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img8.jpg)

### Crear un marcador

```javascript
/// Obj_controller: Create
global.marcador = 0; // Marcador
```

```javascript
/// Obj_controller: Draw
draw_set_colour(c_white);
draw_set_font(fnt_score);
draw_set_halign(fa_right); // Dibujamos el marcador
draw_text(room_width-48, 16, string(global.marcador));
```

```javascript
/// Obj_controller: Step
// Sumamos 50 puntos por fila destruida cuando sacamos la fila de la lista completadas
global.marcador += 50;
```

```javascript
/// Obj_figure: Step
// Sumamos 4 puntos por cada pieza puesta correctamente
global.marcador += 4;
```

Finalmente le pondríamos un poco de música de fondo y ya tendríamos nuestro concepto de tetris.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img10.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/02_tetris.gmx/docs/img10.jpg)