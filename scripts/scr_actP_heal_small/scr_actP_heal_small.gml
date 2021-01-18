/// @description scr_actA_heal_small(return)
/// @param return
function scr_actP_heal_small(argument0) {
	/*
		This is the most basic party attack
	*/

	// Set the properties of the action
	var act_name = "Heal Small";
	var act_cost = 5;
	var act_descrip = "Heal an\nally";
	var act_target = TARGET_SINGLE_PARTY;

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
				create_effect(s_heal_1_2, acting.target.x, acting.target.y);
			break;
		
			case 15:
				// Get the power of the attack
				var heal_power = 1.5;

				// Heal
				var damage = heal_damage(acting, acting.target, heal_power);

				// Display some text
				text_add(acting.target.name+" health went up by "+string(damage)+"!");
	
				// Done
				act_done = true;
			break;
		}
		act_time1++;
	}


}
