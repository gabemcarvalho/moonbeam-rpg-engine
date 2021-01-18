/// @description Insert description here
event_inherited();
type = TYPE_ENEMY;

// Naming scheme for when multiple of a type are present
base_name = "enemy";
name = base_name;
name_scheme = NAME_SEQUENCE;
name_choices = ds_list_create();
ds_list_add(name_choices,"A", "B", "C", "D", "E");
suffix = -1;

// Moveset
moveset = ds_list_create();
ds_list_add(moveset, scr_act_null);

// Drops
xp = 1;
gold = 1;
drops = ds_list_create();
for (var i=0; i<100; i++) drops[|i] = ITEM_NONE;
drops_total_chance = 0;

// Other enemy properties
defeated = false;

// Sprites
has_generated_sprites = true;
generated_sprite_h = random_range(0.0,1.0);
generated_sprite_s = random_range(0.8,1.2);
generated_sprite_v = 1.0;
generated_sprite = scr_generate_random_sprite(sprite_index, generated_sprite_h, generated_sprite_s, generated_sprite_v);
sprite_index = generated_sprite;


