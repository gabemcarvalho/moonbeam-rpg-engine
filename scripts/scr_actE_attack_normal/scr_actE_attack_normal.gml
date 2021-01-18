/// @description scr_actE_attack_normal()
function scr_actE_attack_normal() {
	/*
		This is the most basic enemy attack
		Attacks a random active party member
	*/

	switch act_time1 {
		case 1:
			acting.target = active_party_list[|irandom(ds_list_size(active_party_list)-1)];
			create_effect(s_attack_normal, acting.target.x, acting.target.y);
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
