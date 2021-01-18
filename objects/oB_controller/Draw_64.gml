/// @description Draw the battle UI
// Set Up Text
draw_set_font(f_battle);
draw_set_halign(fa_middle);
draw_set_valign(fa_center);
//draw_set_colour(make_colour_rgb(220,220,220));
draw_set_colour(c_white);

#region BACKGROUND
// Draw the background
surface_set_target(surf_bk_1);
draw_clear_alpha(c_black,0);
	shader_set(shd_bk_wave);
		wave_time += 1;
		shader_set_uniform_f(uni_wave_time,wave_time);
		shader_set_uniform_f(uni_wave_amount,50);//50
		shader_set_uniform_f(uni_wave_speed,0.05);
		shader_set_uniform_f(uni_wave_distortion,0.01);//0.01
		draw_sprite(s_background,back_image,0,0);
	shader_reset();
surface_reset_target();

surface_set_target(surf_bk_2);
draw_clear_alpha(c_black,0);
	shader_set(shd_bloom)
		shader_set_uniform_f(uni_bloom_blursize,0.01);
		var bloom_amt = 0.8;
		if back_image>4 bloom_amt = 0.0;
		shader_set_uniform_f(uni_bloom_intensity,bloom_amt);//0.8
		draw_surface(surf_bk_1,0,0);
	shader_reset();
surface_reset_target();
#endregion

