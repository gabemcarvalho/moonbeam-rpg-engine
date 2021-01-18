/// @description deal_damage(damaging_object, damaged_object, base_power, attack_type)
/// @param damaging_object
/// @param damaged_object
/// @param base_power
/// @param attack_type
function deal_damage(argument0, argument1, argument2, argument3) {
	// This will need an algorithm eventually, but right now it just deals the damage directly
	// Defending halfs damage taken
	var attacker = argument0;
	var victim = argument1;
	var base_power = argument2;
	var type = argument3;

	// Calculate damage
	if type==DAMAGE_PHYSICAL {
		var attack = attacker.atk;
		var victim_defence = victim.def;
	} else if type==DAMAGE_MAGIC {
		var attack = attacker.mag_atk;
		var victim_defence = victim.mag_def;
	} else {
		show_error("that's not a valid attack type!", true);
	}

	var		damage = (attack*base_power - victim_defence) / (1 + victim.defending) * random_range(0.8,1.2);
			damage = round(clamp(damage,0,9999));

	// Lower health
	victim.hp = max(victim.hp-damage,0);

	// Shake
	combatant_shake(victim,5,8);

	// Create damage numbers
	if victim.type == TYPE_ENEMY {
		create_damage_numbers(damage,victim.x,victim.y-48,c_white);
	} else {
		var victim_place = 0;
		for (var i=0; i<ds_list_size(party_list); i++) {
			if party_list[|i] == victim victim_place = i;
		}
		if ds_list_size(party_list) > 1 {
			var dx = 640/2 + 48*( -1 + 2*(victim_place/(ds_list_size(party_list)-1))) * ds_list_size(party_list);
		} else {
			var dx = 640/2;
		}
		create_damage_numbers(damage,dx,266,c_white);
	}

	// Return the damage dealt
	return damage;


}
