///@descr cs_wait_seconds
///@arg seconds
/// do nothing for a certain number of seconds
function cs_wait_seconds(argument0) {
	cs_timer++;

	if cs_timer + 1 >= argument0 * room_speed {
		cs_place++;
	}


}
