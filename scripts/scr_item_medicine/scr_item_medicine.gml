/// @description scr_item_medicine(return)
/// @param return
function scr_item_medicine(argument0) {
	/*
		Heals 20 HP
	*/

	// Set the properties of the item
	var item_name =			"Medicine";
	var item_cost =			0;
	var item_descrip =		"Recover\n20 HP";
	var item_target =		TARGET_SINGLE_PARTY;
	var item_reuseable =	false;

	// Get the arguments
	var return_arg = argument0;

	if return_arg == ACT_NAME {
		return item_name;
	} else if return_arg == ACT_DESCRIP {
		return item_descrip;
	} else if return_arg == ACT_TARGET {
		return item_target;
	} else if return_arg == ACT_ITEM_REUSEABLE {
		return item_reuseable;
	} else if return_arg == ACT_RUN {
		// Execute the item's battle action
		switch act_time1 {
			case 1:
				create_effect(s_heal_1_2, acting.target.x, acting.target.y);
			break;
		
			case 15:
				// Get the amount of HP healed
				var heal_amount = 20;

				// Heal
				heal_damage_exact(acting.target, heal_amount);

				// Display some text
				text_add(acting.target.name+" health went up by "+string(heal_amount)+"!");
	
				// Done
				act_done = true;
			break;
		}
		act_time1++;
	} else if return_arg == ACT_ITEM_USE {
		// Use the item
	}


}
