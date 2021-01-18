/// @descr scr_npc_update_sprite()
function scr_npc_update_sprite() {
	if (abs(hspd) + abs(vspd) == 0) {
		image_index = 0;
	}

	// Get Direction
	switch(sprite_dir) {
		case DIR_RIGHT:		sprite_index = spr_right;		break;
		case DIR_UPRIGHT:	sprite_index = spr_upright;		break;
		case DIR_UP:		sprite_index = spr_up;			break;
		case DIR_UPLEFT:	sprite_index = spr_upleft;		break;
		case DIR_LEFT:		sprite_index = spr_left;		break;
		case DIR_DOWNLEFT:	sprite_index = spr_downleft;	break;
		case DIR_DOWN:		sprite_index = spr_down;		break;
		case DIR_DOWNRIGHT: sprite_index = spr_downright;	break;
	}


}
