        
   /* 
for (var i=0;i<ds_grid_height(global.tablero);i++)
{
    cad = '';
    for (var j=0;j<ds_grid_width(global.tablero);j++)
    {
        if (global.tablero[#i,j] > -1) draw_sprite(spr_block,global.tablero[#i,j],32*i+16,32*j+16);
        
        //// SI CAMBIAMOS EL ORDEN HEIGHT Y WIDTH HAY QUE PONER J,I
        cad+=string(global.tablero[#j,i])+",";
        // DEBUG TOOLS
        // draw_set_color(c_white);
        // draw_text(15*i+130,15*j+5,string(global.tablero[#i,j]));
    }
    show_debug_message(string(i)+":" + string(cad));
    
}


// show_debug_message(string(cad));
// draw_set_color(c_white);
// draw_text(15*i+130,15*j+5,string(global.tablero[#i,j]));

/*
// Borramos las filas completadas
// Y para cada una moveremos todo el contenido superior (i<index) una fila abajo
for(var k=0;k<ds_list_size(completadas);k++)
{
    // Sacamos la fila de la lista
    var fila = ds_list_find_value(completadas, k); 
    show_debug_message("COMPLETA DETECTADA: " + string(fila));
    
    // La borramos
    for (var i=0;i<ds_grid_width(global.tablero);i++)
    {
        for (var j=0;j<ds_grid_height(global.tablero);j++)
        { 
            // Para la fila
            if(i == fila)
            {
                global.tablero[#i,j] = -1;
            }
        
        }
    }
}*/