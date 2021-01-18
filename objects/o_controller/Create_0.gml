/// @description Set up object variables
// Randomize the game
randomize();

// Data objects
party_data = instance_create_layer(0,0,"gui",o_party_data);
global.player_name = "Ness";

// Controls
global.ip_a = ord("Z");
global.ip_b = ord("X");
global.ip_up = vk_up;
global.ip_down = vk_down;
global.ip_right = vk_right;
global.ip_left = vk_left;

global.key_a = false;
global.key_b = false;
global.key_up = false;
global.key_down = false;
global.key_right = false;
global.key_left = false;
global.key_a_pressed = false;
global.key_b_pressed = false;
global.key_up_pressed = false;
global.key_down_pressed = false;
global.key_right_pressed = false;
global.key_left_pressed = false;

// Global variables
global.f_damage = font_add_sprite_ext(s_damage_font,"1234567890",true,0);
global.canmove = true;
global.npc_ai_enabled = true;
global.canmove_after_transition = true;

// Battles
global.enemy_list = [oB_enemy_star,oB_enemy_psycho_kid];
global.battle_background = irandom(sprite_get_number(s_background)-1);

// Overworld variables
global.cloud_speed = 0.2;
global.cloud_alpha = 0.2;
global.day_time_max = room_speed * 60 * 12;
global.day_time = global.day_time_max * 0.30;

// Room Transitions
door_transition = false;
last_room = room;
door_id = 0;
door_spawn_side = DIR_RIGHT;
door_relative_coord = 0;
next_room = rO_test_home;

// Cutscenes
cs_playing = false;
cs_place = 0;
cs_script = [];
scr_reset_cutscene_variables();

// Story flags
story_flags = ds_map_create();
add_flag(FLAGS.TEST_TREE_1);
add_flag(FLAGS.TEST_TREE_2);

// GUI
display_set_gui_maximize();
display_set_gui_size(PORT_WIDTH, PORT_HEIGHT);
surf_transition = -1;
surf_gui = -1;

debug_text = "";

// Go to the next room
room_goto_next();