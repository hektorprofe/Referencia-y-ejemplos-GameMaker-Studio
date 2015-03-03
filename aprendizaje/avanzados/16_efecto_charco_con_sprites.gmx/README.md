## Dibujando charcos con sprites y superficies

Para este ejemplo he utilizado como base el del usuario [nocturne](http://nocturnegames.webs.com/surfaceeffects.htm) llamado Dynamic Blood Puddles.

Importante remarcar que en ocasiones las superficies desaparecen y es necesario comprobar si existen antes de utilizarlas, por ello se añade el código de creación otra vez después de una comprobación en el propio Draw:

```javascript
// Si no existe la superficie la creamos (al cambiar a fullscreen desaparece)
if !surface_exists(global.surf)
{
    global.surf = surface_create(room_width,room_height);
    surface_set_target(global.surf);
    draw_clear_alpha(c_black,0);
    surface_reset_target();
}
```

[![Imagen](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/16_efecto_charco_con_sprites.gmx/captura.png)](https://github.com/hcosta/referencia-gml/raw/master/aprendizaje/avanzados/16_efecto_charco_con_sprites.gmx/captura.png)