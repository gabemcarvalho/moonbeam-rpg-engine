/// @descr cs_npc_turn
/// @arg npc
/// @arg direction
function cs_npc_turn(argument0, argument1) {
	if instance_exists(argument0) {
		with argument0 {
			sprite_dir = argument1;
		}
	} else {
		show_error("tried to turn an NPC that doesn't exist in the room!", false);
	}
	cs_place++;


}
