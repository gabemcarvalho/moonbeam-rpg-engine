///@descr cs_camera_follow_player
function cs_camera_follow_player() {
	// instantly jumps to player and follows them
	if instance_exists(o_player) {
		o_camera.follow = o_player;
	} else {
		show_error("camera tried to jump to player, but player object doesn't exist!", false);
	}

	cs_place++;


}
