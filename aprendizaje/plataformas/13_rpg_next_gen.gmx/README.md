## RPG Next Gen

El ejemplo original en inglés se puede encontrar en [Youtube](https://www.youtube.com/playlist?list=PL_4rJ_acBNMEGUMuO7IbivLgnvUxHklnj) y fue creado por el usuario [rm2kdev](https://www.youtube.com/user/rm2kdev/featured). 

### Parte 1: Creando nuestro héroe

* Creamos los sprites del héroe .
* Desactivamos la interpolacion entre pixels en las plataformas que queramos (en Global Game Settings).
* Creamos el objeto obj_Hero, dándole un image_index = 0.1 en el create.
* Creamos la room.
* Activamos la view y configuramos para seguir al heroe con el zoom:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img1.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img1.png)

* Añadimos los controles básicos:

```javascript
/// Handle Input Logic
if (keyboard_check(vk_left)){
    sprite_index = spr_Hero_Left;
    x -= 1;
}
if (keyboard_check(vk_right)){
    sprite_index = spr_Hero_Right;
    x += 1;
}
if (keyboard_check(vk_up)){
    sprite_index = spr_Hero_Up;
    y -= 1;
}
if (keyboard_check(vk_down)){
    sprite_index = spr_Hero_Down;
    y += 1;
}
```

* Probamos el juego:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img2.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img2.png)

### Parte 2: Tileset y técnicas de mapeo

* Creamos el background.
* En la room añadimos tiles de césped para simular el suelo.
* Creamos una capa con un numero inferior para los elementos superiores.
* Es buena idea tener una chuleta con el nombre de las capas de tiles:
	- 1000000 Floor
	- 999999 Paths and Grass
* Vamos añadiendo hierba para recrear un poco el mapa:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img3.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img3.png)

* Probamos el juego:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img4.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img4.png)

### Parte 3: Colisiones avanzadas y profundidad

* Extraemos una imagen de un árbol y creamos el objeto.
* Le añadimos físicas y una máscara shape pero dejando el triángulo libre en la mitad superior del árbol para hacer que el personaje pueda esconderse detrás, le damos densidad 0.
* Activamos las físicas en la room y desactivamos la gravedad (ponemos a 0).
* Damos densidad 0.1 al héroe y le otorgamos una máscara redonda.
* Ponemos unos cuantos árboles en la room.
* Ahora el personaje no se moverá por las físicas, lo que haremos es cambiar las **x** e **y** por **phy_position_x** y **phy_position_y** en el step.
* Añadimos un evento de colisión con el árbol sin nada dentro del código.
* Damos a cada árbol una depth dependiendo de su posición Y: **depth = y * -1;**
* Hacemos lo mismo para el héroe pero con la posicion Y física: **depth = phy_position_y * -1;**

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img5.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img5.png)

### Parte 4: Dándole vida a nuestro mundo

* Creamos una florecilla.
* Le añadimos el truco de la auto depth **depth = y * -1;**.
* Le creamos otro sprite, clonamos la flor y en la nueva imagen movemos la flor izquierda un pixel abajo a la izquierda, la derecha 1px abajo derecha y bajamos la del medio 1 px.
* Añadimos un script a la floor para animarla, con un random: **image_speed = 0.04 + random(0.03);**
* Hacemos lo mismo para animar los árboles, bajando 1 px cada capa del árbol y creando unas cuantas imagenes de subida y bajada
* Para corregir la profundidad de las flores ponemos el offset del sprite de la flor a 8:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img6.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img6.png)

### Parte 5: Haciendo limpieza

* En esta parte simplemente organizaremos un poco mejor los sprites, objetos y backgrounds del juego, tal como se muestra en la siguiente imagen:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img7.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img7.png)

### Parte 6: Cambios al estilo de RPG Maker

* Empezaremos creando un grupo de objetos System y un objeto dentro llamado GameState
* Creamos una nueva room rm_TitleScreen y le añadimos una instancia de GameState
* Haremos el objeto persistente y le añadiremos un evento Create inicializando todas las variables y un mapa donde guardaremos los estados del juego, por ejemplo si se ha mostrado la pantalla de inicio:

```javascript
/// Initialize Variables
global.gamespeed = 1.0;

switches = ds_map_create();
switches[? "introscene"] = true;
```

```javascript
/// Start Game
room_goto_next();
```

### Parte 7: Sistema dinámico de ventanas

* Empezamos creando dos grupos de sprites System > Window
* Importamos unas ventanas de un tile de RPG Maker "rpg maker vx ace windowskin"
* Partimos la ventana en partes de 16*16 y creamos un sprite para cada lado:
	* spr_Window_TL: Top Left
	* spr_Window_T: Top
	* spr_Window_TR: Top Right
	* spr_Window_ML: Middle Left
	* spr_Window_MR: Middle Right
	* spr_Window_BL: Bottom Left
	* spr_Window_B: Bottom
	* spr_Window_BR: Bottom Right
* También añadimos otro sprite para el fondo:
	* spr_Window_Base
* Creamos un objeto obj_Window_Base en System > Window y le ponemos el spr_Window_Base de fondo.
* Le añadimos un evento Draw que dibujará los bordes automáticamente:

```javascript
/// Draw Window

// Draw Background
draw_sprite_stretched(spr_Window_Base,0,x+4,y+4,sprite_width - 4, sprite_height - 4);

// Draw H V Axis
draw_sprite_stretched(spr_Window_T,0,x+8,y,sprite_width-8,16);
draw_sprite_stretched(spr_Window_B,0,x,y+sprite_height-10,sprite_width,16);

draw_sprite_stretched(spr_Window_ML,0,x,y,16,sprite_height);
draw_sprite_stretched(spr_Window_MR,0,x + sprite_width - 16,y,16,sprite_height);

// Draw Corners
draw_sprite(spr_Window_TL,0,x,y);
draw_sprite(spr_Window_TR,0,x+sprite_width-16,y);
draw_sprite(spr_Window_BL,0,x,y + sprite_height - 10);
draw_sprite(spr_Window_BR,0,x+sprite_width-16,y+sprite_height - 10);
```

* Ahora creamos unas cuantas ventanas en la room:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img8.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img8.png)

* Y el resultado es simplemente genial:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img9.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img9.png)

### Parte 8: Nuestro primer NPC "Bob"

* Creamos un grupo NPC > Bob en sprites.
* Creamos sus 4 sprites Down, Up, Left y Right y les damos el ancla al (16,32)
* Creamos un grupo NPC en objetos y el obj_NPC_Bob y le damos las mismas propiedades físicas y máscara de colisiones que al héroe.
* Creamos un obj_NPC_Base, le damos las mismas propiedades y máscara de colisiones que al héroe y un sprite por defecto.
* Añadimos una colisión al Heroe contra el obj_NPC_Base y el hack para la Depth correction en su Step.
* Hacemos que obj_NPC_Bob sea hijo de obj_NPC_Base de manera que heredará todas sus propiedades y eventos.
* Lo añadimos a la room.
* Añadimos ahora al NPC Bob un evento draw para dibujar lo que será su radio de acción y también a nuestro héroe:

