varying vec2 v_texcoord;

uniform float time;
uniform float wave_amount;
uniform float wave_distortion;
uniform float wave_speed;

void main()
{ 
    vec2 uv = v_texcoord;
	uv.x = uv.x+cos(uv.y*wave_amount+time*wave_speed)*wave_distortion;
    uv.y = uv.y+sin(uv.y*wave_amount+time*wave_speed)*wave_distortion;
    //uv.x = uv.x;
    //uv.y = uv.y+sin(uv.x*wave_amount+time*wave_speed)*wave_distortion;
	
	// Mod values based on the relative size of a 640x360 image in a 1024x512 texture page
	uv.x = mod(uv.x, 0.625); 
	uv.y = mod(uv.y, 0.703125);

	
    gl_FragColor = texture2D(gm_BaseTexture,uv);
}