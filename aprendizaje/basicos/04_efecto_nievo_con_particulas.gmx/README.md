## Efecto nieve con partículas
Utilizando las funciones de partículas integradas en Game Maker es posible crear efectos interesantes. En este ejemplo se hace un generador de copos de nieve.

### Al crear el objeto generador de partículas
```javascript
// Creamos el sistema de partículas
snow = part_system_create();
part_system_depth(snow, 50); // Establecemos la profundidad

// Creamos un nuevo tipo de partícula llamada copo de nieve
snowflake = part_type_create()
part_type_shape(snowflake, pt_shape_snow);    // La forma de copo está incluida en GameMaker
part_type_orientation(snowflake,0,0,0,0,1);   // La orientación aleatoria de giro de cada partícula
part_type_size(snowflake,0.05,0.25,0,0);      // El tamaño aleatorio de cada partícula
part_type_speed(snowflake,1,1.5,0.05,0);      // La velocidad aleatoria de cada partícula
part_type_direction(snowflake,270,270,0,4);   // La dirección aleatoria de cada partícula
part_type_life(snowflake,100,150);            // El tiempo de vida aleatorio de cada partícula (en steps)

// Creamos un nuevo emisor de partículas
snow_emitter = part_emitter_create(snow);
// Establecemos la región de la room donde crear el emisor, el perfil y la forma de distribución
part_emitter_region(snow,snow_emitter,0-100,room_width+100,-10,-5,ps_shape_ellipse,ps_distr_linear);
// part_emitter_region(snow, snow_emitter, x - 50, x + 50, y - 50, y + 50, ps_shape_ellipse, ps_distr_linear) 

// Empezamos a emitir particulas cada 0.20 segundos (-5 == 1:5)
part_emitter_stream(snow,snow_emitter,snowflake,-5);

```

### Y en el evento Destroy borramos el generador
```javascript
// Las partículas utilizan bastante memoria, así que es necesario destruir el generador
part_system_destroy(snow);
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/04_efecto_nievo_con_particulas.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/04_efecto_nievo_con_particulas.gmx/captura.jpg)