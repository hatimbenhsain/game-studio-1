/// @description Insert description here
// You can write your code in this editor



// Inherit the parent event
event_inherited();

var tempRotation=image_angle;
image_angle=0;
phy_rotation=0;

var inst=-1;
var minD=10000;
var wheel=id;

with(obj_door){
	if(!linked){
		var d=distance_to_object(wheel);
		if(d<minD){
			inst=id;
			minD=d;
		}
	}
}

if(inst!=-1){
	inst.linked=true;
	physics_joint_gear_create(id,inst,joint,inst.joint,0.5)
}

image_angle=tempRotation;
phy_rotation=-tempRotation;