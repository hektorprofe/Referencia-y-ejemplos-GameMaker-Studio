/**
 * Created by Hector on 17/03/2015.
 */
var mongoose = require('mongoose');
// Para crear una conexión dentro de mongoose
module.exports = gamedb = mongoose.createConnection(config.database);
