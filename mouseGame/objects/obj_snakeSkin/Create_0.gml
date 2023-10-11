var fix=physics_fixture_create();
w=obj_snake.sWidth;
if(obj_snake.currentLength==0){
	w=obj_snake.hWidth;	
}
//physics_fixture_set_box_shape(fix,obj_snake.bHeight/2,w/2);
physics_fixture_set_polygon_shape(fix);
if(top){
	physics_fixture_add_point(fix,-obj_snake.bHeight/2,w/2);
	physics_fixture_add_point(fix,-obj_snake.bHeight/2,-w/2);
	physics_fixture_add_point(fix,obj_snake.bHeight/2,w/2);
	disY=-w/2;
	disX=-obj_snake.bHeight/2;
	disY2=w/2;
	disX2=obj_snake.bHeight/2;
}else{
	physics_fixture_add_point(fix,-obj_snake.bHeight/2,-w/2);
	physics_fixture_add_point(fix,obj_snake.bHeight/2,-w/2);
	physics_fixture_add_point(fix,-obj_snake.bHeight/2,w/2);
	disY=w/2;
	disX=-obj_snake.bHeight/2;
	disY2=-w/2;
	disX2=obj_snake.bHeight/2;
}
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind(fix,id);
physics_fixture_delete(fix);

ang=arctan2(disY,disX);
d=distance_to_point(disX+x,disY+y);

fakeAng=arctan2(disY*3,disX);
fakeD=distance_to_point(disX+x,disY*3+y);

fakeAng2=arctan2(disY*2.5,disX);
fakeD2=distance_to_point(disX+x,disY*2.5+y);

ang2=arctan2(disY2,disX2);
d2=distance_to_point(disX2+x,disY2+y);
show_debug_message(ang2);
ang2=ang2