event_inherited();
cutscenes = [
	[FLAGS.NONE, [
		[
			[cs_set_canmove, false],
			[cs_textbox, [
				["It's a ^rSTOP sign."],
				["Make sure to ^rSTOP before passing it."],
			]],
			[cs_set_canmove, true],
		],
	]],
];