/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_white);
draw_set_alpha(0.25);
if(distance_to_object(obj_snake)<rad){
	draw_set_alpha(0.5);
}
draw_circle(x,y,rad,true);
draw_set_alpha(1);
