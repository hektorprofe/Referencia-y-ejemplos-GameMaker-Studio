/// argument0: data buffer
var command = buffer_read(argument0, buffer_string);
if (command != "PONG") show_debug_message("Networking Event: " + string(command));

switch(command){

    case "HELLO":
        server_time = buffer_read(argument0, buffer_string);
        show_debug_message("Server welcomes you @ " + server_time);
        // Set connected var as true
        network.connected = true;     
        break;
        
    case "REGISTER":
        status = buffer_read(argument0, buffer_string);
        if (room == rm_auth){
            if (status == "TRUE"){
                with(auth_success){
                    text = "Register Success:#Please Login";
                } 
                global.register=false;
                show_debug_message("Register Success: Please Login");
            } else {
                // Delete the socket to be efficient
                if (instance_number(network) > 0) {
                    with (network) instance_destroy();
                }
                with(auth_error){
                    text = "Register Failed:#Username Taken.";
                }  
            }
        }
        break;
        
    case "LOGIN":
        status = buffer_read(argument0, buffer_string);
        if (room == rm_auth){
            if (status == "TRUE"){
                username = buffer_read(argument0, buffer_string);
                // TODO Inititate a player object on this room
                show_debug_message("Login Success: " + username);
                // Set global username
                global.username = username;
                // Add animation to all UI objects XD
                with(ui_base) motion_add(180, 25);
                // Move to HALL room            
                with (network) alarm[0] = 20;
            } else {
                // Delete the socket to be efficient
                if (instance_number(network) > 0) {
                    with (network) instance_destroy();
                }
                with(auth_error){
                    text = "Login Failed: User or#password incorrect.";
                }    // check if network exists or create
            }
        }
        break;
        
    case "ROOM_EXIT":
    case "ROOM_ENTER":
        count = buffer_read(argument0, buffer_u16);
        global.online_users = count;
        show_debug_message(string(count) + " clients online");
        break;
        
    case "PONG":
        network.pongs+=1;
        break;
        
    case "CHALLENGE_READY":
        global.board = buffer_read(argument0, buffer_string);
        var player1 = buffer_read(argument0, buffer_string);
        var player2 = buffer_read(argument0, buffer_string);
        if (player1 == global.username) global.challenger = player2;
        else global.challenger = player1;
        
        if (room == rm_hall){
            // Add animation to all UI objects XD
            with(ui_base) motion_add(180, 25);
            // Move to HALL room            
            with (network) alarm[3] = 20;
        }
        break;
        
    case "CHALLENGE_START":
        global.board = buffer_read(argument0, buffer_string);
        if (room == rm_game_online){
            go_loading.show = false;
            go_monitor.text = "GAME START";
        }
        break;
        
    case "CHALLENGE_QUIT":
        var exit_challenger = buffer_read(argument0, buffer_string);
        if (exit_challenger == global.challenger) {
            go_monitor.text = global.challenger + " has abandoned :/#You win.";
            go_btn_surrender.text = "Exit";
            go_btn_surrender.exit_now = true;
        }
        break;
        
    case "CHALLENGE_REQUEST":
        global.challenger = buffer_read(argument0, buffer_string);
        if (room == rm_hall){
            show_debug_message("Challenge request from " + global.challenger);  
            hall_richtext_duel.text = global.challenger + " challenges you!";
            hall_btn_request_accept.show = true;
            hall_btn_request_deny.show = true;
        }
        break;
        
    case "CHALLENGE_REQUEST_DENY":
        show_debug_message("Challenge denied");        
        hall_richtext_duel.text = ""; 
        hall_btn_request_challenge.show = true;
        hall_textbox_challenger.show = true;
        break;
        
    case "CHALLENGE_REQUEST_DISABLED":
        show_debug_message("Challenge disabled");           
        hall_richtext_duel.text = ""; 
        hall_btn_request_challenge.show = true;
        hall_textbox_challenger.show = true;
        break;        
    
}
