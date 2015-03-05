///
state_text = 'chase';
var dis = point_distance(x,y, obj_player.x,obj_player.y);
var dir = point_direction(x,y, obj_player.x,obj_player.y);

// si estamos en el rango de deteccion pero no de ataque
// distancia <= rango deteccion y distancia > rango_ataque
// nos movemos hacia el jugador
if (dis <= sight_range && dis > attack_range){
    motion_set(dir,spd); 
} 
// si la distancia es menor o igual al rango de ataque atacamos
else if (dis <= attack_range){
    speed = 0;
    state = scr_enemy_attack;
} 
// sino pausamos el movimiento
else {
    speed = 0;
    state = scr_enemy_idle;
}
