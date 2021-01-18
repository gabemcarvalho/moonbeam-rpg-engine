///@descr cs_widescreen_disable_instant
/// instantly turns off widescreen
function cs_widescreen_disable_instant() {
	with o_camera {
		widescreen_height = 0;
		widescreen_target = 0;
	}
	cs_place++;


}
