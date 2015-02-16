// Cargamos el tiempo del juego
// devuelve array[0] = secs, array[1] = msecs

var file;

file = 'savegame'+'.ini';

if file_exists(file) then
{
    ini_open(file);
    
    global.record[0] = ini_read_real("Record", "secs", 0);
    global.record[1] = ini_read_real("Record", "msecs", 0);
    
    ini_close();
}