```javascript
/// Debug Script
draw_self();
draw_circle(x,y,24,3);
```

* A continuación creamos una variable **action = false;** en el Create del héroe, y añadimos en el Input Handle Script una captura de la letra Z de manera que al apretar ese botón cambiamos **action** a True:

```javascript
if (keyboard_check(ord('Z'))){
    // Interact
    action = true;
    
} else {
    action = false;
}
```

* Cuando apretemos Z, pondremos **action** a True y entonces si estamos cerca de un NPC mostraremos un mensaje. Para hacerlo añadiremos al obj_NPC_Base un script en su Step llamado Hero Interaction:

```javascript
/// Hero interaction
var dist = point_distance(obj_Hero.phy_position_x,obj_Hero.phy_position_y,phy_position_x,phy_position_y);
if (dist < 32){
    if (obj_Hero.action == true){
        show_message("Test");
    }
}
```

* Añadimos al Create del obj_NPC_Base una nueva variable **message = "Undefined NPC";**.
* Y en el objeto hijo obj_NPC_Bob, añadimos la función **event_inherited** en su Create de manera que heredaremos todos los eventos del padre y sus variables:

```javascript
event_inherited();
message = "Hello... I'm Bob.";
```

* Ahora cambiamos **show_message("Test")** por **show_message(message);** y probamos si nuestro NPC habla:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img10.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img10.png)

### Parte 9: Nuestra primera misión

* La primera misión tratará de recolectar un objeto.
* Creamos un sprite llamado spr_Tea con el dibujo de un jarrón de té y una taza.
* A continuación creamos una jerarquía nueva de objetos: Quests > NPC Quest > NPC Bob con el objeto obj_Tea.
* Le activamos las físicas y la casilla **sensor** y lo ponemos en un lugar escondido de la room.
* Creamos dos nuevos disparadores en el GameState para gestionar si la misión está empezada y si se ha recogido el té:

```javascript
switches[? "quest_teaparty_started"]    = false;
switches[? "quest_teaparty_gottea"]     = false;
```

* Establecemos el evento Create:

```javascript
/// Initial vars and depth correction
depth = y*-1;
active = false;
```

* Establecemos el evento Step:

```javascript
/// Check if quest is started
if (GameState.switches[? "quest_teaparty_started"]  == true)
{
    active = true;
}
```

* La colisión del héroe contra el objeto:

```javascript
/// Check colision from hero
GameState.switches[? "quest_teaparty_gottea"] = true;
```

* Y el Draw para saber si debemos o no dibujar este objeto:

```javascript
/// Draw the object only if is active
if (active) draw_self();
```
 
* A continuación creamos una nueva variable **var quest = "";** en el obj_NPC_Base vacía y en el NPC_Bob le damos el valor **quest = "quest_teaparty_started";**.
* Y creamos otra llamada **var hasquest = false;** que inicializaremos a true en el NPC_Bob. De esta forma tendremos una misión en Bob.
* Ahora lo que haremos es iniciar la misión de Bob al hablar con él, para hacerlo únicamente modificaremos el Step del obj_NPC_Base y justo después de hablar añadiremos:

```javascript
if (hasquest){
    GameState.switches[? quest] = true; // quest equivale a 'quest_teaparty_gottea' en Bob
    show_debug_message("Quest Activated: " +  quest);
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img11.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img11.png)

* Ahora lo que haremos es destruir la instancia del objeto té cuando el héroe choca contra él **instance_destroy();**
* También añadiremos algunas variables más a obj_NPC_Base para tener un mejor control del NPC y sus respuestas:

```javascript
var message             = "Undefined Message NPC";
var questCondition       = "Undefined Quest Condition NPC";
var questMessage        = "Undefined Quest Message NPC";
var questSuccessMessage = "Undefined Quest Success Message NPC";

var hasquest = false;
var quest = false;
```

* Luego en el step del obj_NPC_Base haremos una comprobación de todas las posibilidades antes de mostrar los mensajes:

```javascript
/// Hero interaction
var dist = point_distance(obj_Hero.phy_position_x,obj_Hero.phy_position_y,phy_position_x,phy_position_y);
if (dist < 32){
    if (obj_Hero.action == true){
        // If the NPC has a quest
        if (hasquest){
            // If that quest has been successed show successQuestMessage
            if (GameState.switches[? questCondition]){
                show_message(questSuccessMessage);
            } else {
                // Else show questMessage
                show_message(questMessage);
                GameState.switches[? quest] = true;
                show_debug_message("Quest Activated: " +  quest);
            }
        } else {
            // Else show custom NPC message
            show_message(message);
        }
    }
}
```

* Por último en en el NPC Bob inicializaremos todas las variables:

```javascript
event_inherited();

hasquest = true;
quest = "quest_teaparty_started";
questCodition = "quest_teaparty_gottea";

questMessage = "Hello... I'm Bob the Ninja. I lost my tea at the end of the forest, please find it for me and I'll reward you.";
questSuccessMessage = "Oh!!! Thank you so much for finding my tea. God bless you.";
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img12.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img12.png)

### Parte 10: Mejorar las técnicas de mapeo

* En esta parte se explica como utilizar la herramienta RPG Maker VX Ace para crear un mapa genérico, borrarle los elementos y exportarlo utilizando un script que generará una imagen gigante en PNG.
* A continuación con Gimp (o Photoshop) utilizando la herramienta Sector, sectorizamos la imagen en varios trozos de tamaño 640*480.
* Una vez particionadas podemos importarlas en Game Maker. Para ello crearemos un grupo llamado Levels en Backgrounds y dentro otro llamado HomeCity.
* Entonces sólo tenemos que arrastrar las 9 imágenes al grupo creado como Backgrounds y marcarles la opción "Use as Tile Set" dándoles todo el ancho y alto de tamaño (ésto para las versiones 1.3 o mayores de GM:Studio).
* Ahora creamos una nueva room llamada rm_HomeCity, le daremos de tamaño 1376x1440, el tamaño del mapa original.
* En Tiles añadimos todos los trozos del mapa que hemos importado de manera que recreamos el mapa original.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img13.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img13.png)

* Esta técnica de mapeo partiendo el fondo en trozos grandes da unos FPS muy altos ya que en lugar de procesar múltiples tiles se procesa el fondo sólo una vez. Como se ve en el siguiente ejemplo al renderizar el juego oscila sobre los 5000 FPS (con un i7 4790K).

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img14.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img14.png)

* Ahora podemos poner unas cuantas flores y árboles de los que hemos creado anteriormente sobre nuestro fondo, añadimos nuestro héroe, activamos las físicas en la room, ponemos la gravedad a 0, activamos y configuramos las views y...

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img15.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img15.png)

