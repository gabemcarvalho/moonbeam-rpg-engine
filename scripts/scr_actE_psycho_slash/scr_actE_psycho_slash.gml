/// @description scr_actE_psycho_slash()
function scr_actE_psycho_slash() {
	/*
		Hit all party members
	*/
	switch act_time1 {
		case 1:
			create_effect(s_attack_slice, room_width/2, active_party_list[|0].y);
			break;
		
		case 15:
			// Get the power of the attack
			var attack_power = 0.8;

			// Deal damage
			for (var i=0; i<ds_list_size(active_party_list); i++) {
				deal_damage(acting, active_party_list[|i],attack_power, DAMAGE_MAGIC);
			}

			// Display some text
			text_add(acting.name+" used his psychic powers to cut up#the party!");

			// Done
			act_done = true;
			break;
	}
	act_time1++;


}
