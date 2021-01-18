/// @descr scr_controller_execute_cutscene
function scr_controller_execute_cutscene() {
	// the script that plays cutscenes, not an action to be used in a cutscene
	with o_controller {
		if !cs_playing {
			return;
		}
		var wait = false;
		while cs_place < array_length_1d(cs_script) {
			var last_place = cs_place;
			script_execute_array(cs_script[cs_place]); // the important line
			if last_place == cs_place {
				wait = true;
				break; // execute same function again next frame if the place hasn't incremented
			}
			scr_reset_cutscene_variables();
		}
		if !wait && cs_place == array_length_1d(cs_script) {
			// ends cutscene
			cs_playing = false;
		}
	}


}
