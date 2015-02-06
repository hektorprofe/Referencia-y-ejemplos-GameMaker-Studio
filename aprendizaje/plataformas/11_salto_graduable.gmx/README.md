## Salto graduable
Con este cambio en el código activaremos la opción de graduar el salto del héroe en función del rato que presionemos el botón de salto. 

### Utilizaremos la tecla arriba
```javascript
// Añadimos un evento para capturar la tecla arriba
key_up = keyboard_check(vk_up);
```

```javascript
// Necesitaremos mantener el botón arriba para poder saltar
if (vsp < 0 ) && (!key_up) vsp = max(vsp, -jumpspeed/4); 
// Si utilizamos vsp = max(vsp, 0) el salto será más brusco
```

### Resultado
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/11_salto_graduable.gmx/captura.jpg)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/plataformas/11_salto_graduable.gmx/captura.jpg)