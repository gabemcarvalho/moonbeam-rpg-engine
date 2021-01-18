/// @descr doors
if !o_controller.door_transition && global.canmove {
	var door = instance_place(x, y, o_door);
	if door != noone {
		o_controller.last_room = room;
		o_controller.door_id = door.door_id;
		o_controller.door_transition = true;
		o_controller.next_room = door.other_room;
	
		// determine direction of door
		o_controller.door_spawn_side = DIR_RIGHT;
		if x > door.x - door.image_xscale * 4 && x < door.x + door.image_xscale * 4 {
			// pretty sure player is above or below door
			o_controller.door_relative_coord = x - door.x;
			if y < door.y { // above
				o_controller.door_spawn_side = DIR_DOWN;
			} else {
				o_controller.door_spawn_side = DIR_UP;
			}
		} else {
			// pretty sure player is beside door
			o_controller.door_relative_coord = y - door.y;
			if x > door.x {
				o_controller.door_spawn_side = DIR_LEFT;
			}
		}
	
		global.canmove = false;
		global.canmove_after_transition = true;
		scr_transition(TRANSITION_FADE);
	}
}