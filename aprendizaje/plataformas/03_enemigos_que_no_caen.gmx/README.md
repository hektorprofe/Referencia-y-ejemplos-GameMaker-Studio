## Puntos de control
### Script de incialización
Lo llamamos al iniciar la room y establece los valores iniciales sin puntos de control:
```javascript
global.checkpoint = noone; // checkpoint id
global.checkpointR = 0;    // room
global.checkpointx = 0;
global.checkpointy = 0;
```

### Script al morir
Lo llamamos al morir para restaurar el último punto de control guardado:
```javascript
// si hay checkpoint guardado en la room actual
if (global.checkpointR != 0)
{
    room_goto(global.checkpointR);   
}
else
{
    // si no hay checkpoint guardado 
    room_restart();
}
```

### Colisión del punto de control contra el héroe
```javascript
if (place_meeting(x,y,obj_hero))
{
    // guardamos todas las variables
    global.checkpoint = id;
    global.checkpointx = x;
    global.checkpointy = y;
    global.checkpointR = room;
}

// cambiamos la imagen actual del punto de control activo
if (global.checkpointR == room)
{
    if (global.checkpoint == id) image_index = 1; else image_index = 0;
}
```
## Punto de Meta
### Colisión de la meta contra el héroe
```javascript
if (place_meeting(x,y,obj_hero))
{
    room_goto_next(); // avanzamos a la siguiente room
}
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/04_puntos_de_control_y_meta.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/04_puntos_de_control_y_meta.gmx/captura.jpg)