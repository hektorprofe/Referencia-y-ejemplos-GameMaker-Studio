if other.owner == self.id
    {exit}
if CollisionPointIDs(self.id, other.id, noone, noone, noone, noone , noone)
     {damaged = true;
       var sfx;
       sfx = instance_create(__x, __y, obj_specialeffect);
       sfx.sprite_index = spr_lowhit;
       /*curhp -= 5;
       last_damage +=5
       last_damage_timer +=5*/
       
       curhp -= other.damage;
       last_damage += other.damage;
       last_damage_timer +=5;
       
       if curhp <= 0 {dead = true}
        
       if other.type == 'juggle'
           {
           hspeed = 0;
           vspeed = 0;
           motion_add(90, 11);
           juggle_timer = 10;
           scr_quake(5,5);}
           
     }
    
with (other.id) {instance_destroy()}
