event_inherited();
scr_npc_init_sprites(s_notness_r, s_notness_l, s_notness_u, s_notness_d, s_notness_r, s_notness_l, s_notness_r, s_notness_l);
scr_ai_walk_around_setup();
walk_spd = 0.5;

name = "???";
icon = s_face_notness_smug;
this_npc = o_npc_notness;
cutscenes = [
	[FLAGS.NONE, [
		[ // 1
			[cs_set_canmove, false],
			[cs_npc_ai_disable, this_npc],
			[cs_textbox, [
				[icon, name, "hey."],
				[icon, name, "is your refrigerator running?"],
			]],
			[cs_set_canmove, true],
			[cs_npc_ai_enable, this_npc],
		],
		[ // 2
			[cs_set_canmove, false],
			[cs_npc_ai_disable, this_npc],
			[cs_textbox, [
				[icon, name, "you should go catch it."],
			]],
			[cs_set_canmove, true],
			[cs_npc_ai_enable, this_npc],
		],
	]],
	[FLAGS.TEST_TREE_1, [
		[ // 1
			[cs_set_canmove, false],
			[cs_npc_ai_disable, this_npc],
			[cs_textbox, [
				[icon, name, "so you found the note, huh?"],
				[icon, name, "heh."],
			]],
			[cs_set_canmove, true],
			[cs_npc_ai_enable, this_npc],
		],
		[ // 2
			[cs_set_canmove, false],
			[cs_npc_ai_disable, this_npc],
			[cs_textbox, [
				[icon, name, "heh."],
			]],
			[cs_set_canmove, true],
			[cs_npc_ai_enable, this_npc],
		],
	]],
];