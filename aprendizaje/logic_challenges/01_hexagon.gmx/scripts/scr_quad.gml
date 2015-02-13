// Creado por Héctor Costa Guzmán

// Script trapecio: Dibuja un trapecio a partir
// de cuatro coordenadas usando primitivas

// argument0 = c1x 
// argument1 = c1y
// argument2 = c2x 
// argument3 = c2y
// argument4 = c3x 
// argument5 = c3y
// argument6 = c4x 
// argument7 = c4y
// argument8 = color

draw_set_color(argument8);   //pr_trianglefan  pr_linestrip
draw_primitive_begin_texture(pr_linestrip,background_get_texture(back));

draw_vertex_texture(argument0, argument1, 1, 1);
draw_vertex_texture(argument2, argument3, 1, 1);
draw_vertex_texture(argument4, argument5, 1, 1);
draw_primitive_end();
draw_vertex_texture(argument6, argument7, 1, 1);

draw_set_color(0);
