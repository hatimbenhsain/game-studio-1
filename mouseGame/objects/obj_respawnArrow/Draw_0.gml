/// @description Insert description here
// You can write your code in this editor
if(!obj_snake.mouse1Alive){

	draw_sprite_ext(sprite_index,image_index,x-4,y,image_xscale,image_yscale,1,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x+2,y,image_xscale,image_yscale,1,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x,y-2,image_xscale,image_yscale,1,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x,y+2,image_xscale,image_yscale,1,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x-2,y-2,image_xscale,image_yscale,1,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x+2,y+2,image_xscale,image_yscale,1,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x-2,y+2,image_xscale,image_yscale,1,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x+2,y-2,image_xscale,image_yscale,1,c_black,image_alpha);
	draw_self();

	with(obj_ouroboros){
		if(insideCounter>=timeToComplete){
			var camW=camera_get_view_width(view_camera[0]);
			var camH=camera_get_view_height(view_camera[0]);
			var camX=camera_get_view_x(view_camera[0]);
			var camY=camera_get_view_y(view_camera[0]);
			draw_set_alpha((insideCounter-timeToComplete)/(timeToEnd/timeToComplete));
			draw_set_color(c_white);
			draw_rectangle(camX,camY,camX+camW,camY+camH,false);
			draw_set_alpha(1);
		}	
	}

	var rc=respawnCounter;
	var cx=camera_get_view_x(view_camera[0]);
	var cy=camera_get_view_y(view_camera[0]);
	var cw=camera_get_view_width(view_camera[0]);
	var ch=camera_get_view_height(view_camera[0]);

	if(rc>0.4 && rc<0.8){
		rc=rc-0.4
		draw_set_color(c_black);
		draw_rectangle(cx,cy,cx+cw*rc/(2*0.4),cy+ch/(2*0.4),false);	
		draw_rectangle(cx+cw-cw*rc/(2*0.4),cy-ch/(2*0.4),cx+cw,cy+ch,false);	
		draw_set_color(c_white);
		draw_rectangle(cx,cy,cx+cw*rc/(2*0.4),cy+ch/(2*0.4),true);	
		draw_rectangle(cx+cw-cw*rc/(2*0.4),cy-ch/(2*0.4),cx+cw,cy+ch,true);	
	}else if(rc>1 && rc<1.4){
		rc=0.4-(rc-1)
		draw_set_color(c_black);
		draw_rectangle(cx,cy,cx+cw*rc/(2*0.4),cy+ch/(2*0.4),false);	
		draw_rectangle(cx+cw-cw*rc/(2*0.4),cy-ch/(2*0.4),cx+cw,cy+ch,false);
		draw_set_color(c_white);
		draw_rectangle(cx,cy,cx+cw*rc/(2*0.4),cy+ch/(2*0.4),true);	
		draw_rectangle(cx+cw-cw*rc/(2*0.4),cy-ch/(2*0.4),cx+cw,cy+ch,true);
	}else if(rc>0.8 && rc<1.4){
		draw_set_color(c_black);
		draw_rectangle(cx,cy,cx+cw,cy+ch,false);	
	}
}

//draw_text(x+1000,y,fps);