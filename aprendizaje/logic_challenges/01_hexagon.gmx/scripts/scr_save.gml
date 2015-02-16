// Guardamos el tiempo del juego
// argument0 = secs
// argument1 = msecs
var file;

file = 'savegame'+'.ini'
ini_open(file);

ini_write_real("Record", "secs", argument0);
ini_write_real("Record", "msecs", argument1);

ini_close();
