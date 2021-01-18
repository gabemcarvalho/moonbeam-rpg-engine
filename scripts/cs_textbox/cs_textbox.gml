/// @descr cs_textbox
/// @arg script_array
/// script array format: [text] or [icon, name, text]
function cs_textbox(argument0) {
	//[
	//	[text],
	//	[icon, name, text],
	//	[icon, name, text],
	//	[text],
	//]
	if !cs_bool_1 {
		cs_bool_1 = true;
		var tbox = instance_create_layer(0, 0, "gui", o_textbox);
		tbox.increment_cutscene_on_close = true;
		if array_length_1d(argument0) == 0  show_error("tried to open a textbox without a message!", false);
		// Add script to textbox
		for (var i = 0; i < array_length_1d(argument0); i++) {
			var text_tuple = argument0[i];
			var text_data = [];
			switch array_length_1d(text_tuple) {
				case 1:
					text_data[0] = text_tuple[0];
					text_data[1] = undefined;
					text_data[2] = undefined;
					break;
				case 3:
					text_data[0] = text_tuple[2];
					text_data[1] = text_tuple[0];
					text_data[2] = text_tuple[1];
					break;
				default:
					show_error("wrong number of arguments passed into textbox", true);
					break;
			}
			ds_list_add(tbox.script, text_data);
		}
	}


}
