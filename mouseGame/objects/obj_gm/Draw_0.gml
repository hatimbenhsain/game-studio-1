/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_white);


var w=10
//for(var xx=0;xx<camera_get_view_width(view_camera[0]);xx+=w){
//	draw_line(floor((counter%1)*bgSpeed)+xx,camera_get_view_y(view_camera[0]),floor((counter%1)*bgSpeed)+xx,
//	camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0]))
//}
//for(var yy=0;yy<camera_get_view_height(view_camera[0]);yy+=w){
//	draw_line(camera_get_view_x(view_camera[0]),floor((counter%1)*bgSpeed)+yy,camera_get_view_x(view_camera[0])+camera_get_view_width(view_camera[0]),
//	floor((counter%1)*bgSpeed)+yy);
//}

for(var i=0;i<array_length(lines);i++){
	var l=lines[i];
	draw_set_alpha(l.a*sin(pi*(counter%10)/10));
	if(l.vertical){
		draw_line(l.x%camera_get_view_width(view_camera[0]),camera_get_view_y(view_camera[0]),l.x%camera_get_view_width(view_camera[0]),
		camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0]));
	}else{
		draw_line(camera_get_view_x(view_camera[0]),l.y%camera_get_view_height(view_camera[0]),
		camera_get_view_x(view_camera[0])+camera_get_view_width(view_camera[0]),l.y%camera_get_view_height(view_camera[0]));
	}
}

draw_set_alpha(1);
