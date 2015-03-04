for(i=0; i<=sprite_height; i=i+1)
{
    draw_sprite_part(sprite_index,0,0,i,sprite_width,1,x+sin((angulo+i)/b)*amplitud,y+i)
}

angulo+=2
