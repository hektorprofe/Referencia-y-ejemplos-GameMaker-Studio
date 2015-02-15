// Creado por Héctor Costa Guzmán

// Script burst: Crea una ráfaga de trapecios
for (var i=0;i<6;i++)
{   
    trapezoid = instance_create(0, 0, obj_trapezoid);
    with(trapezoid)
    {
        angle = i * 60; 
    }
    
}
