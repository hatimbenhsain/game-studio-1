/// @description Insert description here
// You can write your code in this editor
if(!obj_snake.mouse1Alive){
	x=initX+camera_get_view_x(view_camera[0]);
	y=initY+camera_get_view_y(view_camera[0]);

	if(position_meeting(mouse_x,mouse_y,self)){
		hovered=true;	
	}else{
		hovered=false;	
		respawned=false;
		image_alpha=1;
	}

	if(hovered && !respawned){
		hoverCounter+=delta_time/1000000;	
	}else{
		hoverCounter-=delta_time/1000000;
	}

	if(hoverCounter>=timeToRespawn && !respawned){
		respawned=true;
		obj_snake.respawn=true;
		image_alpha=0.5;
	}

	hoverCounter=clamp(hoverCounter,0,timeToRespawn);

	image_index=hoverCounter*sprite_get_number(sprite_index)/timeToRespawn;

	if(respawnCounter!=-1){
		respawnCounter+=delta_time/1000000;
		if (respawnCounter>1.4){
			respawnCounter=-1;	
		}
	}
}