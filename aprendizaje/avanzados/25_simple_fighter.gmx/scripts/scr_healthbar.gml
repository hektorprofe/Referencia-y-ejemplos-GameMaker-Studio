var height;
height = 0.5;

//player1
with(obj_player_1) {
draw_rectangle(15, 15, 317, 16 + (16 * height), false)
    scr_draw_spritebar(spr_dmgbar, 16, 16, 300 * ((curhp + last_damage) / maxhp), height)
    scr_draw_spritebar(spr_healthbar, 16, 16, 300 * (curhp / maxhp), height)
    if last_damage_timer > 1
       {last_damage_timer -=1}
    else{if last_damage > 0 {last_damage -=1}}
    if (curhp < 0) curhp = 0; // Min live  = 0
}

//player2
with(obj_player_2)
{
    draw_rectangle(room_width - 317, 15, room_width - 16, 16 + (16 * height), false)
    scr_draw_spritebar(spr_dmgbar,  room_width - 316, 16, 300 * ((curhp + last_damage) / maxhp), height)
    scr_draw_spritebar(spr_healthbar, room_width - 316, 16, 300 * (curhp / maxhp), height)
    if last_damage_timer > 1
       {last_damage_timer -=1}
    else{if last_damage > 0 {last_damage -=1}}
    if (curhp < 0) curhp = 0; // Min live  = 0
   
}
