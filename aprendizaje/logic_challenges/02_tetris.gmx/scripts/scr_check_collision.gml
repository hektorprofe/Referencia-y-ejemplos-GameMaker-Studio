/// Comprobaremos si hay bloques a los lados (si hay movimiento) o debajo
for (var i=0;i<ds_grid_width(f_grid);i++)
{
    for (var j=0;j<ds_grid_height(f_grid);j++)
    {
        
        var new_i = i + argument0+round(10/(ds_grid_width(f_grid)))+global.min_i;
        var new_j = j + argument1 + 1; //+1 por debajo
         
        // Si en la nueva posición  horizontal hay algo
        if (global.tablero[#new_i+argument2,new_j] > -1)
        {
            // Y si y solo si en esta posicion de la forma hay algo
            if (f_grid[#i,j] > -1) 
            {
                // Entonces no podemos movernos
                return true;
            }
        }
        
        // Si por debajo en el tablero hay algo
        if (global.tablero[#new_i,new_j] > -1) 
        {
            // Y si y solo si en esta posicion del grid hay algo
            if (f_grid[#i,j] > -1) 
            {
                // Entonces no podemos movernos
                return true;
            }
        }
    }
}

return false;
