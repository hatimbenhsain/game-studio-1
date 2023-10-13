randomise();

physics_world_create(0.1);                      //Pixel to meters scale
physics_world_gravity(0, 0);                    //No gravity
physics_world_update_iterations(20);            //iterations per step
physics_world_update_speed(120);                 

show_debug_message("start");

window_set_fullscreen(true);

counter=0;

window_set_cursor(cr_none);
cursor_sprite=spr_cursor

physics_world_update_iterations(30);