### Físicas básicas en objetos

La base del ejemplo se ha creado siguiendo el tutorial oficial en  [GameMaker:Studio Tech Blog](https://yoyogames.com/tech_blog/83) y adaptando según conveniencia.

Es necesario que activemos la opción de "Physics World" en la room que queremos activar las físicas.

[![Imagen](http://help.yoyogames.com/attachments/token/5yE5NBplFOEF8IesI21JOJluO/?name=Physics_TB_RoomTab.png)](http://help.yoyogames.com/attachments/token/5yE5NBplFOEF8IesI21JOJluO/?name=Physics_TB_RoomTab.png)

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/02_fisicas_basicas_en_objetos.gmx/captura1.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/02_fisicas_basicas_en_objetos.gmx/captura1.jpg)

Para la simulación de la parábola que dibuja el impulso en función de la distancia del ratón sobre la pelota y utilizando el ángulo inverso del ratón (cuanto más lejos más impulso), se ha utilizado el siguiente código:

```javascript
// Recuperamos el factor distancia/fuerza del ratón respecto a la pelota
factor=obj_Ball.distance_factor;  // Es (distance_to_point(mouse_x, mouse_y) / 8) de la pelota 

// Calculamos el ángulo inverso del ratón respecto a la bola 
angle=point_direction(-mouse_x,-mouse_y,-obj_Ball.x,-obj_Ball.y)

// Guardamos su posición inicial
ax=obj_Ball.x
ay=obj_Ball.y

// Buscamos la distancia de las coordenadas al aplicar el factor distancia/fuerza
movex=lengthdir_x(factor,angle)
movey=lengthdir_y(factor,angle)
 
// Dibujaremos una parábola simulando la coordenada después de aplicar el factor
for(i=0 i<40 i+=1)
{
    // Vamos guardando la posición anterior
    lastx = ax
    lasty = ay
    
    // Incrementamos la posición actual a la generada con el factor
    ax += movex
    ay += movey
    
    // Incrementamos la cantidad de distancia que nos vemos en y 0.5
    movey += 0.51
    
    // Dibujamos las líneas que van formando la parábola
    draw_line(lastx,lasty,ax,ay)
}
```
Para aplicar el impulso se ha utilizado:

```javascript
// Si apretamos el ratón
if mouse_check_button_pressed(mb_left)
{
    // Activamos las físicas de la pelota
    obj_Ball.phy_active = true;
    with (obj_Ball)
    {
        // Incrementamos los tiros
        global.tiros = global.tiros+1;
        
        // Calculamos la dirección inversa del ratón respecto a la pelota
        var dir = point_direction(-mouse_x, -mouse_y, -x, -y);
        // Calculamos el factor de fuerza del impulso, dependiendo de la distancia
        var factor = obj_Ball.distance_factor/19;
        // Y finalmente aplicamos ese impulso en la dirección de la pelota
        physics_apply_impulse(x, y, lengthdir_x(factor, dir), lengthdir_y(factor, dir));
    }
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/02_fisicas_basicas_en_objetos.gmx/captura2.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/02_fisicas_basicas_en_objetos.gmx/captura2.jpg)