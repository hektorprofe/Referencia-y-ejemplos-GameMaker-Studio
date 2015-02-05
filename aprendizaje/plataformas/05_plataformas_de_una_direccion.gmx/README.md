## Plataformas de una dirección
### Evento Create
Desactivamos el sprite para quitar la máscara de colisión:
```javascript
sprite_index = -1; 
```

### Evento Step
```javascript
if (instance_exists(obj_hero))
{
    // si el heroe + su altura/2 se encuentra por encima de la y de la plataforma
    // o si hay key_down pulsada desactivamos la máscara de colisión
    if (round(obj_hero.y + (obj_hero.sprite_height/2)) > y) || (obj_hero.key_down) mask_index = -1; 
    // si está por debajo o no se apreta tecla abajo
    // activamos la mascara de colision
    else mask_index = spr_platform; 
}
```

### Evento Draw
```javascript
draw_sprite(spr_platform,0,x,y); // dibujamos sin máscara de colisión
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/05_plataformas_de_una_direccion.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/05_plataformas_de_una_direccion.gmx/captura.jpg)