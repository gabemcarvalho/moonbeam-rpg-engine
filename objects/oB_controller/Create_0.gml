/// @description Initialize the Battle
#region INITIAL STATE
// UI Sprite
current_ui = UI_ACT;

// Select a random background
back_image = global.battle_background;

// State
state = ST_TEXT;
new_state = ST_TEXT;
win_condition = false;
#endregion

#region INITIALIZE PARTY
// List of combatants (add party members and enemies as they are initialized)
combatant_list = ds_list_create();
combatant_number = 0;
active_combatant_list = ds_list_create();
active_combatant_number = 0;

// List of Party Members
party_list = ds_list_create();
for (var i=0; i<ds_list_size(o_party_data.party); i++) {
	var party_member = scr_make_battle_party_member(o_party_data.party[|i]);
	ds_list_add(party_list, party_member);
}
active_party_list = ds_list_create(); // list of active party members
ds_list_clear(active_party_list);
// Create Party Member Objects
for (var i=0; i<ds_list_size(party_list); i++) {
	// Initialize party member
	ds_list_add(combatant_list, party_list[|i]);
	
	if combatant_list[|combatant_number].hp > 0 {
		ds_list_add(active_combatant_list, combatant_list[|combatant_number]);
		ds_list_add(active_party_list, combatant_list[|combatant_number]);
		active_combatant_number++;
	}
	combatant_number++;
	
	// Set party positions
	party_list[|i].y = 252+24;
	if ds_list_size(party_list) > 1 {
		party_list[|i].x = 640/2 + 48*( -1 + 2*(i/(ds_list_size(party_list)-1))) * ds_list_size(party_list);
	} else {
		party_list[|i].x = 640/2;
	}
}
selecting = active_combatant_list[| 0]; // First character to select a move
#endregion

#region INITIALIZE ENEMIES
// Random List of Enemies
// var enemy_number = round(random(3))+1;
enemy_list = ds_list_create();
for (var i=0; i<array_length_1d(global.enemy_list); i++) {
	// ds_list_add(enemy_list, instance_create_layer(0,0,"gui",choose(oB_enemy_star,oB_enemy_psycho_kid)));
	ds_list_add(enemy_list, instance_create_layer(0,0,"gui", global.enemy_list[i]));
}
active_enemy_list = ds_list_create();
ds_list_clear(active_enemy_list);
// Create Enemy Objects
for (var i=0; i<ds_list_size(enemy_list); i++) {
	#region ENEMY NAME
	// Name the enemy
	with enemy_list[|i] {
		if name_scheme==NAME_SEQUENCE {
			var name_choice = 0;
			var number_before_self = 0;
			var type_number = 0;
			for (var j=0; j<ds_list_size(other.enemy_list); j++) {
				if other.enemy_list[|j].object_index == object_index {
					if j<i number_before_self++;
					type_number++;
				}
			}
			if (type_number>1) {
				suffix = number_before_self;
				name += " " + name_choices[|number_before_self];
			}
		} else {
			var name_choice = "";
			var new_name = false;
			while new_name == false {
				if ds_list_size(name_choices)==0 break;
				// Pick a random name from the list
				name_choice = name_choices[|irandom(ds_list_size(name_choices)-1)]; // name choice is a string here
				for (var j=0; j<i; j++) {
					if other.enemy_list[|j].name != name+" "+name_choice {
						new_name = true;
					} else {
						ds_list_delete(name_choices,ds_list_find_index(name_choices,name_choice));
					}
				}
				if i==0 new_name = true;
			}
			if (name_choice!="") {
				suffix = ds_list_find_index(name_choices,name_choice);
				name += " " + name_choice;
			} 
		}
	}
	#endregion
	// Initialize enemy
	ds_list_add(combatant_list, enemy_list[|i]);
	ds_list_add(active_enemy_list,enemy_list[|i]);
	ds_list_add(active_combatant_list, enemy_list[|i]);
	active_combatant_number++;
	combatant_number++;
	// Set enemy location
	enemy_list[|i].y = 236;
	if ds_list_size(enemy_list) > 1 {
		enemy_list[|i].x = 640/2 + 40*( -1 + 2*(i/(ds_list_size(enemy_list)-1))) * ds_list_size(enemy_list);
	} else {
		enemy_list[|i].x = 640/2;
	}
}
#endregion

