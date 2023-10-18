depth=1;

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

respawnCounter=-1;

bgMaxSpeed=20;
bgMinSpeed=10;
bgSpeed=20;

lines=[];
var maxA=0.2
var minA=0.1
for(var k=0;k<=1900;k+=50){
array_push(lines,{vertical:true,x:0+k+random_range(-5,5),behavior:"slowMove",dir:1,period:5+random_range(-0.5,0.5),
	minSpeed:random_range(0,50),maxSpeed:100+random_range(0,50),timeOffset:random_range(0,5),a:random_range(minA,maxA)});
array_push(lines,{vertical:true,x:10+k+random_range(-5,5),behavior:"slowMove",dir:1,period:5+random_range(-0.5,0.5),
	minSpeed:random_range(0,50),maxSpeed:random_range(100,150),timeOffset:random_range(0,5),a:random_range(minA,maxA)});
}
for(var k=0;k<=1000;k+=50){
array_push(lines,{vertical:false,y:0+k+random_range(-5,5),behavior:"slowMove",dir:1,period:5+random_range(-0.5,0.5),
	minSpeed:random_range(0,50),maxSpeed:100+random_range(0,50),timeOffset:random_range(0,5),a:random_range(minA,maxA)});
array_push(lines,{vertical:false,y:10+k+random_range(-5,5),behavior:"slowMove",dir:1,period:5+random_range(-0.5,0.5),
	minSpeed:random_range(0,50),maxSpeed:random_range(100,150),timeOffset:random_range(0,5),a:random_range(minA,maxA)});
}

music=audio_play_sound(snd_music,1,true,1);