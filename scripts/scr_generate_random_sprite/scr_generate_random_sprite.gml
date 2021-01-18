///@description scr_generate_sprite_hsv(sprite, hue, sat, bright);
///@param sprite
///@param hue
///@param sat
///@param bright
function scr_generate_random_sprite(argument0, argument1, argument2, argument3) {
	/*
		Takes an existing sprite, and returns the ID of a new sprite with
		the specified HSV value changes applied. Make sure to delete the
		sprite when it is no longer needed, otherwise it will stay in
		memory and cause a leak.
	*/

	var original_sprite = argument0;

	var subimages = sprite_get_number(original_sprite);
	var spr_width = sprite_get_width(original_sprite);
	var spr_height = sprite_get_height(original_sprite);
	var spr_xoffset = sprite_get_xoffset(original_sprite);
	var spr_yoffset = sprite_get_yoffset(original_sprite);
	var surf_sprite = surface_create(spr_width,spr_height);

	surface_set_target(surf_sprite);
	draw_clear_alpha(GENERATOR_BACK_COLOUR,1.0);
	shader_set(shd_hsv);	

		shader_set_uniform_f(shader_get_uniform(shd_hsv,"h_shift"), argument1);
		shader_set_uniform_f(shader_get_uniform(shd_hsv,"s_multiplier"), argument2);
		shader_set_uniform_f(shader_get_uniform(shd_hsv,"v_multiplier"), argument3);
	
		draw_sprite(original_sprite,0,spr_xoffset,spr_yoffset);
		var new_sprite = sprite_create_from_surface(surf_sprite,0,0,spr_width,spr_height,true,false,spr_xoffset,spr_yoffset);
	
		if subimages > 1 {
			for (var i=1; i<subimages; i++) {
				draw_clear_alpha(GENERATOR_BACK_COLOUR,1.0);
				draw_sprite(original_sprite,i,spr_xoffset,spr_yoffset);
				sprite_add_from_surface(new_sprite,surf_sprite,0,0,spr_width,spr_height,true,false);
			}
		}
	
		sprite_set_speed(new_sprite,sprite_get_speed(original_sprite),spritespeed_framespersecond);
	
	shader_reset();
	surface_reset_target();
	surface_free(surf_sprite);

	return new_sprite;


}
