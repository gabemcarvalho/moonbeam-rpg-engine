// Draw shadows
if !surface_exists( surf_shadows ) {
	surf_shadows = surface_create( VIEW_WIDTH, VIEW_HEIGHT );
}

var vx = o_camera.camera_x;
var vy = o_camera.camera_y;
var sx = shadow_x;
var sy = shadow_y;

surface_set_target( surf_shadows );
draw_clear_alpha( c_black, 0 );
gpu_set_fog( true, c_black, 0, 1 );

with o_has_shadow {
	if draw_shadow {
		var ox = x - sprite_xoffset - vx;
		var oy = y + sprite_height - sprite_yoffset - vy;
		draw_sprite_pos( sprite_index, image_index,
			ox - sx,
			oy - sy,
			ox + sprite_width - sx,
			oy - sy,
			ox + sprite_width,
			oy,
			ox,
			oy,
			1.0 );
	}
}

gpu_set_fog( false, c_white, 0, 0 );
surface_reset_target();

draw_set_alpha( 0.3 );
draw_surface( surf_shadows, vx, vy );
draw_set_alpha( 1.0 );

// Draw objects and characters (IMPORTANT: objects need to be added to either object_list or movable_objects in o_overworld_create_end for them to be drawn)
// update movable object positions in object list
for (var i = 0; i < ds_list_size(movable_objects); i++) {
	var movable_object = movable_objects[|i];
	if movable_object.y != movable_object.draw_last_y {
		var pos = movable_object.draw_depth;
		var moved = false;
		if movable_object.y > movable_object.draw_last_y { // move down the list
			while pos < ds_list_size(object_list) - 1 {
				if movable_object.y > object_list[|pos + 1].y {
					pos++;
					moved = true;
					continue;
				}
				break;
			}
			if moved { // move objects
				for (var j = movable_object.draw_depth; j < pos; j++) {
					object_list[|j] = object_list[|j + 1];
					if object_list[|j].movable { // account for movable objects indices changing
						object_list[|j].draw_depth = j;
					}
				}
				object_list[|pos] = movable_object;
			}
		} else if movable_object.y < movable_object.draw_last_y { // move up the list
			while pos > 0 {
				if movable_object.y < object_list[|pos - 1].y {
					pos--;
					moved = true;
					continue;
				}
				break;
			}
			if moved { // move objects
				for (var j = movable_object.draw_depth; j > pos; j--) {
					object_list[|j] = object_list[|j - 1];
					if object_list[|j].movable { // account for movable objects indices changing
						object_list[|j].draw_depth = j;
					}
				}
				object_list[|pos] = movable_object;
			}
		}
		movable_object.draw_depth = pos;
		movable_object.draw_last_y = movable_object.y;
	}
}

// loop through all objects
for (var i = 0; i < ds_list_size(object_list); i++) {
	var game_object = object_list[|i]; // might want to check if objects exist (or not yolo)
	draw_sprite(game_object.sprite_index, game_object.image_index, game_object.x, game_object.y);
}

//  draw clouds
for (var i = 0; i < ds_list_size(cloud_list); i++) {
	var cloud = cloud_list[|i];
	draw_sprite_ext(cloud.sprite_index, cloud.image_index, cloud.x, cloud.y, cloud.image_xscale, cloud.image_yscale, 0, c_white, global.cloud_alpha);
}
