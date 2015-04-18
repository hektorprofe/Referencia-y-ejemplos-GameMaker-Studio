if other.owner == self.id
    {exit}
if CollisionPointIDs(self.id, other.id, noone, noone, noone, noone , noone)
    {damaged = true}
with (other.id) {instance_destroy()}