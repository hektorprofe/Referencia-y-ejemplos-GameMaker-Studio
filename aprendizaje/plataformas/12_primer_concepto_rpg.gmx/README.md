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