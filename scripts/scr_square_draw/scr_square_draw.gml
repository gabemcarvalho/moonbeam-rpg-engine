///scr_square_draw(x, y)
///@param x
///@param y
function scr_square_draw(argument0, argument1) {
	var sq_x = argument0;
	var sq_y = argument1;

	if sq_visible {
		var theta = sq_angle*pi/180;
		draw_line_width(sq_x+sq_rad*cos(theta),sq_y+sq_rad*sin(theta),sq_x+sq_rad*cos(theta+pi/2),sq_y+sq_rad*sin(theta+pi/2), 2);
		draw_line_width(sq_x+sq_rad*cos(theta+pi/2),sq_y+sq_rad*sin(theta+pi/2),sq_x+sq_rad*cos(theta+pi),sq_y+sq_rad*sin(theta+pi), 2);
		draw_line_width(sq_x+sq_rad*cos(theta+pi),sq_y+sq_rad*sin(theta+pi),sq_x+sq_rad*cos(theta+3*pi/2),sq_y+sq_rad*sin(theta+3*pi/2), 2);
		draw_line_width(sq_x+sq_rad*cos(theta+3*pi/2),sq_y+sq_rad*sin(theta+3*pi/2),sq_x+sq_rad*cos(theta),sq_y+sq_rad*sin(theta), 2);
	}


}
