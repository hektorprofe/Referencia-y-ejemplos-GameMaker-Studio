/**
 * Created by Hector on 16/03/2015.
 */
var zeroBuffer = new Buffer('00', 'hex');

module.exports = packet = {
    // params: array of javascript objects to be turn in buffers
    build: function(params){
        var packetParts = [];
        var packetSize = 0;

        params.forEach(function(param){
            var buffer;
            if (typeof param === 'string'){
                // if param is a string
                buffer = new Buffer(param, 'utf8');
                buffer = Buffer.concat([buffer,zeroBuffer], buffer.length+1);
            } else if (typeof param === 'number'){
                // if param is a number
                buffer = new Buffer(2); // 2 bytes
                buffer.writeUInt16LE(param,0);
            } else {
                console.log("WARNING: Unknown data type in packet builder!");
            }

            packetSize += buffer.length;

            // push the buffer it in the packetParts
            packetParts.push(buffer);
        });

        var dataBuffer = Buffer.concat(packetParts, packetSize);

        // now we need send the buffer sizes to client in orde to split them
        var size = new Buffer(1);
        size.writeUInt8(dataBuffer.length+1, 0);

        var finalPacket = Buffer.concat([size, dataBuffer], size.length + dataBuffer.length);

        return finalPacket;
    },

    // Parse a package to be handled for a client
    parse: function(c, data){
        var idx = 0;
        while( idx < data.length ){
            var packetSize = data.readUInt8(idx);
            var extractedPacket = new Buffer(packetSize);
            data.copy(extractedPacket,0, idx, idx+packetSize);

            // Example recived data: X00000X1111X222X33
            // extractedPacket = X00000 when X=6 (count itself)

            this.interpret(c,extractedPacket);
            idx += packetSize;
        }
    },

    // What the packet is and what to do with that packet
    interpret: function(c, datapacket){
        var header = PacketModels.header.parse(datapacket);
        console.log("Interpret: " + header.command); // from paquetmodels -> header -> command

        switch( header.command.toUpperCase()){
            case "LOGIN":
                var data = PacketModels.login.parse(datapacket);
                User.login(data.username, data.password, function(result, user){
                    console.log("Login Result: " + result);
                    if (result){
                        c.user = user;
                        c.enter_room(c.user.current_room);
                        c.socket.write(packet.build(["LOGIN","TRUE", c.user.current_room, c.user.pos_x, c.user.pos_y, c.user.username]));

                        // Una vez logeado si queremos podemos enviar la posición inicial del cliente para que aparezca en los otros clientes sin moverse antes
                        c.broadcast_room(packet.build(["POS", c.user.username, c.user.pos_x, c.user.pos_y]));

                    } else {
                        c.socket.write(packet.build(["LOGIN","FALSE"]));
                    }
                });// from the user object


                break;
            case "REGISTER":
                var data = PacketModels.register.parse(datapacket);
                User.register(data.username, data.password, function(result){
                    if (result){
                        c.socket.write(packet.build(["REGISTER","TRUE"]));
                    } else {
                        c.socket.write(packet.build(["REGISTER","FALSE"]));
                    }
                });
                break;
            case "POS":
                var data = PacketModels.pos.parse(datapacket);
                c.user.pos_x = data.target_x;
                c.user.pos_y = data.target_y;

                // is not optimal save every time in db, better do it when disconnect
                c.user.save();

                // broadcast the information
                c.broadcast_room(packet.build(["POS", c.user.username, data.target_x, data.target_y]));

                console.log(data);
        }
    }

};