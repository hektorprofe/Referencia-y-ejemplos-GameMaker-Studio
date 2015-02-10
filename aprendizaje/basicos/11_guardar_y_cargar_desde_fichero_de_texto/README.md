## Guardar y cargar utilizando un fichero de texto
Utilizando por ejemplo el obj_heroe, que es el personaje del cual queremos guardar el progreso. Hay que tener en cuenta que este método guarda el fichero en crudo, así que se puede modificar fácilmente. También tener en cuenta que sólo funciona en PC.

### scr_save()
```javascript
// Guardamos la room del juego
if (file_exists("Save.sav")) file_delete("Save.save");
var SaveFile = file_text_open_write("Save.save");
var SavedRoom = argument0;
file_text_write_real(SaveFile, SavedRoom);
file_text_close(SaveFile);
```

### scr_load()
```javascript
// Cargamos la room del juego
if file_exists("Save.sav")
{
	var LoadFile = file_text_open_read("Save.sav");
	var LoadedRoom = file_text_read_real(LoadFile);
	file_text_close(LoadFile);
	room_goto(LoadedRoom);
}
```

### Funciones de fichero
* file_exists(file)
* file_delete(file)
* file_text_open_read(file)
* file_text_open_write(file)
* file_text_read_string(file)
* file_text_read_real(file)
* file_text_close(file)

Documentación y ejemplos [aquí](http://docs.yoyogames.com/source/dadiospice/002_reference/file%20handling/files/index.html)