## Escalando elementos
Este código no es totalmente funcional debido a que cuando una escalera se encuentra entre dos elementos wall no se puede posicionar el personaje completamente en medio y no se puede escalar. También se puede mejorar que cuando se llegue al final de la escalera el personaje no se caiga creando otro tipo de objeto especial que marque el final. Por lo demás es correcto y funcional.

### Modificamos el Create del héroe
```javascript
// Añadimos una variable para indicar si estamos en una escalera
ladder = false;
```

### Modificamos el Step del héroe
```javascript
// Añadimos un evento para capturar la tecla arriba
key_up = keyboard_check(vk_up);
```

```javascript
// Añadimos la detección para saber si el jugador quiere escalar arriba o abajo
if (key_up || key_down) 
{
    // Si estamos sobre unas escaleras activamos el modo ladder
    if (place_meeting(x,y,obj_ladder)) ladder = true;
}

// Si el modo ladder está activado
if (ladder)
{   
    // Paramos el movimiento vertical
    vsp = 0;
    // Si estamos apretando la tecla arriba, nos movemos arriba
    if (key_up) vsp = -2;
    // Si estamos apretando la tecla abajo, nos movemos abajo
    if (key_down) vsp = 2;
    // Si dejamos de estar sobre una escalera desactivamos el modo ladder
    if (!place_meeting(x,y,obj_ladder)) ladder = false;
} 
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/10_escalando_elementos.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/10_escalando_elementos.gmx/captura.jpg)