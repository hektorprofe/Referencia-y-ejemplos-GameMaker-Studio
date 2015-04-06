randomize();
var play = irandom(2);
var spr, h;

if (play == 0) { 
    spr = spr_rock;
    h = "Rock";
} else if (play == 1) {
    spr = spr_paper;
    h = "Paper";
} else {
    spr = spr_scissors;
    h = "Scissors";
}

with(obj_cross) {
    hand = h;
    sprite_index = spr;
    image_index = 0;
    image_speed = 0;
}
