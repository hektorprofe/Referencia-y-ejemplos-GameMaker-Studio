// Creado por Héctor Costa Guzmán

// Script rand_color: Devuelve un color aleatorio de mi paleta de colores.
    //rojo      //naranja   //verde    //azul
var r; r[0]=215;  r[1]=215;  r[2]=35;   r[3]=35;  
var g; g[0]=35;   g[1]=145;  g[2]=215;  g[3]=145;
var b; b[0]=35;   b[1]=35;   b[2]=35;   b[3]=215;

randomize();
var i = round(random(array_length_1d(r) - 1));

return make_color_rgb(r[i],g[i],b[i]);