* Como vemos seguimos con una cantidad de FPS muy alta incluso con las animaciones de los diferentes objetos en la pantalla.

### Parte 11: Colisiones y rendimiento

* Ya tenemos un background pero nuestro personaje se puede mover por todos sitios. Para evitarlo implementaremos una máscara de colisiones.
* Empezaremos creando un nuevo sprite 32x32, transparente de cualquier color en Sprites > System > Collisions > spr_Collision.
* Luego crearemos un objeto llamado obj_Collision en el grupo System y le daremos el sprite que hemos creado anteriormente.
* Creamos un evento de colisión en el heroe contra el obj_Collision con un código vacío.
* Volvemos un momento al obj_Collision, le activamos las físicas, le creamos una máscara cuadrada, ponemos la densidad a 0 para que no pueda ser empujado y muy importante, desmarcamos la casilla **Visible**.
* Paso siguiente crearemos objetos collision en el mapa sobre las zonas que queremos que el héroe no pueda pasar. Podemos darles diferentes tamaños de manera que cubriremos gran parte del mapa.
* Ahora en la room podemos deseleccionar la opción **Show Invisible Objects** en la lupa y alternar de forma cómoda la visión de las máscaras de colisión que vamos creando.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img16.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img16.png)

### Parte 12: Eventos de teletransporte - Parte 1

* Antes de empezar cabe comentar un pequeño código muy útil para dibujar las máscaras de colisión cuando tenemos activadas las físicas. Hay que ponerlo en el Draw de cualquier objeto:

```javascript
draw_self();
physics_draw_debug();
```

* Ahora de cara a crear unas nuevas rooms para transportarnos volvemos a exportar un mapa de RPG Maker (para testing). Repetimos todo el proceso y creamos una nueva room llamada rm_Pub, con sus colisiones y todo:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img17.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img17.png)

* Para gestionar el punto de aparición de nuestro héroe crearemos un nuevo sprite spr_Hero_Start y su correspondiente objeto obj_Hero_Start y lo hacemos invisible.
* Para las zonas de transporte (warp zones) crearemos uno igual spr_Hero_Warp y el objeto obj_Base_Warp con el mismo sprite.
* En el objeto obj_Base_Warp marcamos que usa físicas, le damos el sprite base, activamos **sensor** y le damos también una máscara de colisión que sea un cuadrado y una densidad 0.
* A continuación creamos un objeto base para gestionar el warp a la room rm_Pub en Warp > Locations llamado obj_Warp_Pub. Marcamos que usa físicas, le damos el sprite base, activamos **sensor** y le damos también una máscara de colisión que sea un cuadrado y una densidad 0.
* Creamos un warp zone **obj_Warp_Pub** en la puerta del PUB de la room rm_HomeCity:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img18.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img18.png)

* Ahora añadimos en el obj_Base_Warp un evento Create con la variable **var dest_room = -1;**.
* Seguidamente en el obj_Warp_Pub añadimos un evento create e inicializamos la variable con la room de destino:

```javascript
event_inherited();
dest_room = rm_Pub;
```

* Volvemos al obj_Base_Warp y creamos una colisión con el héroe:

```javascript
room_goto(dest_room);
```

* Ahora lo que tenemos que hacer es indicar al héroe que debe aparecer justo en el punto dónde indicamos el warp obj_Hero_Start dentro de la room rm_Pub:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img19.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img19.png)

* Para hacerlo empezaremos estableciendo nuestro héroe como **Persistent** y luego en el Create de obj_Hero_Start cambiaremos la posición del héroe a su localización:

```javascript
obj_Hero.phy_position_x = x;
obj_Hero.phy_position_y = y;
```

* Ahora ya nos funciona el warp, pero no hay forma de salir de la room, así que vamos a crear el sistema de retorno.
* Para hacerlo guardaremos en nuestro maper global la posición x e y del héroe justo antes de transportarse en el obj_Base_Warp:

```javascript
/// Go to destiny room but capture last room and point before
GameState.switches[? "last_room"] = room;
GameState.switches[? "last_pos_x"] = obj_Hero.phy_position_x;
GameState.switches[? "last_pos_y"] = obj_Hero.phy_position_y;
room_goto(dest_room);
```

* A continuación crearemos un nuevo objeto obj_Warp_Last_Post al que tendremos que llegar para transportarnos al punto guardado en nuestro maper global. Creamos una colisión con el héroe que lo transporte de vuelta a la room anterior y a la coordenada x,y guardada:

```javascript
/// Back to saved room and position
room_goto(GameState.switches[? "last_room"]);

obj_Hero.phy_position_x = GameState.switches[? "last_pos_x"];
obj_Hero.phy_position_y = GameState.switches[? "last_pos_y"];
```

* Añadimos nuestro obj_Warp_Last_Post en la salida de la room:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img20.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img20.png)

### Parte 13: Eventos de teletransporte - Parte 2

El sistema de transporte implementado anteriormente no era del todo funcional así que se ha hecho un remake.

* Empezaremos renombrando el obj_Hero_Start por obj_Hero_Reposition.
* También cambiamos el de obj_Base_Warp por obj_Warp.
* Seguidamente en el obj_Base_Warp crearemos las variables de destino:

```javascript
var dest_room = -1;
var dest_x = 0;
var dest_y = 0;
```

* Ahora borramos los objetos obj_Warp_Pub y obj_Warp_Last_Point.
* Añadimos un obj_Warp en la puerta del Pub y en su creation code ponemos:

```javascript
event_inherited();
dest_room = rm_Pub;
dest_x = 640 + 15; // Posición X de aparición en la casa
				   // El offset de 15 es para acabar de centrarlo
dest_y = 576; // Posición Y de aparición en la casa
```

* Actualizamos la colisión del obj_Warp guardando la última posición:

```javascript
/// Go to destiny room but capture last room and point before
GameState.switches[? "last_pos_x"] = dest_x;
GameState.switches[? "last_pos_y"] = dest_y;
room_goto(dest_room);
```

* Y hacemos lo mismo con el obj_Hero_Reposition:

```javascript
/// Set hero in warp position on create
obj_Hero.phy_position_x = GameState.switches[? "last_pos_x"];
obj_Hero.phy_position_y = GameState.switches[? "last_pos_y"];
```

* Ahora añadimos un obj_Hero_Reposition en cada room y otro obj_Warp en la salida del Pub, con creation code:

```javascript
event_inherited();
dest_room = rm_HomeCity;
dest_x = 288+16;
dest_y = 1120+16; // Este offset Y es muy importante para no salir sobre el warp de nuevo y volver a entrar XD
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img21.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img21.png)

* Ahora antes de probar el juego actualizaremos la posición inicial del jugador estableciendo en el mapeo global su posición en la room rm_CityHome en el objeto **GameState**:

```javascript
// Initial Player position
switches[? "last_pos_x"] = 288+15;
switches[? "last_pos_y"] = 1184;
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img22.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img22.png)

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img23.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img23.png)

