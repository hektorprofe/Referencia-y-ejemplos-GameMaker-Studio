/// Particionar sprite

// Tamaño de cada partícula en pixeles alto*ancho
size=10;

for(i=0; i<=sprite_width; i=i+1*size)
{
    for(j=0; j<=sprite_height; j=j+1*size)
    {
        px[i,j]=i
        py[i,j]=j
    }
}
explode=0