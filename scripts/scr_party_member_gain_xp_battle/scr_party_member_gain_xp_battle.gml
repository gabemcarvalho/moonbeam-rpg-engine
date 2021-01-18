///@description scr_party_member_gain_xp_battle(member, amount);
///@param member
///@param amount
function scr_party_member_gain_xp_battle(argument0, argument1) {
	var member = argument0;

	// Add xp to total
	member.total_xp += argument1;

	// Check if total xp exceeds requirement to gain a level
	var next_xp_requirement = floor(fn_xp_curve(member.level+1));
	while next_xp_requirement <= member.total_xp {
		// Level up
		member.level++;
		var level_results = scr_party_member_level_up(member, member.level);

		if instance_exists(oB_controller) {
			with oB_controller {
				text_add(member.name + " grew to level " + string(member.level) + "!");
				text_add(member.name + " gained " + 
					string(level_results[0]) + " HP, " +
					string(level_results[1]) + " MP, " +
					string(level_results[2]) + " ATK, " +
					string(level_results[3]) + " DEF,#" +
					string(level_results[4]) + " MAG ATK, " +
					string(level_results[5]) + " MAG DEF, " +
					string(level_results[6]) + " SPD, and " +
					string(level_results[7]) + " LUCK");
			}
			var new_moves = level_results[8];
			for (var i=0; i<array_length_1d(new_moves); i++) {
				text_add(member.name + " learned " + string(script_execute(new_moves[i], ACT_NAME)) + "!");
			}
		}

		next_xp_requirement = floor(fn_xp_curve(member.level+1));
	}


}
