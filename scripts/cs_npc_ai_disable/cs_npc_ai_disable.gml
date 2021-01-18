/// @descr cs_npc_ai_disable
/// @arg npc
function cs_npc_ai_disable(argument0) {
	if instance_exists(argument0) {
		with argument0 {
			ai_enabled = false;
		}
	} else {
		show_error("tried to modify an NPC that doesn't exist in the room!", false);
	}
	cs_place++;


}
