sistema = part_system_create()
part_system_depth(sistema,-1);
particula = part_type_create()
part_type_shape(particula,pt_shape_spark)
part_type_scale(particula,1,1)
part_type_colour1(particula,c_red)
part_type_alpha1(particula,1)
part_type_speed(particula,1,2,0,0)
part_type_direction(particula,0,359,0,0)
part_type_gravity(particula,0,270)
part_type_orientation(particula,0,359,0,0,1)
part_type_blend(particula,0)
part_type_life(particula,15,15)

