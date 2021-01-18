/// @description Init surfaces
application_surface_draw_enable(false);
layer_set_visible(layer_get_id("walls"), false);
surf_transition	= surface_create(view_wport[0], view_hport[0]);
surf_gui		= surface_create(view_wport[0], view_hport[0]);