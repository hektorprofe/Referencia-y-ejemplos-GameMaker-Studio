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
  image_index = 0}
  
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
