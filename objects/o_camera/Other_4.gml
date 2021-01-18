/// @description Initialize the camera
// DON'T MAKE ANY NEW CAMERAS, THE OBJECT IS PERSISTENT NOW
// Enable the use of views
view_enabled = true;
view_set_visible(0, true);

// Set the view dimensions
wview = VIEW_WIDTH;
hview = VIEW_HEIGHT;
view_scale = 1;

// Check for a player object to follow
if instance_exists(o_player) {
	follow = o_player;
	fx = follow.x;
	fy = follow.y;
} else {
	follow = noone;
	fx = 0;
	fy = 0;
}

// Screenshake Variables
screenshake = 0;
sc_x = 0;
sc_y = 0;

// Set initial position
x = clamp(fx,wview/2,room_width-(wview/2));
y = clamp(fy,hview/2,room_height-(hview/2));
xTo = x;
yTo = y;
camera_x = x;
camera_y = y;

mode = CAMERA_JUMP;
pan_spd = 1.0;
lerp_amt = 0.5;
done_moving = false;

// Set up the camera
view_camera[0] = camera_create_view(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
view_enabled = true;
view_visible[0] = true;