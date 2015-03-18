# Creando el servidor con nodejs
Este ejemplo se ha creado a partir de la serie de videotutoriales **Lets Build A MMORPG** del usuario [rmkdev](https://www.youtube.com/channel/UCJvrLzbg4VPRxzf2vhW7G4A).

## Parte 1: Arquitectura del server
* Empezamos creando un fichero server.js.
* Añadimos un fichero package.json con los repositorios de nodejs que vamos a utilizar.
* Hacemos un **npm install** para instalar los repositorios.
* Ahora creamos una jerarquía de directorios para nuestro servidor:
    * Initializer: Tareas a realizar antes de poner en marcha el servidor.
    * Modules: Modelos de los datos de la BD.
    * Resources: Ficheros del juego.
        * GameData: Estructura de los ficheros de la app.
            * Items: Ficheros relativos a los objetos del juego.
            * Maps: Ficheros relativos a los mapas del juego.
* Creamos un nuevo fichero de configuración en Resources llamado **config.js** que se encargará de manejar las diversas configuraciones que establezcamos.
* Utilizaremos la librería **minimist** para capturar diferentes argumentos y también **extend** que añade la posibilidad de extender objetos con otros objetos en javascript.
* Configuramos el entorno para añadir argumentos al servidor, que en la terminal equivaldría a lanzar el servidor de la siguiente forma:
```javascript
node server.js --env="test"
```
[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img1.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img1.png)
* Podemos añadir otros modos de debug como **--env="production"**.
* La configuración deseada se cargará automáticamente como módulo de nodejs al utilizar la línea:
```javascript
module.exports = config = conf[environment];
```
* Ahora para cargar la configuración deseada será tan sencillo como cargar la configuración y mostrar la variable del módulo en **server.js**:
```javascript
require(__dirname + '/Resources/config.js');
console.log(config.database);
```

## Parte 2: Cargando resources
Antes de comenzar podemos activar la sintaxis de nodejs en webstorm en **Settings | Javascript | Libraries**, así nos será más fácil proceder.
Además añadiremos los módulos centrales de nodejs en: **File | Settings | Javascript | Node.js** y haciendo clic en Configure.

* Vamos a empezar esta parte importando las librerías **fs** (filesystem) y **net** (network) nativas de nodejs que nos servirán para manejar fiecheros externos y la red.
* La idea es que antes de poner en marcha el servidor vamos a cargar en memoria varias cosas:
    * Inicializadores
    * Modelos
    * Mapas
* Cada uno de estos elementos será declarado en su propio fichero javascript y nos exportará al servidor sus características de una forma ordenada como si fueran objetos de javascript.
* Empezando por los mapas vamos a crear un nuevo mapa llamado **hometown.js** en **Resources | Maps** y añadiremos:
```javascript
exports.name = "Home Town";
exports.room = "rm_map_home";

exports.start_x = 320;
exports.start_y = 320;

exports.client = [];
```
* Ahora para cargar en memoria este mapa (como si fuera un objeto javascript) vamos a cargar todos los ficheros del directorio Maps desde el **server.js**:
```javascript
// Load the maps
maps = {};
var map_files = fs.readdirSync(config.data_paths.maps);
map_files.forEach(function(mapFile){
    console.log("Loading Map:" + mapFile);
    var map = require(config.data_paths.maps + mapFile);
    maps[map.room] = map;
});
```
* De la misma forma a como cargamos los mapas, cargaremos los inicializadores y los models:
```javascript
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
```
* Finalmente podemos debugear los mapas cargados en memoria mostrando por consola el contenido de la variable **maps**:
```javascript
console.log(maps);
```

## Parte 3: Creando la red y el cliente de prueba
* En primer lugar vamos a crear el servidor en **server.js** utilizando la librería net, capaz de crear el bucle del servicio y tratar los sockets que se vayan conectando:
```javascript
// Create the server
net.createServer(function(socket){
    console.log("Socket connected");
    socket.on('error', function(err){
        console.log("Socket error: " + err.toString());
    });
    socket.on('end', function(){
        console.log("Socket closed");
    });
    socket.on('data', function(data){
        console.log("Socket data: " + data.toString());
    });
}).listen(config.port);

console.log("Initialize Completed.\nServer Port: " + config.port + " | Environment: " + config.environment);
```

* Ahora creamos un nuevo proyecto de Game Maker.
* Creamos un objeto llamado **Network** que nos manejará toda la conexión con el servidor, lo hacemos persistente y le damos el siguiente código en el **Create**:
```javascript
/// Initiate the connection
socket = network_create_socket(network_socket_tcp);
network_connect_raw(socket,"127.0.0.1",8082);
```
* Ahora vamos a crear una room nueva, le llamaremos **rm_init**,con el tamaño que queramos y le pondremos una instancia del objeto **Network** dentro.
* Podemos ahora crear 3 fondos para gestionar la conexión del cliente y ponerlos en la room:
    * bg_Loading: Pantalla del juego mientras carga.
    * bg_Connecting: Pantalla del juego mientras conecta (por defecto).
    * bg_Title_Screen: Pantalla del juego preparado para jugar.

* Así que pondremos por defecto el fondo bg_Connecting.
* Ahora si ponemos en marcha nuestro servidor y ejecutamos el juego veremos como se conecta el cliente, así como se desconecta cuando se capturan el evento **end**:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img2.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img2.png)

