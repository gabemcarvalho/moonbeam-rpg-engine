/// @description Control the Battle
#region CONTROLS
// Get inputs
key_a = global.key_a;
key_a_pressed = global.key_a_pressed;
key_b = global.key_b;
key_b_pressed = global.key_b_pressed;
key_up = global.key_up;
key_up_pressed = global.key_up_pressed;
key_down = global.key_down;
key_down_pressed = global.key_down_pressed;
key_right = global.key_right;
key_right_pressed = global.key_right_pressed;
key_left = global.key_left;
key_left_pressed = global.key_left_pressed;
#endregion

#region TEXT
// Control scrolling text
if message != "" && !text_done {
	var advance = false;
	while !advance && !text_done {
		if scroll_cooldown == 0 {
			// Add a new character to the text
			text_place++;
			if string_char_at(message,text_place) == " " text_place++;
			if string_char_at(message,text_place) == "#" {
				text_place++;
				line_start = text_place;
				text_line++;
			}
			var new_text = string_copy(message,line_start,text_place-line_start+1);
			if text_line == 1 text = new_text;
			if text_line == 2 text_2 = new_text;
		
			// --> play a sound
		
			if text_place >= string_length(message) {
				text_done = true;
			}
		
			scroll_cooldown = scroll_cooldown_max;
		} else {
			scroll_cooldown--;
		}
		if key_b advance = false else advance = true;
	}
}
#endregion

