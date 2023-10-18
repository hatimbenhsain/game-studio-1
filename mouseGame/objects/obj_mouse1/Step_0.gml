/// @description Insert description here
// You can write your code in this editor

if(beingEaten==false){
	eatenCounter-=delta_time/4000000;
}

eatenCounter=clamp(eatenCounter,0,eatenMaxTime);

if(eatenCounter>=eatenMaxTime){
	obj_snake.ateCounter=0;
	obj_snake.mouse1Alive=false;
	instance_destroy(id);
}else if(eatenCounter>0){
}

counter+=delta_time/1000000;

if(beingEaten){
	currentState="fleeing";
}


prevCounter=counter;

camera_set_view_pos(view_camera[0],x-60,y-34);