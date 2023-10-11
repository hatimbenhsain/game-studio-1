/// @description Insert description here
// You can write your code in this editor
radius=20;
barLength=80;
barWidth=10;

var fix=physics_fixture_create();
physics_fixture_set_circle_shape(fix,radius)
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind(fix,id);
physics_fixture_delete(fix);

fix=physics_fixture_create();
physics_fixture_set_box_shape(fix,barWidth/2,barLength/2);
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind_ext(fix,id,0,-radius*2);
physics_fixture_delete(fix);

fix=physics_fixture_create();
physics_fixture_set_box_shape(fix,barWidth/2,barLength/2);
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind_ext(fix,id,0,radius*2);
physics_fixture_delete(fix);

fix=physics_fixture_create();
physics_fixture_set_box_shape(fix,barLength/2,barWidth/2);
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind_ext(fix,id,-radius*2,0);
physics_fixture_delete(fix);

fix=physics_fixture_create();
physics_fixture_set_box_shape(fix,barLength/2,barWidth/2);
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind_ext(fix,id,radius*2,0);
physics_fixture_delete(fix);

joint=physics_joint_revolute_create(obj_wall,id,x,y,0,0,false,0,0,false,false);