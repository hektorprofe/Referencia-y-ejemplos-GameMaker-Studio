## Animaciones
Crearemos varios sprites para nuestros personajes con diferentes aspectos. Caminando, saltando, cayendo o parado. Sólo las necesitamos en una dirección.

### Luego en el evento Step del héroe dependiendo de hsp y vsp cambiamos los sprite
```javascript
// primero daremos volteraremos horizontalmente el sprite dependiende del lado al que nos movemos
if (move!=0) image_xscale = move;
// si estamos en el suelo
if (place_meeting(x,y+1,obj_wall))
{
	// si estamos en movimiento horizontal ponemos el sprite de caminar o correr
    if (hsp!=0) sprite_index = spr_hero_walk; 
    // o el sprite parado si estamos quietos
    else sprite_index = spr_hero_idle;

    // si queremos seguir caminando aunque topemos con una pared
    // entonces deberíamos substituir hsp!=0 por move!=0
}
// si no estamos en el suelo
else 
{
	// si estamos moviéndonos hacia arriba ponemos el sprite de salto
    if (vsp < 0) sprite_index = spr_hero_jump;
    // y si estamos cayendo cambiamos al sprite de caer
    else sprite_index = spr_hero_fall;
}

```

Una mejor práctica sería declarar unas variables al detectar anteriormente las colisiones y ahorrarnos de esa forma repetir las detecciones.

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/09_animaciones.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/09_animaciones.gmx/captura.jpg)