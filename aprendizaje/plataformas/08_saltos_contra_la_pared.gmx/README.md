## Saltos contra la pared
Lo único que nos hace falta es comprobar si estamos tocando una pared horizontalmente  en el momento de saltar.

### Añadimos la comprobación al Step del héroe
```javascript
// si estamos tocando la pared de nuestra derecha o izquierda
if(key_jump) && (place_meeting(x+1,y,obj_wall) || place_meeting(x-1,y,obj_wall))
{	
	// entonces podemos saltar otra vez
    vsp = -jumpspeed;
}

```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/08_saltos_contra_la_pared.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/08_saltos_contra_la_pared.gmx/captura.jpg)