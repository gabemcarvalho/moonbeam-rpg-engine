/// @descr scr_play_cutscene(cutscene_script)
/// @arg cutscene_script
function scr_play_cutscene(argument0) {
	// play a cutscene
	// cutscene object has format:
	// [
	// 	[scr_action_1, arg1, arg2],
	// 	[scr_action_2, arg1],
	// 	[scr_action_1, arg1, arg2, arg3, arg4],
	// ]

	if !instance_exists(o_controller) {
		show_error("controller object doesn't exist!", true);
	}
	if o_controller.cs_playing {
		show_error("tried to play two cutscenes at once!", false);
		return;
	}

	o_controller.cs_playing = true;
	o_controller.cs_place = 0;
	o_controller.cs_script = argument0;
	scr_reset_cutscene_variables();
	scr_controller_execute_cutscene();



}
