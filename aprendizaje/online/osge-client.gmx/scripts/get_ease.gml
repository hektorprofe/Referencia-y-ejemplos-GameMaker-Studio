var t;
t = argument0;
if argument1 >= 0
   return (ease_in(argument1,t));
else
   return (1-ease_in(abs(argument1),1-t));