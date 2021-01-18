///@descr scr_get_object_cutscene
///@arg object
function scr_get_object_cutscene(argument0) {
	// check interactions for each flag
	with argument0 {
		// check flags in reverse order (most recently added has precedence)
		var pair_index = 0;
		for (var i = array_length_1d(cutscenes) - 1; i > 0; i--) { // doesn't check index 0 on purpose
			var flag_pair = cutscenes[i];
			if scr_get_flag(flag_pair[0]) {
				pair_index = i;
				break;
			}
		}
		// use default interaction chain
		var flag_pair = cutscenes[pair_index];
		var interaction_chain = flag_pair[1];
		if array_length_1d(interaction_chain) == 0 {
			return []; // no cutscenes to play
		}
		if flag_pair[0] != last_flag { // starting new chain
			last_flag = flag_pair[0];
			interaction_number = 0;
		}
		var index = min(array_length_1d(interaction_chain) - 1, interaction_number);
		interaction_number++;
		return interaction_chain[index];
	}


}
