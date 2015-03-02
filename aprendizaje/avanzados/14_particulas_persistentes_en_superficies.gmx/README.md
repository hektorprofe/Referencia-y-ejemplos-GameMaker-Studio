## Dibujar partículas sobre superficies

El problema que surge al dibujar directamente las partículas sobre la superficie es que al aparecer, éstas borran las partículas que ya dibujadas debajo.

```javascript
/// Create
scr_particula(); //Creamos el sistema y la partícula

// Cambiamos al sistema automatico de dibujo ya que vamos a hacerlo cada step
part_system_automatic_draw(sistema,false);
// Creamos una superficie y la limpiamos
superficie=surface_create(room_width,room_height);
surface_set_target(superficie);
draw_clear_alpha(c_black,0);
surface_reset_target();
```

```javascript
/// Al hacer clic en la pantalla
// Creamos las particulas
part_particles_create(sistema,mouse_x,mouse_y,particula,10); 
```

```javascript
/// Step
//Dibujamos las particulas en la superficie en cada step
surface_set_target(superficie); 
part_system_drawit(sistema);
surface_reset_target(); 
```

```javascript
/// Room End
// Limpiamos la memoria
part_system_destroy(sistema);
surface_free(superficie);
```

```javascript
/// Draw
draw_surface(superficie,0,0); // Dibujamos la superficie
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/14_particulas_persistentes_en_superficies.gmx/captura.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/14_particulas_persistentes_en_superficies.gmx/captura.png)