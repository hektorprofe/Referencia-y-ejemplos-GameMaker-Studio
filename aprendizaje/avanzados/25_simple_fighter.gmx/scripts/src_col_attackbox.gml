if other.owner == self.id
    {exit}
if CollisionPointIDs(self.id, other.id, noone, noone, noone, noone , noone)
     {damaged = true;
       var sfx;
       sfx = instance_create(__x, __y, obj_specialeffect);
       sfx.sprite_index = spr_lowhit;
       curhp -= 5;
     }
    
with (other.id) {instance_destroy()}
