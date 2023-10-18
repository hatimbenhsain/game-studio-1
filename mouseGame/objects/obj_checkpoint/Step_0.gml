/// @description Insert description here
// You can write your code in this editor
if(!active && distance_to_object(obj_snake)<=0){
	with(obj_checkpoint){
		active=false;
		image_alpha=0.5;
	}
	active=true;	
	audio_play_sound(snd_startup,1,false,1);
	image_alpha=1;
	obj_snake.initX=x;
	obj_snake.initY=y;
	sprite_index=spr_checkpoint_turningOn;
	image_index=0;
}

if(active){
	if(sprite_index==spr_checkpoint){
		image_index=1;	
	}else if(image_index>=sprite_get_number(sprite_index)-2){
		sprite_index=spr_checkpoint;
	}
}else{
	image_index=0;
}