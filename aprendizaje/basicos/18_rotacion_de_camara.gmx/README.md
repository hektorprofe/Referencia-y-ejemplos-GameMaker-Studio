## Rotación de vista
Cuando trabajamos con vistas (hay que activarlas en la room), es posible utilizar el efecto de rotación de la vista.

Necesitamos crear un objeto rotate y añadirlo en la room. Luego podemos capturar algunas teclas para cambiar el ángulo de rotación de la view.

### obj_rotate(): Create
```javascript
angle = 0;
```

### obj_rotate(): Game End
```javascript
if (keyboard_check(vk_divide)) angle+= 1;
else
    if (keyboard_check(vk_multiply)) angle-= 1;
    
view_angle[0] = angle;
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/18_rotacion_de_camara.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/18_rotacion_de_camara.gmx/captura.jpg)