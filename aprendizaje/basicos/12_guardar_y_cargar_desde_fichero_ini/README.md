## Guardar y cargar utilizando un fichero ini
Los ficheros .ini permiten gestionar y guardar en secciones diferentes variables y sus valores, ya sean éstos numéricos o cadenas de carácteres.

### scr_save()
```javascript
// Guardamos la room del juego
if (file_exists("Save.ini")) file_delete("Save.ini");
ini_open("Save.ini");
var SavedRoom = room;
ini_write_real("Save", "room", SavedRoom);
ini_close();
```

### scr_load()
```javascript
// Cargamos la room del juego
if (file_exists("Save.ini")) file_delete("Save.ini");
{
	ini_open("Save.ini");
	var LoadedRoom = ini_read_real("Save", "room", SavedRoom);
	ini_close();
	room_goto(LoadedRoom);
}
```

### Funciones de ficheros ini
* file_exists(file)
* file_delete(file)
* ini_open(file)
* ini_close(file)
* ini_write_real()
* ini_write_string()
* ini_read_real()
* ini_read_string()
* ini_key_exists()
* ini_section_exists()
* ini_key_delete()
* ini_section_delete()
* ini_open_from_string()

Documentación y ejemplos [aquí](http://docs.yoyogames.com/source/dadiospice/002_reference/file%20handling/ini%20files/index.html)