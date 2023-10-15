delta_mouse_x = mouse_x - mouse_x_previous
delta_mouse_y = mouse_y - mouse_y_previous
delta_mouse=(delta_mouse_x^2+delta_mouse_y^2)^0.5

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
	physics_apply_impulse(x, y, lengthdir_x(moveSpeed*f, dir), lengthdir_y(moveSpeed*f, dir));

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
			ateCounter=0;
		}
	}
}

if(ateCounter>-1){
	ateCounter+=delta_time/1000000
	if(ateCounter>=bellySpeed*bLength){
		ateCounter=-1;	
		var b=addBody(bodies[array_length(bodies)-1],difX);	
		bLength+=1;
		currentLength+=1
		skins=array_concat(skinsA,array_reverse(skinsB));
	}
}

var b=bodies[array_length(bodies)-1];
if(ateCounter==-1 && place_meeting(x,y,b) && !ouroborosDeleted && !ouroborosMode){
	var a=angle_difference(b.image_angle,image_angle);
	a=0;
	ouroborosJoint=physics_joint_revolute_create(id,b,x,y,a-90,a+90,true,0,0,false,false);
	ouroborosMode=true;
}else if(!place_meeting(x,y,b) && !ouroborosMode){
	ouroborosDeleted=false;
}

if(ouroborosMode && shakeCounter>=5){
	physics_joint_delete(ouroborosJoint);
	ouroborosDeleted=true;
	ouroborosMode=false;
}

shakeTime-=delta_time/1000000
shakeTime=clamp(shakeTime,0,shakeMaxTime);
if(shakeTime<=0){
	shakeCounter=0;	
}

//respawning
if(mouse_check_button_pressed(mb_left) && ateCounter==-1){
	var bl=bLength;
	instance_create_layer(x,y,layer,obj_snakeVanishParticle);
	with(obj_snakeSkin){
		instance_destroy(self);	
	}
	with(obj_snakeBody){
		instance_create_layer(x,y,layer,obj_snakeVanishParticle);
		instance_destroy(self);	
	}
	obj_gm.respawnCounter=0;
	obj_gm.snakeInfo={x:initX,y:initY,bLength:bl};
	alive=false;
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