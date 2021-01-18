/// @descr scr_ai_walk_around_setup()
function scr_ai_walk_around_setup() {
	origin_x = x;
	origin_y = y;
	max_action_time = room_speed * 0.5;
	min_action_time = room_speed * 0.2;
	max_wait_time = room_speed * 2;
	min_wait_time = room_speed * 0.25;

	timer = random_range(min_wait_time, max_wait_time);
	dir = DIR_DOWN;
	walk_spd = 1;
	walking = false;


}
