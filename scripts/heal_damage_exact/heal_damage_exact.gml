/// @description heal_damage(recipient, amount)
/// @param recipient
/// @param amount
function heal_damage_exact(argument0, argument1) {
	var recipient = argument0;
	var amount = argument1;

	// Raise health
	recipient.hp = min(recipient.hp+amount,recipient.max_hp);

	// Create damage numbers
	if recipient.type == TYPE_ENEMY {
		create_damage_numbers(amount,recipient.x,recipient.y-48,c_lime);
	} else {
		var recipient_place = 0;
		for (var i=0; i<ds_list_size(party_list); i++) {
			if party_list[|i] == recipient recipient_place = i;
		}
		if ds_list_size(party_list) > 1 {
			var dx = 640/2 + 48*( -1 + 2*(recipient_place/(ds_list_size(party_list)-1))) * ds_list_size(party_list);
		} else {
			var dx = 640/2;
		}
		create_damage_numbers(amount,dx,266-16,c_lime);
	}


}
