var right, up, left, down, spdinc, maxhspd;
right = argument0;
up = argument1;
left = argument2;
spdinc = 5;
maxhspd = 10;  
side = 0;
     
if onground   
 {
     if keyboard_check_pressed(up) {
            motion_add(90, 10);
     }
 } else {
   spdinc = spdinc/1.25;
   maxhspd = 8; 
  } // limito la velocidad hor durante el salto
   
if abs(hspeed) > 0 and !action {walking = true}
else {walking = false}

{if hspeed < -maxhspd{hspeed = -maxhspd}
if hspeed >= maxhspd{hspeed = maxhspd}}//limit max speed

if action{hspeed = 0}

if abs(hspeed) < maxhspd// if going slower than max speed
    {if keyboard_check(left)
        {motion_add(180, spdinc)}

    if keyboard_check(right)
        {motion_add(0, spdinc)}
    }   
    
if abs(hspeed) >= maxhspd// if going faster than max speed
    {if hspeed > 0{//if going right
        if keyboard_check(left)
            {motion_add(180, spdinc)}}
            
     if hspeed < 0{//if going left
        if keyboard_check(right)
            {motion_add(0, spdinc)}}
     }
