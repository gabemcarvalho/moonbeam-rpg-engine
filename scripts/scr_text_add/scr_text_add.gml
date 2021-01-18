///@description scr_text_add(icon, text);
///@param icon
///@param text
function scr_text_add() {
	/*

	Note: this function can either be: scr_text_add(text) or scr_text_add(icon, name, text)

	*/
	var text_data = [];
		
	switch argument_count {
		case 1:
			text_data[0] = argument[0];
			text_data[1] = undefined;
			text_data[2] = undefined;
			break;
		case 3:
			text_data[0] = argument[2];
			text_data[1] = argument[0];
			text_data[2] = argument[1];
			break;
		default:
			show_error("wrong number of arguments passed into textbox", true);
			break;
	}
		
	ds_list_add(script, text_data);



}
