///Key, basesprite, attacksprite, hitbox, damage, type
if object_index == obj_player_1{
    scr_drawattack(ord('X'), spr_ryu_stand, spr_ryu_jab, spr_ryu_jab_hitbox, 5, 'normal')
    scr_drawattack(ord('V'), spr_ryu_stand, spr_ryu_kneekick, spr_ryu_kneekick_hitbox, 5, 'normal')
    scr_drawattack(ord('Z'), spr_ryu_stand, spr_ryu_flykick, spr_ryu_flykick_hitbox, 5, 'normal')
    scr_drawattack(ord('C'), spr_ryu_stand, spr_ryu_topkick, spr_ryu_topkick_hitbox, 5, 'juggle')}
else{
    scr_drawattack(ord('G'), spr_ryu_stand, spr_ryu_jab, spr_ryu_jab_hitbox, 5, 'normal')
    scr_drawattack(ord('Y'), spr_ryu_stand, spr_ryu_kneekick, spr_ryu_kneekick_hitbox, 5, 'normal')
    scr_drawattack(ord('U'), spr_ryu_stand, spr_ryu_flykick, spr_ryu_flykick_hitbox, 5, 'normal')
    scr_drawattack(ord('H'), spr_ryu_stand, spr_ryu_topkick, spr_ryu_topkick_hitbox, 5, 'juggle')

}
