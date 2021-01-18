/// @description scr_transition(type)
/// @param type
function scr_transition(argument0) {
	with o_camera {
		transitioning = true;
		transition_type = argument0;
	
		switch transition_type {
			case TRANSITION_FADE:
				fade_colour = COL_DARK_GREY;
				alpha_target = 1;
				break;
			case TRANSITION_BATTLE_START_FADE:
				fade_colour = c_white;
				alpha_target = 1;
				alpha_spd = 1 / (room_speed * 0.3); // 0.3 seconds
				break;
			case TRANSITION_BATTLE_END:
				fade_colour = c_black;
				alpha_target = 1;
				alpha_spd = 1 / (room_speed * 0.4); // 0.6 seconds
				break;
		}
	}


}
