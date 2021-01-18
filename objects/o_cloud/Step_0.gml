x -= global.cloud_speed;
if (x + abs(sprite_width) / 2 < 0) x += room_width + sprite_width / image_xscale + 2 * global.cloud_speed;