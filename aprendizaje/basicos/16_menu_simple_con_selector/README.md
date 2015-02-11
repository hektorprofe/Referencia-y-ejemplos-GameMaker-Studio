## Menú simple con selector
La alternativa a no tener que hacer una comprobación de pausa en todos los objetos y evitar el problema de las alarmas es crear un sistema de pausa total. Lo malo de este sistema es que por lo pronto no se puede conservar nada en el fondo de la room, ya que estamos desactivando todas las instancias.

### obj_menu(): Create
```javascript
menu[0] = "Start";
menu[1] = "Level Select";
menu[2] = "Options";
menu[3] = "Quit";

space = 64;  // px entre secciones
mpos = 0     // posición actual del menú
```

### obj_menu(): Step
```javascript
// Capturamos las teclas que mueven el menú
var move = 0;
move -= max(keyboard_check_pressed(vk_up), keyboard_check_pressed(ord("W")),0);
move += max(keyboard_check_pressed(vk_down), keyboard_check_pressed(ord("S")),0);

// Dependiendo de la dirección aumentamos o decrementamos mpos
if (move != 0)
{
	mpos += move;
	if (mpos < 0) mpos = array_length_1d(menu) - 1;
	if (mpos > array_length_1d(menu) - 1) mpos = 0;
}

// También capturamos el momento en que seleccioamos una opción
var push;
push = max(keyboard_check_released(vk_enter), keyboard_check_released(vk_shift), keyboard_check_released(vk_space), 0);
if (push == 1) scr_menu();
```

### obj_menu(): Draw
```javascript
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_menu);
	draw_set_color(c_white);

	// Dibujamos el texto del menú
	var m;
	for (m=0;m<array_length_1d(menu);m+=1)
	{
		draw_text(x + space, y + (m * space), string(menu[m]);
	}

 	// Dibujamos el selector (hay que ponerlo como sprite del obj_menu)
	draw_sprite(sprite_index, 0, x + 16, y + mpos * space);

```


### scr_menu()
```javascript
// Seleccionamos la acción adecuada
switch(mpos)
{
	case 0:
		room_goto_next();
		break;
	case 1:
		break;
	case 2:
		break;
	case 3:
		game_end();
		break;
	default:
		break;
}
```
