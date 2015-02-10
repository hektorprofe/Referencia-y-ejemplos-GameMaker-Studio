## Efecto temblor de pantalla
Para recrear este efecto es necesario habilitar una view. Se ha utilizado un juego simple de disparar a unas cajas y al chocar se crea un objeto shake que moverá la caja mientras éste exista.

### Obj_shake: Create
```javascript
/// Creamos una alarma para borrar el objeto al cabo de 1 segundo
alarm[0] = 30;
```

### Obj_shake: Step
```javascript
// Descentramos la view varias veces en un rango limitado
view_xview = random_range(-2,2);
view_yview = random_range(-2,2);
```

### Obj_shake: Alarma
```javascript
// La alarma vuelve a poner bien la view y borra el objeto shake
view_xview = 0;
view_yview = 0;
instance_destroy();
```

### Llamada en colisión
```javascript
create_instance(x,y,obj_shake);
destroy_instance();
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/08_efecto_temblor_de_pantalla.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/08_efecto_temblor_de_pantalla.gmx/captura.jpg)