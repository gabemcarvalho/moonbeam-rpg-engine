///@description scr_make_battle_party_member(char_data);
///@param char_data
function scr_make_battle_party_member(argument0) {
	var data = argument0;
	var combatant = instance_create_layer(0,0,"gui",oB_party_member);

	combatant.data = data.id;
	combatant.name = data.name;
	combatant.level = data.level;
	combatant.max_hp = data.hp_max;
	combatant.hp = data.hp;
	combatant.max_mp = data.mp_max;
	combatant.mp = data.mp;
	combatant.atk = data.atk;
	combatant.def = data.def;
	combatant.mag_atk = data.mag_atk;
	combatant.mag_def = data.mag_def;
	combatant.spd = data.spd;
	combatant.luck = data.luck;

	combatant.attack_action = data.attack_action;
	combatant.defend_action = data.defend_action;
	ds_list_copy(combatant.abilities, data.abilities);
	ds_list_copy(combatant.magic_actions, data.magic_actions);

	combatant.small_icon = data.small_icon;

	return combatant.id;


}
