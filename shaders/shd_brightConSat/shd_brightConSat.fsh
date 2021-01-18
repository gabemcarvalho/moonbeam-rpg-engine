varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;
uniform float Saturation;
uniform float Brightness;
uniform float Contrast;
uniform float Noise;
uniform float RandomFactor;
uniform float Aberration;
uniform bool Gold;

void main()
{
	//vec4 Colour = texture2D( gm_BaseTexture, v_vTexcoord ); // get colour of pixel
    
	vec4 Color1 = texture2D( gm_BaseTexture, v_vTexcoord )/3.0;
    vec4 Color2 = texture2D( gm_BaseTexture, v_vTexcoord+0.002*Aberration )/3.0;
    vec4 Color3 = texture2D( gm_BaseTexture, v_vTexcoord-0.002*Aberration )/3.0;
    Color1 *= 2.0;
    Color2.g = 0.0;
    Color2.b = 0.0;
    Color3.r = 0.0;
    vec4 Colour = v_vColour * (Color1 + Color2 + Color3);
	
	
	// Brightness and Contrast from xygthop3
	Colour.rgb = Colour.rgb+Brightness;
	
	// Contrast
	Colour.rgb = mix(vec3(0.5,0.5,0.5),Colour.rgb,Contrast);
	
	// Saturation from KeeVee Games
	float Max = max(Colour.r, max(Colour.g, Colour.b)); // get max channel of pixel
    float Min = min(Colour.r, min(Colour.g, Colour.b)); // get min channel of pixel
    float Sat = max(1.0-Min/Max,0.01); // get current saturation of pixel
    // set saturation to pixel that depends on Position uniform
    Colour.r = clamp(Max-(Max-Colour.r)/Sat*(Sat+Saturation), 0.0, Max); // for red channel
    Colour.g = clamp(Max-(Max-Colour.g)/Sat*(Sat+Saturation), 0.0, Max); // for green channel
    Colour.b = clamp(Max-(Max-Colour.b)/Sat*(Sat+Saturation), 0.0, Max); // for blue channel
	
	// Noise - Uses random function from Xor Tutorials
	Colour.rgb += Noise*fract(cos( dot( v_vPosition*RandomFactor, vec2(5.237,6.378)))*8463.648);
	
	// .gold
	if (Gold==true) {
		Colour.rgb = min(max(Colour.rgb,0.0),1.0);
		float blueness = Colour.b - (Colour.r+Colour.g)/2.0;
		if (Colour.r+Colour.g+Colour.b>2.9) {
			Colour.r = 0.7;
			Colour.g = 0.4;
			Colour.b = 0.0;
		} else {
			float val = max(Colour.r,max(Colour.g,Colour.b));
			val = mix(0.25,val,7.0);
			Colour.r = mix(0.1,max(val,Colour.r),1.5);
			Colour.g = val*0.75;
			Colour.b = mix(0.75,blueness,5.0);
		}
	}
	
    gl_FragColor = v_vColour * Colour;
}
