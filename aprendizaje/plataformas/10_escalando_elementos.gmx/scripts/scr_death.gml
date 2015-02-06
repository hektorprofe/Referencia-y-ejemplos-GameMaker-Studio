// si hay checkpoint guardado en la room actual
if (global.checkpointR != 0)
{
    room_goto(global.checkpointR);   
}
else
{
    // si no hay checkpoint guardado 
    room_restart();
}