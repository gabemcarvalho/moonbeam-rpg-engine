///@descr cs_camera_jump
///@arg x
///@arg y
function cs_camera_jump(argument0, argument1) {
	o_camera.follow = noone;
	o_camera.mode = CAMERA_JUMP;
	o_camera.xTo = argument0;
	o_camera.yTo = argument1;
	cs_place++;


}
