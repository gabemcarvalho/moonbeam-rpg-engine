/// @description next_action()
function next_action() {
	// Sets up the battle for the next action
	// Check if there is any text to display
	if text_remaining > 0 {
		// There is some text to display
		text_remaining--;
		message = text_queue[|text_remaining];
		state = ST_TEXT;
	} else  {
		if win_condition {
			// end the battle
			scr_transition(TRANSITION_BATTLE_END);
		} else {
			// Check to see who's left in battle
			var party_exists = false;
			var enemy_exists = false;
			for (var i=0; i<ds_list_size(active_combatant_list); i++) {
				if active_combatant_list[|i].type == TYPE_PARTY {
					party_exists = true;
				} else if active_combatant_list[|i].type == TYPE_ENEMY {
					enemy_exists = true;
				}
			}
			if !party_exists {
				// The party was wiped out
				text_add("The party was wiped out!");
			} else if !enemy_exists {
				// All enemies were defeated, win the battle
				win_condition = true;
				text_add("All the enemies were defeated!");
			
				// Determine the gold, xp and item drops
				var xp_gain = 0;
				var gold_gain = 0;
				var item_drops = [];
				for (var i=0; i<ds_list_size(enemy_list); i++) {
					var enemy = enemy_list[|i];
					if enemy.defeated {
						xp_gain += enemy.xp;
						gold_gain += enemy.gold;
					
						var item_roll = irandom(99);
						var drop = enemy.drops[|item_roll];
						if drop != ITEM_NONE {
							item_drops[array_length_1d(item_drops)] = drop;
						}
					}
				}
			
				// Gain gold, xp and items
				text_add("The party gained " + string(xp_gain) + " XP and " + string(gold_gain) + " gold");
				o_party_data.gold += gold_gain;
				for (var i=0; i<ds_list_size(party_list); i++) {
					scr_party_member_gain_xp_battle(o_party_data.party[|i], xp_gain);
				}
			
				for (var i=0; i<array_length_1d(item_drops); i++) {
					ds_list_add(o_party_data.inventory, item_drops[i]);
					text_add("Obtained " + script_execute(item_drops[i],ACT_NAME) + "!");
				}
			
				next_action();

			} else {
				// The battle continues
				// Check if the turn is over
				if turn_place == ds_list_size(active_combatant_list)-1 {
					// Start a new turn
					turn_place = 0;
					// Set up the next turn
					calculate_turn_order();
					// Do other stuff that happens at the end of a turn
					// Update status of combatants
					for (var i=0; i<ds_list_size(active_combatant_list); i++) {
						with active_combatant_list[|i] {
							// Stop defending
							defending = false;
						}
					}
				} else {
					turn_place++;
				}

				// Check if the next combatant is a party member or an enemy
				if turn_order[|turn_place].type == TYPE_PARTY {
					// The next combatant is a party member
					// Go to the action selection selection screen
					state = ST_SELECT;
					slct_init = true;
					selecting = turn_order[|turn_place];
				} else {
					// The next combatant is an enemy
					// Choose next move (random for now)
					turn_order[|turn_place].turn_action = turn_order[|turn_place].moveset[|irandom(ds_list_size(turn_order[|turn_place].moveset)-1)];
					// Execute the action
					state = ST_ACT;
					acting = turn_order[|turn_place];
				}
			}
		}
	}


}
