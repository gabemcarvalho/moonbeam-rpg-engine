/// @description Define defaults
// Basic Info
name = "Ness";

#region STATS
// Total stats
hp_max =		0;
hp =			hp_max;
mp_max =		0;
mp =			mp_max;
atk =			0;
def =			0;
mag_atk =		0;
mag_def =		0;
spd =			0;
luck =			0;

// Stats gained through bonuses
b_hp =			0;
b_mp =			0;
b_atk =			0;
b_def =			0;
b_mag_atk =		0;
b_mag_def =		0;
b_spd =			0;
b_luck =		0;

// Stats from equipment
e_hp =			0;
e_mp =			0;
e_atk =			0;
e_def =			0;
e_mag_atk =		0;
e_mag_def =		0;
e_spd =			0;
e_luck =		0;

// Stat curves
c_hp =			scr_stat_curve(5, 200, 1.0);
c_mp =			scr_stat_curve(5, 200, 1.0);
c_atk =			scr_stat_curve(5, 200, 1.0);
c_def =			scr_stat_curve(5, 200, 1.0);
c_mag_atk =		scr_stat_curve(5, 200, 1.0);
c_mag_def =		scr_stat_curve(5, 200, 1.0);
c_spd =			scr_stat_curve(5, 200, 1.0);
c_luck =		scr_stat_curve(5, 200, 1.0);
#endregion

// XP
level =			0;
total_xp =		0;

// Sprites
small_icon =	s_chara_icon_small;

// Moves
attack_action = scr_actP_attack_normal;
defend_action = scr_actP_defend_normal;

magic_actions = ds_list_create();
magic_action_level_moves = ds_list_create();
for (var i=0; i<100; i++) magic_action_level_moves[|i] = [];

abilities = ds_list_create();
ability_level_moves = ds_list_create();
for (var i=0; i<100; i++) ability_level_moves[|i] = [];
