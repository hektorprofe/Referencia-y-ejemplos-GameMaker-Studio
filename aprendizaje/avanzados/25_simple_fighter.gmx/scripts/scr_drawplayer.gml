if hspeed > 0 image_xscale = -1;
else if hspeed < 0  image_xscale = 1;

draw_sprite_ext(sprite_index, image_index, x,y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)