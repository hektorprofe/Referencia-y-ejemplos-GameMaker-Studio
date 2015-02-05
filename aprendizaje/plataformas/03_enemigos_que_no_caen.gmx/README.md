## Enemigos que no caen y se dan la vuelta

### Modificamos la colisión vertical del enemigo
```javascript
if (place_meeting(x,y+vsp,obj_wall))
{
    while(!place_meeting(x,y+sign(vsp),obj_wall))
    {
        y += sign(vsp);
    }
    vsp = 0;
    
    // comprobamos si no hay colisión contra el suelo a  
    // una distancia que es la mitad del tamaño del sprite
    if (!position_meeting(
            x+(sprite_width/2)*dir,
            y+(sprite_height/2)+8, // comprueba 8px extra más abajo 
            obj_wall))
    {
        // si el lugar está vacío, daremos media vuelta 
        // evitando así que el enemigo caiga de la plataforma
        dir *= -1;
    }
}
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/03_enemigos_que_no_caen.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/03_enemigos_que_no_caen.gmx/captura.jpg)