/// @description Set up textbox
// Controls
key_a_pressed = false;
key_b_pressed = false;

// Positioning
width = 512;//576
height = 68;
x = (view_wport[0] - width) / 2;
y = view_hport[0] - height - 20;
text_buffer = 10;
text_width = width - 2 * text_buffer;
text_height = height - 2 * text_buffer;
line_height = 16;

// Graphics
font = f_textbox

// Icon
icon_size = 68;
icon = undefined;
icon_buffer = 0;

// Name
name = undefined;
name_colour = TEXT_COLOUR_DEFAULT;

// Text
text_next = true;

script = ds_list_create();

text = ds_list_create(); // The current message which is being scrolled

display_text = ds_list_create(); // The part of the message which is currently on screen
text_y = 0;

command_char = "^";
char_separation = 0;//1
space_width = 6;//6

text_place = 0;
scrolling_up = false;
scroll_up_speed = 1;//4
scroll_distance = 0;
text_done = false;
text_paused = false;

scroll_cooldown_max = 1;//1
scroll_cooldown = scroll_cooldown_max;

line_widths = ds_list_create();
scrolling_line = 0;
text_centred = false;

// Note: character data has the format [char, x, y, colour, effect]

// Close flags
increment_cutscene_on_close = false;

// Advance Indicator
scr_square_create();