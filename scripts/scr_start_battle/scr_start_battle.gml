/// @descr scr_start_battle
function scr_start_battle() {
	with o_controller {
		instance_deactivate_layer("walls");
		instance_deactivate_layer("objects");
		instance_deactivate_object(o_overworld);
		instance_create_layer(0, 0, "gui", oB_controller);
	}


}
