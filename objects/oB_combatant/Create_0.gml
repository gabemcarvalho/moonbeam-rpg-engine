/// @description Initialize a Combatant
// This object is a parent to both party members and enemies in battle
// Define all stats and variables common to party members and enemies
// Base Stats
max_hp = 100;
hp = max_hp;
max_mp = 100;
mp = max_mp;
atk = 5;
def = 5;
mag_atk = 5;
mag_def = 5;
luck = 5; // not currently implemented
spd = 5;
turn_spd = -1; // This is set every turn based on several factors, and used to determine turn order
next_turn_spd = -1;
next_turn_2_spd = -1;

// Stat multipliers and their respective turn counters
atk_multiplier = 1.0;
atk_multiplier_turns = 0;
def_multiplier = 1.0;
def_multiplier_turns = 0;
mag_atk_multiplier = 1.0;
mag_atk_multiplier_turns = 0;
mag_def_multiplier = 1.0;
mag_def_multiplier_turns = 0;
spd_multiplier = 1.0;
spd_multiplier_turns = 0;

// Turn order priority (higher means faster)
priority = 0;

// Moves
turn_action = scr_act_null;
target = noone;
defending = false;

// Status Afflictions (still not sure how I'm going to handle these)
poisoned = false;
poisoned_turns = 0;
burned = false;
burned_turns = 0;

// Info
small_icon = s_chara_icon_small;
name = "NAME_ERROR";

// Visual Effect
shake_amount = 0;
shake_duration = 0;