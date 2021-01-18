/// @descrp cs_npc_walk_at_speed
/// @arg npc
/// @arg direction
/// @arg blocks
/// @arg speed
/// makes an npc walk in a certain direction for a certain number of frames based on the block size
/// WARNING: this script temporarily turns off collision detection for the moving npc.
///          the npc can walk through walls using this script, but other objects will still collide with its hitbox.
function cs_npc_walk_at_speed(argument0, argument1, argument2, argument3) {
	if !instance_exists(argument0) {
		show_error("tried to modify an NPC that doesn't exist in the room!", false);
		cs_place++;
		return;
	}

	var walk_time = argument2 * GRID_SIZE / argument3;
	if cs_timer >= walk_time {
		with argument0 {
			no_collision = false;
			hspd = 0;
			vspd = 0;
			image_speed = 1;
		}
		cs_place++;
		return;
	}

	with argument0 {
		no_collision = true;
		if argument1 == DIR_RIGHT hspd = argument3 else
		if argument1 == DIR_LEFT hspd = -argument3 else
		if argument1 == DIR_UP vspd = -argument3 else
		if argument1 == DIR_DOWN vspd = argument3;
		sprite_dir = argument1;
		image_speed = argument3 / walk_spd; // maybe this should be a lookup instead of an algorithm
	}
	cs_timer++;


}
