/**
 * Created by Hector on 17/03/2015.
 */
var Parser = require('binary-parser').Parser;

// FF F0 E7 AA BC... 00
var StringOptions = {length:99, zeroTerminated:true};

module.exports = PacketModels = {
    //wich command is comming in
    header: new Parser().skip(1)
        .string("command", StringOptions),

    login: new Parser().skip(1)
        .string("command", StringOptions)
        .string("username", StringOptions)
        .string("password", StringOptions)
};