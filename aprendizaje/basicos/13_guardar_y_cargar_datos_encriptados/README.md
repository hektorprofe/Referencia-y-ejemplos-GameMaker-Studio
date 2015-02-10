## Guardar y cargar datos cifrados
Un problema que surge al guardar datos en ficheros de texto es que éstos son fácilmente modificables por el usuario con cualquier editor. Para evitar precisamente ésto es posible codificar las variables y sus valores, aunque ésto no quita que todavía es posible que un usuario avanzado decodifique las variables, las modifique y las vuelva a guardar recodificadas.

### scr_save()
```javascript
// Guardamos la room del juego
if (file_exists("Save.ini")) file_delete("Save.ini");
ini_open("Save.ini");
var SavedRoom = base64_encode(string(room)); // Al encodear necesitamos hacerlo sobre una cadena
ini_write_string("Save", "room", SavedRoom); // Y evidentemente el tipo guardado también es una cadena
ini_close();
```

### scr_load()
```javascript
// Cargamos la room del juego
if file_exists("Save.ini")
{
	ini_open("Save.ini");
	var LoadedRoom = ini_read_string("Save", "room", SavedRoom); // Leemos una cadena de texto
	LoadedRoom = real(base64_decode(LoadedRoom)) // Al decodificar volvemos a convertir a real
	ini_close();
	room_goto(LoadedRoom);
}
```

El formato base64 se utiliza para transportar o guardar cualquier tipo de dato media en forma de texto, por ejemplo imágenes, sonidos, etc.