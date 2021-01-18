///@descr scr_get_flag
///@arg flag
function scr_get_flag(argument0) {
	return ds_map_find_value(o_controller.story_flags, argument0);


}
