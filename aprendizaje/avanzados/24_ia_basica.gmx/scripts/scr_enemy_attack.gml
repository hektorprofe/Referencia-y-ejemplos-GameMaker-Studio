state_text = 'attack';
var dis = point_distance(x,y, obj_player.x,obj_player.y);

if (dis > attack_range){
    // pasamos al modo reto
    state = scr_enemy_chase;
} else{
    // si no atacamos
    if (alarm[0] == -1) {
        obj_player.hp -=1;
        alarm[0] = 30;
    }
}
