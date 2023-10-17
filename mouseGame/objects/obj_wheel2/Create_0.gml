/// @description Insert description here
// You can write your code in this editor



// Inherit the parent event
event_inherited();

var tempRotation=image_angle;
image_angle=0;
phy_rotation=0;

barLength2=50;

fix=physics_fixture_create();
physics_fixture_set_box_shape(fix,barLength2/2,barWidth/2);
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind_ext(fix,id,0,barLength);
physics_fixture_delete(fix);

fix=physics_fixture_create();
physics_fixture_set_box_shape(fix,barLength2/2,barWidth/2);
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind_ext(fix,id,0,-barLength);
physics_fixture_delete(fix);

fix=physics_fixture_create();
physics_fixture_set_box_shape(fix,barWidth/2,barLength2/2);
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind_ext(fix,id,barLength,0);
physics_fixture_delete(fix);

fix=physics_fixture_create();
physics_fixture_set_box_shape(fix,barWidth/2,barLength2/2);
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind_ext(fix,id,-barLength,0);
physics_fixture_delete(fix);

image_angle=tempRotation;
phy_rotation=-tempRotation;