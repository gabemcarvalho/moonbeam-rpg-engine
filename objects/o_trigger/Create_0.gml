if (required_flag != FLAGS.NONE && !scr_get_flag(required_flag)) || (destroy_if_flag != FLAGS.NONE && scr_get_flag(destroy_if_flag)) {
	instance_destroy();
}

cutscene = [];