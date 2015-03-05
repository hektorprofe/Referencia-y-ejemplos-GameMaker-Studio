/// 
state_text = 'idle';
var dis = point_distance(x,y, obj_player.x,obj_player.y);

if (dis <= sight_range){
    state = scr_enemy_chase;
}


