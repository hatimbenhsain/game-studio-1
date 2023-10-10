/// @description Insert description here
// You can write your code in this editor

if(beingEaten==false){
	eatenCounter-=delta_time/1000000;
}

eatenCounter=clamp(eatenCounter,0,eatenMaxTime);

if(eatenCounter>=eatenMaxTime){
	instance_destroy(id);
	show_debug_message(eatenCounter);	
}else if(eatenCounter>0){
	show_debug_message(eatenCounter);	
}