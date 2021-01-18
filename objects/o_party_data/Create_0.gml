/// @description Initialize Party Data
// This object stores important data for the party,
// such as items and other quantities

// Party
party = ds_list_create();

scr_add_party_member("P1");
var player1 = scr_get_party_member("P1");
player1.small_icon =	s_chara_icon_small_alt1;
player1.c_hp =			scr_stat_curve(25, 500, 1.0);
player1.c_mp =			scr_stat_curve(10, 400, 1.0);
player1.c_atk =			scr_stat_curve(5, 300, 1.0);
player1.c_def =			scr_stat_curve(5, 200, 1.0);
player1.c_mag_atk =		scr_stat_curve(5, 200, 1.0);
player1.c_mag_def =		scr_stat_curve(5, 200, 1.0);
player1.c_spd =			scr_stat_curve(5, 200, 1.0);
player1.c_luck =		scr_stat_curve(5, 200, 1.0);
player1.ability_level_moves[|1] = [scr_actP_big_bash, scr_actP_slice];
player1.magic_action_level_moves[|1] = [scr_actP_heal_small];
scr_party_member_gain_xp(player1, 100);

scr_add_party_member("P2");
var player2 = scr_get_party_member("P2");
player2.small_icon =	s_chara_icon_small_alt2;
player2.c_hp =			scr_stat_curve(20, 400, 1.0);
player2.c_mp =			scr_stat_curve(15, 500, 1.0);
player2.c_atk =			scr_stat_curve(5, 200, 1.0);
player2.c_def =			scr_stat_curve(5, 200, 1.0);
player2.c_mag_atk =		scr_stat_curve(5, 200, 1.0);
player2.c_mag_def =		scr_stat_curve(5, 200, 1.0);
player2.c_spd =			scr_stat_curve(5, 200, 1.0);
player2.c_luck =		scr_stat_curve(5, 200, 1.0);
player2.magic_action_level_moves[|1] = [scr_actP_heal_small, scr_actP_heal_large];
player2.magic_action_level_moves[|5] = [scr_actP_heal_group];
scr_party_member_gain_xp(player2, 100);

scr_add_party_member("P3");
var player3 = scr_get_party_member("P3");
player3.small_icon = s_chara_icon_small_alt3;
player3.c_hp =			scr_stat_curve(30, 600, 1.0);
player3.c_mp =			scr_stat_curve(10, 300, 1.0);
player3.c_atk =			scr_stat_curve(5, 300, 1.0);
player3.c_def =			scr_stat_curve(5, 200, 1.0);
player3.c_mag_atk =		scr_stat_curve(5, 200, 1.0);
player3.c_mag_def =		scr_stat_curve(5, 200, 1.0);
player3.c_spd =			scr_stat_curve(5, 200, 1.0);
player3.c_luck =		scr_stat_curve(5, 200, 1.0);
player3.ability_level_moves[|1] = [scr_actP_big_bash, scr_actP_slice, scr_actP_bigger_bash];
scr_party_member_gain_xp(player3, 100);


// Inventory
gold = 0;
inventory = ds_list_create();
ds_list_add(inventory, scr_item_medicine);
ds_list_add(inventory, scr_item_medicine);
