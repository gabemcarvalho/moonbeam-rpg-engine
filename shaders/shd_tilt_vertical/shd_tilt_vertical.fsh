// A simple tilt-shift shader that's hardcoded for a 320x180 view
varying vec2 v_vTexcoord;

void main()
{ 
	
	vec4 sum = vec4(0);	
	float blurSizeY = 1.0 / 180.0;
	float amount = pow( 4.0 * max ( abs( v_vTexcoord.y - 0.5 ) - 0.3, 0.0 ), 2.0 );

	// take nine samples, with the distance blurSize between them
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - 4.0*blurSizeY)) * 0.05;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - 3.0*blurSizeY)) * 0.09;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - 2.0*blurSizeY)) * 0.12;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - blurSizeY)) * 0.15;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y)) * 0.16;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + blurSizeY)) * 0.15;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + 2.0*blurSizeY)) * 0.12;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + 3.0*blurSizeY)) * 0.09;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + 4.0*blurSizeY)) * 0.05;
	
	vec4 full_colour = sum * amount * 0.9 + ( 1.0 - amount ) * texture2D(gm_BaseTexture, v_vTexcoord);
	full_colour *= 1.0 - 0.1 * ( abs( v_vTexcoord.x - 0.5 ) + abs( v_vTexcoord.y - 0.5 ) );
	gl_FragColor = full_colour;

}