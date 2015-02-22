position = 5;

for (var i=0;i<15;i++)
{
    instance_create(room_width+(position*32), 336, obj_coin);
    position+=2;
}