// Draw UI
surface_set_target(surf_ui_base);
draw_clear_alpha(c_black,0);
	draw_sprite(s_UI_whole,current_ui,0,0);

	#region ACTION UI
	// Draw the status UI
	if (current_ui == UI_ACT) {
		// Let each player draw their own status UI
		for (var i=0; i<ds_list_size(party_list); i++) {
			// Get the coordinates of the current UI
			var status_ui_y = 252;
			if ds_list_size(party_list) > 1 {
				var status_ui_x = 640/2 + 48*( -1 + 2*(i/(ds_list_size(party_list)-1))) * ds_list_size(party_list);
			} else {
				var status_ui_x = 640/2;
			}
			// Draw the UI box
			draw_sprite(s_UI_player,0,status_ui_x,status_ui_y);
		
			// Draw the character's name
			draw_set_halign(fa_middle);
			draw_set_valign(fa_center);
			draw_text(status_ui_x+1,status_ui_y+49,party_list[|i].name);
			draw_line_width(status_ui_x-24,status_ui_y+58,status_ui_x+24,status_ui_y+58,2);
			
			// Shake
			var s_amt = party_list[|i].shake_amount;
			var sx = random_range(-s_amt,s_amt);
			var sy = random_range(-s_amt,s_amt);
			if party_list[|i].hp == 0 var icon_col = c_red else var icon_col = c_white;
			draw_sprite_ext(party_list[|i].small_icon,0,status_ui_x-20+sx,status_ui_y-4+sy,2,2,0,icon_col,1);
		
			// Draw subicon
			if party_list[|i].defending {
				draw_sprite_ext(s_subicon_defend,0,status_ui_x-20+sx+4,status_ui_y-4+sy+6,2,2,0,c_white,1);
			}
			
			// Draw level
			draw_set_font(f_battle_small);
			draw_set_colour(c_black);
			draw_text(status_ui_x+21, status_ui_y+33, "Lv."+string(party_list[|i].level));
			draw_set_colour(c_white);
			draw_text(status_ui_x+20, status_ui_y+32, "Lv."+string(party_list[|i].level));
		
			// Draw the HP and MP
			draw_set_halign(fa_left);
			draw_set_colour(c_black);
			var bar_width = 60;
			var bar_height = 10;
			var y_offset = 74;
			
			draw_healthbar(status_ui_x-bar_width/2, status_ui_y+y_offset-bar_height/2, status_ui_x+bar_width/2,
							status_ui_y+y_offset+bar_height/2+1, party_list[|i].hp/party_list[|i].max_hp*100,
							c_dkgray, c_red, c_lime, 0, true, false);
			draw_text(status_ui_x-bar_width/2+2,status_ui_y+y_offset+2,"HP: "+string(party_list[|i].hp)+"/"+string(party_list[|i].max_hp));
			
			draw_healthbar(status_ui_x-bar_width/2, status_ui_y+y_offset+20-bar_height/2, status_ui_x+bar_width/2,
							status_ui_y+y_offset+20+bar_height/2+1, party_list[|i].mp/party_list[|i].max_mp*100,
							c_dkgray, c_aqua, c_aqua, 0, true, false);
			draw_text(status_ui_x-bar_width/2+2,status_ui_y+y_offset+20+2,"MP: "+string(party_list[|i].mp)+"/"+string(party_list[|i].max_mp));
			
			draw_set_font(f_battle);
			draw_set_colour(c_white);
		}
	}
	#endregion

	#region SELECTION UI
	// Draw the move selection UI
	if (current_ui == UI_SELECT) {
		// Draw the side info for each character
		draw_set_halign(fa_left);
		draw_set_valign(fa_center);
		var j = 0; // used for side info
		for (var i=0; i<ds_list_size(party_list); i++) {
			// Dont draw the info for the character who's currently selecting a move
			if party_list[|i] != selecting {
				// Get panel coords
				var panel_x = 455;
				var panel_y = 254+j*34;
				// Draw the panel and info
				draw_sprite(s_UI_side_panel,0,panel_x,panel_y);
				if party_list[|i].hp == 0 var icon_col = c_red else var icon_col = c_white;
				draw_sprite_ext(party_list[|i].small_icon,0,panel_x+10,panel_y+8,1,1,0,icon_col,1);
				if party_list[|i].defending draw_sprite(s_subicon_defend,0,panel_x+10+2,panel_y+8+3);
				
				draw_set_halign(fa_left);
				draw_set_font(f_battle_small);
				draw_set_colour(c_black);
				var bar_width = 50;
				var bar_height = 6;
				panel_x+=32;
				panel_y+=10;
			
				draw_healthbar(panel_x, panel_y, panel_x+bar_width, panel_y+bar_height+1, party_list[|i].hp/party_list[|i].max_hp*100,
								c_dkgray, c_red, c_lime, 0, true, false);
				draw_text(panel_x+2,panel_y+5,"HP: "+string(party_list[|i].hp)+"/"+string(party_list[|i].max_hp));
			
				draw_healthbar(panel_x, panel_y+10, panel_x+bar_width, panel_y+10+bar_height+1, party_list[|i].mp/party_list[|i].max_mp*100,
								c_dkgray, c_aqua, c_aqua, 0, true, false);
				draw_text(panel_x+2,panel_y+5+10,"MP: "+string(party_list[|i].mp)+"/"+string(party_list[|i].max_mp));
			
				draw_set_font(f_battle);
				draw_set_colour(c_white);
				
				j++;
			}
		}
	
		// Draw info for the currently selecting party member
		draw_set_halign(fa_middle);
		draw_text(238,258,selecting.name);
		draw_sprite_ext(selecting.small_icon,0,114,264,2,2,0,c_white,1);
		
		// Draw level
		draw_set_font(f_battle_small);
		draw_set_colour(c_black);
		draw_text(149, 305, "Lv."+string(selecting.level));
		draw_set_colour(c_white);
		draw_text(148, 304, "Lv."+string(selecting.level));
		
		// Health and MP
		draw_set_halign(fa_left);
		draw_set_colour(c_black);
		var bar_width = 70;
		var bar_height = 10;
		var y_offset = 318;
		var x_offset = 134
			
		draw_healthbar(x_offset-bar_width/2, y_offset-bar_height/2, x_offset+bar_width/2,
						y_offset+bar_height/2+1, selecting.hp/selecting.max_hp*100,
						c_dkgray, c_red, c_lime, 0, true, false);
		draw_text(x_offset-bar_width/2+2,y_offset+2,"HP: "+string(selecting.hp)+"/"+string(selecting.max_hp));
			
		draw_healthbar(x_offset-bar_width/2, y_offset+20-bar_height/2, x_offset+bar_width/2,
						y_offset+20+bar_height/2+1, selecting.mp/selecting.max_mp*100,
						c_dkgray, c_aqua, c_aqua, 0, true, false);
		draw_text(x_offset-bar_width/2+2,y_offset+20+2,"MP: "+string(selecting.mp)+"/"+string(selecting.max_mp));
			
		draw_set_font(f_battle);
		draw_set_colour(c_white);
	
		// Draw the action selection area
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		switch slct_screen {
			case SLCT_TOP:
				var sx = 224;
				var sy = 270;
				var xspace = 78;
				var yspace = 22;
				// Draw the action types
				draw_text(sx		,sy				,"ATK");
				draw_text(sx		,sy+yspace		,"MAG");
				draw_text(sx		,sy+2*yspace	,"ITM");
				draw_text(sx+xspace	,sy				,"ABL");
				draw_text(sx+xspace	,sy+yspace		,"DFND");
				draw_text(sx+xspace	,sy+2*yspace	,"RUN");
			
				// Draw the side text
				draw_text(366,264,side_text);
				break;
			case SLCT_MAGIC:
				// Draw the action names
				var act_number = ds_list_size(selecting.magic_actions);
				if act_number==0 {
					draw_text(366,264,"No magic\navailable");
				} else {
					var j=0;
					var sy = 270;
					var yspace = 22;
					for (var i=slct_list_top; i<act_number && i<slct_list_top+3; i++) {
						draw_text(224,sy+j*yspace,script_execute(selecting.magic_actions[|i],ACT_NAME));
						j++;
					}
			
					// Draw the side text
					draw_text(366,264,script_execute(selecting.magic_actions[|slct_place+slct_list_top],ACT_DESCRIP));
					draw_line_width(360,319,440,319,2);
					draw_text(366,322,"Cost: "+string(script_execute(selecting.magic_actions[|slct_place+slct_list_top],ACT_COST)));
				}
				break;
			case SLCT_ITEM:
				// Draw the item names
				var act_number = ds_list_size(o_party_data.inventory);
				if act_number==0 {
					draw_text(366,264,"No items\navailable");
				} else {
					var j=0;
					var sy = 270;
					var yspace = 22;
					for (var i=slct_list_top; i<act_number && i<slct_list_top+3; i++) {
						draw_text(224,sy+j*yspace,script_execute(o_party_data.inventory[|i],ACT_NAME));
						j++;
					}
			
					// Draw the side text
					draw_text(366,264,script_execute(o_party_data.inventory[|slct_place+slct_list_top],ACT_DESCRIP));
				}
				break;
			case SLCT_ABILITY:
				// Draw the action names
				var act_number = ds_list_size(selecting.abilities);
				if act_number==0 {
					draw_text(366,264,"No move\navailable");
				} else {
					var j=0;
					var sy = 270;
					var yspace = 22;
					for (var i=slct_list_top; i<act_number && i<slct_list_top+3; i++) {
						draw_text(224,sy+j*yspace,script_execute(selecting.abilities[|i],ACT_NAME));
						j++;
					}
			
					// Draw the side text
					draw_text(366,264,script_execute(selecting.abilities[|slct_place+slct_list_top],ACT_DESCRIP));
					draw_line_width(360,319,440,319,2);
					draw_text(366,322,"Cost: "+string(script_execute(selecting.abilities[|slct_place+slct_list_top],ACT_COST)));
				}
				break;
		}
	
	}
	#endregion

	#region TOP TEXT
	// Draw in textbox at top of screen
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	//draw_set_colour(make_colour_rgb(220,220,220));
	var tb_x = 104;
	var tb_y = 23;
	draw_text(tb_x,tb_y,text);
	draw_text(tb_x,tb_y+26,text_2);
	//draw_set_colour(c_white);
	#endregion

	#region TURN ORDER BAR
	// Draw Turn Order Icons 586,136
	var bar_x = 586;
	var bar_y = 126;
	var max_actions_displayed = 5;
	if turn_place == -1 var j=0 else var j=turn_place;
	var place = 0;
	for (var i=j; i<ds_list_size(turn_order); i++) {
		if place>=max_actions_displayed break;
		draw_sprite(turn_order[|i].small_icon,0,bar_x,bar_y+(i-j)*24);
		if turn_order[|i].type==TYPE_ENEMY {
			if turn_order[|i].suffix!=-1 draw_sprite(s_icon_font,turn_order[|i].suffix,bar_x+3,bar_y+3+(i-j)*24);
			
		}
		if turn_order[|i].defending draw_sprite(s_subicon_defend,0,bar_x+2,bar_y+(i-j)*24+3);
		//draw_text(bar_x+20,bar_y+(i-j)*24,turn_order[|i].turn_spd);
		place++;
	}
	// Draw next turn as well
	var place_2 = place;
	for (var i=0; i<ds_list_size(next_turn_order); i++) {
		if (place+i)>=max_actions_displayed break;
		draw_sprite(next_turn_order[|i].small_icon,0,bar_x,bar_y+(i+place)*24);
		if next_turn_order[|i].type==TYPE_ENEMY {
			if next_turn_order[|i].suffix!=-1 draw_sprite(s_icon_font,next_turn_order[|i].suffix,bar_x+3,bar_y+3+(i+place)*24);
		}
		if next_turn_order[|i].defending draw_sprite(s_subicon_defend,0,bar_x+2,bar_y+(i+place)*24+3);
		//draw_text(bar_x+20,bar_y+(i+place)*24,next_turn_order[|i].next_turn_spd);
		place_2++;
	}
	// And the next
	for (var i=0; i<ds_list_size(next_turn_order_2); i++) {
		if (place_2+i)>=max_actions_displayed break;
		draw_sprite(next_turn_order_2[|i].small_icon,0,bar_x,bar_y+(i+place_2)*24);
		if next_turn_order_2[|i].type==TYPE_ENEMY {
			if next_turn_order_2[|i].suffix!=-1 draw_sprite(s_icon_font,next_turn_order_2[|i].suffix,bar_x+3,bar_y+3+(i+place_2)*24);
		}
		if next_turn_order_2[|i].defending draw_sprite(s_subicon_defend,0,bar_x+2,bar_y+(i+place_2)*24+3);
		//draw_text(bar_x+20,bar_y+(i+place_2)*24,next_turn_order_2[|i].next_turn_spd);
	}
	
	#endregion


	// Draw a cool square
	scr_square_draw(sq_x, sq_y);

	
	#region OTHER OBJECTS
	
	if instance_exists(o_effect) {
		with o_effect draw_self();
	}
	
	if instance_exists(oB_damage_numbers) {
		with oB_damage_numbers {
			draw_set_font(global.f_damage);
			draw_set_halign(fa_middle);
			draw_set_valign(fa_center);
			draw_set_colour(colour);
			draw_set_alpha(alpha);

			draw_text(x,y,damage);

			draw_set_color(c_white);
			draw_set_alpha(1);
		}
	}
	
	if instance_exists(oB_target_selector) {
		with oB_target_selector draw_self();
	}
	
	#endregion
	
	draw_surface(surf_ui,0,0);
surface_reset_target();


// Draw the battle screen
shader_set(shd_brightConSat);
	shader_set_uniform_f(uni_bcs_aberration,0.0);
	shader_set_uniform_f(uni_bcs_brightness,0.0);
	shader_set_uniform_f(uni_bcs_contrast,1.05);
	shader_set_uniform_f(uni_bcs_saturation,0.05);
	shader_set_uniform_f(uni_bcs_noise,0.0);
	shader_set_uniform_f(uni_bcs_gold,false);
	shader_set_uniform_f(uni_bcs_random_factor,random_range(0.9,1.1));

	// Draw background
	draw_surface(surf_bk_2,0,0);
	
	// Draw enemies
	with oB_enemy scr_enemy_combatant_draw();

	// Draw the current UI
	draw_surface(surf_ui_base,0,0);

shader_reset();

surface_set_target(surf_ui);
draw_clear_alpha(c_black,0);
surface_reset_target();