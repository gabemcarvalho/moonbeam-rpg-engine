/// @description create_damage_numbers(damage, x, y, colour)
/// @param damage
/// @param x
/// @param y
/// @param colour
function create_damage_numbers(argument0, argument1, argument2, argument3) {
	var dm = instance_create_layer(argument1,argument2,"GUI",oB_damage_numbers);
	dm.damage = string(argument0);
	dm.colour = argument3;


}
