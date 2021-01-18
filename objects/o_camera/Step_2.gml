/// @description Control the camera
if follow != noone && instance_exists(follow) {
	mode = CAMERA_JUMP;
	xTo = follow.x;
	yTo = follow.y - 12;
}

// Set the camera position
if x != xTo || y != yTo {
	switch mode {
		case CAMERA_JUMP:
			x = xTo;
			y = yTo;
			break;
		case CAMERA_LERP:
			x = lerp(x, xTo, lerp_amt);
			y = lerp(y, yTo, lerp_amt);
			if abs(x - xTo) + abs(y - yTo) < 0.1 {
				x = xTo;
				y = yTo;
				done_moving = true;
			}
			break;
		case CAMERA_PAN:
			var dx = xTo - x;
			var dy = yTo - y;
			var dist = sqrt(dx * dx + dy * dy);
			var xHat = dx / dist;
			var yHat = dy / dist;
			if dist <= pan_spd {
				x = xTo;
				y = yTo;
				done_moving = true;
			} else {
				x += xHat * pan_spd;
				y += yHat * pan_spd;
			}
			break;
	}
}

// Screenshake
sc_x = random_range(-screenshake,screenshake);
sc_y = random_range(-screenshake,screenshake);

// Clamp the view
x = clamp(x,wview/2,room_width-(wview/2));
y = clamp(y,hview/2,room_height-(hview/2));

// Set camera position
var vw = VIEW_WIDTH * view_scale;
var vh = VIEW_HEIGHT * view_scale;
camera_set_view_size(view_camera[0], vw, vh);
camera_x = clamp(x + sc_x, vw / 2, room_width - vw / 2) - vw / 2;
camera_y = clamp(y + sc_y, vh / 2, room_height - vh / 2) - vh / 2;
camera_set_view_pos(view_camera[0], camera_x, camera_y);