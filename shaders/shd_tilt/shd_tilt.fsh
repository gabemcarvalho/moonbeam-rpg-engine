// A simple tilt-shift shader that's hardcoded for a 320x180 view
varying vec2 v_vTexcoord;

void main()
{ 
	
	vec4 sum = vec4(0);
	int j;
	int i;
	
	float blurSizeX = 1.0 / 320.0;
	float blurSizeY = 1.0 / 180.0;
	float amount = max ( abs( v_vTexcoord.y - 0.5 ) * 2.0 - 0.2, 0.0 );

	// take nine samples, with the distance blurSize between them
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - 4.0*blurSizeX, v_vTexcoord.y)) * 0.05;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - 3.0*blurSizeX, v_vTexcoord.y)) * 0.09;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - 2.0*blurSizeX, v_vTexcoord.y)) * 0.12;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - blurSizeX, v_vTexcoord.y)) * 0.15;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y)) * 0.16;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + blurSizeX, v_vTexcoord.y)) * 0.15;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + 2.0*blurSizeX, v_vTexcoord.y)) * 0.12;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + 3.0*blurSizeX, v_vTexcoord.y)) * 0.09;
	sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + 4.0*blurSizeX, v_vTexcoord.y)) * 0.05;

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

	sum /= 2.0;
	
	vec4 full_colour = sum * amount * 0.8 + ( 1.0 - amount ) * texture2D(gm_BaseTexture, v_vTexcoord);
	full_colour *= 1.0 - 0.1 * ( abs( v_vTexcoord.x - 0.5 ) + abs( v_vTexcoord.y - 0.5 ) );
	
	
	gl_FragColor = full_colour;

}