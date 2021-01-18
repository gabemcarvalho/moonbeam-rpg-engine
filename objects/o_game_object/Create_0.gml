// destroy on certain flags
if (required_flag != FLAGS.NONE && !scr_get_flag(required_flag)) || (destroy_if_flag != FLAGS.NONE && scr_get_flag(destroy_if_flag)) {
	instance_destroy();
}

// collisions
hitbox = instance_create_layer(x, y, "walls", o_wall);
hitbox.sprite_index = sprite_index;
movable = false;

// cutscenes
interaction_number = 0;
last_flag = FLAGS.NONE;
cutscenes = [
	[FLAGS.NONE, [
		// cutscene for first interaction goes here
	]],
];