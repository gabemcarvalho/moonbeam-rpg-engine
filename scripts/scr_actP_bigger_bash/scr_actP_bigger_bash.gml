/// @description scr_actA_bigger_bash(return)
/// @param return
function scr_actP_bigger_bash(argument0) {
	/*
		This is the most basic party attack
	*/

	// Set the properties of the action
	var act_name = "Bigger Bash";
	var act_cost = 8;
	var act_descrip = "Bash an\nenemy";
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
				create_effect(s_attack_hit, acting.target.x+random_range(-40,40), acting.target.y-50+random_range(-50,50));
				combatant_shake(acting.target,5,8);
				break;
			
			case 4:
				create_effect(s_attack_hit, acting.target.x+random_range(-40,40), acting.target.y-50+random_range(-50,50));
				combatant_shake(acting.target,5,8);
				break;
			
			case 7:
				create_effect(s_attack_hit, acting.target.x+random_range(-40,40), acting.target.y-50+random_range(-50,50));
				combatant_shake(acting.target,5,8);
				break;
			
			case 10:
				create_effect(s_attack_hit, acting.target.x+random_range(-40,40), acting.target.y-50+random_range(-50,50));
				combatant_shake(acting.target,5,8);
				break;
			
			case 13:
				create_effect(s_attack_hit, acting.target.x+random_range(-40,40), acting.target.y-50+random_range(-50,50));
				combatant_shake(acting.target,5,8);
				break;
			
			case 16:
				create_effect(s_attack_hit, acting.target.x+random_range(-40,40), acting.target.y-50+random_range(-50,50));
				combatant_shake(acting.target,5,8);
				break;
			
			case 19:
				create_effect(s_attack_hit, acting.target.x+random_range(-40,40), acting.target.y-50+random_range(-50,50));
				combatant_shake(acting.target,5,8);
				break;
			
			case 22:
				create_effect(s_attack_hit, acting.target.x+random_range(-40,40), acting.target.y-50+random_range(-50,50));
				combatant_shake(acting.target,5,8);
				break;
			
			case 25:
				// Get the power of the attack
				var attack_power = 2.0;

				// Deal damage
				var damage = deal_damage(acting, acting.target, attack_power, DAMAGE_PHYSICAL);

				// Display some text
				text_add(acting.name+" bashed "+acting.target.name+" for "+string(damage)+" damage!");
	
				// Done
				act_done = true;
				break;
		}
		act_time1++;
	}


}
