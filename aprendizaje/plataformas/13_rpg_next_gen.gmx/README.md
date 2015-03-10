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
* Ahora creamos una nueva room llamada rm_HomeCity, le daremos de tamaño 1376*1440, el tamaño del mapa original.
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