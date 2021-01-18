///@description scr_enemy_drop_add(item, percent_chance);
///@param item
///@param percent_chance
function scr_enemy_drop_add(argument0, argument1) {
	var item = argument0;
	var chance = argument1;

	for (var i=0; i<chance; i++) {
		if drops_total_chance < 100 {
			drops[|drops_total_chance] = item;
			drops_total_chance++;
		} else {
			show_error("enemy drops misconfigured", true);
		}
	}


}
