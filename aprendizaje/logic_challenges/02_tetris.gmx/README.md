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

### Creación e inicialización del tablero