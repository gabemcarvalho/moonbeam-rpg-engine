/// @description Star
// Inherit the parent event
event_inherited();

base_name = "Grand Star";
name = base_name;
name_scheme = NAME_SEQUENCE;
small_icon = scr_generate_random_sprite(s_icon_star, generated_sprite_h, generated_sprite_s, generated_sprite_v);

max_hp = 40;
hp = max_hp;
atk = 15;
def = 9;
mag_atk = 14;
mag_def = 15;
spd = 7;

// Moveset
moveset[|0] = scr_actE_attack_normal;
moveset[|1] = scr_actE_do_nothing;
moveset[|2] = scr_actE_psycho_slash;
moveset[|3] = scr_actE_small_heal;

// Drops
xp = 25
gold = 32
scr_enemy_drop_add(scr_item_medicine, 25);