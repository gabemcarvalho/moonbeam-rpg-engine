event_inherited();
cutscenes = [
	[FLAGS.NONE, [
		[
			[cs_set_canmove, false],
			[cs_wait_seconds, 0.2],
			[cs_camera_jump, 0, 0],
			[cs_wait_seconds, 0.5],
			[cs_camera_pan_seconds, 400, 400, 2, false],
			[cs_wait_seconds, 0.5],
			[cs_camera_lerp, 230, 200, 0.1, true],
			[cs_textbox, [
				["It's a ^bmailbox^d."],
			]],
			[cs_camera_pan_to_player, 0.5],
			[cs_set_canmove, true],
		],
	]],
];