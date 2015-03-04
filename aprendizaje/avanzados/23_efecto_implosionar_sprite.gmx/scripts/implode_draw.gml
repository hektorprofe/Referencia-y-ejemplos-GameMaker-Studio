/// Dibujar las partes en movimiento
for(i=0; i<=sprite_width; i=i+1*size)
{
    for(j=0; j<=sprite_height; j=j+1*size)
    {

        if implode=1
        {
            if abs(px[i,j]-sprite_width/2)>2 or abs(py[i,j]-sprite_height/2)>2
            {
                draw_sprite_part(sprite_index,image_index,i,j,size,size,x+px[i,j],y+py[i,j])
            }
            
            if abs(px[i,j]-sprite_width/2)>2
            {
                px[i,j]+=cos(degtorad(point_direction(x+i,y+j,x+sprite_width/2,y+sprite_height/2)))*(2)
            }
            
            if abs(py[i,j]-sprite_height/2)>2
            {
                py[i,j]-=sin(degtorad(point_direction(x+i,y+j,x+sprite_width/2,y+sprite_height/2)))*(2)
            }
        }
        else
        {
            draw_self();
        }

    }
}

if mouse_check_button_pressed(mb_left) { implode=1; }
