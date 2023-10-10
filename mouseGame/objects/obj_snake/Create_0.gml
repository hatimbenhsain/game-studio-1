moveSpeed=15;
bWidth=10;	//body width
bHeight=16;	//body height
bLength=20;	//body length
sWidth=10;	//skin width

hWidth=7; //head width

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

var difX=5;

currentLength=0

skinsA=[];
skinsB=[];

function addBody(instA,diff){	
	var b=instance_create_layer(instA.x-bHeight-diff,instA.y,instA.layer,obj_snakeBody);
	b.snakeParent=instA;
	physics_joint_revolute_create(instA,b,instA.x-bHeight/2-diff/2,instA.y,0,0,false,100,50,false,true);
	addSkin(b,bWidth);
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




var b=id;


addSkin(b,hWidth);
currentLength+=1

for(i=0;i<bLength;i++){
	b=addBody(b,difX);	
	currentLength+=1
}

skins=array_concat(skinsA,array_reverse(skinsB));
