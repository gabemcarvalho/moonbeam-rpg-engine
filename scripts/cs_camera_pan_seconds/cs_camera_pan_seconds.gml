///@descr cs_camera_pan_seconds
///@arg x
///@arg y
///@arg seconds
///@arg async
/// pan to a position over a certain amount of time
function cs_camera_pan_seconds(argument0, argument1, argument2, argument3) {
	if !cs_bool_1 {
		with o_camera {
			done_moving = false;
			follow = noone;
			mode = CAMERA_PAN;
			xTo = clamp(argument0, wview / 2, room_width - wview / 2);
			yTo = clamp(argument1, hview / 2, room_height - hview / 2);
		
			var dx = xTo - x;
			var dy = yTo - y;
			var dist = sqrt(dx * dx + dy * dy);
			var frames = argument2 * room_speed;
			pan_spd = dist / frames;
		}
		cs_bool_1 = true;
	}

	if o_camera.done_moving || argument3 {
		cs_place++;
	}


}