### Parte 14: Ventanas animadas

* Vamos de vuelta a nuestro obj_Window_Base.
* Le añadimos un evento Create con **start = false;**.
* Un Step con:

```javascript
if (start == true){
	// lerp => interpolación en %
	// lerp(0,10,0.5) devuelve 5 (el 50% entre 0 y 10)
	// lerp(0,10,2) devuelve 20 (el 200% entre 0 y 10)
	image_yscale = lerp(image_yscale, target_yscale, 0.4);
	progress = image_yscale / target_yscale;
	y = lerp(start_y, target_y, progress);
}
```

* A continuación creamos un evento de usuario en la ventana:

```javascript
/// User Defined 0
target_y = y; // Guardamos la posición y donde se crea la ventana
start_y = y + sprite_height / 2; // La ventana se empezará a dibujar en el centro vertical
y = start_y; // Damos a y el nuevo valor de inicio

target_yscale = image_yscale; // Guardamos el escalado inicial vertical de la ventana
image_yscale = 0; // Reiniciamos a 0 el escalado vertical
start = true; // Establecemos a true para poder comenzar el proceso de escalado
```

* Para probar las ventanas podemos crear un evento Global Clic Left en el GameState con el siguiente código:

```javascript
/// Creamos una ventana al hacer clic con el mouse
with ( instance_create(mouse_x-32,mouse_y-32,obj_Window_Base)){
    image_xscale = 1 + random (4);
    image_yscale = 1 + random (2);
    event_user(0);    
}
```

* Ahora para darle un toque más interesante podemos modificar el color de fondo sobre la marcha y añadirle un poco de transparencia. Lo podeos hacer fácilmente modificando el método **draw_sprite_stretched** del background a:

```javascript
// Draw Background
draw_sprite_stretched_ext(spr_Window_Base,0,x+4,y+4,sprite_width - 4, sprite_height - 4,c_black,0.3);
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img24.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img24.png)

### Parte Extra: Añadir texto y sonido a las ventanas (propio)

En este apartado he decidido adaptar a mi manera el generador de ventanas para añadirle texto apareciendo poco a poco y un efecto de sonido como el de los juegos de Phoenix Wright.

* Primero creamos un script llamado scr_Create_Window que se encargará de crear la instancia de la ventana e inicializar una serie de variables (como el tamaño de la misma) a partir de la longitud del texto que queremos mostrar:

```javascript
// Nombre: Script Ventana
// Descripción: Muestra un texto dentro una caja creada dinámicamente
// a partir del tamaño del texto, y lo muestra poco a poco.
// Uso: scr_text("Text",speed,x,y);

with ( instance_create(argument2,argument3,obj_Window_Base)){
    
    padding = 16;
    maxlength = view_wview[0];
    text = argument0;           // Establecemos el texto del primer argumento
    spd = argument1;            // Establecemos la velocidad del segundo argumento
    font = fnt_Window;         // Establecemos una fuente

    text_length = string_length(text); // Longitud del texto
    font_size = font_get_size(font);   // Tamaño de la fuente

    // Establecemos la fuente
    draw_set_font(font);

    // Tamaño aproximado del texto w y h
    text_width = string_width_ext(text, font_size + (font_size/2), maxlength);
    text_height = string_height_ext(text, font_size + (font_size/2), maxlength);

    // Le sumamos los márgenes interiores (paddings)
    box_width = text_width + (padding*2);
    box_height = text_height + (padding*2);   

    // Calculamos el redimensionamiento de escalado, por defecto 48x48 equivale 1x1
    image_xscale = 1 * box_width / (48+padding);
    image_yscale = 1 * box_height / (48+padding+6); // offset de 6 inferior
    
    // Llamamos al evento que dibujará la ventana    
    event_user(0);    
}
```

* Ahora en el **Create** del obj_Window_Base ponemos el código que iniciará las variables y empezará a reproducir el primer sonido al escribir:

```javascript
start = false;
alpha = 0;  	 // La transparencia será el máximo
print_text = ""; // Texto que se va a ir mostrando
time = 0;   	 // Tiempo en que se irá mostrando el texto
depth = depth - instance_number(obj_Window_Base); // Profundidad

/// Play first sound while letters appearing
if (audio_is_playing(snd_Talking) == false)
{   
    audio_play_sound(snd_Talking, 10, false);
}
stop_sound = true;   
```   

En el **Step** tendremos dos códigos, el de calcular el tamaño (ya lo tenemos) y uno nuevo en el que iremos guardando las letras del texto a escribir en el Draw y manejaremos el sonido:

```javascript
/// Show letters little by little and manage sound
if (time < text_length)
{   
    time += spd; // Sumamos al tiempo la velocidad que graduamos nosotros
    print_text = string_copy(text,0,time); // E iremos añadiendo poco a poco el texto     
    
    /// Play sound while letters appearing
    if (audio_is_playing(snd_Talking) == false){   
        if (audio_is_playing(snd_Talking2) == false){
            audio_play_sound(snd_Talking2, 10, true);
        }
    }
}
// When text is completed then stop sound
else
{
    // Check if we should stop sound
    if (stop_sound) 
    {
        // Stop it
        audio_stop_sound(snd_Talking2);
        stop_sound = false;
    }
}
```   

* El evento **User Defined 0** también está correcto, pero en **Draw** vamos a dibujar también a parte de la ventana el texto por encima:

```javascript
/// Draw text
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_ext(
    x + padding,               // Dentro del margen interior horizontal
    y + padding,               // Dentro del margen interior vertical
    print_text,                // El texto a escribir
    font_size + (font_size/2), // Distancia en px entre cada línea
    maxlength                  // Ancho máximo en px antes de cada salto de línea
);
``` 

* Ahora sólo nos queda actualizar nuestro evento **Global Left Pressed** para crear correctamente la instancia. A modo de pruebas generaré varios textos con diferentes tamaños:

```javascript
/// Creamos una ventana al hacer clic con el mouse
var str;
switch(irandom(4))
{
    case 0: 
        str = "Lorem ipsum dolor sit amet,#consectetur adipiscing elit.#Aliquam ultricies imperdiet augue.#Ut cursus lacus dui.";
        break
    case 1: 
        str = "Aliquam ultricies imperdiet augue.#Ut cursus lacus dui.";
        break

    case 2: 
        str = "In posuere diam quis massa accumsan rhoncus id in est.";
        break

    case 3: 
        str = "Donec vel est feugiat.";
        break

    default: 
        str = "Etiam in justo nisl.";
        break
}
    
