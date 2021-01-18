/// @description Draw the texbox
surface_set_target(o_controller.surf_gui);

draw_set_font(f_textbox);
// Draw the box
draw_set_alpha(0.9);
draw_set_colour(c_black); // c_black
draw_rectangle(x, y, x+width, y+height, false);
draw_set_alpha(1.0);
draw_set_colour(c_white);

// Draw icon
if icon != undefined {
	var icon_scale = icon_size / sprite_get_height(icon);
	draw_set_colour(c_black);
	draw_rectangle(x, y+height-icon_size-2*text_buffer, x+icon_size+2*text_buffer, y+text_height+line_height+4, false);
	draw_set_colour(c_white);
	draw_sprite_ext(icon, 0, x+text_buffer, y+height-icon_size-text_buffer, icon_scale, icon_scale, 0, c_white, 1);
	
	if name != undefined {
		draw_set_colour(c_dkgray);
		draw_rectangle(x+icon_size+2*text_buffer+1, y-line_height-4, x+icon_size+4*text_buffer+text_width, y-1, false);
		draw_set_colour(name_colour);
		draw_text(x+icon_size+2*text_buffer+text_buffer, y-line_height-2, name);
	}
}

// Draw the text
draw_set_font(f_textbox);
draw_set_colour(TEXT_COLOUR_DEFAULT);
var last_y = 0;
var current_line = 0;
for (var i=0; i<ds_list_size(display_text); i++) {
	var char = display_text[|i];
	
	// Colour
	var coloured = false;
	if char[3] != TEXT_COLOUR_DEFAULT {
		coloured = true;
		draw_set_color(char[3]);
	}
	
	// Shake
	var shake_x = 0;
	var shake_y = 0;
	if char[4]==TEXT_EFFECT_SHAKE {
		if irandom(6)==0 shake_x = -1 + irandom(2);
		if irandom(6)==0 shake_y = -1 + irandom(2);
	}
	
	// Alignment
	var align_offset = 0;
	if text_centred {
		current_line = char[2] div line_height;
		align_offset = text_width/2 - line_widths[|current_line]/2;	
		last_y = char[2];
	}
	
	draw_text(char[1] + shake_x + x + text_buffer + align_offset + icon_buffer, char[2] + shake_y + y + text_buffer, char[0]);
	
	// Reset colour
	if coloured draw_set_colour(TEXT_COLOUR_DEFAULT);
}




// Draw the advance indicator (rotating square)
scr_square_draw(x + width - 14, y + height - 14);

surface_reset_target();