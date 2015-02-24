## Logic Challenge

Los logic challenge son unos ejercicios de análisis que me he propuesto hacer a lo largo de mi aprendizaje en el desarrollo de videojuegos. Se trata de observar, analizar e investigar un tipo de juego concreto, y determinar si se puede, o mejor dicho, soy capaz de crear un concepto similar en Game Maker. 

# Logic Challenge 3: La Brisca Reloaded

En éste, mi tercer logic challenge quiero reencontrarme con mi antiguo yo. Fue en febrero de 2011 cuando hice mi primer juego, [LaBrisca](https://github.com/hcosta/LaBrisca) programado en Java y utlizando la orientación a objetos, cuyo mayor reto fue programar la inteligencia artificial.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/03_la_brisca_reloaded.gmx/docs/img1.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/logic_challenges/03_la_brisca_reloaded.gmx/docs/img1.jpg)

Evidentemente carecía de muchas funcionalidades, de hecho no era ni un juego real, sinó que se basaba en un formulario sobre una ventana vacía. Como en aquel entonces no sabía en que se basaban los videojuegos me las apañé como pude, pero debo reconocer que el resultado me gustó y fue una experiencia de la que ahora es el momento de sacar provecho, mucho provecho.

## Análisis Previo

En cuanto a la lógica los juegos de cartas son sencillos, ya que sólo se requiere recrear el juego en objetos, listas y matrices cuando sea necesario. Además como en este caso ya sé la lógica lo que quiero hacer en este análisis es enfocarme en la jugabilidad y los fallos que cometí en la antigua versión.

### Valoración de la antigua versión

* La interacción era totalmente con el teclado y como resultado era un juego confuso y con poca jugabilidad.  
* Las explicaciones y opciones del juego aparecían explicadas en ventanas emergentes al apretar diferentes teclas, lo que conllevaba más confusión y errores de interpretación.
* Aunque habían algunos elementos que dibujaban la interfaz gráfica y el resultado del juego en todo momento, estos elementos no tenían un espacio propio que diferenciara la GUI del tablero.
* En lo que se refiere al juego en sí el mayor problema es que entre jugadas el jugador no se da cuenta de que le toca jugar, ya que no había transiciones entre las manos del jugador y la cpu.
* En los momentos especiales del juego que se pueden hacer cambios de cartas no se da ningún aviso al jugador.
* Algo divertido era que al ganar una partida el jugador escuchaba una melodía famosa de un RPG.

### Correcciones para la nueva versión

* Se enfocará toda la jugabilidad a través de los clics, las acciones presionar y arrastrar tendrán sus propios usos.
* Se creará una pantalla inicial, con un menú de juego y sus espacios de ayuda si es necesario.
* Se diseñará un espacio para la GUI que quede integrado en el tablero de juego.
* Se enfocarán los turnos de los jugadores de manera que en todo momento el jugador sepa que es su turno.
* Se notificará de alguna forma cuando el jugador pueda realizar jugadas especiales, como un cambio de cartas.
* Se añadirán animaciones y sonidos a las cartas para enfatizar el propio ritmo del juego.
* Una música de fondo no muy alta podría amenizar las partidas, se valorará.

## Trasladando el concepto

Para enfocar este juego en GameMaker voy a intentar recrear sus diferentes elementos en objetos. 

* Objeto carta: Contendrá un palo, un número, una puntuación y un estado (volteada si/no).
* Objeto baraja: Contendrá una lista con todas las cartas. 
* Objeto jugador: Contendrá una lista con la mano actual (<=3 cartas) y otra lista con las cartas ganadas.
* Objeto jugada: Contendrá una lista con las cartas jugadas de cada jugador (<=2 cartas).

## Descripción del flujo de juego

* Se empieza con la baraja de 48 cartas y se mezcla unas cuantas veces.
* Se toman 3 cartas de la baraja para cada jugador.
* Se toma 1 carta de triunfo para indicar el palo ganador y se sitúa debajo de la baraja.
* Empieza aleatoriamente uno de los dos jugadores a jugar la primera ronda.
* Cada jugador tira una carta, éstas se enfrentan en la jugada y se determina un ganador.
* El ganador se queda con las dos cartas y toma una carta de la baraja.
* El perdedor toma otra carta de la baraja.
* El ganador empieza de nuevo la ronda y se repite el ciclo hasta que ambos se quedan sin cartas.
* Cuando se han jugado todas las cartas se hace el recuento de puntos y se anuncia el ganador.

Situaciones especiales / ajustes extras:

* Al ganar una mano se puede cambiar el 2 del palo triunfo por las cartas del 3 al 7.
* Al ganar una mano se puede cambiar el 7 del palo triunfo por las cartas del 10 al 12.
* Arrastrar en la última ronda si el jugador tiene el triunfo más alto. (el as arrastra el 3 o las mayores de su palo).

