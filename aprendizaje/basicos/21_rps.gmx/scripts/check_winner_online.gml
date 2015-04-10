// Returns -1 if draw
//          1 if winner p1
//          0 if loser p1

var p1,p2;
with (obj_game_online.current_hand) {
    p1 = hand;
}

p2 = obj_cross.hand;

if p1 == p2 return -1;
if (p1 == "Rock" && p2 == "Scissors") || (p1 == "Paper" && p2 == "Rock") || (p1 == "Scissors" && p2 == "Paper") {
    return 1;
} else return 0;