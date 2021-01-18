/// @description heal_damage(healing_object, recipient, base_power)
/// @param healing_object
/// @param recipient
/// @param base_power
function heal_damage(argument0, argument1, argument2) {
	// This will need an algorithm eventually, but right now it just heals the damage directly
	var healer = argument0;
	var recipient = argument1;
	var base_power = argument2;

	// Calculate healing power
	var		damage = healer.mag_def * base_power * random_range(0.8, 1.2);
			damage = round(clamp(damage,0,9999));

	// Raise health
	recipient.hp = min(recipient.hp+damage,recipient.max_hp);

	// Create damage numbers
	if recipient.type == TYPE_ENEMY {
		create_damage_numbers(damage,recipient.x,recipient.y-48,c_green);
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
		create_damage_numbers(damage,dx,266-16,c_lime);
	}

	// Return the damage dealt
	return damage;


}
