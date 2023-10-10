draw_set_color(c_white);
//physics_draw_debug();
//draw_sprite_ext(spr_snakeHead,0,x,y,image_xscale,image_yscale,-phy_rotation,c_white,1)

var points=[];

var a=skins[0].ang2-degtorad(skins[0].image_angle);
var xx=skins[0].x+cos(a)*skins[0].d2;
var yy=skins[0].y+sin(a)*skins[0].d2;
array_push(points,{x:xx,y:yy});
for(var i=0;i<array_length(skins);i++){
	var a=skins[i].ang-degtorad(skins[i].image_angle);
	var xx=skins[i].x+cos(a)*skins[i].d;
	var yy=skins[i].y+sin(a)*skins[i].d;
	array_push(points,{x:xx,y:yy});
}
var a=skins[array_length(skins)-1].ang2-degtorad(skins[array_length(skins)-1].image_angle);
var xx=skins[array_length(skins)-1].x+cos(a)*skins[array_length(skins)-1].d2;
var yy=skins[array_length(skins)-1].y+sin(a)*skins[array_length(skins)-1].d2;
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
