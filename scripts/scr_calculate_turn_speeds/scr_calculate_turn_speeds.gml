///scr_calculate_turn_speeds
function scr_calculate_turn_speeds() {
	/*
	This is the formula that is used to produce a combatants speed for the turn,
	which determines the turn order. It also assigns speeds to dead combatants,
	which are used if they re-enter battle.
	*/
	for (var i=0; i<ds_list_size(oB_controller.combatant_list); i++) {
		with oB_controller.combatant_list[|i] {
			if next_turn_2_spd == -1 {
				next_turn_2_spd = spd*(spd_multiplier + random_range(-RANDOM_SPEED_MULTIPLIER,RANDOM_SPEED_MULTIPLIER)) + 1000000*priority;
			}
			if next_turn_spd == -1 {
				next_turn_spd = spd*(spd_multiplier + random_range(-RANDOM_SPEED_MULTIPLIER,RANDOM_SPEED_MULTIPLIER)) + 1000000*priority;
			}
		
			turn_spd = next_turn_spd;
			next_turn_spd = next_turn_2_spd;
		
			next_turn_2_spd = spd*(spd_multiplier + random_range(-RANDOM_SPEED_MULTIPLIER,RANDOM_SPEED_MULTIPLIER)) + 1000000*priority;
		}
	}


}
