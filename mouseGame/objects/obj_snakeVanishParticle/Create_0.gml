/// @description Insert description here
// You can write your code in this editor
lifeTime=0.7;
life=0;
image_angle=random_range(0,360);
vx=random_range(-10,10);
vy=random_range(-10,10);

var fix = physics_fixture_create();
physics_fixture_set_box_shape(fix,3,3);
physics_fixture_set_density(fix, 0.8);
physics_fixture_set_restitution(fix, 0.1);
physics_fixture_set_friction(fix, 0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_set_linear_damping(fix,20);
physics_fixture_bind(fix, id);
physics_fixture_delete(fix);