scr_Create_Window(str,1,mouse_x,mouse_y);
``` 

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img25.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img25.png)

### Parte 15: Caminos de patrullas y movimiento de NPC

* Empezamos creando 4 nuevos sprites para un NPC que llamaremos Guard.
* Duplicamos el NPC Bob a obj_NPC_Guard con el sprite spr_Guard_Down por defecto.
* Lo añadimos al mapa en algun sitio en medio del camino.
* Ahora vamos a crear un Path llamado path_Guard. Empezando por la posición inicial del Guarda creamos un camino que éste seguirá.
* Podemos activar de fondo la room para ver el recorrido:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img26.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img26.png)

* A continuación vamos a crear un nuevo sprite spr_Follow_Target, algo sencillo, con una bola dentro. Le centramos el anchor.
* Ahora creamos un nuevo objeto obj_Follow_Target y le otorgamos el sprite anterior.
* En el NPC_Base_Create añadimos el código

```javascript
// Create a target for every NPC
my_target = instance_create(x,y,obj_Follow_Target);
my_path = -1;
``` 

* Todos los NPC podrán tendran un objeto target y un path, utilizarlos o no es cosa nuestra, pero de base ahí están.
* Es necesario crear un objeto target para poder hacer que el NPC se mueva correctamente en nuestro mundo de físicas.
* En el obj_NPC_Guard_Create personalizamos un poco nuestro guarda y le otorgamos un path:

```javascript
event_inherited();
hasquest = true;
message = "Hello there. This town is safe under my control";
my_path = path_Guard;
event_user(0); // Evento asociado para empezar el movimiento
``` 

* Vamos a crear el evento personalizado Obj_NPC_Base.User Defined 0 encargado de poner en marcha el Path en el objeto auxiliar (la bola):

```javascript
with(my_target){
	path_start(other.my_path,1,0,1);
}
```

* En este punto tenemos la bolita moviéndose por la pantalla pero nuestro Guarda todavía no la siguie:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img27.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img27.png)

* Ahora vamos al obj_NPC_Base.Step y añadimos un nuevo bloque de código para hacer que el NPC se mueva en dirección a su target object:

```javascript
/// Follow Path if available
if(my_path != -1)
{
    // Calculate the direction where is the target
    	dir = point_direction(my_target.x,my_target.y,phy_position_x,phy_position_y);
    	dis = point_distance(my_target.x,my_target.y,phy_position_x,phy_position_y);
    
    // Calculate moving position 2px into target
    	dx = lengthdir_x(2,dir);
    	dy = lengthdir_y(2,dir);
    
    // And Move it   
   	phy_position_x -= dx;
   	phy_position_y -= dy;
}
```

* Con ésto el héroe ya se mueve pero si lo bloqueamos veremos que no controla las colisiones correctamente:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img28.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img28.png)

* Vamos a crear un evento de colisión con obj_Collision en el obj_NPC_Base con un código vacío.
* Sin embargo ésto no soluciona el problema del todo y crea uno nuevo, y es que eventualmente el Guarda se nos queda atrapado en el Pub! Esto sucede porque está siguiendo la posición x del target.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img29.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img29.png)

* Para solucionarlo (por ahora) vamos a hacer que si el Guard se aleja demasiado de su target se teletransporte detrás automáticamente añadiendo al step una comprobación de distancia:

```javascript
/// Follow Path if available
if(my_path != -1)
{
    // Calculate the direction where is the target
    	dir = point_direction(my_target.x,my_target.y,phy_position_x,phy_position_y);
    	dis = point_distance(my_target.x,my_target.y,phy_position_x,phy_position_y);
    
    // Calculate moving position 2px into target
    	dx = lengthdir_x(2,dir);
    	dy = lengthdir_y(2,dir);
    
    // And Move it   
   	phy_position_x -= dx;
   	phy_position_y -= dy;

   	// If distance is increasing teleport the npc
   	if (dis > 32){
   		phy_position_x = my_target.x;
   		phy_position_y = my_target.y;
   	}
}
```

### Parte Extra: Ventanas de texto en NPC en movimiento (propio)

He adaptado un poco más mi script generador de ventanas de diálogo para hacer que aparezcan sobre los NPC y se muevan con ellos en el caso que éstos tengan un Path.

**scr_Create_Window**
```javascript
// Nombre: Script Ventana
// Descripción: Muestra un texto dentro una caja creada dinámicamente
// a partir del tamaño del texto, y lo muestra poco a poco.
// Uso: scr_text("Text",speed,origin_object);
var window = instance_create(argument2.x,argument2.y,obj_Window_Base);
with (window){
    
    origin_object = argument2;

    padding = 16;
    maxlength = view_wview[0];
    text = argument0;           // Establecemos el texto del primer argumento
    spd = argument1;            // Establecemos la velocidad del segundo argumento
    font = fnt_Window;         // Establecemos una fuente

    text_length = string_length(text); // Longitud del texto
    font_size = font_get_size(font);   // Tamaño de la fuente

    // Establecemos la fuente
    draw_set_font(font);

    // Tamaño aproximado del texto w y h
    text_width = string_width_ext(text, font_size + (font_size/2), maxlength);
    text_height = string_height_ext(text, font_size + (font_size/2), maxlength);

    // Le sumamos los márgenes interiores (paddings)
    box_width = text_width + (padding*2);
    box_height = text_height + (padding*2);   
    
    // Relocate window position
    x = x-box_width/2;
    y = y-box_height/2 - 60; // negative offset top

    // Calculamos el redimensionamiento de escalado, por defecto 48x48 equivale 1x1
    image_xscale = 1 * box_width / (48+padding);
    image_yscale = 1 * box_height / (48+padding+6);
    
    // Llamamos al evento que dibujará la ventana    
    event_user(0);
}   
    
// return id
return window; 
```

**obj_Window_Base.Create**
```javascript
start = false;
alpha = 0;  // La transparencia será el máximo
print_text = ""; // Texto que se va a ir mostrando
time = 0;   // Tiempo en que se irá mostrando el texto
depth = depth - room_height - instance_number(obj_Window_Base); // Profundidad

/// Play first sound while letters appearing
if (audio_is_playing(snd_Talking) == false)
{   
    audio_play_sound(snd_Talking, 10, false);
}
stop_sound = true; 

// Talking box sizes
box_width = 0;
box_height = 0;

// origin object to follow
origin_object = noone;
```

**obj_Window_Base.Step_1**
```javascript
/// Calculate new resizes
if (start == true){
    // lerp => interpolación en %
    // lerp(0,10,0.5) devuelve 5 (el 50% entre 0 y 10)
    // lerp(0,10,2) devuelve 20 (el 200% entre 0 y 10)
    image_yscale = lerp(image_yscale, target_yscale, 0.4);
    progress = image_yscale / target_yscale;
    y = lerp(start_y, target_y, progress);
}
```

**obj_Window_Base.Step_2**
```javascript
/// Show letters little by little and manage sound
if (time < text_length)
{   
    time += spd; // Sumamos al tiempo la velocidad que graduamos nosotros
    print_text = string_copy(text,0,time); // E iremos añadiendo poco a poco el texto     
    
    /// Play sound while letters appearing
    if (audio_is_playing(snd_Talking) == false){   
        if (audio_is_playing(snd_Talking2) == false){
            audio_play_sound(snd_Talking2, 10, true);
        }
    }
}
// When texts is completed then
else
{
    // Check if we should stop sound
    if (stop_sound) 
    {
        // Stop it
        audio_stop_sound(snd_Talking2);
        stop_sound = false;
    }
}
```

**obj_Window_Base.Step_3**
```javascript
/// Relocate the window
x = origin_object.x-box_width/2;
y = origin_object.y-box_height/2 - 60; // negative offset top
```

**obj_Window_Base.User Defined 0**
```javascript
/// User Defined 0
target_y = y; // Guardamos la posición y donde se crea la ventana
start_y = y + sprite_height / 2; // La ventana se empezará a dibujar en el centro vertical
y = start_y; // Damos a y el nuevo valor de inicio

