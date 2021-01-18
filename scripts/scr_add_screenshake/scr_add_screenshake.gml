/// @descr scr_add_screenshake
/// @param amount
/// @param duration
function scr_add_screenshake(argument0, argument1) {
	if instance_exists(o_camera) {
		o_camera.screenshake = argument0;
		o_camera.alarm[0] = argument1;
	}


}
