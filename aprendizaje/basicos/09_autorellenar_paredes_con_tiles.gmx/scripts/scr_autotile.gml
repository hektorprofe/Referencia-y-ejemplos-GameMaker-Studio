var sw,sh,obj;

check = 0;
sw = sprite_width;
sh = sprite_height;
obj = object_index;

if (place_meeting(x + sw, y      , obj)) check += 16;   //right
if (place_meeting(x     , y + sh , obj)) check += 64;   //down
if (place_meeting(x - sw, y      , obj)) check += 8;    //left
if (place_meeting(x     , y - sh , obj)) check += 2;    //up
if (place_meeting(x - sw, y - sh , obj)) check += 1;    //up & left
if (place_meeting(x + sw, y - sh , obj)) check += 4;    //up & right
if (place_meeting(x + sw, y + sh , obj)) check += 128;  //down & right
if (place_meeting(x - sw, y + sh , obj)) check += 32;   //down & left

temp = check
check = scr_convert(check);

image_index = check;