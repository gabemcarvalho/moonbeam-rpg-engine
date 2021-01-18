/// @descr cs_battle
/// @arg enemies
/// @arg transition
/// @arg background
/// @arg music
function cs_battle(argument0, argument1, argument2, argument3) {
	if !cs_bool_1 {
		cs_bool_1 = true;
		global.enemy_list = argument0;
		global.battle_background = argument2;
		scr_transition(argument1);
		var music = argument3;
	}


}
