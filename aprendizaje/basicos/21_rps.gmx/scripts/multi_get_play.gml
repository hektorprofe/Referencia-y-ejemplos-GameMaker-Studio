var play = obj_game_online.enemy_hand;
var spr, h;

if (play == "Rock") { 
    spr = spr_rock;
} else if (play == "Paper") {
    spr = spr_paper;
} else {
    spr = spr_scissors;
}

with(obj_cross) {
    hand = play;
    sprite_index = spr;
    image_index = 0;
    image_speed = 0;
}
