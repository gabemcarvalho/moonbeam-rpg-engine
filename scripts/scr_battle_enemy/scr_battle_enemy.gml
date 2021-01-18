/// @descr scr_battle_enemy
/// @arg enemy_object
function scr_battle_enemy(argument0) {
	var list_index = irandom(array_length_1d(argument0.enemy_lists) - 1);
	var list = argument0.enemy_lists[@list_index];
	var bk = argument0.background;
	var transition = argument0.transition;
	var music = argument0.music;

	var battle_cutscene = [
		[cs_set_canmove, false],
		[cs_npc_ai_disable_global],
		[cs_battle, list, transition, bk, music],
		[cs_npc_ai_disable, argument0],
		[cs_object_teleport, argument0, -128, -128],
		[cs_npc_ai_enable_global],
		[cs_set_canmove, true],
	];

	scr_play_cutscene(battle_cutscene);


}
