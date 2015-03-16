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
* Configuramos el enterno para aádir argumentos al servidor, que en la terminal equivaldría a lanzar el servidor de la siguiente forma:
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
* Ahora para cargar la configuración deseada será tan sencillo como cargar la configuración y mostrar la variable del módulo:
```javascript
require(__dirname + '/Resources/config.js');
console.log(config.database);
```