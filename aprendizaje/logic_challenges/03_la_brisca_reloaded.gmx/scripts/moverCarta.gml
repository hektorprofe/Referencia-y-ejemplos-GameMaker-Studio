// moverCarta(carta, xdestino, ydestino, speed) <- ideal con speed
var carta = argument0;
var xdestino = argument1;
var ydestino = argument2;
var spd = 75;


with (carta){
    if point_distance(x,y,xdestino,ydestino) > spd
    {
        move_towards_point(xdestino,ydestino,spd);
    }
    else 
    {   
        speed = 0;
        x = xdestino;
        y = ydestino;
    }
}
