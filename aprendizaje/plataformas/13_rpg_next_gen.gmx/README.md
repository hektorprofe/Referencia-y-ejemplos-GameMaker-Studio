## RPG Next Gen

El ejemplo original en inglés se puede encontrar en [Youtube](https://www.youtube.com/playlist?list=PL_4rJ_acBNMEGUMuO7IbivLgnvUxHklnj) y fue creado por el usuario [rm2kdev](https://www.youtube.com/user/rm2kdev/featured). 

### Parte 1: Creando nuestro héroe

* Creamos los sprites del héroe .
* Desactivamos la interpolacion entre pixels en las plataformas que queramos (en Global Game Settings).
* Creamos el objeto obj_Hero, dándole un image_index = 0.1 en el create.
* Creamos la room.
* Activamos la view y configuramos paa seguir al heroe con el zoom:

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

- creamos el background
- en room añadimos tiles todo de cesped
- añadimos una capa con un numero inferior
- creamos una chuleta con el nombre de las capas de tiles
  1000000 Floor
   999999 Paths and Grass
- Vamos añadiendo hierba para recrear un poco el mapa
img3.png
- probamos el juego
img4.png

### Parte 3: Colisiones avanzadas y profundidad

- extraremos una imagend e un arbol y creamos el objeto,
- añadimos fisicas y una mascara shape pero dejando el triángulo libre de la mitad arriba del árbol para hacer que el personaje pueda esconderse detras, le damos densidad 0.0
- activamos las fisicas en la room y desactivamos la gravedad
- damos densidad 0.1 al Heroe para que no se pueda mover y le otorgamos una máscara redonda
- ponemos unos cuantos árboles en la room
- ahora el personaje no se moverá por las físicas, lo que haremos es cambiar las x e y por phy_position_x y phy_position_y en el step
- añadimos un evento de colision con el árbol sin nada dentro
- damos a cada arbol una depth dependiendo de su posicion y: depth = y * -1;
- hacemos lo mismo para el heroe pero con la posicion y física: depth = phy_position_y * -1;
img5.png

### Parte 4: Dándole vida a nuestro mundo

- creamos una florecilla
- añadimos el truco de la auto depth
- creamos otro sprite , clonamos la flor y movemos la flor izquierda un pixel abajo a la izquierda y la derecha 1px abajo derecha y bajamos la dl medio 1 px
- añadimos un script a la floor para animarla, con un random
- hacemos lo mismo para animar los árboles, bajando 1 px cada capa del árbol y creando unas cuantas imagenes de subida y bajada
- para corregir la profundidad de las flores ponemos el offset de la flor a 8
img6.png

### Parte 5: Haciendo limpieza

- En esta parte simplemente organizaremos un poco mejor los sprites, objetos y backgrounds del juego, tal como se muestra en la siguiente imagen:
img6.png

### Parte 6:







