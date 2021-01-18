event_inherited();
scr_npc_init_sprites(s_notness_r, s_notness_l, s_notness_u, s_notness_d, s_notness_r, s_notness_l, s_notness_r, s_notness_l);
scr_ai_walk_around_setup();
walk_spd = 0.5;

enemy_lists = [
	[oB_enemy_psycho_kid],
	[oB_enemy_psycho_kid, oB_enemy_psycho_kid],
	[oB_enemy_psycho_kid, oB_enemy_star, oB_enemy_psycho_kid],
	[oB_enemy_psycho_kid, oB_enemy_psycho_kid, oB_enemy_psycho_kid],
];

background = 0;
transition = TRANSITION_BATTLE_START_FADE;
music = pointer_null;