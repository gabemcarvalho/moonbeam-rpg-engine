/// @description Draw UI
// widescreen
if o_camera.widescreen_height > 0 && instance_exists(o_overworld) { // don't want this to draw in battle
	draw_set_colour(c_black);
	draw_rectangle(0, 0, view_wport[0], o_camera.widescreen_height, false);
	draw_rectangle(0, view_hport[0] - o_camera.widescreen_height, view_wport[0], view_hport[0], false);
	draw_set_colour(c_white);
}

// transitions
draw_surface_ext(surf_transition, 0, 0, 1, 1, 0, c_white, 1.0);
surface_set_target(surf_transition);
draw_clear_alpha(c_black, 0);
surface_reset_target();

// UI
draw_surface_ext(surf_gui, 0, 0, 1, 1, 0, c_white, 1.0);
surface_set_target(surf_gui);
draw_clear_alpha(c_white, 0);
surface_reset_target();

// debug
draw_text(320, 120, debug_text);