var key, spr_base, spr_atk;
key = argument0
spr_base = argument1
spr_atk = argument2
spr_atk_hitbox = argument3//new argument introduced
damage = argument4;
type = argument5;

//This section was switched to the top.
//this code looks to see if attack animation has completed
//if so, return back to base sprite       
if sprite_index == spr_atk//if currently attacking
    {if image_index == image_number - 1//check if animation finished
        {sprite_index = spr_base; //if animation finished return to base
         action = false}}

//this entire section is new
//if action{exit}  
if scr_preventattack(){exit}  // prevenimos el ataque enemigo durante un momento
if keyboard_check_pressed(key)
    {var atkbox;
    atkbox = instance_create(x, y, obj_attackbox)
    atkbox.owner = self.id
    atkbox.sprite_index = spr_atk_hitbox
    atkbox.image_index = 0
    // Get current xscale and set it to the attack :)
    atkbox.image_xscale = image_xscale;
    
    // Attack damage and type
    atkbox.damage = damage;
    atkbox.type = type;
    }

//This section switched to bottom.
//if currently not attacking, and a key has been pressed
//change sprite to attack sprite
if keyboard_check_pressed(key) //and !action
    {if sprite_index != spr_atk
        {image_index = 0; //set to beginning of animation
        sprite_index = spr_atk; 
        action = true}
    }
