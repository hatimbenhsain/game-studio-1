//physics_draw_debug();
draw_set_color(c_white);
draw_set_alpha(1);
draw_line(x-sprite_width/2,y-sprite_height/2,x-sprite_width/2,y+sprite_height/2);
draw_line(x-sprite_width/2,y-sprite_height/2,x+sprite_width/2,y-sprite_height/2);
draw_line(x+sprite_width/2,y-sprite_height/2,x+sprite_width/2,y+sprite_height/2);
draw_line(x-sprite_width/2,y+sprite_height/2,x+sprite_width/2,y+sprite_height/2);
