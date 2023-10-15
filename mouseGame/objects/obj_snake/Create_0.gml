moveSpeed=15;
bWidth=10;	//body width
bHeight=16;	//body height
sWidth=10;	//skin width
ateCounter=-1;
bellySpeed=0.1;
difX=5;

eating=false;

hWidth=7; //head width

initX=x;
initY=y;

x=initX+(bLength*(bHeight+difX)-difX)/2;

show_debug_message("depth");
show_debug_message(depth);

depth=-1;

var fix=physics_fixture_create();
physics_fixture_set_box_shape(fix,bHeight/2,hWidth/2,);
physics_fixture_set_density(fix,0.8);
physics_fixture_set_restitution(fix,0.1);
physics_fixture_set_linear_damping(fix,0.6);
physics_fixture_set_angular_damping(fix,0.6);
physics_fixture_set_friction(fix,0.2);
physics_fixture_set_collision_group(fix,1);
physics_fixture_bind(fix,id);
physics_fixture_delete(fix);



currentLength=0

skinsA=[];
skinsB=[];

bodies=[];

alive=true;

function addBody(instA,diff){	
	var a=degtorad(instA.phy_rotation);
	var b=instance_create_layer(instA.x-(bHeight+diff)*cos(a),instA.y-(bHeight+diff)*sin(a),instA.layer,obj_snakeBody);
	b.snakeParent=instA;
	b.phy_rotation=instA.phy_rotation;
	physics_joint_revolute_create(instA,b,instA.x-(bHeight+diff)*cos(a)/2,instA.y-(bHeight+diff)*sin(a)/2,0,0,false,100,50,false,true);
	b.phy_rotation=0;
	addSkin(b,bWidth);
	b.phy_rotation=instA.phy_rotation;
	array_push(bodies,b);
	return b;
}

function addSkin(instA,w){
	var s=instance_create_layer(instA.x,instA.y+10,instA.layer,obj_snakeSkin,{top:false});
	s.snakeParent=instA;
	var f=10;	//frequency
	var d=12;	//damping
	var maxMotorForce=200;
	var motorSpeed=2;
	physics_joint_prismatic_create(instA,s,instA.x,instA.y,0,10,-w,0,true,maxMotorForce,motorSpeed,true,false);
	array_push(skinsA,s);
	s=instance_create_layer(instA.x,instA.y,instA.layer,obj_snakeSkin,{top:true});
	s.snakeParent=instA;
	physics_joint_prismatic_create(instA,s,instA.x,instA.y,0,-10,0,w,true,maxMotorForce,motorSpeed,true,false);
	array_push(skinsB,s);
}

ouroborosMode=false;
ouroborosJoint=-1;
ouroborosDeleted=false;



var b=id;


addSkin(b,hWidth);
currentLength+=1

for(i=0;i<bLength;i++){
	b=addBody(b,difX);	
	currentLength+=1
}

skins=array_concat(skinsA,array_reverse(skinsB));

mouse_x_previous=mouse_x;
mouse_y_previous=mouse_y;
delta_mouse_x_previous=0;
delta_mouse_y_previous=0;

shakeCounter=0;
shakeTime=0;
shakeMaxTime=0.5;



spawnCounter=0;

stunLength=0;
stunLength2=0;

respawn=false;