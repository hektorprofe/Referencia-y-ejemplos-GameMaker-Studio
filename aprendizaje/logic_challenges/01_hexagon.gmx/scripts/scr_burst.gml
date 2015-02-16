// Creado por Héctor Costa Guzmán

// Script burst: Crea una ráfaga de trapecios aleatoria

var rand = round(random(4));
var nrand = round(random(5)); // 0 al 6


switch(rand)
{
    case 0:
        // rand = 0 , 1 camino
        if (nrand > 3) nrand -= 4;
        //show_debug_message("CASE 0: nrand: " +string(nrand) + " rand: " + string(rand));
    
        for (var i=0;i<6;i++)
        {   
            if (nrand != i)
            {
        
                trapezoid = instance_create(0, 0, obj_trapezoid);
                with(trapezoid)
                {
                    angle = i * 60;  
                }
            
            }
            
        }
        
        break;
        
    case 1:
        // rand = 1 , 2 caminos v1
        if (nrand > 2) nrand-=3;
        //show_debug_message("CASE 1: nrand: " +string(nrand) + " nrand+3: " + string(rand)+ " rand: " + string(rand));
    
        for (var i=0;i<6;i++)
        {   
            if (nrand != i && nrand+3 != i)
            {
                trapezoid = instance_create(0, 0, obj_trapezoid);
                with(trapezoid)
                {
                    angle = i * 60; 
                }
            }
            
        }
        
        break;
        
    case 2:
    
        // rand = 0 , 1 camino (sino es muy facil)
        if (nrand > 3) nrand -= 4;
        //show_debug_message("CASE 0: nrand: " +string(nrand) + " rand: " + string(rand));
    
        for (var i=0;i<6;i++)
        {   
            if (nrand != i)
            {
        
                trapezoid = instance_create(0, 0, obj_trapezoid);
                with(trapezoid)
                {
                    angle = i * 60;  
                }
            
            }
            
        }
        
        break;
        
        /*
        
        // rand = 2 , 2 caminos v2
        if (nrand > 2) nrand-=2;
        
        for (var i=0;i<6;i++)
        {   
            if (nrand != i && nrand+2 != i)
            {
                trapezoid = instance_create(0, 0, obj_trapezoid);
                with(trapezoid)
                {
                    angle = i * 60; 
                }
            }
            
        }
        
        break;
        
        */
        
    case 3:
        // rand = 3 , 3 caminos
        if (nrand > 2) nrand-=4;
        
        for (var i=0;i<6;i++)
        {   
            if (nrand != i && nrand+2 != i && nrand+4 != i) 
            {
                trapezoid = instance_create(0, 0, obj_trapezoid);
                with(trapezoid)
                {
                    angle = i * 60; 
                }
            }
            
        }
        
        break;
        
    default:
        // rand = 0 , 1 camino
        if (nrand > 3) nrand -= 4;
        //show_debug_message("CASE 0: nrand: " +string(nrand) + " rand: " + string(rand));
        
        var resize = false;        
        if (round(random(2) == 0)) resize = true;
    
        for (var i=0;i<6;i++)
        {   
            if (nrand != i)
            {
        
                trapezoid = instance_create(0, 0, obj_trapezoid);
                with(trapezoid)
                {
                    angle = i * 60; 
                    height = 77 - (i*7);   
                }
            
            
            }
            
        }
        
        break;
        
}
