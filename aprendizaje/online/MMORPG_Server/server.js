/**
 * Created by Hector on 16/03/2015.
 */

// Import required libraries
require(__dirname + '/Resources/config.js');
var fs = require('fs');
var net = require('net');

// Load the initializers
var init_files = fs.readdirSync(__dirname + "/Initializers");
init_files.forEach(function(initFile){
    console.log("Loading Initializers:" + initFile);
    require(__dirname + "/Initializers/" + initFile);
});

// Load the modules
var model_files = fs.readdirSync(__dirname + "/Models");
model_files.forEach(function(modelFile){
    console.log("Loading Model:" + modelFile);
    require(__dirname + "/Models/" + modelFile);
});

// Load the maps
maps = {};
var map_files = fs.readdirSync(config.data_paths.maps);
map_files.forEach(function(mapFile){
    console.log("Loading Map:" + mapFile);
    var map = require(config.data_paths.maps + mapFile);
    maps[map.room] = map;
});

console.log(config.database);
console.log(maps);

// 1. Load the initializers
// 2. Load data models
// 3. Load game maps data
// 4. Initiate the server and listen to the internet
// Server logic
