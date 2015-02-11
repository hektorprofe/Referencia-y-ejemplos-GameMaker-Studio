## Sistema de pausa simple
Un método que se puede utilizar para pausar el juego consiste en crear un objeto controlador pausa. Asignarle una variable global pausa true/false y crear un evento que al apretar ESC se cambie el estado. Posteriormente en cada objeto con movimiento del juego creamos una condición inicial que evite que se mueva si tenemos pausa activado.

### obj_pausa(): Create
```javascript
global.pause = false;
```

### obj_pausa(): Al apretar ESC
```javascript
global.pause = !globa.pause;
```

### obj_pausa(): Draw
```javascript
if (global.pause)
{
	// Podemos crear un rectángulo transparente sobre el juego mostrando un texto
	draw_set_color(c_black);
	draw_set_alpha(0.5);
	draw_rectangle(0,0,room_width,room_height,0);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_text(room_width/2,room_height/2, "Juego Pausado");
	draw_set_color(c_black);

}
```

### En el Step de todos los objetos con movimiento
```javascript
// En la primera línea añadimos la condición
if (global.pause) exit;
```

Es importante tener en cuenta que con este sistema tan simple no hay control sobre algunas cosas, por ejemplo las alarmas.