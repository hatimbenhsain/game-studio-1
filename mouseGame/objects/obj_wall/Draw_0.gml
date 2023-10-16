//physics_draw_debug();
//draw_self();
draw_set_color(c_black);
draw_rectangle(x-sprite_width/2,y-sprite_height/2,x+sprite_width/2,y+sprite_height/2,false);

draw_set_color(c_white);
draw_set_alpha(1);
//draw_line(x-sprite_width/2,y-sprite_height/2,x-sprite_width/2,y+sprite_height/2);
//draw_line(x-sprite_width/2,y-sprite_height/2,x+sprite_width/2,y-sprite_height/2);
//draw_line(x+sprite_width/2,y-sprite_height/2,x+sprite_width/2,y+sprite_height/2);
//draw_line(x-sprite_width/2,y+sprite_height/2,x+sprite_width/2,y+sprite_height/2);

var camW=camera_get_view_width(view_camera[0]);
var camH=camera_get_view_height(view_camera[0]);
var camX=camera_get_view_x(view_camera[0]);
var camY=camera_get_view_y(view_camera[0]);

//edges1=[];
//edges2=[];

//for(var yy=0;yy<sprite_height;yy++){
//	if(y-sprite_height/2+yy<camY){
//		continue;	
//	}else if(y-sprite_height/2+yy>camY+camH){
//		break;	
//	}
//	if(x+sprite_width/2>camX+camW || x+sprite_width/2<camX){
		
//	}else{
//		var inst=instance_position(x+sprite_width/2,y-sprite_height/2+yy,obj_wall);
//			if(inst==noone || inst==id){
//			draw_set_color(c_white);
//			draw_point(x+sprite_width/2,y-sprite_height/2+yy);
//		}
//	}
//	if(x-sprite_width/2>camX+camW || x-sprite_width/2<camX){
		
//	}else{
//		var inst=instance_position(x-sprite_width/2-1,y-sprite_height/2+yy,obj_wall);
//		if(inst==noone || inst==id){
//			draw_set_color(c_white);
//			draw_point(x-sprite_width/2,y-sprite_height/2+yy);
//		}	
//	}
	
//}

//for(var xx=0;xx<sprite_width;xx++){
//	if(x-sprite_width/2+xx<camX){
//		continue;	
//	}else if(x-sprite_width/2+xx>camX+camW){
//		break;	
//	}
//	if(y-sprite_height/2<camY || y-sprite_height/2>camY+camH){
		
//	}else{
//		var inst=instance_position(x-sprite_width/2+xx,y-sprite_height/2-1,obj_wall);
//		if(inst==noone || inst==id){
//			draw_set_color(c_white);
//			draw_point(x-sprite_width/2+xx,y-sprite_height/2);
//		}
//	}
//	if(y+sprite_height/2<camY || y+sprite_height/2>camY+camH){
		
//	}else{
//		var inst=instance_position(x-sprite_width/2+xx,y+sprite_height/2+1,obj_wall);
//		if(inst==noone || inst==id){
//			draw_set_color(c_white);
//			draw_point(x-sprite_width/2+xx,y+sprite_height/2);
//		}	
//	}
//}

//physics_draw_debug();

draw_self();