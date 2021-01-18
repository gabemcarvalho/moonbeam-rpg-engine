/// @description calculate_turn_order()
function calculate_turn_order() {
	// Determine turn order using the active combatant list
	// Calculate the turn speeds of each combatant
	// Turn speed is currently calculated using the equation:		speed*(speed multiplier + random multiplier) + 1,000,000*priority
	// Note: priority is meaningless as of right now
	scr_calculate_turn_speeds();

	// Get the turn order based on the calculated turn speeds
	ds_list_clear(turn_order);
	ds_list_add(turn_order, active_combatant_list[|0]);
	turn_length = 1;
	for (var i=1; i<ds_list_size(active_combatant_list); i++) {
		var j = 0;
		// Increment until the place where the current combatant is fastest
		while (turn_order[|j].turn_spd >= active_combatant_list[|i].turn_spd) {
			// Tie breaker
			if turn_order[|j].turn_spd == active_combatant_list[|i].turn_spd {
				if round(random(1))==1 break;
			}
			j++;
			if j == turn_length break;
		}
	
		// Insert current combatant
		ds_list_insert(turn_order, j, active_combatant_list[|i])
		turn_length++;
		j++;
	}

	// Do the same for the next turn as well
	ds_list_clear(next_turn_order);
	ds_list_add(next_turn_order, active_combatant_list[|0]);
	next_turn_length = 1;
	for (var i=1; i<ds_list_size(active_combatant_list); i++) {
		var j = 0;
		// Increment until the place where the current combatant is fastest
		while (next_turn_order[|j].next_turn_spd >= active_combatant_list[|i].next_turn_spd) {
			// Tie breaker
			if next_turn_order[|j].next_turn_spd == active_combatant_list[|i].next_turn_spd {
				if round(random(1))==1 break;
			}
			j++;
			if j == next_turn_length break;
		}
	
		// Insert current combatant
		ds_list_insert(next_turn_order, j, active_combatant_list[|i])
		next_turn_length++;
		j++;
	}

	// And the next
	ds_list_clear(next_turn_order_2);
	ds_list_add(next_turn_order_2, active_combatant_list[|0]);
	next_turn_length = 1;
	for (var i=1; i<ds_list_size(active_combatant_list); i++) {
		var j = 0;
		// Increment until the place where the current combatant is fastest
		while (next_turn_order_2[|j].next_turn_2_spd >= active_combatant_list[|i].next_turn_2_spd) {
			// Tie breaker
			if next_turn_order_2[|j].next_turn_2_spd == active_combatant_list[|i].next_turn_2_spd {
				if round(random(1))==1 break;
			}
			j++;
			if j == next_turn_length break;
		}
	
		// Insert current combatant
		ds_list_insert(next_turn_order_2, j, active_combatant_list[|i])
		next_turn_length++;
		j++;
	}


}
