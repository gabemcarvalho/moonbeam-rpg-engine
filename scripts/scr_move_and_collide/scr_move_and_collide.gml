/// @description scr_move_and_collide()
function scr_move_and_collide() {
	// object should have variables hspd and vspd for this to work
	// need to disable hitbox before moving
	var hitbox_sprite = hitbox.sprite_index;
	hitbox.sprite_index = -1; // no sprite
	var collided = false;

	if no_collision {
		x += hspd;
		y += vspd;
	} else {
		var granularity = 0.1;
	
		// Horizontal Collisions
		for (var i = 0; i < abs(hspd); i += granularity) {
			if place_meeting(x + sign(hspd), y, o_wall) {
				hspd = 0;
				collided = true;
				break;
			}
			x += granularity * sign(hspd);
		}

		// Vertical Collisions
		for (var i = 0; i < abs(vspd); i += granularity) {
			if place_meeting(x, y + sign(vspd), o_wall) {
				vspd = 0;
				collided = true;
				break;
			}
			y += granularity * sign(vspd);
		}
	}

	hitbox.sprite_index = hitbox_sprite;
	hitbox.x = x;
	hitbox.y = y;
	return collided;


}
