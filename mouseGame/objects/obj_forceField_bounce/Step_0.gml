/// @description Insert description here
// You can write your code in this editor
inside=false;

rad2=rad2+rad*delta_time/(1000000*time);
if(rad2>rad){
	rad2=0;	
}

var closestBody=-1;
var d=rad*2;
var ff=id;

with(obj_snakeBody){
	var d2=distance_to_point(ff.x,ff.y);
	if(d2<d){
		closestBody=id;
		d=d2;
	}
}
var hitHead=false;
with(obj_snake){
	var d2=distance_to_point(ff.x,ff.y);
	if(d2<d){
		closestBody=id;
		d=d2;
		hitHead=true;
	}
}

if(d<rad){
	inside=true;	
}

if(d<rad2){
	show_debug_message(d);
	var xx=x;
	var yy=y;
	var m=modifier;
	with(closestBody){
		var dir=point_direction(xx,yy,x,y);
		physics_apply_impulse(x,y,lengthdir_x(m,dir),lengthdir_y(m,dir));
	}	
	with(obj_snake){
		if(hitHead){
			stunLength=0.5;
			stunLength2=stunLength+0.5;
		}
		screenShake=0.3;
		shakeIntensity=6;
	}
	audio_play_sound(sounds[floor(random(array_length(sounds)))],1,false,1);
}
