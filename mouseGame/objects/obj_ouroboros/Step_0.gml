/// @description Insert description here
// You can write your code in this editor

inside=false;
bodiesInside=0;
touching=false;



var o=id;
var bodiesInside=0;

with(obj_snakeBody){
	if(place_meeting(x,y,o)){
		o.touching=true;
		bodiesInside++;
	}
}

if(place_meeting(x,y,obj_snake)){
	touching=true;
	bodiesInside++;
}else{
	bodiesInside=0;
}

if(bodiesInside>=1){
	inside=true;
}

if(touching && !finishedGoingUp){
	if(image_alpha<0.5){
		image_alpha=lerp(image_alpha,0.5,0.01);	
	}
}else{
	image_alpha=lerp(image_alpha,0.25,0.1);	
}

if(!touching){
	finishedGoingUp=false;
	buffer=2;	
}

if(inside && obj_snake.ouroborosMode && !finishedGoingUp){
	insideCounter+=delta_time/1000000;
}else{
	insideCounter-=2*delta_time/1000000;
}

insideCounter=clamp(insideCounter,0,timeToEnd);

if(bodiesInside<minBodies && inside){
	insideCounter=clamp(insideCounter,0,timeToComplete*bodiesInside/minBodies);
	if(obj_snake.bLength<minBodies && insideCounter>=timeToComplete*bodiesInside/minBodies){
		buffer-=delta_time/1000000;
		if(buffer<=0){
			finishedGoingUp=true;
		}
	}
}		

var c=clamp(insideCounter,0,timeToComplete);

image_alpha=image_alpha+c*0.5/timeToComplete;
image_index=(sprite_get_number(sprite_index)-1)*c/timeToComplete;

if(insideCounter>=timeToComplete){
	obj_snake.screenShake=(insideCounter-timeToComplete)/2;
	obj_snake.shakeIntensity=5*(insideCounter-timeToComplete)/(timeToEnd-timeToComplete)
	audio_sound_gain(sound,(insideCounter-timeToComplete)/(timeToEnd-timeToComplete),0)
	audio_sound_gain(obj_gm.music,1-(insideCounter-timeToComplete)/(timeToEnd-timeToComplete),0)
	if(insideCounter>=timeToEnd){
		game_end();
	}		
}else{
	audio_sound_gain(obj_gm.music,1,0)
}


prevInside=inside;

