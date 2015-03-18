/**
 * Created by Hector on 16/03/2015.
 */
var now = require('performance-now');
var _ = require('underscore');

module.exports = function(){

    var client = this;
    // These objects will be added at runtime.
    // this.socket = {}
    // this.user = {}

    // Initialization
    this.initiate = function(){
        // Send the connection handshake packet to the client
        client.socket.write(packet.build(["HELLO", now().toString()]));
        console.log("Client initiated and greeted.");
    };

    // Client Methods
    this.enter_room = function(selected_room){
        maps[selected_room].clients.forEach(function(otherClient){
            otherClient.socket.write(packet.build(["ENTER"], client.username, client.pos_x, client.pos_y));
        }); // en la room de maps
        maps[selected_room].clients.push(client);
    };
    this.broadcast_room = function(packetData){
        maps[client.user.current_room].clients.forEach(function(otherClient){
            // send the data from the user to all other users in same room (but not itself)
            if (otherClient.user.username != client.user.username) {
                otherClient.socket.write(packetData);
            }
        });
    };

    // Socket Stuff
    this.data = function(data){
        packet.parse(client, data);
        //console.log("Client data: " + data.toString());
    };

    this.error = function(err){
        console.log("Client error: " + err.toString());
    };

    this.end = function(){
        console.log("Client closed");
    }
};