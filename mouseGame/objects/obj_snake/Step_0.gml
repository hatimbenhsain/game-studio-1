delta_mouse_x = mouse_x - mouse_x_previous
delta_mouse_y = mouse_y - mouse_y_previous
delta_mouse=(delta_mouse_x^2+delta_mouse_y^2)^0.5

atePebbleCounter-=delta_time/1000000;
atePebbleCounter=clamp(atePebbleCounter,0,2);

if(delta_mouse>40 && (sign(delta_mouse_x)!=sign(delta_mouse_x_previous) || sign(delta_mouse_y)!=sign(delta_mouse_y_previous))){
	shakeCounter+=1	
	shakeTime=shakeMaxTime;
}


var l=((mouse_x-x)^2+(mouse_y-y)^2)^0.5;
var xx=(mouse_x-x)/(l*100);
var yy=(mouse_y-y)/(l*100);

//physics_apply_impulse(x+xx,y+yy,x,y);

var dir = point_direction(x, y,mouse_x, mouse_y);
var dist=abs(distance_to_point(mouse_x,mouse_y));
var f=1;

if(dist<=16){
	f=dist/16
}

if(stunLength>0){
	f=0;	
	image_index=18;
}else if(stunLength2>0){
	f=f*1-stunLength2;	
}

if(alive){
	f=f*spawnCounter/2;
	physics_apply_impulse(x, y, lengthdir_x(moveSpeed*f*60/(max(fps,30)), dir), lengthdir_y(moveSpeed*f*60/(max(fps,30)), dir));

	//if(abs(distance_to_point(mouse_x,mouse_y))<=1){
	//	physics_apply_force(x, y,(x-phy_linear_velocity_x)*0.01,(y-phy_linear_velocity_y)*0.01);
	//}

	var turnRate=100/room_speed;
	var ad=angle_difference(-dir,phy_rotation);
	phy_rotation=lerp(phy_rotation,phy_rotation+ad,0.05);
}
//}else{
//	physics_apply_impulse(x, y,y-phy_linear_velocity_x,y-phy_linear_velocity_y);

var sn=id;

with(obj_mouse){
	beingEaten=false;	
}

var wasEating=eating;
eating=false;

if(!ouroborosMode && alive){
	var inst=instance_place(x,y,obj_mouse)
	if(inst!=noone){
		with(inst){
			beingEaten=true;
			eatenCounter+=delta_time/1000000;
			obj_snake.eating=true;
		}
	}
	if(eating==false){
		var inst=instance_place(x,y,obj_pebble)
		if(inst!=noone){
			instance_destroy(inst);
			pebblesAte+=1;
			atePebbleCounter=0.5;
			audio_play_sound(eatingSounds2[floor(random(2))],1,false,1);
			if(pebblesAte>=pebblesToGrow){
				ateCounter=0;
				pebblesAte=0;
			}
		}
	}
	if(eating){
		if(eatingSound==-1 || !audio_is_playing(eatingSound)){
			eatingSound=audio_play_sound(eatingSounds[floor(random_range(0,array_length(eatingSounds)))],1,false,1);	
		}
	}else if(wasEating){
		//audio_stop_sound(eatingSound);
		audio_sound_gain(eatingSound,0,250)
	}
	
	if(audio_sound_get_gain(eatingSound)==0){
		audio_stop_sound(eatingSound);	
	}
}

if(ateCounter>-1){
	ateCounter+=delta_time/1000000
	if(ateCounter>=bellySpeed*bLength){
		shakeIntensity=1;
		screenShake=0.2;
		ateCounter=-1;	
		var b=addBody(bodies[array_length(bodies)-1],difX);	
		bLength+=1;
		currentLength+=1
		skins=array_concat(skinsA,array_reverse(skinsB));
		audio_play_sound(snd_pop,1,false,1);
	}
}

var b=bodies[array_length(bodies)-1];
if(ateCounter==-1 && place_meeting(x,y,b) && !ouroborosDeleted && !ouroborosMode){
	var a=angle_difference(b.image_angle,image_angle);
	a=0;
	ouroborosJoint=physics_joint_revolute_create(id,b,x,y,a-90,a+90,true,0,0,false,true);
	ouroborosMode=true;
}else if(!place_meeting(x,y,b) && !ouroborosMode){
	ouroborosDeleted=false;
}

if(ouroborosMode && shakeCounter>=3){
	physics_joint_delete(ouroborosJoint);
	ouroborosDeleted=true;
	ouroborosMode=false;
}

shakeTime-=delta_time/1000000
shakeTime=clamp(shakeTime,0,shakeMaxTime);
if(shakeTime<=0){
	shakeTime=0;	
	shakeCounter=0;
}

//respawning
if(respawn && ateCounter==-1){
	var bl=bLength;
	respawn=false;
	instance_create_layer(x,y,layer,obj_snakeVanishParticle);
	with(obj_snakeSkin){
		instance_destroy(self);	
	}
	with(obj_snakeBody){
		instance_create_layer(x,y,layer,obj_snakeVanishParticle);
		instance_destroy(self);	
	}
	screenShake=0.3;
	shakeIntensity=6;
	obj_gm.respawnCounter=0;
	obj_gm.snakeInfo={x:initX,y:initY,bLength:bl};
	alive=false;
	audio_play_sound(snd_death,1,false,1);
}


mouse_x_previous = mouse_x
mouse_y_previous = mouse_y
delta_mouse_x_previous=delta_mouse_x;
delta_mouse_y_previous=delta_mouse_y;

if(spawnCounter<2){
	spawnCounter+=delta_time/1000000;
}

stunLength-=delta_time/1000000;
stunLength2-=delta_time/1000000;

stunLength=clamp(stunLength,0,10);
stunLength2=clamp(stunLength2,0,10);

if(screenShake>0){
	screenShake-=delta_time/1000000;
	screenShake=clamp(screenShake,0,10);
}

var camW=camera_get_view_width(view_camera[0]);
var camH=camera_get_view_height(view_camera[0]);
var camX=camera_get_view_x(view_camera[0]);
var camY=camera_get_view_y(view_camera[0]);
var l=0.005;
var dx=abs(x-(camX+camW/2));
var dy=abs(y-(camY+camH/2));
var d=(dx+dy*2)/3
if(d>200 && alive){
	tCamX=x-camW/2;
	tCamY=y-camH/2;
	if(d>400){
		l=0.01;
	}
	if(d>600){
		l=0.05;	
	}
	//l=l+(clamp(d,400,600)-400)*0.05/200;
	if(spawnCounter<2){
		l+=0.02*(2-spawnCounter)/2;
	}
}
l=l*60/(max(fps,30));
camX=lerp(camX+camW/2,tCamX+camW/2,l)-camW/2;
camY=lerp(camY+camH/2,tCamY+camH/2,l)-camH/2;

if(screenShake>0){
	camX+=random_range(-shakeIntensity,shakeIntensity);
	camY+=random_range(-shakeIntensity,shakeIntensity);
}

camera_set_view_pos(view_camera[0],camX,camY);

//if(distance_to_point(camX+camW/2,camY+camH/2)>200){
//	camera_set_view_pos(view_camera[0],lerp(camX+camW/2,x,l)-camW/2,lerp(camY+camH/2,y,l)-camH/2);
//}