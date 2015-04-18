//States

action = false
walking = false
damaged = false

onground = false;
ground = 302;

curhp = 100
maxhp = 100

image_speed = 1/(image_number*2);

last_damage = 0
last_damage_timer = 0
juggle_timer = 0;

dead = 0

if self.id = obj_player_1.id
    {other_player = obj_player_2.id}
else
    {other_player = obj_player_1.id}
