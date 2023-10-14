/// @description Insert description here
// You can write your code in this editor

counter+=delta_time/1000000


if(respawnCounter>-0.8){
	respawnCounter+=delta_time/1000000;
	if(respawnCounter>=1){
		with(obj_snake){
			instance_destroy(id);	
		}
		instance_create_layer(snakeInfo.x,snakeInfo.y,layer,obj_snake,{bLength:snakeInfo.bLength});	
		respawnCounter=-1;
	}
}