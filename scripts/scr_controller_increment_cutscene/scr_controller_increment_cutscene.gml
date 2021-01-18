/// @descr scr_controller_increment_cutscene
function scr_controller_increment_cutscene() {
	// manually tells the cutscene to continue
	with o_controller {
		if !cs_playing {
			show_error("tried to increment cutscene position, but no cutscene was playing!", false);
			return;
		}
		cs_place++;
		scr_reset_cutscene_variables();
		scr_controller_execute_cutscene();
	}


}
