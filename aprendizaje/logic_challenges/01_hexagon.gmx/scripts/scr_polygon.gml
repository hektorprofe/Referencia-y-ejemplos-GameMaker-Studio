// Creado por Héctor Costa Guzmán

// Script polígono: Dibuja un polígono en una coordenada.
// Utiliza una coordenada x-y, un radio y un número de lados.
// Además se puede indicar el ángulo de rotación respecto al centro.

// argument0 = x 
// argument1 = y
// argument2 = radius
// argument3 = edges
// argument4 = color
// argument5 = angle in degrees

var rads = degtorad(argument5); // A radianos

draw_set_color(argument4);
draw_primitive_begin_texture(pr_trianglefan,background_get_texture(back)) 

for (var i=0; i<argument3;i++) 
{
    var edgeX = argument0  + argument2 * cos(2 * pi * i / argument3);
    var edgeY = argument1  + argument2 * sin(2 * pi * i / argument3);
    
    // La rotación determina el nuevo punto (dx,dy) = (x2-x1, y2-y1)
    var newCoord = scr_rotate_coord(edgeX,edgeY,argument0,argument1,global.angle);
    
    draw_vertex_texture(newCoord[0] , newCoord[1], 1, 1);
}

draw_primitive_end();
draw_set_color(0);