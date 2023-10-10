var fix = physics_fixture_create();
physics_fixture_set_box_shape(fix, sprite_width / 2, sprite_height / 2);
physics_fixture_set_density(fix, 0);
physics_fixture_set_restitution(fix, 0.1);
physics_fixture_set_friction(fix, 0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind(fix, id);
physics_fixture_delete(fix);
