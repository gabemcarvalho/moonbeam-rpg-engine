///@descr cs_widescreen_disable
///@arg async
/// turns off widescreen
function cs_widescreen_disable(argument0) {
	if !cs_bool_1 {
		with o_camera {
			widescreen_height = WIDESCREEN_HEIGHT;
			widescreen_target = 0;
		}
		if argument0 {
			cs_place++;
		} else {
			o_camera.widescreen_continue_cs = true;
		}
		cs_bool_1 = true;
	}


}
