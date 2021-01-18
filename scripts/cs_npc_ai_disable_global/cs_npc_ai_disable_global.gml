/// @descr cs_npc_ai_disable_global
function cs_npc_ai_disable_global() {
	global.npc_ai_enabled = false;
	with o_npc_parent {
		hspd = 0;
		vspd = 0;
	}
	with o_overworld_enemy {
		hspd = 0;
		vspd = 0;
	}
	cs_place++;


}
