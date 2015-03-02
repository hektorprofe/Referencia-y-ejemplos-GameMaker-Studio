## Dibujar partículas acumuladas sobre superficies

Para solucionar el problema anterior lo que podemos hacer es dibujar las partículas justo antes de que lleguen al final de sus ciclo de vida en lugar de dibujarlas en cada Step.

```javascript
/// Create
scr_particula(); //Creamos el sistema y la partícula

// Creamos una superficie y la limpiamos
superficie=surface_create(room_width,room_height);
surface_set_target(superficie);
draw_clear_alpha(c_black,0);
surface_reset_target();
```

```javascript
/// Al hacer clic en la pantalla
// Creamos las particulas si la alarma esta inactiva
if alarm[0]<0
{
    part_particles_create(sistema,mouse_x,mouse_y,particula,10); 
    // Llamamos la alarma un momento antes que llegue al final del
    // ciclo de vida de la partícula ya que sino desaparecerá la partícula
    // antes que podamos llegar a dibujarla
    alarm[0]=14;  // Si el ciclo de vida es de 15 steps la dibujamos a los 14 steps
}
```

```javascript
/// Alarm 0
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

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/15_particulas_persistentes_acumuladas_en_superficies.gmx/captura.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/15_particulas_persistentes_acumuladas_en_superficies.gmx/captura.png)