#region TURN ORDER
// Determine turn order using the active combatant list
// Calculate first turn speeds
turn_order = ds_list_create();
turn_length = 0;
next_turn_order = ds_list_create();
next_turn_order_2 = ds_list_create();
next_turn_length = 0;
calculate_turn_order();
turn_place = -1; // Needs to be -1 because it increments by 1 when next_action() is called
#endregion

#region TEXT
// Text variables
message = "NULL";
text_place = 0;
text = "";
text_2 = "";
text_line = 1;
line_start = 1;
scroll_cooldown_max = 1;
scroll_cooldown = scroll_cooldown_max;
text_done = false;
text_queue = ds_list_create();
ds_list_add(text_queue, "NULL");
text_remaining = 0;

// Get the initial encounter text
// In the final game this text will probably be hardcoded along with the possible encounter scenarios
var encounter_message = "";
if ds_list_size(enemy_list)==1 {
	encounter_message = "~ "+enemy_list[|0].name+" appeared!";
} else {
	var enemy_group = true;
	for (var i=1; i<ds_list_size(enemy_list); i++) {
		if enemy_list[|i].object_index != enemy_list[|0].object_index enemy_group = false;
	}
	if enemy_group {
		encounter_message = "~ A group of "+enemy_list[|0].base_name+" appeared!";
	} else {
		encounter_message = "~ Some enemies appeared!";
	}
}
text_add(encounter_message);
#endregion

#region OTHER VARIABLES
// Variables for action selection screen
slct_screen = SLCT_TOP;
slct_type = SLCT_ATK;
slct_list_top = 0;
slct_place = 0;
slct_init = false;
slct_target_screen = false;
slct_target_type = TYPE_ENEMY;
slct_target = 0;

// Variables for the action state
acting = combatant_list[|0];
act_done = false;
act_state = 0;
act_time1 = 0;
act_time2 = 0;
act_var1 = 0;
act_var2 = 0;

// Square
scr_square_create();
sq_x = 205;
sq_y = 274;
sq_x_textbox = 528;
sq_y_textbox = 64;

// Other misc variables
side_text = "";
temp_active_combatant_list = ds_list_create();
#endregion

next_action();

// Initialize surfaces and shaders
surf_bk_1 = surface_create(PORT_WIDTH, PORT_HEIGHT);
surf_bk_2 = surface_create(PORT_WIDTH, PORT_HEIGHT);
surf_ui_base = surface_create(PORT_WIDTH, PORT_HEIGHT);
surf_ui = surface_create(PORT_WIDTH, PORT_HEIGHT);

uni_wave_time = shader_get_uniform(shd_bk_wave,"time");
uni_wave_amount = shader_get_uniform(shd_bk_wave,"wave_amount");
uni_wave_distortion = shader_get_uniform(shd_bk_wave,"wave_distortion");
uni_wave_speed = shader_get_uniform(shd_bk_wave,"wave_speed");
wave_time = 0;

uni_bloom_blursize = shader_get_uniform(shd_bloom,"blurSize");
uni_bloom_intensity = shader_get_uniform(shd_bloom,"intensity");

uni_bcs_saturation = shader_get_uniform(shd_brightConSat,"Saturation");
uni_bcs_brightness = shader_get_uniform(shd_brightConSat,"Brightness");
uni_bcs_contrast = shader_get_uniform(shd_brightConSat,"Contrast");
uni_bcs_noise = shader_get_uniform(shd_brightConSat,"Noise");
uni_bcs_random_factor = shader_get_uniform(shd_brightConSat,"RandomFactor");
uni_bcs_aberration = shader_get_uniform(shd_brightConSat,"Aberration");
uni_bcs_gold = shader_get_uniform(shd_brightConSat,"Gold");
