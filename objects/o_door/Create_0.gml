/// @description make wall
// ensures player cannot go through door and mess with direction calculations
wall = instance_create_layer(x, y, "walls", o_wall);
wall.sprite_index = s_door_wall;
wall.image_xscale = image_xscale;
wall.image_yscale = image_yscale;