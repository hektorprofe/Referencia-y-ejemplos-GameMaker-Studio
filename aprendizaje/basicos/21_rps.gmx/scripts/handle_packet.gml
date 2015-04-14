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
                with(auth_error){
                    text = "Register Failed:#Username Taken.";
                }  
            }
            // Delete the socket to be efficient ALWAYS
            if (instance_number(network) > 0) {
                with (network) instance_destroy();
            }
        }
        break;
        
    case "LOGIN":
        status = buffer_read(argument0, buffer_string);
        if (room == rm_auth){
            if (status == "TRUE"){
            
                username = buffer_read(argument0, buffer_string);
                duels = buffer_read(argument0, buffer_string);
            
                // set player options     
                if (duels == "TRUE") global.duels = true;
                else global.duels = false;
            
                // TODO Inititate a player object on this room
                show_debug_message("Login Success: " + username);
                // Set global username
                global.username = username;
                // Add animation to all UI objects XD
                // with(ui_base) motion_add(180, 10);
                // Move to HALL room            
                // with (network) alarm[0] = room_speed;
            
                /// Room on clic
                if (!instance_exists(obj_fade)){
                    var fade = instance_create(0,0,obj_fade);
                    fade.target = rm_hall;
                }
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
        network.pings=network.pongs;
        break;
        
    case "CHALLENGE_READY":
        global.board = buffer_read(argument0, buffer_string);
        var player1 = buffer_read(argument0, buffer_string);
        var player2 = buffer_read(argument0, buffer_string);
        if (player1 == global.username) global.challenger = player2;
        else global.challenger = player1;
        
        if (room == rm_hall){
            // Add animation to all UI objects XD
            // with(ui_base) motion_add(180, 10);
            // Move to HALL room            
            // with (network) alarm[3] = room_speed;
            
            /// Room on clic
            if (!instance_exists(obj_fade)){
                var fade = instance_create(0,0,obj_fade);
                fade.target = rm_game_online;
            }
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
        global.challenging = false; 
        if (exit_challenger == global.challenger) {
            //go_monitor.text = global.challenger + " has abandoned :/#You win.";
            //go_btn_surrender.text = "Exit";
            //go_btn_surrender.exit_now = true;
            obj_game_online.exit_now = true;
            obj_game_online.draw_texts = false;
            go_btn_surrender.show = true;
            // Hide all icons
            with (obj_hand) visible = false;
            if instance_exists(obj_cross) obj_cross.visible = false;
        }
        break;
        
    case "CHALLENGE_REQUEST":
        var the_challenger = buffer_read(argument0, buffer_string);
        
        // first check if client is in waiting queue and exit it
        if (room == rm_hall ){
            if (hall_loading.show == true) {
                if (instance_number(network) > 0) {
                    
                    // GLOBAL CONTROL OF CHALLENGE
                    global.challenging = false; 
                
                    // check if network exists or create
                    var cancel_packet = buffer_create(1, buffer_grow, 1);
                    buffer_write(cancel_packet, buffer_string, "challenge_search_cancel");
                    buffer_write(cancel_packet, buffer_string, global.username);
                    network_write(network.socket, cancel_packet);
                    
                    hall_btn_search_cancel.show = false;
                    hall_loading.show = false;
                }
            }
        
            // Then process request
            if (global.challenging == false){
                global.challenger = the_challenger;
                // THIS CHECK IF IS IN CHALLENGE MODE TO AVOID INVITES
                global.challenging = true; 
                show_debug_message("Challenge request from " + global.challenger);  
                hall_richtext_duel.text = global.challenger + " challenges you!";
                hall_btn_request_accept.show = true;
                hall_btn_request_deny.show = true;
                // hide controls 
                hall_btn_search.show = false; 
                hall_btn_request_challenge.show = false;
                hall_textbox_challenger.show = false;
                // start countdown accept timer
                with(hall_btn_request_deny) {
                    alarm[0] = room_speed;
                    countdown = true;
                }
            } else {
                // if not waiting, just playing or dueling
                // auto decline duels before doing nothing, cause im busy :P
                if (instance_number(network) > 0) {
                    var deny_packet = buffer_create(1, buffer_grow, 1);
                    buffer_write(deny_packet, buffer_string, "challenge_request_deny");
                    buffer_write(deny_packet, buffer_string, the_challenger);
                    network_write(network.socket, deny_packet);
                }
            }
        } else {
            // if not in hall room also decline the duel
            if (instance_number(network) > 0) {
                var deny_packet = buffer_create(1, buffer_grow, 1);
                buffer_write(deny_packet, buffer_string, "challenge_request_deny");
                buffer_write(deny_packet, buffer_string, the_challenger);
                network_write(network.socket, deny_packet);
            }
        }
        break;
        
    case "CHALLENGE_REQUEST_DENY":
        global.challenger = "";
        // THIS CHECK IF IS IN CHALLENGE MODE TO AVOID INVITES
        global.challenging = false; 
        show_debug_message("Challenge denied");        
        hall_richtext_duel.text = ""; 
        hall_btn_request_challenge.show = true;
        hall_textbox_challenger.show = true;
        hall_btn_search.show = true; 
        // disable countdown on hall_btn_request_challenge
        hall_btn_request_challenge.countdown = false;
        break;
        
    case "CHALLENGE_REQUEST_DISABLED":
        global.challenger = "";
        // THIS CHECK IF IS IN CHALLENGE MODE TO AVOID INVITES
        global.challenging = false; 
        show_debug_message("Challenge disabled");     
        hall_btn_request_challenge.show = true;
        hall_btn_search.show = true;       
        hall_richtext_duel.text = ""; 
        hall_textbox_challenger.show = true;
        // disable countdown on hall_btn_request_challenge
        hall_btn_request_challenge.countdown = false;
        break;      
    
    case "ROOM_PLAYERS":
        global.playing_users = buffer_read(argument0, buffer_u16);
        //show_debug_message(global.playing_users);  
        break;  
        
    case "GAME_RPS_HAND":
        var challenger = buffer_read(argument0, buffer_string);
        // Definimos la mano y 
        obj_game_online.enemy_hand = buffer_read(argument0, buffer_string);
        
        // Hide the syncro ... dots
        go_syncro.show = false;
        
        // Lanzamos el evento que dibujara la jugada sobre las manos,
        // dentro de este evento se comprobará la jugada cuando se haya
        // movido todo el escenario poniendo obj_game_online.checking a true
        with (obj_game_online.current_hand) event_perform(ev_other,ev_user0);
}