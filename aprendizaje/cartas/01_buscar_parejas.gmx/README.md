## Busca parejas de cartas
Juego muy sencillo para experimentar con listas. El código básico utilizado para trabajar con ellas es el siguiente:

### Crear la baraja de 8 cartas en una lista
```javascript
// Empezamos creando una baraja de 8 cartas
for (var i=0; i<8; i+=1)
{
    // Creamos las cartas fuera del tablero
    carta = instance_create(-999 , -999, obj_carta);
        
    // Asignamos un valor a cada carta, al llegar a 4 el valor se repite
    if (i<4) carta.valor = i + 1;
    else carta.valor = i + 1 - 4;
        
    // Añadimos cada id de las cartas a la lista
    ds_list_add(global.baraja,carta);
}

```

### La barajamos
```javascript
randomize(); // Sin esto no se hace el aleatorio real
ds_list_shuffle(global.baraja);
```

### Recorremos las cartas y las mostramos en 2 filas de 4 columnas 
```javascript
// Ahora volvemos a recorrer todas las cartas en dos filas
var contador = 0;
for (var i=0; i<2; i+=1){

    // Determinamos unas posiciones de base x e y
    var posx = 200;
    if (i == 0) {
        var posy = 80;
    } else {
        var posy = 200;
    }

    // Y cuatro columnas 
    for (var j=0; j<4; j+=1)
    {
        // Recorremos una a una las cartas de la baraja usando el contador
        // y les vamos otorgando la posición x e y respectiva a cada una      
        carta = ds_list_find_value(global.baraja,contador);
        with(carta)
        {
            x = posx + (120*j);
            y = posy;
        }
        // Incrementamos el contador, que acabará siendo 8
        contador+=1;
    
    }
    
}
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/cartas/01_buscar_parejas.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/cartas/01_buscar_parejas.gmx/captura.jpg)