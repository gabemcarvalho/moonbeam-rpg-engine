///@descr cs_wait_frames
///@arg frames
/// do nothing for a certain number of frames
function cs_wait_frames(argument0) {
	cs_timer++;

	if cs_timer + 1 >= argument0 {
		cs_place++;
	}


}
