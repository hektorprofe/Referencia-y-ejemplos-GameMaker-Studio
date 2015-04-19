if dead{
    if sprite_index != spr_ryu_defeat {
        sprite_index = spr_ryu_defeat;
        image_index = 0; 
        image_speed = image_speed / 2; 
        if image_xscale == -1 motion_set(200, 12);
        else motion_set(20, 12);
   } else {
        if image_index = image_number -1{
            image_speed = 0;
        }
   }
   exit;
}

if other_player.dead {
    if (other_player.dead && (other_player.image_index == other_player.image_number-1)){
        if (sprite_index != spr_ryu_win){ 
              sprite_index = spr_ryu_win;
              image_speed = image_speed / 2;
        }
        if image_index = image_number -1 {
              image_speed = 0
        }
    }
    exit;
}


if walking and !action and onground
    { 
        //if hspeed < 0 sprite_index = spr_ryu_back
        //else sprite_index = spr_ryu_front
        sprite_index = spr_ryu_back
    }

if !walking and !action and onground
    {sprite_index = spr_ryu_stand}
    

if damaged and sprite_index != spr_ryu_hit
{sprite_index = spr_ryu_hit;
  action = true
  image_index = 0;
  
  // Push effect from enemy
  if (other_player.x < x && other_player.onground == true) motion_add(0, 6);  
  if (other_player.x > x && other_player.onground == true) motion_add(180, 6);  
}
  
if sprite_index == spr_ryu_hit{
     {if image_index >= image_number -1
            {action = false; damaged = false}}}
            
if !onground {
    if sprite_index == spr_ryu_back or sprite_index == spr_ryu_stand {
        image_index = 0
        sprite_index = spr_ryu_jump
    }
}
if sprite_index == spr_ryu_jump {
    if image_index > image_number -1 {
        image_index = image_number -1
    }
}
