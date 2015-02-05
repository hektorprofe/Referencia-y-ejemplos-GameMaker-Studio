## Plataformas en movimiento
Son exactamente iguales que las plataformas de una dirección pero tienen en cuenta algunos factores extra:

### Actualizamos las variables iniciales del héroe
```javascript
hsp_carry = 0; // velocidad de carga de una plataforma
```

### Actualizamos el movimiento horizontal del héroe en su Step
```javascript
// Calcular la velocidad final con carga y reiniciar v carga
// Esta variable nueva solo existe en este step y nos permite evitar
// una aceleracion si sumaramos hsp_carry a hsp directamente
var hsp_final = hsp + hsp_carry;
hsp_carry = 0;

// Y en horizontal collision tendremos en cuenta esta hsp_final
if (place_meeting(x+hsp_final,y,obj_wall))
{
    while(!place_meeting(x+sign(hsp_final),y,obj_wall))
    {
        x += sign(hsp_final);
    }
    hsp_final = 0;
    hsp = 0;
}
x += hsp_final;
```

### Evento Create de la plataforma en movimiento
Tienen dirección y velocidad de movimiento horizontal
```javascript
sprite_index = -1;
dir = -1;
movespeed = 2;
hsp = 0;
```

### Evento Step de la plataforma en movimiento
```javascript
// otorgamos una máscara, necesaria para la f() place_meeting
mask_index = spr_platformM; 
// le otortgamos la velocidad horizontal
hsp = dir * movespeed;
// creamos una detección de colisiones horizontal con su rectificación
if (place_meeting(x+hsp,y,obj_wall))
{
    while(!place_meeting(x+sign(hsp),y,obj_wall))
    {
        x += sign(hsp);
    }
    hsp = 0;
    dir *= -1; // con su cambio de dirección
}

x += hsp; // y le añadimos el movimiento horizontal

// y cuando el héroe esté en la sala entonces
if (instance_exists(obj_hero))
{
   // si el héroe + su altura/2 se encuentra por debajo de la y de la plataforma
    // o si hay key_down pulsada desactivamos la máscara de colisión
    if (round(obj_hero.y + (obj_hero.sprite_height/2)) > y) || (obj_hero.key_down) mask_index = -1; 
    
    // si está por encima o no se apreta tecla abajo, activamos la máscara de colision
    else
    {
        mask_index = spr_platformM; 
        // comprobamos que el héroe se encuentre 1px encima de la plataforma
        if place_meeting(x,y-1,obj_hero)
        {
            // si se encuentra encima guardamos la velocidad de la plataforma en el héroe en hsp_carry
            // y lo que haremos es sumar esta velocidad de "carga" en el heroe
            obj_hero.hsp_carry = hsp;
        }
    }
}
```

### Evento Draw de la plataforma en movimiento
```javascript
draw_sprite(spr_platform,0,x,y); // dibujamos sin máscara de colisión
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/06_plataformas_en_movimiento.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/06_plataformas_en_movimiento.gmx/captura.jpg)