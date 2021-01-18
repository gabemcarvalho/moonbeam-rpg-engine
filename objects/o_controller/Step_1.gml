/// @description Get controls
global.key_a = keyboard_check(global.ip_a);
global.key_a_pressed = keyboard_check_pressed(global.ip_a);
global.key_b = keyboard_check(global.ip_b);
global.key_b_pressed = keyboard_check_pressed(global.ip_b);
global.key_up = keyboard_check(global.ip_up);
global.key_up_pressed = keyboard_check_pressed(global.ip_up);
global.key_down = keyboard_check(global.ip_down);
global.key_down_pressed = keyboard_check_pressed(global.ip_down);
global.key_right = keyboard_check(global.ip_right);
global.key_right_pressed = keyboard_check_pressed(global.ip_right);
global.key_left = keyboard_check(global.ip_left);
global.key_left_pressed = keyboard_check_pressed(global.ip_left);

// play cutscenes
scr_controller_execute_cutscene();