/// @description Control the numbers
x += xspd;
y += yspd;

life--;
if life <= 0 instance_destroy();

alpha = sqrt(life/max_life);