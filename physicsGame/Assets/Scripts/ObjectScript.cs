using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

public class ObjectScript : MonoBehaviour
{
    public bool inTornado=false;
    private Transform tornadoCenter;
    private TornadoScript tornadoScript;
    private float pullForce;
    private Rigidbody body;

    private float pullIntensity=1;

    private float pullResetTimer=0f;

    private float timer=0f;
    private float timeOffset=0f;
    private float tornadoPeriod;
    private float ringNumber;

    private float restTimer=-1f;
    private float restPeriod=0.5f;

    private float scaleToMassRatio=4f;

    private bool hasBeenMoved=false;
    private Vector3 startPosition;

    private float distanceMoved;
    public float score;

    private Collider[] colliders;
    public Collider myCollider;

    private void Awake() {
        body=GetComponent<Rigidbody>();
        body.mass=2*body.mass*(transform.localScale.x+transform.localScale.y+transform.localScale.z)/3;
        distanceMoved=0f;
        score=0f;
        colliders=GetComponentsInChildren<Collider>();
        myCollider=FindGameObjectInChildWithTag(gameObject,"myCollider").GetComponent<Collider>();
        if(myCollider!=null) myCollider.enabled=false;
    }

    public void EnterTornado(TornadoScript ts, float f){
        inTornado=true;
        tornadoScript=ts;
        tornadoCenter=ts.transform;
        pullForce=f;
        pullResetTimer=1f;
        timer=0f;
        tornadoPeriod=ts.cyclePeriod;
        timeOffset=Random.Range(0f,tornadoPeriod);
        ringNumber=ts.ringNumber;
        restTimer=-1f;
        if(!hasBeenMoved){
            startPosition=transform.position;
        }
        hasBeenMoved=true;
        if(myCollider!=null){
            foreach(Collider c in colliders){
                c.enabled=false;
            }
            myCollider.enabled=true;
        }
    }

    public void ExitTornado(){
        inTornado=false;
        restTimer=-1f;
        timer=0f;
        // foreach(Collider c in colliders){
        //     c.enabled=true;
        // }
        // myCollider.enabled=false;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        if(inTornado || pullResetTimer>0f){
            float modifier=1f;
            float d=Vector3.Distance(tornadoCenter.position,transform.position);
            float r=tornadoScript.currentRadius*1.5f;
            float tm=tornadoScript.currentRadius*scaleToMassRatio;
            if(!inTornado){
                modifier=Mathf.Clamp(1-(d-r)/(2*r),0f,1f);
            }
            if(body.mass>tm){
                modifier=modifier*Mathf.Pow(tm/body.mass,2f);
                //modifier=0f;
                if(gameObject.name=="apple")  Debug.Log("apple drag");
            }
            if(restTimer==-1f){
                timer+=Time.fixedDeltaTime;
                
                timer=Mathf.Min(timer,tornadoPeriod);

                
                float ringSize=timer/tornadoPeriod;
                float k=Mathf.PI*2*(timer+timeOffset)*ringNumber/tornadoPeriod;
                float tx=r*Mathf.Cos(k)*ringSize;
                float tornadoHeight=r*2;
                float ty=tornadoHeight*(timer/tornadoPeriod-0.5f);
                float tz=r*Mathf.Sin(k)*ringSize;
                
                Vector3 targetPosition=tornadoCenter.position+new Vector3(tx,ty,tz);
                body.velocity=Vector3.Lerp(body.velocity,targetPosition-transform.position,modifier*0.5f);
            
                if(timer==tornadoPeriod){
                    restTimer=0f;
                }
                if(modifier==1f && gameObject.name=="apple"){
                     Debug.Log("apple nromal");
                    Debug.Log(targetPosition);
                }
            }else{
                if(gameObject.name=="apple") Debug.Log("apple rest");
                restTimer+=Time.fixedDeltaTime;
                Vector3 forceDir=tornadoCenter.position-transform.position;
                body.AddForce(forceDir.normalized*pullForce*Time.fixedDeltaTime*modifier*pullIntensity,ForceMode.Impulse);
                if(restTimer>=restPeriod){
                    restTimer=-1f;
                    timer=0f;
                    timeOffset=Random.Range(0f,tornadoPeriod);
                }
            }            
            if(tornadoScript.currentRadius<=1f){
                ExitTornado();
            }
        }
        if(!inTornado && pullResetTimer>0f){
            pullResetTimer-=Time.fixedDeltaTime*tornadoScript.pullResetSpeed;
        }
        pullResetTimer=Mathf.Clamp(pullResetTimer,0f,1f);

        if(hasBeenMoved){
            distanceMoved=Mathf.Max(distanceMoved,Vector3.Distance(transform.position,startPosition));
            score=distanceMoved*Mathf.Pow(body.mass/2f,0.75f);
        }
    }

    //following function from Roixo https://discussions.unity.com/t/how-to-find-child-with-tag/129880/3
    public static GameObject FindGameObjectInChildWithTag (GameObject parent, string tag)
	{
		Transform t = parent.transform;

		for (int i = 0; i < t.childCount; i++) 
		{
			if(t.GetChild(i).gameObject.tag == tag)
			{
				return t.GetChild(i).gameObject;
			}
				
		}
			
		return null;
	}

    private void OnCollisionEnter(Collision other) {
        if(other.gameObject.tag=="Floor" && restTimer>0f){
            restTimer=-1f;
            timer=0f;
            timeOffset=Random.Range(0f,tornadoPeriod);
            Debug.Log("reset");
        }
    }
}
