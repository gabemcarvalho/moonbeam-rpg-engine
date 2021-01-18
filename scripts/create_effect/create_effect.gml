///@description create_effect(sprite, x, y)
///@param sprite
///@param x
///@param y
function create_effect(argument0, argument1, argument2) {
	var effect = instance_create_layer(argument1, argument2, "GUI", o_effect);
	effect.sprite_index = argument0;
	return effect;


}
