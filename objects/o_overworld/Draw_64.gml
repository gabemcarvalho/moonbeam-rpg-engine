// Day/Night Cycle
//surface_set_target(surf_colour_overlay);
shader_set(shd_overlay);
shader_set_uniform_f_array(u_col, colour_mix);
shader_set_uniform_f_array(u_con_sat_brt, con_sat_brt_mix);
	draw_surface_part_ext(application_surface, 0, 0, PORT_WIDTH, PORT_HEIGHT, 0, 0, 1, 1, c_white, 1);
shader_reset();
//surface_reset_target();

// Tilt Shift
//surface_set_target(surf_midtilt);
//shader_set(shd_tilt_horizontal);
//	draw_surface(surf_colour_overlay, 0, 0);
//shader_reset();
//surface_reset_target();

//shader_set(shd_tilt_vertical);
//	draw_surface(surf_midtilt, 0, 0);
//shader_reset();