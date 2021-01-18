///@descr cs_camera_pan_speed
///@arg x
///@arg y
///@arg speed
///@arg async
/// pan to a position at a certain speed
function cs_camera_pan_speed(argument0, argument1, argument2, argument3) {
	if !cs_bool_1 {
		with o_camera {
			done_moving = false;
			follow = noone;
			mode = CAMERA_PAN;
			xTo = clamp(argument0, wview / 2, room_width - wview / 2);
			yTo = clamp(argument1, hview / 2, room_height - hview / 2);
			pan_spd = argument2;
		}
		cs_bool_1 = true;
	}

	if o_camera.done_moving || argument3 {
		cs_place++;
	}


}
