/// @description Insert description here
// You can write your code in this editor
if((beingEaten && eatenCounter%0.3<=0.15) || (eatenCounter>0 && !beingEaten && eatenCounter%0.2<=0.1)){
	image_alpha=0.5
}
draw_self();
image_alpha=1;

//draw_rectangle(initialX-zoneW/2,initialY-zoneH/2,initialX+zoneW/2,initialY+zoneH/2,true)
//draw_point(targetX,targetY)