target_yscale = image_yscale; // Guardamos el escalado inicial vertical de la ventana
image_yscale = 0; // Reiniciamos a 0 el escalado vertical
start = true; // Establecemos a true para poder comenzar el proceso de escalado
```

**obj_Window_Base.Draw 1**
```javascript
/// Draw Window

// Draw Background
draw_sprite_stretched_ext(spr_Window_Base,0,x+4,y+4,sprite_width - 4, sprite_height - 4,c_white,0.75);

// Draw H V Axis
draw_sprite_stretched(spr_Window_T,0,x+8,y,sprite_width-8,16);
draw_sprite_stretched(spr_Window_B,0,x,y+sprite_height-10,sprite_width,16);

draw_sprite_stretched(spr_Window_ML,0,x,y,16,sprite_height);
draw_sprite_stretched(spr_Window_MR,0,x + sprite_width - 16,y,16,sprite_height);

// Draw Corners
draw_sprite(spr_Window_TL,0,x,y);
draw_sprite(spr_Window_TR,0,x+sprite_width-16,y);
draw_sprite(spr_Window_BL,0,x,y + sprite_height - 10);
draw_sprite(spr_Window_BR,0,x+sprite_width-16,y+sprite_height - 10);
```

**obj_Window_Base.Draw 2**
```javascript
/// Draw text
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_ext(
    x + padding,               // Dentro del margen interior horizontal
    y + padding,               // Dentro del margen interior vertical
    print_text,                // El texto a escribir
    font_size + (font_size/2), // Distancia en px entre cada línea
    maxlength                  // Ancho máximo en px antes de cada salto de línea
);
```

Ahora para manejar las ventanas de texto añadiremos al **obj_NPC_Base.Create**:

```javascript
// Manage the text window
is_talking = false;
talk_window = noone;
```

Crearemos una alarma **obj_NPC_Base.Alarm 0** para manejar cuando se puede volver a hablar con el personaje (para no ir sacando múltiples ventanas) y destruir la instancia actual:

```javascript
/// Stop talking
is_talking = false;
with (talk_window) instance_destroy();
```

Ahora modificaremos el **obj_NPC_Base.Step2**  para que en lugar de mostrar un message box genérico muestre nuestra ventana de diálogo:

```javascript
/// Hero interaction
var dist = point_distance(obj_Hero.phy_position_x,obj_Hero.phy_position_y,phy_position_x,phy_position_y);
if (dist < 32){
    if (obj_Hero.action == true){
        // If the NPC has a quest
        if (hasquest){
            // If that quest has been successed show success
            if (GameState.switches[? questCondition]){
                if !(is_talking) {
                    talk_window = scr_Create_Window(questSuccessMessage,1,id);
                    is_talking = true;
                }
            } else {
                // Else
                if !(is_talking) {
                    talk_window = scr_Create_Window(questMessage,1,id);
                    is_talking = true;
                    GameState.switches[? quest] = true;
                    //show_debug_message("Quest Activated: " +  quest);
                }
            }
        } else {
            if !(is_talking) {
                // Else show inhertied custom message
                talk_window = scr_Create_Window(message,1,id);
                is_talking = true;
            }
        }
    }
}
```

Y añadimos un pequeño código en  **obj_NPC_Base.Step4** que destruirá la instancia a los 5 segundos si el NPC está hablando: 

```javascript
/// Check if should stop talking
if (is_talking && alarm[0]==-1){
    alarm[0] = room_speed * 5; //cerrar en 5 segundos
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img30.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img30.png)

### Parte Extra: Animar los NPC (propio)

Para animar los NPC necesitaremos tener un esquema genérico de sus sprites de movimiento, por ejemplo:

* Animación por defecto (sprite + indice de imagen)
* Animación hacia arriba
* Animación hacia abajo
* Animación hacia la izquierda
* Animación hacia la derecha

Empezaremos por añadir en el obj_NPC_Base.Create un espacio para almacenar los diferentes sprites de dirección:

```javascript
// Animation vars
deault_Sprite = 0;
default_Index = 0;
default_Sprite_Speed = 0;
left_Sprite = 0;
right_Sprite = 0;
up_Sprite = 0;
down_Sprite = 0;
default_Animation_Speed = 0.1;
```

Y añadiremos un nuevo código al obj_NPC_Base.Step para que en función de la próxima posición dónde se moverá el NPC dibuje un sprite u otro:

```javascript
/// Process the animation
if(phy_position_x+dx<phy_position_x){
    sprite_index=right_Sprite;
    image_speed = default_Animation_Speed;
}

else if(phy_position_x+dx>phy_position_x){
    sprite_index=left_Sprite;
    image_speed = default_Animation_Speed;
}

else if(phy_position_y+dy>phy_position_y){
    sprite_index=up_Sprite;
    image_speed = default_Animation_Speed;
}

else if(phy_position_y+dy<phy_position_y){
    sprite_index=down_Sprite;
    image_speed = default_Animation_Speed;
}
else {
    sprite_index=down_Sprite;
    image_index = default_Index;
    image_speed = default_Sprite_Speed;
}
```

Por último en el obj_NPC_Guard.Create inicializaremos todas las variables de animación:
```javascript
event_inherited();

hasquest = false;
message = "Hello there.#This town is safe under my control!";

my_path = path_Guard;
event_user(0); // Evento asociado para empezar el movimiento

/// Set animation variables
deault_Sprite = spr_Guard_Down;
left_Sprite = spr_Guard_Left;
right_Sprite = spr_Guard_Right;
up_Sprite = spr_Guard_Up;
down_Sprite = spr_Guard_Down;
default_Index = 1;
default_Sprite_Speed = 0;
default_Animation_Speed = 0.2;
```

El resultado es viable aunque da problemas por las colisiones. **Si cambiamos la densidad del NPC a 0** entonces funciona totalmente bien:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img31.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img31.png)

### Parte Extra: Parar animación y movimiento del NPC al hablar

He decidido antes de continuar acabar de pulir la animación del NPC si éste se encuentra quieto. Para gestionarlo utilizaremos la variable **path_speed** del objeto target que nos permitirá graduar la velocidad de movimiento.

