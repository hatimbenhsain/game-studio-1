/// @description Insert description here
// You can write your code in this editor
if(!foundEdges){
	edges=[];
	var e1=-1;
	var e2=-1;
	var prevE1=-1;
	var prevE2=-1;
	
	for(var yy=0;yy<sprite_height+1;yy++){
		var xxx=sprite_width/2;
		var yyy=-sprite_height/2+yy;
		var inst=instance_position(x+xxx+1,y+yyy,obj_wall);
		if(inst==noone || inst==id){
			//array_push(edges,{x:xxx,y:yyy});
			if(e1==-1){
				e1={x:xxx,y:yyy};
			}
		}else if(e1!=-1 && prevE1!=-1){
			array_push(edges,e1);
			array_push(edges,prevE1);
			e1=-1;
		}
		prevE1={x:xxx,y:yyy};
		var xxx=-sprite_width/2;
		inst=instance_position(x+xxx-1,y+yyy,obj_wall);
		if(inst==noone || inst==id){
			//array_push(edges,{x:xxx,y:yyy});
			if(e2==-1){
				e2={x:xxx,y:yyy};
			}
		}else if(e2!=-1 && prevE2!=-1){
			array_push(edges,e2);
			array_push(edges,prevE2);
			e2=-1;
		}
		prevE2={x:xxx,y:yyy};
	}
	
	if(e1!=-1 && prevE1!=-1){
		array_push(edges,e1);
		array_push(edges,prevE1);
		e1=-1;
	}
	if(e2!=-1 && prevE2!=-1){
		array_push(edges,e2);
		array_push(edges,prevE2);
		e2=-1;
	}
	
	e1=-1;
	e2=-1
	prevE1=-1;
	prevE2=-1;
	
	for(var xx=0;xx<sprite_width+1;xx++){
		var xxx=-sprite_width/2+xx;
		var yyy=sprite_height/2;
		var inst=instance_position(x+xxx,y+yyy,obj_wall);
		if(inst==noone || inst==id){
			//array_push(edges,{x:xxx,y:yyy});
			if(e1==-1){
				e1={x:xxx,y:yyy};
			}
		}
		else if(e1!=-1 && prevE1!=-1){
			array_push(edges,e1);
			array_push(edges,prevE1);
			e1=-1;
		}
		prevE1={x:xxx,y:yyy};
		var yyy=-sprite_height/2;
		inst=instance_position(x+xxx,y+yyy-1,obj_wall);
		if(inst==noone || inst==id){
			if(e2==-1){
				e2={x:xxx,y:yyy};
			}
		}else if(e2!=-1 && prevE2!=-1){
			array_push(edges,e2);
			array_push(edges,prevE2);
			e2=-1;
		}
		prevE2={x:xxx,y:yyy};
	}
	if(e1!=-1 && prevE1!=-1){
		array_push(edges,e1);
		array_push(edges,prevE1);
		e1=-1;
	}
	if(e2!=-1 && prevE2!=-1){
		array_push(edges,e2);
		array_push(edges,prevE2);
		e2=-1;
	}
	foundEdges=true;
}

