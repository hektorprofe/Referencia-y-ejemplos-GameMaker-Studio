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

    this.initiate = function(){
        // Send the connection handshake packet to the client
        client.socket.write(packet.build(["HELLO", now().toString()]));
        console.log("Client initiated and greeted.");
    };

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