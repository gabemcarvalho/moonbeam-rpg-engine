/// @description Psycho Kid
// Inherit the parent event
event_inherited();

base_name = "Psycho Kid";
name = base_name;
name_scheme = NAME_SEQUENCE;
small_icon = scr_generate_random_sprite(s_icon_psycho_kid, generated_sprite_h, generated_sprite_s, generated_sprite_v);

max_hp = 30;
hp = max_hp;
atk = 15;
def = 8;
mag_atk = 16;
mag_def = 12;
spd = 7;

// Moveset
moveset[|0] = scr_actE_attack_normal;
moveset[|1] = scr_actE_do_nothing;
moveset[|2] = scr_actE_psycho_slash;
moveset[|3] = scr_actE_punch_in_the_face;

// Drops
xp = 15
gold = 18
scr_enemy_drop_add(scr_item_medicine, 12);