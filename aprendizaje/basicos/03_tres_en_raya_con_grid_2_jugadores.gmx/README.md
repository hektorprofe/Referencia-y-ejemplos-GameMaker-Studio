## Tres en raya con grid
Este es un juego muy simple para practicar las grid, unos arrays 2D que tiene GML. El tutorial original en inglés se puede encontrar en [Youtube](https://www.youtube.com/watch?v=VPhY_6ruhnE) y fue creado por usuario Heartbeast. 

### Al crear el controlador
```javascript
/// Creamos una grid 
grid = ds_grid_create(3,3);
ds_grid_set_region(grid,0,0,2,2,-1); // -1 es nulo, 0 es O y 1 es X
```

### Boton derecho
```javascript
/// Ponemos una O
var gridx = mouse_x div 160;
var gridy = mouse_y div 160;
grid[# gridx, gridy] = 0;
```

### Botón izquierdo
```javascript
/// Ponemos una X
var gridx = mouse_x div 160;
var gridy = mouse_y div 160;
grid[# gridx, gridy] = 1;
```

### Detección de colisiones contra enemigos
```javascript
// Dibujamos la tabla
for(var i=0;i<ds_grid_width(grid);i++){
    for(var j=0;j<ds_grid_height(grid);j++){
        if(grid[# i, j] != -1) {
            var subimage = grid[# i, j];
            draw_sprite(spr_ficha, subimage, i*160, j*160); 
        }   
    }
}
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/03_tres_en_raya_con_grid_2_jugadores.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/03_tres_en_raya_con_grid_2_jugadores.gmx.gmx/captura.jpg)