surf_shadows	= surface_create( VIEW_WIDTH, VIEW_HEIGHT );
shadow_x = 10;
shadow_y = 20;

surf_midtilt	= surface_create( view_wport[0], view_hport[0] );

// Day night cycle shader (from Gaming Reverends - DevCorner)
surf_colour_overlay		= surface_create( view_wport[0], view_hport[0] );
dn_shader				= shd_overlay;
u_col					= shader_get_uniform( dn_shader, "col" );
u_con_sat_brt			= shader_get_uniform( dn_shader, "con_sat_brt" );

colour_mix		= -1;
colour[0,0]		= undefined;

con_sat_brt_mix = -1;

key_previous	= -1;
key_next		= -1;

// arguments:	 R		G		B		con		sat		brt		popS	popT
scr_add_key_time(030,	120,	225,	0.60,	1.00,  -0.20,	0.80,	0.65);	// 00h
scr_add_key_time(040,	125,	215,	0.65,	0.90,  -0.20,	0.70,	0.65);	// 02h
scr_add_key_time(080,	080,	185,	0.80,	0.60,  -0.15,	0.20,	0.80);	// 04h
scr_add_key_time(125,	070,	175,	1.00,	0.85,  -0.10,  -0.50,	0.60);	// 06h
scr_add_key_time(160,	145,	100,	1.20,	0.65,  -0.03,	0.00,	1.00);	// 08h
scr_add_key_time(128,	128,	128,	1.00,	1.00,	0.00,	0.00,	1.00);	// 10h
scr_add_key_time(128,	128,	128,	1.20,	0.85,	0.05,	0.00,	1.00);	// 12h
scr_add_key_time(128,	128,	128,	1.00,	1.00,	0.00,	0.00,	1.00);	// 14h
scr_add_key_time(140,	130,	120,	1.10,	0.80,	0.00,	0.00,	1.00);	// 16h
scr_add_key_time(145,	120,	090,	1.10,	0.75,	0.00,	0.00,	1.00);	// 18h
scr_add_key_time(150,	060,	190,	1.25,	0.70,  -0.05,  -0.50,	0.60);	// 20h
scr_add_key_time(080,	080,	185,	0.80,	0.60,  -0.15,	0.20,	0.80);	// 22h

number_of_key_times = array_height_2d(colour);

// clouds
cloud_list = ds_list_create();
cloud_density = 0.2;
cloud_area = 128 * 64;
room_area = room_width * room_height;
cloud_number = round(room_area * cloud_density / cloud_area);
for ( var i = 0; i < cloud_number; i++ ) {
	var new_cloud = instance_create_layer(irandom(room_width), irandom(room_height), "objects", o_cloud);
	with new_cloud {
		while place_meeting( x, y, o_cloud ) {
			x = irandom(room_width);
			y = irandom(room_height);
		}
	}
	ds_list_add(cloud_list, new_cloud);
}

// create player object
if o_controller.door_transition {
	if instance_exists(o_door) with o_door {
		if other_room == o_controller.last_room && door_id == o_controller.door_id {
			if instance_exists(o_player) instance_destroy(o_player); // can't have multiple players
			// create player at this door
			var new_player = instance_create_layer(x, y, "objects", o_player);
			new_player.sprite_dir = o_controller.door_spawn_side;
			if o_controller.door_spawn_side == DIR_RIGHT {
				new_player.x += 20;
				new_player.y += o_controller.door_relative_coord;
			} else if o_controller.door_spawn_side == DIR_LEFT {
				new_player.x -= 20;
				new_player.y += o_controller.door_relative_coord;
			} else if o_controller.door_spawn_side == DIR_UP {
				new_player.x += o_controller.door_relative_coord;
				new_player.y -= 20;
			} else if o_controller.door_spawn_side == DIR_DOWN {
				new_player.x += o_controller.door_relative_coord;
				new_player.y += 20;
			}
		}
	}
	
	// should probably set up camera stuff here
	
	o_controller.door_transition = false;
}

// objects to draw
object_list = ds_list_create();
movable_objects = ds_list_create();
// instance_create_layer(0, 0, "gui", o_overworld_create_end); // IMPORTANT: this populates the lists of objects in the begin step event after everything has been created

// add static objects to object list
if instance_exists(o_game_object) {
	for (var i = 0; i < instance_number(o_game_object); i++) { // for every other game object
		var game_object = instance_find(o_game_object, i);
		if game_object.movable {
			ds_list_add(movable_objects, game_object);
			continue;
		}
		var added = false;
		for (var j = 0; j < ds_list_size(object_list); j++) { // insert at relative depth based on y position
			if game_object.y <= ds_list_find_value(object_list, j).y {
				ds_list_insert(object_list, j, game_object);
				added = true;
				break;
			}
		}
		if !added ds_list_add(object_list, game_object);
	}
}
	
// moving objects
if ds_list_size(movable_objects) > 0 {
	for (var i = 0; i < ds_list_size(movable_objects); i++) {
		var game_object = ds_list_find_value(movable_objects, i);
		var added = false;
		for (var j = 0; j < ds_list_size(object_list); j++) { // insert at relative depth based on y position
			if game_object.y <= ds_list_find_value(object_list, j).y {
				ds_list_insert(object_list, j, game_object);
				added = true;
				break;
			}
		}
		if !added {
			ds_list_add(object_list, game_object);
			game_object.draw_depth = ds_list_size(object_list) - 1;
		}
	}
	for (var i = 0; i < ds_list_size(movable_objects); i++) {
		var game_object = ds_list_find_value(movable_objects, i);
		game_object.draw_depth = ds_list_find_index(object_list, game_object);
	}
}