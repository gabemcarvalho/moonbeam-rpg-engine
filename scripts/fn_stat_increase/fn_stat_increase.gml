///@description fn_stat_increase(stat_curve, level, raw_stat);
///@param stat_curve
///@param level
///@param raw_stat
function fn_stat_increase(argument0, argument1, argument2) {
	var curve = argument0;
	var level = argument1;
	var old_stat = argument2;

	var new_stat = floor( curve[0] + (curve[1]-curve[0]) * power(level/100.0, curve[2]) );

	return max(new_stat - old_stat, 0);


}
