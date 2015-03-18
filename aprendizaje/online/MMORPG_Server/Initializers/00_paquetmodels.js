/**
 * Created by Hector on 17/03/2015.
 */
var Parser = require('binary-parser').Parser; // ver 1.1.3 bugged, use 1.1.2 instead

// FF F0 E7 AA BC... 00
var StringOptions = {length:99, zeroTerminated:true};

module.exports = PacketModels = {
    //wich command is comming in
    header: new Parser().skip(1)
        .string("command", StringOptions),

    login: new Parser().skip(1)
        .string("command", StringOptions)
        .string("username", StringOptions)
        .string("password", StringOptions),

    register: new Parser().skip(1)
        .string("command", StringOptions)
        .string("username", StringOptions)
        .string("password", StringOptions),

    pos: new Parser().skip(1)
        .string("command", StringOptions)
        .int32le("target_x", StringOptions)
        .int32le("target_y", StringOptions)
};