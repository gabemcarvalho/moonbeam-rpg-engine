/// @descr scr_end_battle
function scr_end_battle() {
	with o_controller {
		instance_activate_layer("walls");
		instance_activate_layer("objects");
		instance_activate_object(o_overworld);
		instance_destroy(oB_controller);
	}


}
