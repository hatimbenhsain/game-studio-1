var fix=physics_fixture_create();
physics_fixture_set_circle_shape(fix,sprite_width/2);
physics_fixture_set_density(fix,0);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind(fix,id);
physics_fixture_delete(fix);