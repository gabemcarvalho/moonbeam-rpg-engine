///@descr cs_camera_pan_to_player
///@arg speed
/// pan to aplayer at a certain speed then follow them
function cs_camera_pan_to_player(argument0) {
	if !cs_bool_1 {
		if instance_exists(o_player) {
			with o_camera {
				done_moving = false;
				follow = noone;
				mode = CAMERA_PAN;
				xTo = clamp(o_player.x, wview / 2, room_width - wview / 2);
				yTo = clamp(o_player.y - 12, hview / 2, room_height - hview / 2);
				pan_spd = argument0;
			}
		} else {
			show_error("camera tried to pan to player, but player object doesn't exist!", false);
		}
		cs_bool_1 = true;
	}

	if o_camera.done_moving {
		o_camera.follow = o_player;
		cs_place++;
	}


}
