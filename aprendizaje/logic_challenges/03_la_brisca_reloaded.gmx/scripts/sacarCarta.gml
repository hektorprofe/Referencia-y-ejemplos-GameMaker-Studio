if  (ds_list_size(baraja) > 0)
{
    var carta = ds_list_find_value(baraja,0);
    ds_list_delete(baraja,0);
    
    audio_play_sound(snd_slide, 10, false);
    
    return carta;
    

}
return false;
