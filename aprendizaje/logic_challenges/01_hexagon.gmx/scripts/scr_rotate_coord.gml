// Creado por Héctor Costa Guzmán

// Script rotar coordenada: Devuelve un array con 2 valores.
// El primero correspondo al siguiente punto x y el segundo al y.

// argument0 = x 
// argument1 = y
// argument2 = offset_x
// argument3 = offset_y
// argument4 = angle

// retorna coord[x,y];

var rads = degtorad(argument4); // A radianos
var coord;
var newX = argument0 - argument2;
var newY = argument1 - argument3;

edgeX = newX * cos(rads) - newY * sin(rads);
edgeY = newX * sin(rads) + newY * cos(rads);

coord[0] = edgeX + argument2;
coord[1] = edgeY + argument3;

return coord;
