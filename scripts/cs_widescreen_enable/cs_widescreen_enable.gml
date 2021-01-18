///@descr cs_widescreen_enable
///@arg async
/// turns on widescreen
function cs_widescreen_enable(argument0) {
	if !cs_bool_1 {
		with o_camera {
			widescreen_height = 0;
			widescreen_target = WIDESCREEN_HEIGHT;
		}
		if argument0 {
			cs_place++;
		} else {
			o_camera.widescreen_continue_cs = true;
		}
		cs_bool_1 = true;
	}


}
