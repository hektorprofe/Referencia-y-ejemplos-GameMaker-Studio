## Pruebas con arrays y grids

### Obj_controller: Create
```javascript
/// Creamos unas variables
arreglo = ds_list_create();

// Añadimos 10 números
for (var i=0; i<10; i+=1)
{
    ds_list_add(arreglo, -1);
}

grid = ds_grid_create(3,3);

// Inicializamos todos los valores a -1
ds_grid_set_region(grid,0,0,2,2,-1);
```

### Obj_controller: Draw
```javascript
// Mostramos el contenido del arreglo
draw_set_color(c_white);
for (var i=0; i<ds_list_size(arreglo); i+=1)
{
    draw_text(20+(i*25), 15, arreglo[|i]);
}

// Mostramos el contenido de la grid
// Dibujamos la tabla
for(var i=0;i<ds_grid_width(grid);i++){
    for(var j=0;j<ds_grid_height(grid);j++){
        draw_text(20+(i*25), 80+(j*25),grid[# i, j]);  
    }
}
```

### Obj_controller: Left Key Pressed
```javascript
/// Asignos nuevos valores aleatorios al arreglo y al grid
for(var i=0;i<ds_list_size(arreglo);i++){
    arreglo[|i] = irandom(9);
}

for(var i=0;i<ds_grid_width(grid);i++){
    for(var j=0;j<ds_grid_height(grid);j++){
        grid[# i, j] = irandom(9); 
    }
}
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/07_pruebas_con_arrays_y_grids.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/07_pruebas_con_arrays_y_grids.gmx/captura.jpg)