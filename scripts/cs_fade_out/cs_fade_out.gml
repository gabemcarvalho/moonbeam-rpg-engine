///@descr cs_fade_out
///@arg seconds
///@arg async
/// fades the screen to black
function cs_fade_out(argument0, argument1) {
	if !cs_bool_1 {
		with o_camera {
			fade_alpha = 0;
			alpha_target = 1;
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