Empiezo creando tres nuevas variables en el **obj_NPC_Base.Create** para manejar la velocidad por defecto de la patrol, así como una predeclaración de las dx y dy que se usan en el cálculo de movimiento del NPC:

```javascript
my_path_speed = 2;
dx = 0;
dy = 0;
```

Ahora creo dos nuevos eventos de usuario para Pausar el Path y reaunudarlo, así como modifico el primer evento de usuario para indicar la velocida de movimiento en **my_path_speed**:

```javascript
/// Obj_NPC_Base.User Event 0
//Start path moving with associated object
var ps = my_path_speed;
with(my_target){
    path_start(other.my_path,ps,1,1);
}
```

```javascript
/// Obj_NPC_Base.User Event 1
// Pause path moving with associated object
with(my_target){
    path_speed = 0;
}
```

```javascript
/// Obj_NPC_Base.User Event 2
// Continue path moving with associated object
var ps = my_path_speed;
with(my_target){
    path_speed = ps;
}
```

Ahora actualizaré la alarma para indicar que al destruir la ventana de texto se continue la marcha con el event 2:

```javascript
/// Obj_NPC_Base.Alarm 0
// Stop talking
is_talking = false;
with (talk_window) {
    instance_destroy();
}
event_user(2); // Continue walking
```

También actualizaré el Step con la interacción del héroe para parar la velocidad de movimiento utilizando el event 1:

```javascript
/// Obj_NPC_Base.Step 2
// Hero interaction
var dist = point_distance(obj_Hero.phy_position_x,obj_Hero.phy_position_y,phy_position_x,phy_position_y);
if (dist < 32){
    if (obj_Hero.action == true){
        // If the NPC has a quest
        if (hasquest){
            // If that quest has been successed show success
            if (GameState.switches[? questCondition]){
                if !(is_talking) {
                    talk_window = scr_Create_Window(questSuccessMessage,1,id);
                    is_talking = true;
                    event_user(1); // Stop moving while talking
                }
            } else {
                // Else
                if !(is_talking) {
                    talk_window = scr_Create_Window(questMessage,1,id);
                    is_talking = true;
                    GameState.switches[? quest] = true;
                    event_user(1); // Stop moving while talking
                    //show_debug_message("Quest Activated: " +  quest);
                }
            }
        } else {
            if !(is_talking) {
                // Else show inhertied custom message
                talk_window = scr_Create_Window(message,1,id);
                is_talking = true;
                event_user(1); // Stop moving while talking
            }
        }
    }
}
```

Y el Step que maneja el movimiento del NPC cambiaré la velocidad 2 por la establecida en la variable:

```javascript
/// Obj_NPC_Base.Step 2
// Follow Path if available
if(my_path != -1 && my_target.path_speed != 0){
    // Calculate the direction where is the target
    dir = point_direction(my_target.x,my_target.y,phy_position_x,phy_position_y);
    dis = point_distance(my_target.x,my_target.y,phy_position_x,phy_position_y);
    
    // Calculate moving position at custom speed into target
    dx = lengthdir_x(my_path_speed,dir);
    dy = lengthdir_y(my_path_speed,dir);
    
    // And Move it   
   phy_position_x -= dx;
   phy_position_y -= dy;
    
    // If distance is increasing teleport the npc
   if (dis > 32){
        phy_position_x = my_target.x;
        phy_position_y = my_target.y;
   }
}
```

Por último, ahora que tenemos una velocidad de path variable será muy sencillo detectar cuando el NPC estará parado (path_speed será 0) así que podemos animar el NPC en parado:

```javascript
/// Obj_NPC_Base.Step 2
// Process the animation

// If NPC is quiet
if(my_target.path_speed == 0 ){
    sprite_index = down_Sprite;
    image_speed = default_Sprite_Speed;
    image_index = default_Index;
} 
// If is moving
else { 
    if(phy_position_x+dx<phy_position_x){
        sprite_index=right_Sprite;
        image_speed = default_Animation_Speed;
    } else if(phy_position_x+dx>phy_position_x){
        sprite_index=left_Sprite;
        image_speed = default_Animation_Speed;
    } else if(phy_position_y+dy>phy_position_y){
        sprite_index=up_Sprite;
        image_speed = default_Animation_Speed;
    } else if(phy_position_y+dy<phy_position_y){
        sprite_index=down_Sprite;
        image_speed = default_Animation_Speed;
    }
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img32.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img32.png)

### Parte 16: Monstruos

* Para este tema empezamos creando un nuevo mapa de pruebas dónde posicionaremos nuestros enemigos.
* Para llegar a este nuevo mapa tendremos que salir del pueblo por el sur, así que una vez tengamos el mapa preparado con la room en marcha, yo le he llamado rm_Desert, crearemos un nuevo Warp Zone (en realidad serán 3 para abarcar todo el camino), e indicaremos en sus creation code la posición exacto de la room dónde iran a parar, el primero de la izquierda qudaría así:

```javascript
event_inherited();
dest_room = rm_Desert;
dest_x = 192 + 15;
dest_y = 26;
```

* Y a su vez el primero de la izquierda de vuelta a la ciudad desde rm_Desert quedaría:

```javascript
event_inherited();
dest_room = rm_HomeCity;
dest_x = 640+16;
dest_y = 1344+16;
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img33.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img33.png)

* Bien, ahora vamos a ponernos manos a la obra creando el nuevo grupo de sprites Enemies > Desert Mobs y como antes creamos los 4 sprites de turno y tal.
* Creamos el obj_Desert_Monster, activamos las físicas, le damos un 0.1 de densidad, la máscara redonda y el sprite que toca.
* Le ponemos un image_speed 0.1 en el Create para limitar la animación.
* Clonamos el objeto y creamos un obj_Base_Monster para declarar unas variables comunes que luego se heredarán, así que ponemos al obj_Desert_Monster como hijo del obj_Base_Monster.
* Añadimos al Héroe un evento de colisión vacío contra el monster base.
* Y en la base del monstruo una colisión contra los demás monstruos y otra contra las máscara de colisión general.
* Ahora vamos a añadir movimiento a los mobs. Para ello vamos a crear un evento Create, una alarma y un Step:

**obj_Desert_Monster.Create**
```javascript
randomize();
alarm[0] = random(60);
dx = 0;
dy = 0;
```

**obj_Desert_Monster.Alarm 0**
```javascript
dir = random(360);
dx = lengthdir_x(2, dir);
dy = lengthdir_y(2, dir);

/// No usamos esto, pero es interesante el efecto
// physics_apply_impulse(x,y,dx,dy);

alarm[0] = random(60);
```

**obj_Desert_Monster.Step**
```javascript
phy_position_x += dx;
phy_position_x += dy;
```