## Parte 4: Representando al cliente
* Para poder manejar a cada cliente específico necesitaremos representarlo de alguna forma en tiempo real dentro del servidor.
* Una librería de nodejs que nos ayudará a gestionar mejor el tiempo es **performance-now**, la añadimos al **package.json** y la instalamos con **npm install**.
* Vamos a crear un nuevo fichero **client.js** en la raíz de nuestro proyecto:
```javascript
var now = require('performance-now');
var _ = require('underscore');

module.exports = function(){
    // These objects will be added at runtime.
    // this.socket = {}
    // this.user = {}

    this.initiate = function(){
        console.log("Client initiating");
    }

    this.data = function(data){
        console.log("Client data: " + data.toString());
    }

    this.error = function(err){
        console.log("Client error: " + err.toString());
    }

    this.end = function(){
        console.log("Client closed");
    }
}
```
* Ahora necesitamos crear la representación de este cliente con varias funciones dentro del servidor cuando se conecte un socket.
* Para hacerlo crearemos una instancia del cliente justo al conectarse un nuevo socket, entonces le asignaremos el socket e iniciaremos el cliente.
* También substituiremos las antiguas funciones por las específicas del cliente:
```javascript
// Create the server
net.createServer(function(socket){
    console.log("Socket connected");
    var c_inst = new require('./client.js');
    var thisClient = new c_inst()

    thisClient.socket = socket;
    thisClient.initiate();

    socket.on('error', thisClient.error);
    socket.on('end', thisClient.end);
    socket.on('data', thisClient.data);
}).listen(config.port);
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img3.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img3.png)

## Parte 5: Enviando paquetes utilizando buffers

* Cuando el servidor envía información a los clientes lo hace escribiendo información en el socket abierto contra el cliente.
* Sin embargo en Game Maker necesitaremos ser más rudimentarios porque no basta con escribir un texto.
* Game Maker nos permite crear un socket de tipo TCP. Ésto significa poca pérdida de datos, pero más complejidad para nosotros a la hora de enviar la información.
* Digamos que tendremos que empaquetar la información en pequeños trocitos que almacenarán los datos. A estos trocitos los llamaremos buffers.
* El problema aquí es que cuando el cliente recibe los paquetitos de información, la va procesando toda de golpe añadiéndola a su buffer local en tiempo real.
* Nosotros mismos tendremos que encargarnos de manejar estos buffers e indicarle al cliente sus longitudes. De manera que el cliente irá troceando su buffer local para interpretar las órdenes recibidas.
* En otras palabras, iremos indicando la longitud de cada buffer en el paquete.
* Empezaremos creando el **packet.js** en la raíz del proyecto. Este objeto nos permitirá crear nuestros buffers:
```javascript
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

        // now we need also to send the buffer sizes to client in order to split them
        var size = new Buffer(1);
        size.writeUInt8(dataBuffer.length+1, 0);

        // at last we create the paquet with the dataBuffer and its size
        var finalPacket = Buffer.concat([size, dataBuffer], size.length + dataBuffer.length);

        return finalPacket;
    }
}
```
* A continuación lo importamos globalmente en nuestro **server.js**:
```javascript
require('./packet.js');
```
* Por ahora básicamente enviaremos un buffer al cliente con información de un saludo, una cadena de texto **HOLA**.
* Lo haremos en el código del **client.js** en el momento de la inicialización:
```javascript
this.initiate = function(){
    var client = this; // represents all the function itself

    // Send the connection handshake packet to the client
    client.socket.write(packet.build(["HELLO", now().toString()]));
    console.log("Client initiated and greeted.");
};
```
* Si ponemos el servidor en marcha y conectamos un cliente no veremos nada nuevo, pero al no dar error sabremos que hemos escrito un paquete al cliente:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img4.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img4.png)

## Parte 6: Recibiendo los paquetes

* Creamos en el objeto Network un evento **Networking** que se llamará cada vez que se recibe un paquete.
* En él tendremos que manejar los datos y evitar los posibles fallos. Es un código complicado que se debe leer con calma:
```javascript
/// when a packet comes in
show_debug_message("networking event triggered");

