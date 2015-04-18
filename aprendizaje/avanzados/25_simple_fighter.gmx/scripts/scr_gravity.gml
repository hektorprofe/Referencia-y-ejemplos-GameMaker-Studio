var gforce;
gforce = 0.75
if y >= ground
    {vspeed = 0; y = ground; onground = true}
if y < ground
    {motion_add(270, gforce); onground = false}
