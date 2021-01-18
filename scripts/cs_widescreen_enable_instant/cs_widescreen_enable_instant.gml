///@descr cs_widescreen_enable_instant
/// instantly turns on widescreen
function cs_widescreen_enable_instant() {
	with o_camera {
		widescreen_height = WIDESCREEN_HEIGHT;
		widescreen_target = WIDESCREEN_HEIGHT;
	}
	cs_place++;


}
