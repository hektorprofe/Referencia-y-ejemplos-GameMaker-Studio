/**
 * Created by Hector on 16/03/2015.
 */
// Import required libraries
var args = require('minimist')(process.argv.slice(2));
var extend = require('extend');

// Store the environment variable
var environment = args.env || "test";

// Common config: name,version,max_players,etc
var common_conf = {
    name: "hcosta mmo game server",
    version: "0.0.1",
    environment: environment,
    max_players: 100,
    data_paths: {
        items: __dirname + '\\GameData\\' + "Items\\",
        maps: __dirname + '\\GameData\\' + "Maps\\",
    },
    starting_zone: "rm_map_home"
};

// Environment Specific Configuration
var conf = {
    production: {
        ip: args.ip || "0.0.0.0",
        port: args.port || 8081,
        database: "mongodb://127.0.0.1/mmodb_prod"
    },

    test: {
        ip: args.ip || "0.0.0.0",
        port: args.port || 8082,
        database: "mongodb://127.0.0.1/mmodb_test"
    }
};

// Share the common conf with the specific
extend(false, conf.production, common_conf);
extend(false, conf.test, common_conf);

// Export to the config global as a module the current config
module.exports = config = conf[environment];