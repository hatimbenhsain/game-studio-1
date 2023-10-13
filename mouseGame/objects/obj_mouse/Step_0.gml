/// @description Insert description here
// You can write your code in this editor

if(beingEaten==false){
	eatenCounter-=delta_time/4000000;
}

eatenCounter=clamp(eatenCounter,0,eatenMaxTime);

if(eatenCounter>=eatenMaxTime){
	obj_snake.ateCounter=0;
	instance_destroy(id);
}else if(eatenCounter>0){
}

counter+=delta_time/1000000;

if(beingEaten){
	currentState="fleeing";
}

switch(currentState){
	case "idle":
		if(counter>=2){
			targetX=initialX+random_range(-zoneW/2,zoneW/2);
			targetY=initialY+random_range(-zoneH/2,zoneH/2);
			currentState="roaming";
			counter=0;
		}
		break;
	case "roaming":
		var dir=point_direction(x,y,targetX,targetY);
		var turnRate=100/room_speed;
		var ad=angle_difference(-dir,phy_rotation);
		phy_rotation=lerp(phy_rotation,phy_rotation+ad,0.1);
		var f=1;
		physics_apply_impulse(x,y,lengthdir_x(moveSpeed*f,dir),lengthdir_y(moveSpeed*f,dir));
		if(distance_to_point(targetX,targetY)<=5 || counter>=5){
			counter=0;
			currentState="idle";
		}
		
		break;
	case "fleeing":
		var dir=point_direction(obj_snake.x,obj_snake.y,x,y);
		var turnRate=100/room_speed;
		var ad=angle_difference(-dir,phy_rotation);
		phy_rotation=lerp(phy_rotation,phy_rotation+ad,0.1);
		var f=1;
		physics_apply_impulse(x,y,lengthdir_x(moveSpeed*f,dir),lengthdir_y(moveSpeed*f,dir));
		if(distance_to_object(obj_snake)>=400){
			currentState="vigilant";
			counter=0;
		}
		break;
	case "vigilant":
		if(counter>=8){
			currentState="idle";
			counter=0;
		}else if(counter%2<prevCounter%2){
			targetAngle=phy_rotation+random_range(90,270);
			show_debug_message("change angle");
		}
		phy_rotation=lerp(phy_rotation,targetAngle,0.1);
		break;
}

prevCounter=counter;