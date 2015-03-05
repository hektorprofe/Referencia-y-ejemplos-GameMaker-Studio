## Ejemplo de IA muy simple

Ejemplo creado siguiendo el videotutorial [Basic Artificial Intelligence](hhttps://www.youtube.com/watch?v=vitWB3KJyS4) de [HeartBeast](https://www.youtube.com/channel/UCrHQNOyU1q6BFEfkNq2CYMA).

Se basa en alternar tres estados en los enemigos dependiendo de la distancia a la que se encuentre el jugador de ellos:

* Idle: Estado inactivo, el enemigo está esperando que el jugador entre en su campo de visión. Cuando ésto sucede el estado cambia a persecución.
* Chase: Estado de persecución, el enemigo tiene al jugador en su campo de caza pero no de ataque, así que empieza a seguirlo. Cuando la distancia es sufiente corta se pasa al estado de ataque, si al contrario es demasiado grande se vuelve al estado de inactividad. 
* Attack: Estado de ataque, el enemigo ataca al jugador y le resta vida cada segundo. Sólo se llama cuando se está a una distancia muy corta, si la distancia se incrementa se vuelve al estado de persecución.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/24_ia_basica.gmx/captura.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/24_ia_basica.gmx/captura.png)