/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_white);
var f=0;
if(inside){
	f=0.25
}
draw_set_alpha(0.25+f);
draw_circle(x,y,rad,true);
draw_set_alpha(0.5+f);
draw_circle(x,y,rad2,true);
draw_set_alpha(1);
