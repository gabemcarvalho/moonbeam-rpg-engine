///@description fn_xp_curve(x);
///@param x
function fn_xp_curve(argument0) {
	var fx = argument0; // level
	return 0.1*power(fx-1,3) + 5*power(fx-1,2) + 10*(fx-1);


}
