// Creo la baraja
baraja = ds_list_create();

// Índice del sprite
var n=0; 

// Añado los oros
for (var i=0;i<12;i++)
{
    var carta = instance_create(999,999,obj_carta);    
    with(carta)
    {
        palo = 0;
        numero = i+1;
        valor = valorCarta(numero);
        puntos = puntosCarta(numero);
        sprite = n;
    }
    ds_list_add(baraja,carta);
    n++;
}

// Añado las copas
for (var i=0;i<12;i++)
{
    var carta = instance_create(999,999,obj_carta);     
    with(carta)
    {
        palo = 1;
        numero = i+1;
        valor = valorCarta(numero);
        puntos = puntosCarta(numero);
        sprite = n;
    }
    ds_list_add(baraja,carta);
    n++;
}

// Añado las espadas
for (var i=0;i<12;i++)
{
    var carta = instance_create(999,999,obj_carta);   
    with(carta)
    {
        palo = 2;
        numero = i+1;
        valor = valorCarta(numero);
        puntos = puntosCarta(numero);
        sprite = n;
    }
    ds_list_add(baraja,carta);
    n++;
}

// Añado los bastos
for (var i=0;i<12;i++)
{
    var carta = instance_create(999,999,obj_carta);  
    with(carta)
    {
        palo = 3;
        numero = i+1;
        valor = valorCarta(numero);
        puntos = puntosCarta(numero);
        sprite = n;
    }
    n++;
    ds_list_add(baraja,carta);
}

// Barajamos un par de veces
ds_list_shuffle(baraja);
randomize();
ds_list_shuffle(baraja);

// Les damos las posiciones iniciales
for (var i=0;i<ds_list_size(baraja);i++)
{
    var carta = ds_list_find_value(baraja,i);
    with(carta)
    {
        x = 50+(i/6);
        y = room_height/2-130+(i/6) 
        depth = i;
    }  
    show_debug_message(string(carta));
}

return baraja;