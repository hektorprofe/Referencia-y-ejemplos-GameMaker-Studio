var gforce;
gforce = 0.75
   /* if y >= ground
    {vspeed = 0; y = ground; onground = true}
if y < ground
    {motion_add(270, gforce); onground = false}
*/

// tener presente que vspeed negativo es hacia arriba en game maker
if y >= ground
    {if vspeed > 0{vspeed = 0}; y = ground; onground = true}

if y < ground
    {motion_add(270, gforce); onground = false}
