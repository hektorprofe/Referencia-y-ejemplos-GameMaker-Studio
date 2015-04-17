//CollisionRectIDs(id1,id2)
//works like CheapCollisionRectIDs(id1,id2)
//but returns the average rectangular area of the collision
//from the left and top most colliding area to the righ and bottom most
//does not handle multiple areas, it would combine them into a single larger one

//return 0 if no intersection
//return 1 if boxes intersect
//sets the following instance variables for you to get the region
//__left;
//__top;
//__right;
//__bottom;
//__x is the average (center of rect)
//__y is the average (center of rect)



var xx,yy,xxx,yyy;

xx = max(argument0.bbox_left,argument1.bbox_left)
yy = max(argument0.bbox_top,argument1.bbox_top)
xxx = min(argument0.bbox_right,argument1.bbox_right)
yyy = min(argument0.bbox_bottom,argument1.bbox_bottom)

if(xx>xxx) return 0;
if(yy>yyy) return 0;
with(argument0)
{
    if(!instance_place(x,y,argument1)) return 0;
}

__left = xx;
__top = yy;
__right = xxx;
__bottom = yyy;

var xxxx,yyyy, found,ct;
xxxx = xx;
found = false;
ct = xxx-xx
do
{
    if(collision_line(xxxx,yy,xxxx,yyy,argument0,true,false))
    if(collision_line(xxxx,yy,xxxx,yyy,argument1,true,false))
    {
        found = true;
        __left = xxxx;
    }
    xxxx+=1;
    ct -=1
} until (found or ct<0)

xxxx = xxx;
found = false;
ct = xxx-xx
do
{
    if(collision_line(xxxx,yy,xxxx,yyy,argument0,true,false))
    if(collision_line(xxxx,yy,xxxx,yyy,argument1,true,false))
    {
        found = true;
        __right = xxxx;
    }
    xxxx-=1;
    ct -=1
} until (found or ct<0)

yyyy = yy;
found = false;
ct = yyy-yy
do
{
    if(collision_line(xx,yyyy,xxx,yyyy,argument0,true,false))
    if(collision_line(xx,yyyy,xxx,yyyy,argument1,true,false))
    {
        found = true;
        __top = yyyy;
    }
    yyyy+=1;
    ct -=1
} until (found or ct<0)

yyyy = yyy;
found = false;
ct = yyy-yy
do
{
    if(collision_line(xx,yyyy,xxx,yyyy,argument0,true,false))
    if(collision_line(xx,yyyy,xxx,yyyy,argument1,true,false))
    {
        found = true;
        __bottom = yyyy;
    }
    yyyy-=1;
    ct -=1
} until (found or ct<0)

__x = (__left+__right)/2
__y = (__top+__bottom)/2

return 1;