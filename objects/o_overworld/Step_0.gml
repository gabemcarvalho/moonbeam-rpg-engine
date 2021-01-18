
// get key times
var time		= global.day_time / global.day_time_max;
global.day_time		= ( global.day_time + 1 ) mod global.day_time_max;
key_previous	= min( floor( time * number_of_key_times ), number_of_key_times - 1 );
key_next		= ( key_previous + 1 ) mod number_of_key_times;

// get lerp amount
var lerp_amt	= ( time - key_previous / number_of_key_times ) * number_of_key_times;

// mix colours
colour_mix		= [ lerp( colour[key_previous,0], colour[key_next,0], lerp_amt ),	// R
					lerp( colour[key_previous,1], colour[key_next,1], lerp_amt ),	// G
					lerp( colour[key_previous,2], colour[key_next,2], lerp_amt ) ];	// B
					
con_sat_brt_mix	= [ lerp( con_sat_brt[key_previous,0], con_sat_brt[key_next,0], lerp_amt ),		// con
					lerp( con_sat_brt[key_previous,1], con_sat_brt[key_next,1], lerp_amt ),		// sat
					lerp( con_sat_brt[key_previous,2], con_sat_brt[key_next,2], lerp_amt ),		// brt
					lerp( con_sat_brt[key_previous,3], con_sat_brt[key_next,3], lerp_amt ),		// pop str
					lerp( con_sat_brt[key_previous,4], con_sat_brt[key_next,4], lerp_amt )];	// pop thresh
					
global.cloud_alpha = 0.2 * ( 1 - clamp( 1.3*sin( (2*time+0.4) * pi) + 0.3, 0, 1 ) );
shadow_x = -40 * cos( (time * 2 + 0.5 ) * pi );
shadow_y = 20 * max( -cos( time * 2 * pi ), 0 );
