/// @description Insert description here
// You can write your code in this editor
fix=physics_fixture_create();
physics_fixture_set_box_shape(fix,25/2,17/2);
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,4);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind_ext(fix,id,0,0);
physics_fixture_delete(fix);

eatenCounter=0;
eatenMaxTime=0.6;
beingEaten=false;

currentState="idle";
counter=0;
prevCounter=counter;
targetX=x;
targetY=y;

initialX=x;
initialY=y;

moveSpeed=2;

targetAngle=phy_rotation;