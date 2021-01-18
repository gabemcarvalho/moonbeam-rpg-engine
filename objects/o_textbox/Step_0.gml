/// @description Control the textbox
// Controls
key_a_pressed = global.key_a_pressed;
key_b_pressed = global.key_b_pressed;

// Text
draw_set_font(font); // need to set the font so text widths can be calculated properly
if text_next {
	// Setup the text to be displayed
	if ds_list_size(script) == 0 {
		// There are no more messages to be displayed, close the textbox
		if increment_cutscene_on_close {
			scr_controller_increment_cutscene();
		}
		instance_destroy();
		
	} else {
		#region PROCESS NEXT MESSAGE
		// Process the next message for display
		var next_script_data = script[|0];
		var next_text_raw = next_script_data[0];
		var text_x = 0;
		text_y = 0;
		
		// Get icon
		icon = next_script_data[1];
		if icon == undefined {
			// Text takes up whole box
			text_width = width - 2 * text_buffer;
			icon_buffer = 0;
		} else {
			// Resize text area to fit with icon
			text_width = width - 4 * text_buffer - icon_size;
			icon_buffer = icon_size + 2 * text_buffer;
		}
		
		// Get name
		name = next_script_data[2];
		if name != undefined {
			if string_char_at(name, 1) == command_char {
				switch string_char_at(name, 2) {
					case "b":
						name_colour = TEXT_COLOUR_BLUE;
						break;
					case "o":
						name_colour = TEXT_COLOUR_ORANGE;
						break;
					case "l":
						name_colour = TEXT_COLOUR_LIME;
						break;
					case "p":
						name_colour = TEXT_COLOUR_PURPLE;
						break;
					case "r":
						name_colour = TEXT_COLOUR_RED;
						break;
					default: // "d"
						name_colour = TEXT_COLOUR_DEFAULT;
						break;
				}
				name = string_copy(name, 3, string_length(name));
			} else {
				name_colour = TEXT_COLOUR_DEFAULT;
			}
		}
		
		// Create a list off all the colours and effects in the message
		// Also create a list of all the spaces in the message
		var next_text = "";
		var colours = ds_list_create();
		var effects = ds_list_create();
		var current_colour = TEXT_COLOUR_DEFAULT;
		var current_effect = TEXT_EFFECT_NONE;
		var text_length = 0;
		var spaces = ds_list_create();
		var next_space = 0;
		var line_breaks = ds_list_create();
		var next_line_break = 0;
		var pauses = ds_list_create();
		var next_pause = 0;
		// First pass through message
		for (var i=1; i<string_length(next_text_raw)+1; i++) {
			if string_char_at(next_text_raw, i)==command_char {
				i++;
				// List of in-line text commands
				switch string_char_at(next_text_raw, i) {
					case "n": // New line
						ds_list_add(line_breaks, text_length+1);
						break;
					case ".": // Pause scrolling
						ds_list_add(pauses, text_length+1);
						break;
					case "d": // Default colour
						current_colour = TEXT_COLOUR_DEFAULT;
						break;
					case "b":
						current_colour = TEXT_COLOUR_BLUE;
						break;
					case "o":
						current_colour = TEXT_COLOUR_ORANGE;
						break;
					case "l":
						current_colour = TEXT_COLOUR_LIME;
						break;
					case "p":
						current_colour = TEXT_COLOUR_PURPLE;
						break;
					case "r":
						current_colour = TEXT_COLOUR_RED;
						break;
					case "e": // No effect
						current_effect = TEXT_EFFECT_NONE;
						break;
					case "s": // Shaking effect
						current_effect = TEXT_EFFECT_SHAKE;
						break;
				}
			} else {
				// Add to the normal text string
				text_length++;
				if string_char_at(next_text_raw, i)==" " {
					// Character is a space, add it to the list of spaces
					ds_list_add(spaces, text_length);
					current_colour = TEXT_COLOUR_DEFAULT;
					current_effect = TEXT_EFFECT_NONE;
				}
				next_text += string_char_at(next_text_raw, i);
				colours[|text_length] = current_colour;
				effects[|text_length] = current_effect;
			}
		}
		// Note: next_text does not contain any of the in-line text commands,
		//		 so it's width will be accurate
		
		// Compute a list of characters with set x positions based on the list of spaces
		var line_width = 0;
		var new_line = true;
		// Second pass through message
		for (var i=1; i<string_length(next_text)+1; i++) {
			// Check for in-line commands
			if i==pauses[|next_pause] {
				ds_list_add(text, scr_text_char_create(command_char + ".", 0, 0, 0, 0));
			}
			while i==line_breaks[|next_line_break] {
				new_line = true;
				text_x = 0;
				ds_list_add(text, scr_text_char_create(command_char + "n", 0, 0, 0, 0));
				next_line_break++;
			}
			
			// Check for spaces
			if i==spaces[|next_space] || new_line {
				// There is at least one more word, add it to the line string
				// Find the end of the current word
				var next_word_end = 0;
				if next_space >= ds_list_size(spaces)-1 {
					next_word_end = string_length(next_text);
				} else {
					next_word_end = spaces[|next_space+1];
				}
				
				// Add the width of the word to the total width of the line
				var word_width = 0;
				for (var j=i; j<next_word_end; j++) {
					if string_char_at(next_text,j)==" " {
						word_width += space_width;
					} else {
						word_width += string_width(string_char_at(next_text,j)) + char_separation;
					}
				}
				line_width = text_x + word_width;
			}
			
			// Check if the updated line string is wider than the textbox
			if (line_width>text_width && !new_line) {
				// Line break
				new_line = true;
				text_x = 0;
				ds_list_add(text, scr_text_char_create(command_char + "n", 0, 0, 0, 0));
				if i==spaces[|next_space] next_space++;
				continue;
			}
			
			new_line = false;

			// Skip spaces
			if i==spaces[|next_space] {
				text_x += space_width;
				next_space++;
				continue;
			}
				
			// Add character
			ds_list_add(text, scr_text_char_create(string_char_at(next_text,i), text_x, 0, colours[|i], effects[|i]));
			text_x += string_width(string_char_at(next_text,i)) + char_separation;
		}
		
		ds_list_destroy(colours);
		ds_list_destroy(effects);
		ds_list_destroy(line_breaks);
		ds_list_destroy(pauses);
		ds_list_destroy(spaces);
		ds_list_delete(script, 0);
		
		text_next = false;
		#endregion
	}
} else {
	if !text_done && !text_paused {
		if key_b_pressed {
			#region SCROLL TO END
			// If a button is pressed, scroll to the end
			var unnecessary_lines = 0;
			while text_place<ds_list_size(text) {
				var next_char = text[|text_place];
				if next_char[0] == command_char + "n" {
					// New line
					if text_y+line_height > text_height-text_buffer {
						unnecessary_lines++;
					} else {
						scrolling_line++;
					}
					text_y += line_height;
				} else if next_char[0] == command_char + "." {
					// Stop and wait for a button press to continue
					text_paused = true;
					scr_square_set_visible(true);
					text_place++;
					break;
				} else {
					// Add the next character
					next_char[2] = text_y;
					ds_list_add(display_text, next_char);
					scroll_cooldown = scroll_cooldown_max;
					line_widths[|scrolling_line] = next_char[1] + string_width(next_char[0]);
				}
				text_place++;
			}
			
			// Delete lines which have been scrolled past
			if unnecessary_lines > 0 {
				for (var i=0; i<ds_list_size(text); i++) {
					var char = display_text[|0];
					var char_line = char[2] div line_height;
					if char_line < unnecessary_lines {
						ds_list_delete(display_text, 0);
					} else {
						break;
					}
				}
			}
			
			// Snap remaining lines to correct height (iterates on remaining lines)
			var first_char = display_text[|0];
			if (first_char[2] mod line_height != 0) || (unnecessary_lines > 0) {
				for (var i=0; i<ds_list_size(display_text); i++) {
					var char = display_text[|i];
					char[@2] = ((char[2] div line_height) - unnecessary_lines) * line_height;
				}
			}
			
			// Finish scrolling
			if text_place >= ds_list_size(text) {
				text_done = true;
				text_place = 0;
				scroll_cooldown = 0;
				scr_square_set_visible(true);
			}
			
			#endregion
		} else {
			#region SCROLL TEXT
			// Scroll the text
			if scroll_cooldown != 0 {
				scroll_cooldown--;
			} else {
				if !scrolling_up {
					// Add a character
					var next_char = text[|text_place];
					if next_char[0] == command_char + "n" {
						// New line
						if text_y+line_height > text_height-text_buffer {
							// Already at bottom line, scroll down
							ds_list_delete(line_widths, 0);
							// Remove all the display characters on the first line
							var done_deleting = false;
							while !done_deleting {
								var top_char = display_text[|0];
								if top_char[2] <= 0 {
									ds_list_delete(display_text,0);
								} else {
									done_deleting = true;
								}
							}
							// Start scrolling current characters up
							scrolling_up = true;
						} else {
							// Move down a line
							text_y += line_height;
							scrolling_line++;
						}
					} else if next_char[0] == command_char + "." {
						// Stop and wait for a button press to continue
						text_paused = true;
						scr_square_set_visible(true);
					} else {
						// Add the next character
						next_char[2] = text_y;
						ds_list_add(display_text, next_char);
						scroll_cooldown = scroll_cooldown_max;
						line_widths[|scrolling_line] = next_char[1] + string_width(next_char[0]);
					}
				
					// Advance the text place
					text_place++;
					if text_place >= ds_list_size(text) {
						text_done = true;
						text_place = 0;
						scroll_cooldown = 0;
						scr_square_set_visible(true);
					}
				}
			}
		
			if scrolling_up {
				// Move all current characters up until the first one is at the highest possible text position
				var scroll_speed = min(scroll_up_speed, line_height - scroll_distance);
			
				for (var i=0; i<ds_list_size(display_text); i++) {
					var char = display_text[|i];
					char[@2] = char[2] - scroll_speed;
				}
			
				scroll_distance += scroll_speed;
				if scroll_distance >= line_height {
					scrolling_up = false;
					scroll_distance = 0;
				}
			}
			#endregion
		}
	} else if text_paused {
		#region UNPAUSE TEXT
		// Press a key to unpause the text
		if key_a_pressed {
			text_paused = false;
			scr_square_set_visible(false);
		}
		#endregion
	} else {
		#region ADVANCE TEXT
		// Message is done scrolling, press a key to advance to the next message
		if key_a_pressed {
			ds_list_clear(display_text);
			ds_list_clear(text);
			ds_list_clear(line_widths);
			scrolling_line = 0;
			text_done = false;
			text_next = true;
			scr_square_set_visible(false);
		}
		#endregion
	}
}

// Control advance indicator
scr_square_step();