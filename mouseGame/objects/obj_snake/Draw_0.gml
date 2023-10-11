draw_set_color(c_white);
//physics_draw_debug();
//draw_sprite_ext(spr_snakeHead,0,x,y,image_xscale,image_yscale,-phy_rotation,c_white,1)

var points=[];

var f=1;
if((eating && image_index%2<=1)){
	f=1.8;
}

var a=skins[0].ang2*f-degtorad(skins[0].image_angle);
var xx=skins[0].x+cos(a)*skins[0].d2*f;
var yy=skins[0].y+sin(a)*skins[0].d2*f;
array_push(points,{x:xx,y:yy});
for(var i=0;i<array_length(skins);i++){
	var aa=skins[i].ang;
	var d=skins[i].d;
	if(ateCounter>=0 && (floor(ateCounter/bellySpeed)==i || floor(ateCounter/bellySpeed)==array_length(skins)-i-1)){
		aa=skins[i].fakeAng;	
		var d=skins[i].fakeD;
	}else if(ateCounter>=0 && (floor(ateCounter/bellySpeed)==i-1 || floor(ateCounter/bellySpeed)==i+1 || 
	floor(ateCounter/bellySpeed)==array_length(skins)-i-2 || floor(ateCounter/bellySpeed)==array_length(skins)-i)){
		aa=skins[i].fakeAng2;	
		var d=skins[i].fakeD2;
	}
	var a=aa-degtorad(skins[i].image_angle);
	var xx=skins[i].x+cos(a)*d;
	var yy=skins[i].y+sin(a)*d;
	array_push(points,{x:xx,y:yy});
	if(i==array_length(skins)/2-1){
		var b=skins[i].snakeParent;
		a=pi-degtorad(b.image_angle)
		xx=b.x+15*cos(a);
		yy=b.y+15*sin(a);
		array_push(points,{x:xx,y:yy});
	}
}
var a=skins[array_length(skins)-1].ang2*f-degtorad(skins[array_length(skins)-1].image_angle);
var xx=skins[array_length(skins)-1].x+cos(a)*skins[array_length(skins)-1].d2*f;
var yy=skins[array_length(skins)-1].y+sin(a)*skins[array_length(skins)-1].d2*f;
array_push(points,{x:xx,y:yy});
xx=x;
yy=y;
array_push(points,{x:xx,y:yy});

//for(var i=0;i<array_length(skins);i++){
//	var k=(i+1)%array_length(skins);
//	draw_set_color(c_white);
//	draw_line(skins[i].x,skins[i].y,skins[k].x,skins[k].y);
//}
for(var i=0;i<array_length(points);i++){
	var k=(i+1)%array_length(points);
	draw_set_color(c_white);
	draw_line(points[i].x,points[i].y,points[k].x,points[k].y);
}


//draw_circle(x,y,2,true);
draw_self();
