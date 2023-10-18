/// @description Insert description here
// You can write your code in this editor

counter+=delta_time/1000000

//bgSpeed=bgMinSpeed+sin((counter%1)*(bgMaxSpeed-bgMinSpeed));

if(respawnCounter>-0.8){
	respawnCounter+=delta_time/1000000;
	if(respawnCounter>=1){
		var d;
		with(obj_snake){
			d=depth;
			instance_destroy(id);	
		}
		var s=instance_create_layer(snakeInfo.x,snakeInfo.y,layer_get_id("instances"),obj_snake,{bLength:snakeInfo.bLength,pebblesAte:snakeInfo.pa});
		respawnCounter=-1;
		audio_play_sound(snd_respawn2,1,false,1);
	}
}

for(var i=0;i<array_length(lines);i++){
	var l=lines[i];
	switch(l.behavior){
		case "slowMove":
			if(l.vertical){
				l.x+=(l.minSpeed+(l.maxSpeed-l.minSpeed)*sin(pi*((counter+l.timeOffset)%l.period)/l.period))*delta_time/1000000;
			}else if(!l.vertical){
				l.y+=(l.minSpeed+(l.maxSpeed-l.minSpeed)*sin(pi*((counter+l.timeOffset)%l.period)/l.period))*delta_time/1000000;
			}
			break;
	}
}

