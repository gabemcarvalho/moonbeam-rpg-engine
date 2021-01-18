/// @description scr_actA_heal_group(return)
/// @param return
function scr_actP_heal_group(argument0) {
	/*
		This is the most basic party attack
	*/

	// Set the properties of the action
	var act_name = "Heal Group";
	var act_cost = 20;
	var act_descrip = "Heal all\nallies";
	var act_target = TARGET_ALL_PARTY;

	// Get the arguments
	var return_arg = argument0;

	if return_arg == ACT_NAME {
		return act_name;
	} else if return_arg == ACT_COST {
		return act_cost;
	} else if return_arg == ACT_DESCRIP {
		return act_descrip;
	} else if return_arg == ACT_TARGET {
		return act_target;
	} else if return_arg == ACT_RUN {
		// Execute the action
		switch act_time1 {
			case 1:
				for (var i=0; i<ds_list_size(party_list); i++) {
					if party_list[|i].hp > 0 {
						create_effect(s_heal_1_2, party_list[|i].x, party_list[|i].y);
					}
				}
				break;
		
			case 15:
				// Get the power of the attack
				var heal_power = 1.5;

				// Heal
				for (var i=0; i<ds_list_size(party_list); i++) {
					if party_list[|i].hp > 0 {
						heal_damage(acting, party_list[|i],heal_power);
					}
				}
	
				// Display some text
				text_add("The party regained some health!");
	
				// Done
				act_done = true;
				break;
		}
		act_time1++;
	}


}