#region STATE MACHINE
switch state {
	case ST_TEXT:
		#region START STATE
		// Scroll text, then go to selecting the first move
		if text_done {
			if !sq_visible {
				sq_visible = true;
				sq_x = sq_x_textbox;
				sq_y = sq_y_textbox;
			} else {
				if key_a_pressed {
					sq_visible = false;
					text_clear();
					// Go to the next action
					next_action();
				}
			}
		}
		#endregion
		break;
	case ST_SELECT:
		#region SELECT STATE
		current_ui = UI_SELECT;
		if slct_init == true {
			slct_screen = SLCT_TOP;
			slct_type = selecting.selection_top_place;
			slct_list_top = 0;
			slct_place = 0;
			// Note: slct_init is set to false in the SLCT_TOP section
		}
		
		if !slct_target_screen {
			sq_visible = true;
			switch slct_screen {
			case SLCT_TOP:
				#region TOP MENU
				var sx = 210;
				var sy = 279;
				var xspace = 78;
				var yspace = 22;
			
				// Switch place based on directional input
				if (key_down_pressed || key_up_pressed || key_right_pressed || key_left_pressed || slct_init) {
					// Get current place
					switch slct_type {
						case SLCT_ATK:		var slct_x = 0; var slct_y = 0; break;
						case SLCT_MAGIC:	var slct_x = 0; var slct_y = 1; break;
						case SLCT_ITEM:		var slct_x = 0; var slct_y = 2; break;
						case SLCT_ABILITY:	var slct_x = 1; var slct_y = 0; break;
						case SLCT_DEFEND:	var slct_x = 1; var slct_y = 1; break;
						case SLCT_RUN:		var slct_x = 1; var slct_y = 2; break;
					}
			
					// Change place
					slct_x = clamp(slct_x+key_right_pressed-key_left_pressed,0,1);
					slct_y = clamp(slct_y+key_down_pressed-key_up_pressed,0,2);
			
					// Change the location of the cursor
					sq_x = sx+slct_x*xspace;
					sq_y = sy+slct_y*yspace;
			
					// Assign the new selection type
							if (slct_x==0 && slct_y==0) {
						slct_type = SLCT_ATK;
						side_text = script_execute(selecting.attack_action,ACT_DESCRIP);
					} else	if (slct_x==0 && slct_y==1) {
						slct_type = SLCT_MAGIC;
						side_text = "Use\nmagic";
					} else	if (slct_x==0 && slct_y==2) {
						slct_type = SLCT_ITEM;
						side_text = "Use an\nitem";
					} else	if (slct_x==1 && slct_y==0) {
						slct_type = SLCT_ABILITY;
						side_text = "Use an\nability";
					} else	if (slct_x==1 && slct_y==1) {
						slct_type = SLCT_DEFEND;
						side_text = script_execute(selecting.defend_action,ACT_DESCRIP);
					} else	if (slct_x==1 && slct_y==2) {
						slct_type = SLCT_RUN;
						side_text = "Run\naway";
					}
					
					selecting.selection_top_place = slct_type;
					slct_init = false;
				}
			
				// Proceed based on which action type is currently selected
				if key_a_pressed {
					switch slct_type {
						case SLCT_ATK:
							// Select the basic attack
							selecting.turn_action = selecting.attack_action;
							// Go to target selection
							slct_target_screen = true;
							slct_target_type = TYPE_ENEMY;
							break;
						case SLCT_MAGIC:
							// Got to magic list
							slct_screen = SLCT_MAGIC;
							if selecting.selection_last_list == SLCT_MAGIC {
								slct_place = selecting.selection_list_place;
								slct_list_top = selecting.selection_list_top;
							}
							selecting.selection_last_list = SLCT_MAGIC;
							break;
						case SLCT_ITEM:
							// Go to item list
							slct_screen = SLCT_ITEM;
							if selecting.selection_last_list == SLCT_ITEM {
								slct_place = selecting.selection_list_place;
								slct_list_top = selecting.selection_list_top;
							}
							selecting.selection_last_list = SLCT_ITEM;
							break;
						case SLCT_ABILITY:
							// Go to ability list
							slct_screen = SLCT_ABILITY;
							if selecting.selection_last_list == SLCT_ABILITY {
								slct_place = selecting.selection_list_place;
								slct_list_top = selecting.selection_list_top;
							}
							selecting.selection_last_list = SLCT_ABILITY;
							break;
						case SLCT_DEFEND:
							// Select defend
							selecting.turn_action = selecting.defend_action;
							state = ST_ACT;
							acting = selecting;
							sq_visible = false;
							break;
						case SLCT_RUN:
							// Not implemented
							break;
					}
				}
				#endregion
				break;
			case SLCT_MAGIC:
				#region MAGIC MENU
				if key_b_pressed {
					// Go back to the top menu
					slct_screen = SLCT_TOP;
					slct_init = true;
				} else {
					// Scroll through the list of magic attacks
					var place_change = key_down_pressed-key_up_pressed;
					if place_change != 0 {
						var act_number = ds_list_size(selecting.magic_actions);
						var lines_displayed = 3;
						slct_place += place_change;
						if slct_place == -1 {
							slct_place = 0;
							slct_list_top = max(slct_list_top-1,0);
						} else if slct_place+slct_list_top > act_number-1 {
							slct_place--;
						} else if slct_place >= lines_displayed {
							slct_place--;
							slct_list_top++;
						}
						selecting.selection_list_place = slct_place;
						selecting.selection_list_top = slct_list_top;
					}
				
					// Display the cursor at the corrct location
					sq_visible = true;
					var sy = 279;
					var yspace = 22;
					sq_x = 210;
					sq_y = sy+slct_place*yspace;
				
					// Select an action
					if key_a_pressed && selecting.magic_actions[|slct_place+slct_list_top]!=scr_act_null {
						// Selecting a valid action, check if the party member has enough MP
						if selecting.mp >= script_execute(selecting.magic_actions[|slct_place+slct_list_top],ACT_COST) {
							// Has enough MP, select the action
							selecting.turn_action = selecting.magic_actions[|slct_place+slct_list_top];
							if script_execute(selecting.turn_action,ACT_TARGET) == TARGET_SINGLE_ENEMY {
								slct_target_screen = true;
								slct_target_type = TYPE_ENEMY;
							} else if script_execute(selecting.turn_action,ACT_TARGET) == TARGET_SINGLE_PARTY {
								slct_target_screen = true;
								slct_target_type = TYPE_PARTY;
							} else {
								selecting.mp -= script_execute(selecting.turn_action,ACT_COST);
								state = ST_ACT;
								acting = selecting;
								sq_visible = false;
							}
						}
					}
				}
				#endregion
				break;
			case SLCT_ITEM:
				#region ITEM MENU
				if key_b_pressed {
					// Go back to the top menu
					slct_screen = SLCT_TOP;
					slct_init = true;
				} else {
					// Scroll through the list of items
					var place_change = key_down_pressed-key_up_pressed;
					if place_change != 0 {
						var act_number = ds_list_size(o_party_data.inventory);
						var lines_displayed = 3;
						slct_place += place_change;
						if slct_place == -1 {
							slct_place = 0;
							slct_list_top = max(slct_list_top-1,0);
						} else if slct_place+slct_list_top > act_number-1 {
							slct_place--;
						} else if slct_place >= lines_displayed {
							slct_place--;
							slct_list_top++;
						}
						selecting.selection_list_place = slct_place;
						selecting.selection_list_top = slct_list_top;
					}
				
					// Display the cursor at the corrct location
					sq_visible = true;
					var sy = 279;
					var yspace = 22;
					sq_x = 210;
					sq_y = sy+slct_place*yspace;
				
					// Select an action
					if key_a_pressed && ds_list_size(o_party_data.inventory)>0 {
						// Set the item's script as the turn action
						selecting.turn_action = o_party_data.inventory[|slct_place+slct_list_top];
						if script_execute(selecting.turn_action,ACT_TARGET) == TARGET_SINGLE_ENEMY {
							slct_target_screen = true;
							slct_target_type = TYPE_ENEMY;
						} else if script_execute(selecting.turn_action,ACT_TARGET) == TARGET_SINGLE_PARTY {
							slct_target_screen = true;
							slct_target_type = TYPE_PARTY;
						} else {
							state = ST_ACT;
							acting = selecting;
							sq_visible = false;
						}
					}
				}
				#endregion				
				break;
			case SLCT_ABILITY:
				#region ABILITY MENU
				if key_b_pressed {
					// Go back to the top menu
					slct_screen = SLCT_TOP;
					slct_init = true;
				} else {
					// Scroll through the list of magic attacks
					var place_change = key_down_pressed-key_up_pressed;
					if place_change != 0 {
						var act_number = ds_list_size(selecting.abilities);
						var lines_displayed = 3;
						slct_place += place_change;
						if slct_place == -1 {
							slct_place = 0;
							slct_list_top = max(slct_list_top-1,0);
						} else if slct_place+slct_list_top > act_number-1 {
							slct_place--;
						} else if slct_place >= lines_displayed {
							slct_place--;
							slct_list_top++;
						}
						selecting.selection_list_place = slct_place;
						selecting.selection_list_top = slct_list_top;
					}
				
					// Display the cursor at the corrct location
					sq_visible = true;
					var sy = 279;
					var yspace = 22;
					sq_x = 210;
					sq_y = sy+slct_place*yspace;
				
					// Select an action
					if key_a_pressed && selecting.abilities[|slct_place+slct_list_top]!=scr_act_null {
						// Selecting a valid action, check if the party member has enough MP
						if selecting.mp >= script_execute(selecting.abilities[|slct_place+slct_list_top],ACT_COST) {
							// Has enough MP, select the action
							selecting.turn_action = selecting.abilities[|slct_place+slct_list_top];
							if script_execute(selecting.turn_action,ACT_TARGET) == TARGET_SINGLE_ENEMY {
								slct_target_screen = true;
								slct_target_type = TYPE_ENEMY;
							} else if script_execute(selecting.turn_action,ACT_TARGET) == TARGET_SINGLE_PARTY {
								slct_target_screen = true;
								slct_target_type = TYPE_PARTY;
							} else {
								selecting.mp -= script_execute(selecting.turn_action,ACT_COST);
								state = ST_ACT;
								acting = selecting;
								sq_visible = false;
							}
						}
					}
				}
				#endregion
				break;
			}
		} else {
			#region TARGET SELECTION
			// Selecting a target
			sq_visible = false;
			if !instance_exists(oB_target_selector) instance_create_layer(0,0,"GUI",oB_target_selector);
			if key_b_pressed {
				// Go back
				slct_target_screen = false;
				slct_target = 0;
				if instance_exists(oB_target_selector) instance_destroy(oB_target_selector);
			} else {
				// Selecting a target
				if slct_target_type == TYPE_ENEMY {
					current_ui = UI_ACT;
					// Selecting an enemy
					slct_target += key_right_pressed-key_left_pressed;
					slct_target = clamp(slct_target,0,ds_list_size(active_enemy_list)-1);
					
					// Position target selector
					oB_target_selector.y = 100;
					oB_target_selector.x = active_enemy_list[|slct_target].x;
					
					// Select
					if key_a_pressed {
						if instance_exists(oB_target_selector) instance_destroy(oB_target_selector);
						state = ST_ACT;
						acting = selecting;
						acting.target = active_enemy_list[|slct_target];
						slct_target_screen = false;
						slct_target = 0;
						
						if slct_screen == SLCT_ITEM {
							// Dispose of an item if necessary
							if !script_execute(acting.turn_action, ACT_ITEM_REUSEABLE) {
								scr_item_delete(slct_place+slct_list_top);
							}
						} else if slct_screen == SLCT_ABILITY || slct_screen == SLCT_MAGIC {
							// Reduce MP if necessary
							acting.mp -= script_execute(acting.turn_action,ACT_COST);
						}
					}
				} else {
					// Selecting a party member
					current_ui = UI_ACT;
					slct_target += key_right_pressed-key_left_pressed;
					slct_target = clamp(slct_target,0,ds_list_size(party_list)-1);
					
					// Position target selector
					oB_target_selector.y = 236;
					if ds_list_size(party_list) > 1 {
						oB_target_selector.x = 640/2 + 48*( -1 + 2*(slct_target/(ds_list_size(party_list)-1))) * ds_list_size(party_list);
					} else {
						oB_target_selector.x = 640/2;
					}
					
					
					// Select
					if key_a_pressed {
						if instance_exists(oB_target_selector) instance_destroy(oB_target_selector);
						state = ST_ACT;
						acting = selecting;
						acting.target = active_party_list[|slct_target];
						slct_target_screen = false;
						slct_target = 0;
						
						if slct_screen == SLCT_ITEM {
							// Dispose of an item if necessary
							if !script_execute(acting.turn_action, ACT_ITEM_REUSEABLE) {
								scr_item_delete(slct_place+slct_list_top);
							}
						} else if slct_screen == SLCT_ABILITY || slct_screen == SLCT_MAGIC {
							// Reduce MP if necessary
							acting.mp -= script_execute(acting.turn_action,ACT_COST);
						}
					}
				}
			}
			#endregion
		}
		#endregion
		break;
	case ST_ACT:
		#region ACT STATE
		current_ui = UI_ACT;
		/*
			Note:	Each action ends when the act_done variable is flagged as true.
					Several other variables have been pre-defined for use in actions, and reset upon
					the completion of the action. Please do not define any non-local variables inside
					an action, instead use the pre-define act_ variables.
					
					Also, refer to the object performing the attack as 'acting', as the action is
					being executed within the controller object.
		*/
		if !act_done {
			// Execute the action
			script_execute(acting.turn_action,ACT_RUN);
		} else {
			// Action complete
			// Reset action state
			act_done = false;
			act_state = 0;
			act_time1 = 0;
			act_time2 = 0;
			act_var1 = 0;
			act_var2 = 0;
			
			#region REMOVE COMBATANTS WITH 0 HP
			// Need to check if any active combatants have been defeated, and show some text if so
			var combatants_defeated = ds_list_create();
			// Party members take priority
			for (var i=0; i<ds_list_size(active_combatant_list); i++) {
				if active_combatant_list[|i].type == TYPE_PARTY {
					if active_combatant_list[|i].hp <= 0 {
						// A party member has been knocked out
						party_member_knockout_status(active_combatant_list[|i]);
						ds_list_add(combatants_defeated, active_combatant_list[|i])
					}
				}
			}
			
			// Do the same for enemies
			var enemies_defeated = ds_list_create();
			for (var i=0; i<ds_list_size(active_combatant_list); i++) {
				if active_combatant_list[|i].type == TYPE_ENEMY {
					if active_combatant_list[|i].hp <= 0 {
						// An enemy has been defeated
						active_combatant_list[|i].defeated = true;
						ds_list_add(enemies_defeated, active_combatant_list[|i])
						ds_list_add(combatants_defeated, active_combatant_list[|i])
					}
				}
			}
			
			// Remove combatants from active list
			for (var i=0; i<ds_list_size(combatants_defeated); i++) {
				remove_combatant(combatants_defeated[|i]);
			}
			ds_list_destroy(combatants_defeated);
			
			// Display defeated text for enemies
			if ds_list_size(active_enemy_list)>0 {
				if ds_list_size(enemies_defeated)==1 {
					text_add(enemies_defeated[|0].name+" was defeated!");
				} else if ds_list_size(enemies_defeated)>1 {
					text_add("Multiple enemies were defeated!");
				}
			}
			ds_list_destroy(enemies_defeated);
			#endregion
			
			// Go to next action
			next_action();
		}
		#endregion
		break;
}
#endregion

// Selection Square
scr_square_step();
