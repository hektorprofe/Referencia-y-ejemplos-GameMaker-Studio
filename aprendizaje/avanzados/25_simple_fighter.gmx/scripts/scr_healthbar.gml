//player 1
with(obj_player_1){
draw_healthbar(16, 16, 316, 32, curhp/maxhp * 100, 
                      c_orange, c_green, c_green, 180, true, true)}

//player 2
with(obj_player_2){
draw_healthbar(room_width - 16, 16, room_width - 316, 
                      32, curhp/maxhp * 100, c_orange, c_green, 
                      c_green, 0, true, true)}
