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
    }
};