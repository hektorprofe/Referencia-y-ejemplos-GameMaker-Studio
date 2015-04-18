var right, up, left, down, spdinc, maxhspd;
right = argument0;
up = argument1;
left = argument2;
spdinc = 5;
maxhspd = 10;  
side = 0;
   
if abs(hspeed) > 0 and !action {walking = true}
else {walking = false}

if action{hspeed = 0}

{
    if hspeed < -maxhspd{hspeed = -maxhspd}
    if hspeed >= maxhspd{hspeed = maxhspd}
}//limit max speed

if dead or other_player.dead  {exit} // si esta muerto uno de los dos Players

if onground { 
    if keyboard_check_pressed(up){
       motion_add(90, 12)
       scr_create_sfx(x, y, spr_jump);
    } 
 } else {
   spdinc = spdinc/1.25;
   maxhspd = 8; 
} // limito la velocidad hor durante el salto

if abs(hspeed) < maxhspd// if going slower than max speed
    {if keyboard_check(left)
        {motion_add(180, spdinc);}

    if keyboard_check(right)
        {motion_add(0, spdinc);}
    } 
    
if abs(hspeed) >= maxhspd// if going faster than max speed
    {if hspeed > 0{//if going right
        if keyboard_check(left)
            {motion_add(180, spdinc);}}
            
     if hspeed < 0{//if going left
        if keyboard_check(right)
            {motion_add(0, spdinc);}}
     }  

// Si estamos a la izq y nos movemos a la derecha, o a la derecha y amos a la izq
// Entonces solo dejo que el jugador se mueva al lado contrario, pero no a través del otro pnj
if place_meeting(x+hspeed,y,other_player) {
    if (x < other_player.x && sign(hspeed) == 1) or (x > other_player.x && sign(hspeed) == -1){
        walking = false;
        hspeed = 0;
    }
} else {
  if abs(hspeed) > 0 scr_create_sfx(x,y,spr_move);
}




