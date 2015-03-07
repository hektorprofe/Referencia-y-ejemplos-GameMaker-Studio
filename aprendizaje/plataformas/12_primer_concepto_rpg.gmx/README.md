## Primer concepto de RPG

El ejemplo original en inglés se puede encontrar en [Youtube](https://www.youtube.com/watch?v=FqYS-4_oSRw) y fue creado por el usuario [Heartbeast](https://www.youtube.com/channel/UCrHQNOyU1q6BFEfkNq2CYMA). 

### Parte 1: Terreno 2D y personaje

Utilizando una pequeña técnica de perspectiva se puede crear un efecto de superposición con un rectángulo de dos colores, añadiendo el punto de anclaje vertical en medio (0,24) para sprite (32,48) y la máscara de colisión sólo al rectángulo inferior.

Luego utilizando un Script se establece automáticamente la profundidad de las paredes dándoles más a aquellas que estan más arriba en la room:

```javascript
{
	/// scr_find_depth()
    // Cuanto más arriba más atrás
    depth = y*-1;   
}
```

Este script se llama en el create de las paredes y en cada Step del jugador para ponerlo en todo momento al mismo nivel que las paredes. Evidentemente la máscara de colisión y el anclaje vertical también es el mismo que las paredes.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/12_primer_concepto_rpg.gmx/captura.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/12_primer_concepto_rpg.gmx/captura.png)

### Parte 2: Estadísticas de personaje

En todo RPG nuestro personaje tiene una serie de variables tales como el nivel, la experiencia, la vida, los puntos de ataque, etc. Vamos a comenzar creando un objeto para manejar todas las variables de personaje:

```javascript
/// Obj globals: Create
{
    global.level = 1;
    global.hp = 10;
    global.maxhp = 10;
    global.expr = 0;
    global.maxexpr = 2;
}
```

Para probar estad estadísticas vamos a crear un objeto llamado experiencia (una bolita) que al colisionar con el personaje le otorgarán un punto de experiencia:

```javascript
/// Obj player: Collision with obj_expr
{
    global.expr++;
    with(other) instance_destroy();
}
```

A continuación manejaremos la experiencia del personaje para hacer que suba de nivel cuando se alcance la experiencia necesaria, aumentando la vida y otorgando un nuevo valor a la experiencia necesaria para alcanzar el próximo nivel:

```javascript
/// Obj globals: Step
{
    if(global.expr >= global.maxexpr)
    {
        global.level+=1;
        global.hp+=5;
        global.maxhp+=5;
        // La experiencia actual será la resta de la experiencia actual del nivel menos la experiencia actual
        global.expr = global.expr-global.maxexpr;
        // La experiencia máxima para alcanzar el próximo nivel pasará a ser el doble que la del nivel actual
        global.maxexpr *= 2;
    }   
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/12_primer_concepto_rpg.gmx/captura2.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/12_primer_concepto_rpg.gmx/captura2.png)