## Transición blanca para finalizar el juego (con superficies)

Este es un ejemplo interesante para entender como funcionan las superficies, en el que se puede observar que las superficies son una especie de capas dibujables que podemos ir superponiendo para crear efectos.

El efecto se consigue gracias a la propiedad draw_set_blend_mode(bm_add) que permite ir sumando las opacidades de las superficies, luego hay que dejarla nuevamente a normal draw_set_blend_mode(bm_normal).

Sin embargo este sistema no es muy eficiente ya que se basa en añadir muchas superficies con rectángulos blancos de transparencia 1% una encima de otras para ir recreando el efecto de transición. En lugar de añadir 70 superficies con rectángulos de 1%, es mucho más eficiente poner 1 superficie con un rectángulo de 70% de transparencia.

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/20_transicion_blanca_de_final_de_juego.gmx/captura.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/basicos/20_transicion_blanca_de_final_de_juego.gmx/captura.png).
