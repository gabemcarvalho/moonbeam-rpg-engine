/// @descr cs_object_teleport
/// @arg object
/// @arg x
/// @arg y
function cs_object_teleport(argument0, argument1, argument2) {
	if instance_exists(argument0) {
		with argument0 {
			x = argument1;
			y = argument2;
		}
	} else {
		show_error("tried to modify an object that doesn't exist in the room!", false);
	}
	cs_place++;


}
