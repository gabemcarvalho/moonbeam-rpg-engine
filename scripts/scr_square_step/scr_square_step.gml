///@description scr_square_step()
function scr_square_step() {
	if sq_visible {
		// Rotate
		sq_angle += 360/sq_rotaion_period;
		if sq_angle > 360 sq_angle -= 360;
		// Pulsate
		sq_timer++;
		if sq_timer > sq_pulse_period sq_timer -= sq_pulse_period;
		sq_rad = sq_rad_max*(0.6 + 0.4*(1+cos(sq_timer* 2*pi/sq_pulse_period))/2);
	}


}
