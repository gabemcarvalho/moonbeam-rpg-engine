/// @description text_add(text)
/// @param text
function text_add(argument0) {
	// Adds some text to the queue
	with oB_controller {
		ds_list_insert(text_queue, 0, argument0);
		text_remaining++;
	}


}
