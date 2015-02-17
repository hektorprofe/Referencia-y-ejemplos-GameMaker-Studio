## Superficies básicas
Cuando Game Maker dibuja algo no lo hace directamente en la pantalla, sinó que crea una superficie llamada application surface. Esta superficie es básicamente un canvas en blanco (como el de javascript) que GMS maneja automáticamente.

Sin embargo su potencial recae en la posibilidad de crear tus propias superficies y utilizarlas para añadir efectos especiales a los juegos, para manipularlas como si fueran texturas, para crear sprites dinámicos de la pantalla o complejas capas superpuestas, etc.

Las cuatro reglas para utilizarlas son:

* Las superficies son capas volátiles guardadas en la memoria de texturas y pueden desaparecer al minimizar el juego o perder el foco, por lo que es necesario implementar siempre algun tipo de código anti fallos, por ejemplo haciendo uso de la función surface_exists.
* Las superficies requieren grandes cantidaded de memoria de textura por lo que hay que mantener su tamaño lo más pequeño posible. A poder ser deben ocupar una porción de la pantalla total o como mucho ese tamaño.
* Las superficies en la medida de lo posible se deben dibujar en el evento draw ya que ese es el momento óptimo que el sistema dibuja la pantalla.
* Cuando se dibujan superficies manualmente éstas siempre tienen la posición 0,0, por lo que hay que transformar sus coordenadas absolutas en las coordenadas locales de la superficie. 

El uso básico es el siguiente:

* Primero se crea una superficie y se asigna su indice a una variable.
* Entonces se establece la superficie como la capa actual en la que hay que dibujar, en lugar de la capa por defecto de GMS.
* Una vez se ha realizado el dibujo que se requiere se reinicia la superficie a la de GMS para que continue dibujando su contenido. Es posible asignar una superficie a una vista para utilizarla explícitamente con view_surface_id[0..7].

Más información en la [docu oficial](http://docs.yoyogames.com/source/dadiospice/002_reference/surfaces/index.html).

Para este ejemplo voy a realizar una pizarra donde al apretar el ratón se podrá dibujar encima. Lo haré creando una superficie tal como se explica en el videotutorial de HeartBeast en [aquí en Youtube](https://www.youtube.com/watch?v=iOljy91Lhwk).



### obj_paper(): Create
```javascript
/// Inicializar superficie
surface = noone;
mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;
```

### obj_paper(): Game End
```javascript
/// Destruir la superficie
if (surface_exists(surface)) 
{
    surface_free(surface);
}
```

### obj_paper(): Draw
```javascript
/// Dibujar la superficie
if (surface_exists(surface))
{
    if (mouse_check_button(mb_left))
    {
    	// Cambiamos a la nueva superficie
        surface_set_target(surface);
        
        // Dibujamos un punto
        draw_circle(mouse_x, mouse_y, 3, false);

        // Trazamos una línea entre los dos puntos (el anterior y el actual)
        draw_line_width(mouse_xprevious, mouse_yprevious, mouse_x, mouse_y, 8);
        
    	// Volvemos a la superficie de la aplicación
        surface_reset_target();
    }
    
    // Dibujamos la superficie que hemos creado
    draw_surface(surface,0,0);
    mouse_xprevious = mouse_x;
    mouse_yprevious = mouse_y;
} 
else
{
    surface = surface_create(640, 360); // Creamos una superficie de 640*360
    surface_set_target(surface);        // Lo que dibujemos ahora se dibujará en esta superficie
    draw_clear_alpha(c_white, 1);       // Le damos un color de fondo
    surface_reset_target();             // Activamos la superficie de la aplicación
}
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/17_superficies_basicas.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/17_superficies_basicas.gmx/captura.jpg)