/// @description scr_actA_attack_normal(return)
/// @param return
function scr_actP_attack_normal(argument0) {
	/*
		This is the most basic party attack
	*/

	// Set the properties of the action
	var act_name = "Attack";
	var act_cost = 0;
	var act_descrip = "Attack\nnormally";
	var act_target = TARGET_SINGLE_ENEMY;

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
				create_effect(s_attack_normal, acting.target.x, acting.target.y-50);
				break;
		
			case 15:
				// Get the power of the attack
				var attack_power = 1.0;

				// Deal damage
				var damage = deal_damage(acting, acting.target, attack_power, DAMAGE_PHYSICAL);

				// Display some text
				text_add(acting.name+" attacked "+acting.target.name+" for "+string(damage)+" damage!");
	
				// Done
				act_done = true;
				break;
		}
		act_time1++;
	}


}
