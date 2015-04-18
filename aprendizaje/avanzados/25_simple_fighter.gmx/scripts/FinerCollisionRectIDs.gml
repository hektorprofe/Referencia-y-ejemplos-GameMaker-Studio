//FinerCollisionRectIDs(id1,id2)
//works like CollisionRectIDs(id1,id2)
//but performs 2 passes to reduce error

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


//pass2
xx = __left;
yy = __top;
xxx = __right;
yyy = __bottom;

xxxx = xx;
yyyy = yy;
found = false;
ct = (xxx-xx+1) * (yyy-yy+1)
do
{
    if(collision_point(xxxx,yyyy,argument0,true,false))
    if(collision_point(xxxx,yyyy,argument1,true,false))
    {
        found = true;
        __left = xxxx;
        __top = yyyy;
    }
    yyyy+=1;
    if(yyyy>yyy) 
    {
        xxxx+=1;
        yyyy = yy;
    }
    ct -=1
} until (found or ct<0)

xxxx = xxx;
yyyy = yyy;
found = false;
ct = (xxx-xx+1) * (yyy-yy+1)
do
{
    if(collision_point(xxxx,yyyy,argument0,true,false))
    if(collision_point(xxxx,yyyy,argument1,true,false))
    {
        found = true;
        __right = xxxx;
        __bottom = yyyy;
    }
    yyyy-=1;
    if(yyyy<yy) 
    {
        xxxx-=1;
        yyyy = yyy+1;
    }
    ct -=1
} until (found or ct<0)


__x = (__left+__right)/2
__y = (__top+__bottom)/2

return 1;