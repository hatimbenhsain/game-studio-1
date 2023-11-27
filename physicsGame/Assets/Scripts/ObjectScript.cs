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

    private void Awake() {
        body=GetComponent<Rigidbody>();
    }

    public void EnterTornado(TornadoScript ts, float f){
        inTornado=true;
        tornadoScript=ts;
        tornadoCenter=ts.transform;
        pullForce=f;
        pullResetTimer=1f;
        Debug.Log(Vector3.Distance(tornadoCenter.position,transform.position));
    }

    public void ExitTornado(){
        inTornado=false;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        if(inTornado || pullResetTimer>0f){
            Vector3 forceDir=tornadoCenter.position-transform.position;
            float d=Vector3.Distance(tornadoCenter.position,transform.position);
            float modifier=1f;
            float r=tornadoScript.radius;
            if(d>r){
                modifier=Mathf.Clamp(1-(d-r)/(2*r),0f,1f);
            }
            body.AddForce(forceDir.normalized*pullForce*Time.fixedDeltaTime*modifier*pullIntensity,ForceMode.Impulse);
        }
        if(!inTornado && pullResetTimer>0f){
            pullResetTimer-=Time.fixedDeltaTime*tornadoScript.pullResetSpeed;
        }
        pullResetTimer=Mathf.Clamp(pullResetTimer,0f,1f);
    }
}
