//CheapCollisionRectIDs(id1,id2)
//works like IntersectRectIDs(id1,id2)
//but only if the 2 objects are really colliding
//determines the intersecting rectangular area of 2 instances' bbox

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
__x = (xx+xxx)/2
__y = (yy+yyy)/2
return 1;