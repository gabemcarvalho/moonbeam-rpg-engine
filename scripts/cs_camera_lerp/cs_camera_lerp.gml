///@descr cs_camera_lerp
///@arg x
///@arg y
///@arg lerp_amount
///@arg async
/// pan to a position using a lerp
function cs_camera_lerp(argument0, argument1, argument2, argument3) {
	if !cs_bool_1 {
		with o_camera {
			done_moving = false;
			follow = noone;
			mode = CAMERA_LERP;
			xTo = clamp(argument0, wview / 2, room_width - wview / 2);
			yTo = clamp(argument1, hview / 2, room_height - hview / 2);
			lerp_amt = argument2;
		}
		cs_bool_1 = true;
	}

	if o_camera.done_moving || argument3 {
		cs_place++;
	}


}