* Con ésto los bichos se moverán pero lamentablemente se saldrán de mapa mientras se mueven a todos lados aleatoriamente.
* La forma más sencilla de limitarles el movimiento es crear una pequeña máscara de colisión que sólo les afecte a ellos.
* Así que podemos duplicar fácilmente la actual y llamar a la nueva obj_Enemy_Collision y hacer que tengan colisiones únicamente los enemigos con ella, haciendo que queda de una forma muy sutil como en la siguiente imagen:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img34.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img34.png)

* Añadimos la colisión del monstruo base contra esta nueva máscara. Ahora ya tendremos los bichos moviéndose por ahí sin salirse de sus límites, como en un RPG de verdad ^^:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img35.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img35.png)

* Y ya si queremos rizar el rizo podemos añadirle animaciones en el step:

```javascript
/// Process the animation

if(phy_position_x+dx<phy_position_x){
    sprite_index=spr_Desert_Mob_Left;
}

else if(phy_position_x+dx>phy_position_x){
    sprite_index=spr_Desert_Mob_Right;
}

else if(phy_position_y+dy>phy_position_y){
    sprite_index=spr_Desert_Mob_Down;
}

else if(phy_position_y+dy<phy_position_y){
    sprite_index=spr_Desert_Mob_Up;
}

if(phy_position_y+dy==phy_position_y && phy_position_x+dx==phy_position_x){
    sprite_index=spr_Desert_Mob_Down;
}
```

* Acompañados de un cambio en la distancia de la alarm para que de tanto en tanto sea 0 y se queden quitas:

```javascript
randomize();
dir = random(360);
dx = lengthdir_x(irandom(2), dir);
dy = lengthdir_y(irandom(2), dir);
alarm[0] = random(60);
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img36.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img36.png)

### Parte 17: Ataques en el héroe

* En este RPG en tiempo real los ataques van a ser básicamente disparos mágicos. Tendremos varios diferentes y podremos cambiar entre ellos con las teclas 1-2-3. 

* Por defecto el ataque será el primero:

```javascript
///obj_Hero.Create
...
attack_type = 1;
```

* Añadimos 3 eventos key_press para los dígitos 1,2 y 3 que simplemente cambiarán el ataque por defecto:

```javascript
///obj_Hero.Key_press
attack_type = 1; // 2 o 3
```

* Ahora creamos un evento Draw GUI en el héroe para mostrar información sobre el tipo de ataque activo:

```javascript
draw_text(10,10, "Attack Type": + string(attack_type));
```

* Creamos un obj_Attack_Fire (luego crearemos otros tipos):

```javascript
///spr_Attack_Fire.Create
```

```javascript
///spr_Attack_Fire.Create
alarm[0] = 20;
image_speed = 0.25;
phy_fixed_rotation = true;
force = 16;
```

```javascript
///spr_Attack_Fire.Alarm 0
instance_destroy();

```javascript
///spr_Attack_Fire.Collision with obj_Monster_Base
// angle bullet to enemy
hit_angle = point_direction(x,y,other.phy_position_x,other.phy_position_y);
hit_dx = lengthdir_x(5,hit_angle);
hit_dy = lengthdir_y(5,hit_angle);

randomize();
damage = 1 + random(3);

with (other) {              // other aqui es la bullet
    hp -= other.damage;
    physics_apply_impulse(x,y,other.hit_dx,other.hit_dy);
    phy_fixed_rotation = true;
    if(hp<=0){
        instance_destroy();
    }
}

instance_destroy();
```

* Creamos el disparo en el héroe al apretar el botón del ratón:

```javascript
/// obj_Hero.global_Left_Pressed
// Create a bullet
dir = point_direction(phy_position_x, phy_position_y, mouse_x, mouse_y);
spawn_x = lengthdir_x(16, dir); // a 24px del centro del heroe
spawn_y = lengthdir_y(16, dir); 
attack_obj = 0;

// Select the attack
switch(attack_type){
    case 1:
        attack_obj = obj_Attack_Fire;
        break;
    case 2:
        attack_obj = obj_Attack_Ice;
        break;
    case 3:
        attack_obj = obj_Attack_Lighting;
        break;
}

// restamos el offset -16 para crearlo justo sobre le heroe
attack = instance_create(phy_position_x+spawn_x, phy_position_y+spawn_y, other.attack_obj);

with(attack){
    force_x = lengthdir_x(force, other.dir); 
    force_y = lengthdir_y(force, other.dir); 
    phy_rotation = -other.dir;
    physics_apply_impulse(x,y, force_x, force_y);
}
```

* Añadimos vida genérica en el monstruo base:

```javascript
/// obj_Monster_Base.Create
max_hp = 10;
hp = max_hp;
```

* Heredamos en nuestro monstruo:

```javascript
/// obj_Monster_Desert.Create
event_inherited();
randomize();
image_speed = 0.15;
alarm[0] = random(60);
dx = 0;
dy = 0;
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img37.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img37.png)

### Parte Extra: Mejorando el movimiento de los mobs

Una pequeña mejora de la IA nos permitirá crear un efecto de movimiento más suave y real. Haremos que el mob se mueva lentamente mientras el héroe no se encuentre en su radio de visión. Al acercarse, el mob se moverá hacia la dirección del héroe mucho más rápido.

```javascript
/// obj_Monster_Desert.Create
event_inherited();
randomize();
image_speed = 0.15;
alarm[0] = random(60);
hero_dist = 0;  // distancia del héroe
vision_r = 48;  // radio de visión del mob
dx = 0;
dy = 0;
```

```javascript
/// obj_Monster_Desert.Alarm 0
randomize();
if (hero_dist < vision_r){  // si está en el rango de visión
    dir = point_direction(x,y, obj_Hero.phy_position_x, obj_Hero.phy_position_y);  
    dist = random(4)+8;
    dx = lengthdir_x(dist, dir);
    dy = lengthdir_y(dist, dir); 
    alarm[0] = 1+random(7);  
} else {
    if (random(2) > 1) // si no lo está sólo hay un 50% de que se mueva 
    {
        dir = random(360);    
        dist = irandom(4);
        dx = lengthdir_x(dist, dir);
        dy = lengthdir_y(dist, dir);  
        alarm[0] = 1+random(15);  
    } else {
        dx = 0;
        dy = 0;   
        alarm[0] = 1+random(30);  
    }
}

```javascript
/// obj_Monster_Desert.Step
// Movit
phy_position_x += dx / 5;
phy_position_y += dy / 5;
```

Podemos crear un modo debug para dibujar el radio de detección del héroe, de color verde si no se encuentra dentro, y rojo si se detecta:

```javascript
/// obj_Monster_Desert.Draw
event_inherited();
draw_self();

if (hero_dist < vision_r){
    draw_circle_color(x,y,vision_r, c_red,c_red,1);
    draw_line_colour(x,y,obj_Hero.phy_position_x,obj_Hero.phy_position_y,c_red,c_red);
} else{
    draw_circle_color(x,y,vision_r, c_green,c_green,1);
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img38.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/13_rpg_next_gen.gmx/Screens/img38.png)