///@descr cs_fade_in
///@arg seconds
///@arg async
/// fades in to the room
function cs_fade_in(argument0, argument1) {
	if !cs_bool_1 {
		with o_camera {
			fade_alpha = 1;
			alpha_target = 0;
			alpha_spd = 1 / (room_speed * argument0);
		}
		if argument1 {
			cs_place++;
		} else {
			o_camera.fade_continue_cs = true;
		}
		cs_bool_1 = true;
	}


}
