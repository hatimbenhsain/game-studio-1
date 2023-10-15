/// @description Insert description here
// You can write your code in this editor
if(distance_to_object(obj_snake)<rad){
	with(obj_snake){
		physics_apply_force(x,y,-phy_linear_velocity_x*modifier,-phy_linear_velocity_y*modifier);
	}
}
