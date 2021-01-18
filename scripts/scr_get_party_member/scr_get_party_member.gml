///@description scr_get_party_member(name);
///@param name
function scr_get_party_member(argument0) {
	var name = argument0;
	for (var i=0; i<ds_list_size(o_party_data.party); i++) {
		if o_party_data.party[|i].name == name {
			return o_party_data.party[|i];
		}
	}
	return noone;


}
