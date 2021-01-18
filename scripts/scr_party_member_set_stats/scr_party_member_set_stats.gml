///@descrip scr_party_member_set_stats(member, hp, mp, atk, def, mag_atk, mag_def, spd, luck);
///@param member
///@param hp
///@param mp
///@param atk
///@param def
///@param mag_atk
///@param mag_def
///@param spd
///@param luck
function scr_party_member_set_stats(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8) {

	var member = argument0;
	member.hp_max = argument1;
	member.hp = argument1;
	member.mp_max = argument2;
	member.mp = argument2;
	member.atk = argument3;
	member.def = argument4;
	member.mag_atk = argument5;
	member.mag_def = argument6;
	member.spd = argument7;
	member.luck = argument8;


}
