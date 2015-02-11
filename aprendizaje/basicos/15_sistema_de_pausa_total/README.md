## Sistema de pausa total
La alternativa a no tener que hacer una comprobación de pausa en todos los objetos y evitar el problema de las alarmas es crear un sistema de pausa total. Lo malo de este sistema es que por lo pronto no se puede conservar nada en el fondo de la room, ya que estamos desactivando todas las instancias.

### obj_pausa(): Create
```javascript
pause = false;
```

### obj_pausa(): Al apretar ESC
```javascript
pause = !pause;
if (pause)
{
	instance_deactivate_all(true); // desactiva todos los objetos menos si mismo
} 
else 
{
	instance_activate_all();
}
```

### obj_pausa(): Draw
```javascript
if (pause)
{
	// Creamos un rectángulo mostrando un texto
	draw_set_color(c_black);
	draw_rectangle(0,0,room_width,room_height,0);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_text(room_width/2,room_height/2, "Juego Pausado");
	draw_set_color(c_black);
}
```