function scr_enemy_combatant_draw() {
	// Screenshake
	if shake_duration > 0 {
		shake_duration--;
	} else {
		shake_amount = 0;
	}
	var sx = random_range(-shake_amount,shake_amount);
	var sy = random_range(-shake_amount,shake_amount);

	// Draw the sprite
	if !defeated draw_sprite(sprite_index,image_index,x+sx,y+sy);


}
