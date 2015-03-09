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






