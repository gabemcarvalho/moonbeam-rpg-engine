/// @descr cs_npc_ai_enable
/// @arg npc
function cs_npc_ai_enable(argument0) {
	if instance_exists(argument0) {
		with argument0 {
			ai_enabled = true;
			hspd = 0;
			vspd = 0;
		}
	} else {
		show_error("tried to modify an NPC that doesn't exist in the room!", false);
	}
	cs_place++;


}
