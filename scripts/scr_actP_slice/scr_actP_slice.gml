/// @description scr_actA_slice(return)
/// @param return
function scr_actP_slice(argument0) {
	/*
		This is the most basic party attack
	*/

	// Set the properties of the action
	var act_name = "Slice";
	var act_cost = 6;
	var act_descrip = "Slice all\nenemies";
	var act_target = TARGET_ALL_ENEMY;

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
				create_effect(s_attack_slice, room_width/2, active_enemy_list[|0].y-50);
				break;
		
			case 15:
				// Get the power of the attack
				var attack_power = 0.8;

				// Deal damage
				for (var i=0; i<ds_list_size(active_enemy_list); i++) {
					deal_damage(acting, active_enemy_list[|i], attack_power, DAMAGE_PHYSICAL);
				}

				// Display some text
				text_add(acting.name+" sliced up the enemy party!");
	
				// Done
				act_done = true;
				break;
		}
		act_time1++;
	}


}
