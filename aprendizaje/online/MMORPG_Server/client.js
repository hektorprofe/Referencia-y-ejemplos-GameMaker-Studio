/**
 * Created by Hector on 16/03/2015.
 */
var now = require('performance-now');
var _ = require('underscore');

module.exports = function(){
    // These objects will be added at runtime.
    // this.socket = {}
    // this.user = {}

    this.initiate = function(){
        var client = this; // represents all the function itself

        // Send the connection handshake packet to the client
        client.socket.write(packet.build(["HELLO", now().toString()]));
        console.log("Client initiated and greeted.");

    };

    this.data = function(data){
        console.log("Client data: " + data.toString());
    };

    this.error = function(err){
        console.log("Client error: " + err.toString());
    };

    this.end = function(){
        console.log("Client closed");
    }
};