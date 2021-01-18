///@descr add_flag
///@arg flag
function add_flag(argument0) {
	// initializes a story flag as false
	// should only be called in controller
	ds_map_add(story_flags, argument0, false);


}
