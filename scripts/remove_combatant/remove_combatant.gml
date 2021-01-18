/// @description remove_combatant(object_id)
/// @param object_id
function remove_combatant(argument0) {
	var comb_id = argument0;

	// Remove from active combatant list
	ds_list_delete(active_combatant_list,ds_list_find_index(active_combatant_list,comb_id));

	// Remove from active type lists
	if comb_id.type == TYPE_PARTY {
		ds_list_delete(active_party_list,ds_list_find_index(active_party_list,comb_id));
	} else {
		ds_list_delete(active_enemy_list,ds_list_find_index(active_enemy_list,comb_id));
	}

	// If the combatant has already acted, decrease the turn place
	if ds_list_find_index(turn_order,comb_id) <= turn_place {
		turn_place--;
	}

	// Remove from turn order
	ds_list_delete(turn_order,ds_list_find_index(turn_order,comb_id));
	ds_list_delete(next_turn_order,ds_list_find_index(next_turn_order,comb_id));
	ds_list_delete(next_turn_order_2,ds_list_find_index(next_turn_order_2,comb_id));

	// Decrease the active combatant number
	active_combatant_number--;


}
