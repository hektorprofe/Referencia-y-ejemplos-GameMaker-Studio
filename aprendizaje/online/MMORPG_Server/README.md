# Creando el servidor con nodejs
Este ejemplo se ha creado a partir de la serie de videotutoriales **Lets Build A MMORPG** del usuario [rmkdev](https://www.youtube.com/channel/UCJvrLzbg4VPRxzf2vhW7G4A).

## Parte 1
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

## Parte 2
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



