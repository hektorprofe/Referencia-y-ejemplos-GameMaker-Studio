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




































