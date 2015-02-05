## Doble salto
Simplemente necesitaremos crear un contador de saltos en el héroe:

### Actualizamos las variables iniciales del héroe
```javascript
jumps = 0;     // saltos actuales disponibles
jumpsmax = 2;  // saltos contínuos permitidos
```

### Actualizamos el salto en su Step
```javascript
// Si estamos tocando el suelo tendremos el máximo de saltos disponibles
if (place_meeting(x,y+1,obj_wall))
{
    jumps = jumpsmax;
    //if (key_jump) vsp = -jumpspeed; // lógica antigua 
}

// miramos si se quiere saltar y tenemos saltos disponibles
if (key_jump) && (jumps > 0)
{
    jumps -= 1;       // restamos un salto
    vsp = -jumpspeed; // damos la velocidad vertical para saltar
}

```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/07_doble_salto.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/07_doble_salto.gmx/captura.jpg)