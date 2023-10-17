/// @description Insert description here
// You can write your code in this editor

draw_sprite_ext(sprite_index,image_index,x-4,y,image_xscale,image_yscale,1,c_black,image_alpha);
draw_sprite_ext(sprite_index,image_index,x+2,y,image_xscale,image_yscale,1,c_black,image_alpha);
draw_sprite_ext(sprite_index,image_index,x,y-2,image_xscale,image_yscale,1,c_black,image_alpha);
draw_sprite_ext(sprite_index,image_index,x,y+2,image_xscale,image_yscale,1,c_black,image_alpha);
draw_sprite_ext(sprite_index,image_index,x-2,y-2,image_xscale,image_yscale,1,c_black,image_alpha);
draw_sprite_ext(sprite_index,image_index,x+2,y+2,image_xscale,image_yscale,1,c_black,image_alpha);
draw_sprite_ext(sprite_index,image_index,x-2,y+2,image_xscale,image_yscale,1,c_black,image_alpha);
draw_sprite_ext(sprite_index,image_index,x+2,y-2,image_xscale,image_yscale,1,c_black,image_alpha);
draw_self();

//draw_text(x+1000,y,fps);