///@description scr_party_member_gain_xp(member, amount);
///@param member
///@param amount
function scr_party_member_gain_xp(argument0, argument1) {
	var member = argument0;

	// Add xp to total
	member.total_xp += argument1;

	// Check if total xp exceeds requirement to gain a level
	var next_xp_requirement = floor(fn_xp_curve(member.level+1));
	while next_xp_requirement <= member.total_xp {
		// Level up
		member.level++;
		scr_party_member_level_up(member, member.level);

		next_xp_requirement = floor(fn_xp_curve(member.level+1));
	}



}