switch(async_load[?"type"]){
    case network_type_data:
        // decrypt the package every time a new buffer arrives and put to local buffer
        buffer_copy(async_load[?"buffer"], 0, async_load[?"size"], savedBuffer, buffer_tell(savedBuffer));
        // move to the current position we need to read within the buffer
        buffer_seek(savedBuffer, buffer_seek_relative, async_load[?"size"] + 1);
        // create endless loop to read all buffer info till it ends
        while(true){
            var size = buffer_peek(savedBuffer, reading, buffer_u8);
            // if the saved buffer is bigger than the current position plus the size of data that we are looking for
            if(buffer_get_size(savedBuffer) >= reading + size){
                // now we can copy the data out of the savedBuffer into the curBuffer
                buffer_copy(savedBuffer, reading, size, cutBuffer, 0);
                buffer_seek(cutBuffer, 0, 1);

                // we manage the current packet
                handle_packet(cutBuffer);

                // now we have succesfully pulled the information out and proccessed to our handle packet function
                // we can now determine if there's still more data left to read and allow our loop continue or resize
                // the savedBuffer back to one byte and then set the reading position back to zero and end the while loop
                if (buffer_get_size(savedBuffer) != reading+size){
                    reading += size;
                } else {
                    // we reach the end of the buffer to process
                    // we can resize the savedBuffer to nothing
                    buffer_resize(savedBuffer, 1);
                    reading = 0;
                    break;
                }
            } else {
                break;
            }
        }
        break;
}
```
* A continuación creamos el script **handle_paquet** con el que manejaremos los datos recibidos.
```javascript
/// argument0: data buffer
var command = buffer_read(argument0, buffer_string);
show_debug_message("Networking Event: " + string(command));

switch(command){
    case "HELLO":
        server_time = buffer_read(argument0, buffer_string);
        room_goto_next();
        show_debug_message("Server welcomes you @ " + server_time);
        break;
}
```
* Y creamos una nueva room **rm_Login** a la que nos dirigiremos cuando el comando recibido sea "HELLO":

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img5.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img5.png)

## Parte 7: Creando una interfaz de usuario

* Creamos una jerarquía de objetos **ui_base**, **ui_focus_base** (hijo de ui_base), **ui_textbox_base** (hijo de ui_focus_base) y **ui_button_base** (hijo de ui_base) con un sprite de base.
* A continuación creamos los textboxes y los botones específicos de la **rm_login**:
    * **txt_Username**: (hijo de ui_text_base)
    * **txt_Password**: (hijo de ui_text_base)
    * **btn_Login**: (hijo de ui_button_base)
    * **btn_Register**: (hijo de ui_button_base)
* Ahora los ponemos dentro de la room creando un formulario:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img6.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img6.png)

* Creamos los placeholder de los textboxes:
```javascript
/// Create
event_inherited();
placeholder = "Username";
```
* Añadimos los eventos de ui_focus_base y ui_textbox_base:
```javascript
/// ui_focus_base: Create
event_inherited();
focused = false;
```
```javascript
/// ui_focus_base: Left Released
event_inherited();
focused = true;
```
```javascript
/// ui_focus_base: Global Left Pressed
event_inherited();
with(ui_focus_base){
    focused = false;
}
```
```javascript
/// ui_textbox_base: Create
event_inherited();
text = "";
```
```javascript
/// ui_textbox_base: Draw
draw_self();
if (focused){
    draw_rectangle(x,y,x+(16*image_xscale),y+(16*image_yscale),true);
}
if (string_length(text)>0 || focused){
    draw_text(x+3,y+8,string(text));
} else {
    draw_text(x+3,y+8,string(placeholder));
}
```
```javascript
/// ui_textbox_base: Press any key
if (focused) {
    if(keyboard_key == vk_backspace){
        text = string_copy(text, 0, string_length(text)-1);
    } else {
        text += keyboard_lastchar;
    }
}
```
* Creamos el texto de los botones:
```javascript
/// Create
event_inherited();
text = "Login";
```
* Añadimos los eventos de ui_button_base:
```javascript
/// ui_button_base: Create
text = "";
hover = false;
```
```javascript
/// ui_button_base: Mouse Enter
event_inherited();
hover = true;
```
```javascript
/// ui_button_base: Mouse Leave
event_inherited();
hover = false;
```
```javascript
/// ui_button_base: Draw
if (hover){
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_gray, 1.0);
} else {
    draw_self();
}
draw_text(x+3,y+8,string(text));
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img7.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img7.png)

