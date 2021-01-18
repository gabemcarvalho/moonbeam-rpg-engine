/// @description scr_actE_punch_in_the_face()
function scr_actE_punch_in_the_face() {
	/*
		Punch a random party member
	*/

	switch act_time1 {
		case 1:
			acting.target = active_party_list[|irandom(ds_list_size(active_party_list)-1)];
			create_effect(s_attack_hit, acting.target.x, acting.target.y);
			break;
		
		case 15:
			// Get the power of the attack
			var attack_power = 1.3;

			// Deal damage
			var damage = deal_damage(acting, acting.target, attack_power, DAMAGE_PHYSICAL);

			// Display some text
			text_add(acting.name+" punched "+acting.target.name+" in the face,#dealing "+string(damage)+" damage!");

			// Done
			act_done = true;
			break;
	}
	act_time1++;


}
