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
    private float restPeriod=1f;



    private void Awake() {
        body=GetComponent<Rigidbody>();
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
    }

    public void ExitTornado(){
        inTornado=false;
        restTimer=-1f;
        timer=0f;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        if(inTornado || pullResetTimer>0f){
            float modifier=1f;
            float d=Vector3.Distance(tornadoCenter.position,transform.position);
            float r=tornadoScript.currentRadius*1.5f;
            if(d>r){
                modifier=Mathf.Clamp(1-(d-r)/(2*r),0f,1f);
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
                body.velocity=Vector3.Lerp(body.velocity,modifier*(targetPosition-transform.position),0.5f);
            
                if(timer==tornadoPeriod){
                    restTimer=0f;
                }
            }else{
                restTimer+=Time.fixedDeltaTime;
                //Vector3 forceDir=tornadoCenter.position-transform.position;
                //body.AddForce(forceDir.normalized*pullForce*Time.fixedDeltaTime*modifier*pullIntensity,ForceMode.Impulse);
                if(restTimer>=restPeriod){
                    restTimer=-1f;
                    timer=0f;
                }
            }            
        }
        if(!inTornado && pullResetTimer>0f){
            pullResetTimer-=Time.fixedDeltaTime*tornadoScript.pullResetSpeed;
        }
        pullResetTimer=Mathf.Clamp(pullResetTimer,0f,1f);
    }
}
