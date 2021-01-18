varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 col;
uniform float con_sat_brt[5];

#define con			con_sat_brt[0]
#define sat			con_sat_brt[1]
#define brt			con_sat_brt[2]
#define pop_str		con_sat_brt[3]
#define pop_thresh	con_sat_brt[4]

void main()
{
    vec3 out_col	= texture2D( gm_BaseTexture, v_vTexcoord ).rgb;
	float grey		= dot( out_col, vec3( 0.299, 0.587, 0.114 ) );
	
	// overlay colour
	out_col = grey > 0.5 ? 1.0-(1.0-2.0*(out_col-0.5))*(1.0-col) : 2.0*out_col*col;
	// add saturation
	out_col			= mix( vec3( grey ), out_col, sat );
	// add contrast
	out_col			= ( out_col - 0.5 ) * con + 0.5;
	// pop lights
	out_col			= out_col + pop_str * max( grey - pop_thresh, 0.0 );
	// add brightness
	out_col			= out_col + brt;
	
	gl_FragColor	= vec4( out_col, 1.0 );
}
