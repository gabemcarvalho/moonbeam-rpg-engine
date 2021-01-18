/// @description Set Up the Game
// Macros
#macro VIEW_WIDTH	320
#macro VIEW_HEIGHT	180
#macro PORT_WIDTH	640
#macro PORT_HEIGHT	360

#macro UI_ACT		1
#macro UI_SELECT	0

#macro ST_TEXT		0
#macro ST_SELECT	1
#macro ST_ACT		2
#macro ST_WAIT		10

#macro SLCT_TOP		-1
#macro SLCT_ATK		0
#macro SLCT_MAGIC	1
#macro SLCT_ITEM	2
#macro SLCT_ABILITY 3
#macro SLCT_DEFEND	4
#macro SLCT_RUN		5

#macro ACT_NAME				0
#macro ACT_COST				1
#macro ACT_DESCRIP			2
#macro ACT_TARGET			3
#macro ACT_RUN				4
#macro ACT_ITEM_REUSEABLE	5
#macro ACT_ITEM_USE			6

#macro ITEM_NONE			-1
#macro MOVE_NONE			-1

#macro TYPE_PARTY	0
#macro TYPE_ENEMY	1

#macro TARGET_SINGLE_ENEMY	0
#macro TARGET_ALL_ENEMY		1
#macro TARGET_SINGLE_PARTY	2
#macro TARGET_ALL_PARTY		3
#macro TARGET_SELF			4

#macro NAME_SEQUENCE		0
#macro NAME_RANDOM			1

#macro GENERATOR_BACK_COLOUR make_color_rgb(145,170,15)

#macro RANDOM_SPEED_MULTIPLIER 0.2

#macro DAMAGE_PHYSICAL	0
#macro DAMAGE_MAGIC		1

#macro DROP_ITEM	0
#macro DROP_CHANCE	1

#macro TEXT_COLOUR_DEFAULT	c_white
#macro TEXT_COLOUR_BLUE		c_aqua
#macro TEXT_COLOUR_ORANGE	c_orange
#macro TEXT_COLOUR_LIME		c_lime
#macro TEXT_COLOUR_PURPLE	make_colour_rgb(133, 96, 169);
#macro TEXT_COLOUR_RED		c_red

#macro TEXT_EFFECT_NONE		0
#macro TEXT_EFFECT_SHAKE	1

// these correspond to counts of 45 degree angles from the x axis
#macro DIR_RIGHT		0
#macro DIR_UPRIGHT		1
#macro DIR_UP			2
#macro DIR_UPLEFT		3
#macro DIR_LEFT			4
#macro DIR_DOWNLEFT		5
#macro DIR_DOWN			6
#macro DIR_DOWNRIGHT	7

#macro CAMERA_JUMP		0
#macro CAMERA_PAN		1
#macro CAMERA_LERP		2

#macro WIDESCREEN_HEIGHT	32
#macro WIDESCREEN_SPEED		0.5

#macro GRID_SIZE	16

#macro COL_DARK_GREY	make_colour_rgb(20, 20, 20)

#macro TRANSITION_FADE					0
#macro TRANSITION_BATTLE_START_FADE		1
#macro TRANSITION_BATTLE_END			2

enum FLAGS {
	NONE,
	TEST_TREE_1,
	TEST_TREE_2,
	
}
