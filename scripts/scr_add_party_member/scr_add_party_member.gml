///@description scr_add_party_member(name);
///@param name
function scr_add_party_member(argument0) {

	var char_data = instance_create_layer(0,0,"gui",o_character_data);

	char_data.name = argument0;

	ds_list_add(o_party_data.party, char_data);


}
