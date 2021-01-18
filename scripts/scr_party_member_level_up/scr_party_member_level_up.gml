///@description scr_party_member_level_up(member, level);
///@param member
///@param level
function scr_party_member_level_up(argument0, argument1) {
	var member = argument0;
	var level = argument1;

	with member {
		var result = [];
	
		// Increase stats
		result[0] = fn_stat_increase(c_hp, level, hp_max-b_hp-e_hp);
		hp_max += result[0];
		hp = hp_max;
	
		result[1] = fn_stat_increase(c_mp, level, mp_max-b_mp-e_mp);
		mp_max += result[1];
		mp = mp_max;
	
		result[2] = fn_stat_increase(c_atk, level, atk-b_atk-e_atk);
		atk += result[2];
	
		result[3] = fn_stat_increase(c_def, level, def-b_def-e_def);
		def += result[3];
	
		result[4] = fn_stat_increase(c_mag_atk, level, mag_atk-b_mag_atk-e_mag_atk);
		mag_atk += result[4];
	
		result[5] = fn_stat_increase(c_mag_def, level, mag_def-b_mag_def-e_mag_def);
		mag_def += result[5];
	
		result[6] = fn_stat_increase(c_spd, level, spd-b_spd-e_spd);
		spd += result[6];
	
		result[7] = fn_stat_increase(c_luck, level, luck-b_luck-e_luck);
		luck += result[7];
	
		// Learn new moves by level
		var new_moves = [];
	
		var new_abilities = ability_level_moves[|level];
		for (var i=0; i<array_length_1d(new_abilities); i++) {
			scr_party_member_add_ability(self, new_abilities[i]);
			new_moves[array_length_1d(new_moves)] = new_abilities[i];
		}
	
		var new_magic = magic_action_level_moves[|level];
		for (var i=0; i<array_length_1d(new_magic); i++) {
			scr_party_member_add_magic(self, new_magic[i]);
			new_moves[array_length_1d(new_moves)] = new_magic[i];
		}
	
		result[8] = new_moves;
	
	}

	return result;


}