* Añadimos el evento Left Released al **btn_Login** para mostrar un mensaje por pantalla:
```javascript
show_message("Username: " + txt_Username.text + " - Password: " + txt_Password.text);
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img8.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img8.png)

## Parte 8: Creando el registro y autenticación de usuarios con mongodb

* Para esta parte ya empezamos a necesitar un sistema de persistencia. En este caso utilizarmeos mongodb, además del cliente robomongo.
* Luego si hay problemas para poner en marcha el servicio en Windows 8 podemos utilizar el comando **mongod --dbpath=C:/mongo/data/db** o la ruta que queramos.
* Una vez con el server en marcha y conectado robomongo vamos a crear una base de datos por ejemplo **mymmo_test**.
* Creamos una nueva colección llamada **users** donde guardaremos toda la información de los jugadores.
* A continuación crearemos en el servidor y en el directorio **Initializers** un nuevo fichero **01_mongodb.js** (el 01 es para que se ejecute primero):
```javascript
var mongoose = require('mongoose');
// Para crear una conexión dentro de mongoose
module.exports = gamedb = mongoose.createConnection(config.database);
```
* Ahora crearemos un nuevo modelo llamado **user.js** en **Models** que tendrá dos métodos diferentes, register y login que crearán un usuario en la base de datos de mongo o lo autenticarán contra ella:
```javascript
var mongoose = require('mongoose');
var userSchema = new mongoose.Schema({
    username: {type: String, unique: true},
    password: String,
    sprite: String,
    current_room: String,
    pos_x: Number,
    pos_y: Number
});

userSchema.statics.register = function(username, password, callback){
    var new_user = new User({
        username: username,
        password: password,
        sprite: "spr_Hero",
        current_room: maps[config.starting_zone].room,
        pos_x:maps[config.starting_zone].start_x,
        pos_y:maps[config.starting_zone].start_y
    });

    new_user.save(function(err){
        if(!err){
            callback(true);
        } else {
            callback(false);
        }
    })
};

userSchema.statics.login = function(username, password, callback){
    User.findOne({username: username}, function(err, user){
       if (!err && user){
           if (user.password == password){
               callback(true, user);
           } else {
               callback(false, null);
           }
       } else {
           // error || user not exists
           callback(false, null);
       }
    });
};

module.exports = User = gamedb.model('User', userSchema);
```

## Parte 9: Implementando el login

* Lo primero que añadiremos a nuestro proyecto de game maker es una función para escribir en el socket, es decir, hasta ahora podíamos sólo recibir datos del servidor pero no enviarle. Con esta función **network_write** podremos hacer exactamente éso:
```javascript
//argument0: socket
//argument1: buffer of data to send

//Initialize
var packetSize = buffer_tell(argument1);
var bufPacket = buffer_create(1, buffer_grow, 1);

// Write the size, and the packet... into new buffer
buffer_write(bufPacket, buffer_u8, packetSize+1);
buffer_copy(argument1, 0, packetSize, bufPacket, 1);
buffer_seek(buffPacket, 0, packetSize+1);

// Send the packet to server
network_send_raw(argument0, bufPacket, buffer_tell(bufPacket));

