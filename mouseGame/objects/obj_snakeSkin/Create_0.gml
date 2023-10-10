var fix=physics_fixture_create();
var w=obj_snake.sWidth;
if(obj_snake.currentLength==0){
	w=obj_snake.hWidth;	
}
//physics_fixture_set_box_shape(fix,obj_snake.bHeight/2,w/2);
physics_fixture_set_polygon_shape(fix);
if(top){
	physics_fixture_add_point(fix,-obj_snake.bHeight/2,w/2);
	physics_fixture_add_point(fix,-obj_snake.bHeight/2,-w/2);
	physics_fixture_add_point(fix,obj_snake.bHeight/2,w/2);
}else{
	physics_fixture_add_point(fix,-obj_snake.bHeight/2,-w/2);
	physics_fixture_add_point(fix,obj_snake.bHeight/2,-w/2);
	physics_fixture_add_point(fix,-obj_snake.bHeight/2,w/2);
}
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind(fix,id);
physics_fixture_delete(fix);

