/// @description Insert description here
event_inherited();
type = TYPE_PARTY;
level = 1;
data = noone;

attack_action = scr_actP_attack_normal;
defend_action = scr_actP_defend_normal;
magic_actions = ds_list_create();
abilities = ds_list_create();

// Menu Memory
selection_top_place = SLCT_ATK;
selection_last_list = SLCT_MAGIC;
selection_list_place = 0;
selection_list_top = 0;