//physics_draw_debug();
//draw_self();
draw_set_color(c_white);
draw_set_alpha(1);
//draw_line(x-sprite_width/2,y-sprite_height/2,x-sprite_width/2,y+sprite_height/2);
//draw_line(x-sprite_width/2,y-sprite_height/2,x+sprite_width/2,y-sprite_height/2);
//draw_line(x+sprite_width/2,y-sprite_height/2,x+sprite_width/2,y+sprite_height/2);
//draw_line(x-sprite_width/2,y+sprite_height/2,x+sprite_width/2,y+sprite_height/2);

for(var yy=0;yy<sprite_height;yy++){
	var inst=instance_position(x+sprite_width/2,y-sprite_height/2+yy,obj_wall);
	if(inst==noone || inst==id){
		draw_set_color(c_white);
		draw_point(x+sprite_width/2,y-sprite_height/2+yy);
	}
	inst=instance_position(x-sprite_width/2-1,y-sprite_height/2+yy,obj_wall);
	if(inst==noone || inst==id){
		draw_set_color(c_white);
		draw_point(x-sprite_width/2,y-sprite_height/2+yy);
	}	
}

for(var xx=0;xx<sprite_width;xx++){
	var inst=instance_position(x-sprite_width/2+xx,y-sprite_height/2-1,obj_wall);
	if(inst==noone || inst==id){
		draw_set_color(c_white);
		draw_point(x-sprite_width/2+xx,y-sprite_height/2);
	}
	inst=instance_position(x-sprite_width/2+xx,y+sprite_height/2+1,obj_wall);
	if(inst==noone || inst==id){
		draw_set_color(c_white);
		draw_point(x-sprite_width/2+xx,y+sprite_height/2);
	}	
}