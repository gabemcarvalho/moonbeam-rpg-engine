/// @descr draw transitions
if fade_alpha > 0 || transitioning {
	surface_set_target(o_controller.surf_transition);
	
	if fade_alpha > 0 {
		draw_set_colour(fade_colour);
		draw_set_alpha(fade_alpha);
		draw_rectangle(0, 0, view_wport[0], view_hport[0], false);
		draw_set_colour(c_white);
		draw_set_alpha(1);
	}

	surface_reset_target();
}