/// @description Insert description here
// You can write your code in this editor
life+=delta_time/1000000

image_angle+=delta_time*280/1000000;
image_xscale=0.1+0.7*(lifeTime-life)/lifeTime;
image_yscale=image_xscale;

if(life>=lifeTime){
	instance_destroy(self);	
}
//x+=vx;
//y+=vy;

physics_apply_impulse(x,y,vx,vy);

vx=vx*0.93;
vy=vy*0.93;