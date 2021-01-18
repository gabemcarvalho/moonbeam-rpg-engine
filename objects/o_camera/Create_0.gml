/// @descr set up transitions
// normal room transitions
fade_alpha = 0;
alpha_target = 0;
alpha_spd_default = 1 / (room_speed * 0.2);
alpha_spd = alpha_spd_default;
timer = 0;
fade_colour = COL_DARK_GREY;

transitioning = false;
transition_type = TRANSITION_FADE;
executed_black_frame = false;

// widescreen
widescreen_height = 0;
widescreen_target = 0;
widescreen_spd = WIDESCREEN_SPEED;

// these tell the cutscene to continue after the transition is done
fade_continue_cs = false;
widescreen_continue_cs = false;