// Destroy the buffers
buffer_delete(argument1);
buffer_delete(bufPacket);
```
* Ahora añadimos la acción en el momento de hacer clic derecho en el **btn_Login**:
```javascript
event_inherited();
if (string_length(txt_Username.text) > 0 && string_length(txt_Password.text) > 0){
    var login_packet = buffer_create(1, buffer_grow, 1);
    buffer_write(login_packet, buffer_string, "login");
    buffer_write(login_packet, buffer_string, txt_Username.text);
    buffer_write(login_packet, buffer_string, txt_Password.text);
    network_write(Network.socket, login_packet);
} else {
    show_message("Error: Username or password cannot be blank");
}
```
* A continuación vamos a crear un inicializador para manejar los paquetes llamado **00_paquetmodels.js**:
```javascript
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
```
* Y añadimos las funciones **parse** e **interpret** en el **packet.js**:
```javascript
// Parse a package to be handled for a client
parse: function(c, data){
    var idx = 0; //index
    while( idx < data.length ){
        var packetSize = data.readUInt8(idx);
        var extractedPacket = new Buffer(packetSize);
        data.copy(extractedPacket,0, idx, idx+packetSize)

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
               if (result){
                   c.user = user;
                   //c.enter_room(c.user.current_room);
                   c.socket.write(packet.build(["LOGIN","TRUE", c.user.current_room, c.user.pos_x, c.user.pos_y, c.user.username]));
               } else {
                   c.socket.write(packet.build(["LOGIN","FALSE"]));
               }
            });// from the user object
            break;
        case "REGISTER":
            // do something
            break;
    }
}
```

## Parte 10: Implementando el registro

* Empezaremos añadiendo una acción al **btn_Register** para cuando se haga clic encima procesar el registro:
```javascript
event_inherited();
if (string_length(txt_Username.text) > 0 && string_length(txt_Password.text) > 0){
    var register_packet = buffer_create(1, buffer_grow, 1);
    buffer_write(register_packet, buffer_string, "register");
    buffer_write(register_packet, buffer_string, txt_Username.text);
    buffer_write(register_packet, buffer_string, txt_Password.text);
    network_write(Network.socket, register_packet);
} else {
    show_message("Error: Username or password cannot be blank");
}
```
* Ahora volvemos al servidor para implementar nuestra fución de registro en el fichero **packet.js**, pero antes añadiremos al **00_paquetmodels.js** la nueva funcionalidad:
```javascript
register: new Parser().skip(1)
    .string("command", StringOptions)
    .string("username", StringOptions)
    .string("password", StringOptions)
```
* Ahora sí añadimos el código del registro en nuestro paquete:
```javascript
case "REGISTER":
    var data = PacketModels.register.parse(datapacket);
    User.register(data.username, data.password, function(result){
        if (result){
            c.socket.write(packet.build(["REGISTER","TRUE"]));
        } else {
            c.socket.write(packet.build(["REGISTER","FALSE"]));
        }
    });
```
* Y modificamos la función **this.data()** de **client.js** para que analice el paquete.recibido:
```javascript
this.data = function(data){
    packet.parse(client, data);
    //console.log("Client data: " + data.toString());
};
```
* Ahora podemos registrar un usuario en nuestro servidor:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img9.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img9.png)

* Si inspeccionamos la base de datos con robomongo parece que nuestro usuario está ahí guardado correctamente:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img10.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img10.png)

* Y si intentamos hacer un login, lo encuentra bien y el logeo es satisfactorio:

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img11.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img11.png)

## Parte 11: Manejando el login y el registro en el cliente

* Vamos a empezar creando la función que nos permitirá cambiar la room y llevar el recuento de usuarios en el fichero **client.js**:
```javascript
// Client Methods
this.enter_room = function(selected_room){
    maps[selected_room].clients.forEach(function(otherClient){
        otherClient.socket.write(packet.build(["ENTER"], client.username, client.pos_x, client.pos_y));
    }); // en la room de maps
    maps[selected_room].clients.push(client);
};
```
* Creamos la nueva función en el cliente para responder al registro en **handle_packet**:
```javascript
case "REGISTER":
    status = buffer_read(argument0, buffer_string);
    if (status == "TRUE"){
        show_message("Register Success: Please Login");
    } else {
        show_message("Register Failed: Username Taken");
    }
    break;
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img12.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img12.png)

* Ahora nos ponemos con el login. Lo esencial es replicar las rooms del servidor en el cliente. Así que creamos una nueva room inicial llamada **rm_map_home** tal como tenemos declarada en **hometown.js**.
* En lo que respecta al login en el cliente lo que haremos es leer todos los parámetros del buffer y dirigirnos a la room inicial del jugador, definida primeramente en la **config.js** como **starting_zone: "rm_map_home"** y luega llamada en el **packet.js** en el momento del login **c.enter_room(c.user.current_room);** y que ejecuta la escritura del socket arriba definida.
```javascript
case "LOGIN":
    status = buffer_read(argument0, buffer_string);
    if (status == "TRUE"){
        target_room = buffer_read(argument0, buffer_string);
        target_x = buffer_read(argument0, buffer_u16); // numbers pass across as UInt16LE in server
        target_y = buffer_read(argument0, buffer_u16);
        name = buffer_read(argument0, buffer_string);

        goto_room = asset_get_index(target_room);
        room_goto(goto_room);

        // Inititate a player object on this room

    } else {
        show_message("Login Failed: Username not exists or password incorrect.");
    }
    break;
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img13.png
)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/online/MMORPG_Server/Screens/img13.png)

* Es requisito tener siempre una representación de las rooms dentro de la carpeta **GameData/Maps** antes de indicarle al cliente su posición.
