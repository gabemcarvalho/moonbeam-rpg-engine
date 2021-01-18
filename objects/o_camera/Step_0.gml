/// @descr transitions
if widescreen_height != widescreen_target {
	widescreen_height = approach(widescreen_height, widescreen_spd, widescreen_target);
} else if widescreen_continue_cs {
	widescreen_continue_cs = false;
	scr_controller_increment_cutscene();
}

if fade_alpha != alpha_target {
	fade_alpha = approach(fade_alpha, alpha_spd, alpha_target);
	if fade_alpha == alpha_target {
		alpha_spd = alpha_spd_default;
	}
} else if fade_continue_cs {
	fade_continue_cs = false;
	scr_controller_increment_cutscene();
}

if transitioning {
	switch transition_type {
		case TRANSITION_FADE: // fade to new room
			if alpha_target == 1 && fade_alpha >= 1 {
				alpha_target = 0;
				room_goto(o_controller.next_room);
			} else if alpha_target == 0 {
				if !executed_black_frame {
					if global.canmove_after_transition global.canmove = true;
					executed_black_frame = true;
				}
				if fade_alpha <= 0 { // done
					transitioning = false;
					executed_black_frame = false;
				}
			}
			break;
		case TRANSITION_BATTLE_START_FADE: // fade into battle
			if alpha_target == 1 && fade_alpha >= 1 {
				if timer > room_speed * 0.5 { // wait on white screen for some time
					alpha_target = 0;
					alpha_spd = 1 / (room_speed * 0.8); // 0.8 seconds
					scr_start_battle();
				} else {
					timer ++
				}
			} else if alpha_target == 0 {
				if fade_alpha <= 0 { // done
					transitioning = false;
					timer = 0;
				}
			}
			break;
		case TRANSITION_BATTLE_END: // fade out of battle
			if alpha_target == 1 && fade_alpha >= 1 {
				if timer > room_speed * 0.4 { // wait on white screen for some time
					alpha_target = 0;
					alpha_spd = 1 / (room_speed * 0.5); // 0.8 seconds
					scr_end_battle();
					scr_controller_increment_cutscene(); // this is when the battle really ends
				} else {
					timer ++
				}
			} else if alpha_target == 0 {
				if fade_alpha <= 0 { // done
					transitioning = false;
					timer = 0;
				}
			}
			break;
	}
}