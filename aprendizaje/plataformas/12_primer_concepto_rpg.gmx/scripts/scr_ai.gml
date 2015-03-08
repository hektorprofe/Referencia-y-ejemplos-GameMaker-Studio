{
    if ( instance_exists(obj_player) )
    {
        // Si no hay una pared y el jugador está a menos de 256px
        if (distance_to_point(obj_player.x,obj_player.y) <= 256 && !collision_line(x,y,obj_player.x,obj_player.y,obj_wall,false,true))
        {
            // Eliminamos la fricción y añadimos 1 de speed hacia la dirección del jugador
            friction = 0;
            motion_add( point_direction(x,y,obj_player.x,obj_player.y), 1 );
            if(speed>=4) speed = 4;
        } 
        // Si hay una pared paramos el movimiento
        else
        {
            friction = 1;
        }
    }
}
