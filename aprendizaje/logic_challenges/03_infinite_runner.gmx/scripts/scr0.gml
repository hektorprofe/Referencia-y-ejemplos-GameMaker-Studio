alarm[0] = 140;
global.mov=-10;
instance_create(room_width, 336, obj_block);
// instance_create(room_width+200,336, obj_hp);
// instance_create(room_width+50,336, obj_box);
script_execute(choose(co_1, co_2, co_3), irandom(1));
