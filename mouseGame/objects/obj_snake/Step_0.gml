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

physics_apply_impulse(x, y, lengthdir_x(moveSpeed*f, dir), lengthdir_y(moveSpeed*f, dir));

//if(abs(distance_to_point(mouse_x,mouse_y))<=1){
//	physics_apply_force(x, y,(x-phy_linear_velocity_x)*0.01,(y-phy_linear_velocity_y)*0.01);
//}

var turnRate=100/room_speed;
var ad=angle_difference(-dir,phy_rotation);
phy_rotation=lerp(phy_rotation,phy_rotation+ad,0.05);
//}else{
//	physics_apply_impulse(x, y,y-phy_linear_velocity_x,y-phy_linear_velocity_y);

var sn=id;

with(obj_mouse){
	beingEaten=false;	
}
eating=false;

var inst=instance_place(x,y,obj_mouse)
if(inst!=noone){
	with(inst){
		beingEaten=true;
		eatenCounter+=delta_time/1000000;
		obj_snake.eating=true;
	}
}
