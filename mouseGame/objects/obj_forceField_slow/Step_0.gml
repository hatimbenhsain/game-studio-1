/// @description Insert description here
// You can write your code in this editor
var m=modifier
var ff=id;

inside=false;
	
with(obj_snake){
	if(distance_to_point(ff.x,ff.y)<ff.rad){
		physics_apply_force(x,y,-phy_linear_velocity_x*m,-phy_linear_velocity_y*m);
		ff.inside=true;
	}
}
