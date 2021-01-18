/// @descrip scr_ai_walk_around
function scr_ai_walk_around() {
	if global.npc_ai_enabled && ai_enabled {
		if timer <= 0 {
			if walking {
				walking = false;
				hspd = 0;
				vspd = 0;
				timer = random_range(min_wait_time, max_wait_time);
			} else {
				var next_movement = choose(0, 1);
				var next_dir = choose(DIR_RIGHT, DIR_LEFT, DIR_UP, DIR_DOWN);
				if next_movement == 0 {
					// turn on the spot
					dir = next_dir;
					timer = random_range(min_wait_time, max_wait_time);
				} else {
					// start walking
					walking = true;
					dir = next_dir;
					timer = random_range(min_action_time, max_action_time);
				}
			}
		} else {
			if walking {
				if dir == DIR_RIGHT hspd = walk_spd else
				if dir == DIR_LEFT hspd = -walk_spd else
				if dir == DIR_UP vspd = -walk_spd else
				if dir == DIR_DOWN vspd = walk_spd;
			}
			timer--;
		}
		sprite_dir = dir;
	}


}
