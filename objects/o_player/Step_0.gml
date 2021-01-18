var key_right = max(keyboard_check(vk_right), keyboard_check(ord("D")), 0);
var key_left = max(keyboard_check(vk_left), keyboard_check(ord("A")), 0);
var key_down = max(keyboard_check(vk_down), keyboard_check(ord("S")), 0);
var key_up = max(keyboard_check(vk_up), keyboard_check(ord("W")), 0);

if global.canmove {
	// Trigger cutscenes (goes before movement so it can trigger at the start of a room)
	var trigger = instance_place(x, y, o_trigger);
	if trigger != noone {
		var trigger_cs = scr_get_trigger_cutscene(trigger);
		scr_play_cutscene(trigger_cs);
		if trigger.destroy_on_trigger {
			instance_destroy(trigger);
		}
	}

	// Get Direction
	var xaxis = key_right - key_left;
	var yaxis = key_down - key_up;
	var dir = point_direction(0, 0, xaxis, yaxis);

	// Get Speed
	var spd = 0;
	if (xaxis != 0) || (yaxis != 0) {
		spd = move_spd;
		sprite_dir = round(dir/45); // turns into DIR_ macro
		if (sprite_dir == 8) sprite_dir = 0;
	}

	// Get the speed variables
	hspd = spd * cos(dir * pi / 180);
	vspd = -spd * sin(dir * pi / 180);
} else {
	hspd = 0;
	vspd = 0;
}

// collisions
scr_move_and_collide();
scr_npc_update_sprite();

if global.canmove {
	// Interact with an object
	if keyboard_check_pressed(ord("Z")) {
		var d_look = 4; // max distance for interacting with object
		if sprite_dir == DIR_RIGHT var xlook = d_look else if sprite_dir == DIR_LEFT var xlook = -d_look else var xlook = 0;
		if sprite_dir == DIR_DOWN var ylook = d_look else if sprite_dir == DIR_UP var ylook = -d_look else var ylook = 0;
		var object = instance_place(x + xlook, y + ylook, o_game_object);
		if object != noone {
			var obj_cs = scr_get_object_cutscene(object);
			if array_length_1d(obj_cs) > 0 {
				// has a cutscene
				// if npc, make them turn to face you
				if object_is_ancestor(object.object_index, o_npc_parent) {
					object.hspd = 0;
					object.vspd = 0;
					if sprite_dir == DIR_RIGHT	object.sprite_dir = DIR_LEFT	else
					if sprite_dir == DIR_LEFT	object.sprite_dir = DIR_RIGHT	else
					if sprite_dir == DIR_UP		object.sprite_dir = DIR_DOWN	else
					if sprite_dir == DIR_DOWN	object.sprite_dir = DIR_UP;
				}
				scr_play_cutscene(obj_cs);
			}
		}
	}
	
	// Collide with enemies
	if !o_controller.cs_playing {
		// check 4 corners
		var coords = [[-1, -1], [-1, 1], [1, -1], [1, 1]];
		for (var i = 0; i < 4; i++) {
			var pair = coords[i];
			var enemy = instance_place(x + pair[0], y + pair[1], o_overworld_enemy);
			if enemy != noone {
				scr_battle_enemy(enemy);
				break;
			}
		}
	}
}