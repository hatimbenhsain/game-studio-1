/// @description Insert description here
// You can write your code in this editor
if(!active && distance_to_object(obj_snake)<=0){
	with(obj_checkpoint){
		active=false;
		image_alpha=0.5;
	}
	active=true;	
	image_alpha=1;
	obj_snake.initX=x;
	obj_snake.initY=y;
}

if(active){
	image_index=1;	
}else{
	image_index=0;
}