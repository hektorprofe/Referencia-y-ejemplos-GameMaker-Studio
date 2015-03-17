/// argument0: data buffer
var command = buffer_read(argument0, buffer_string);
show_debug_message("Networking Event: " + string(command));

switch(command){
    case "HELLO":
        server_time = buffer_read(argument0, buffer_string);
        room_goto_next();
        show_debug_message("Server welcomes you @ " + server_time);
        break;
}
