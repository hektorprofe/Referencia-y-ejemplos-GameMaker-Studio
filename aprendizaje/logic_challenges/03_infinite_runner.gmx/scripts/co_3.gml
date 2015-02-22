n = 336
o = 318

position = 5;
for (var i=0;i<15;i++)
{
    instance_create(room_width+(position * 32), n, obj_coin);
    position+=2;
}

position = 6;
for (var i=0;i<14;i++)
{
    instance_create(room_width+(position * 32), o, obj_coin);
    position+=2;
}
