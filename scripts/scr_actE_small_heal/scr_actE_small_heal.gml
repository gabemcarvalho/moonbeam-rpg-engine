/// @description scr_actE_small_heal()
function scr_actE_small_heal() {
	/*
		The enemy heals a random enemy
	*/
	switch act_time1 {
		case 1:
			acting.target = active_enemy_list[|irandom(ds_list_size(active_enemy_list)-1)];
			create_effect(s_heal_1_2, acting.target.x, acting.target.y-50);
			break;
		
		case 15:
			// Get the power of the heal
			var heal_power = 0.8;

			// Deal damage
			var damage = heal_damage(acting, acting.target, heal_power);

			// Display some text
			if acting.target == acting {
				text_add(acting.name+" healed itself by "+string(damage)+" points!");
			} else {
				text_add(acting.name+" healed "+acting.target.name+" by "+string(damage)+" points!");
			}

			// Done
			act_done = true;
			break;
	}
	act_time1++;


}
