using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class TornadoScript : MonoBehaviour
{
    public Transform tornadoCenter;
    public float pullForce;
    public float refreshRate;
    public float pullResetSpeed=0.5f;

    public float radius=1f;
    public int behaviorType=1;

    [Header("Behavior Type 1")]
    public float tornadoGrowthRate=0f;
    public float tornadoDegrowthRate=1f;
    public float minRadius=1f;
    public float maxRadius=1000f;

    public float maxGrowthRate=10f;
    public float minGrowthRate=-10f;

    public float jumpIncrease=1f;

    public float currentRadius=1f;

    [Header("Behavior Type 2")]
    private float period;
    public float avgPeriod=0.9f;
    public float idealPeriod=0.9f;
    public float incrementRate=0.1f;
    public float incrementer=1f;
    public float deincrementRate=0.5f;
    public float maxIncrementRate=0.5f;

    private bool jumped=false;
    
    private void Awake() {
        radius=transform.localScale.x/2;
        period=0f;
    }
    private void OnTriggerEnter(Collider other) {
        if(other.tag=="Object"){
            ObjectScript os=other.GetComponent<ObjectScript>();
            os.EnterTornado(this,pullForce);
        }
    }

    private void OnTriggerExit(Collider other) {
        if(other.tag=="Object"){
            ObjectScript os=other.GetComponent<ObjectScript>();
            os.ExitTornado();
        }
    }

    public void Jumped(){
        jumped=true;
    }

    private void Update() {
        period+=Time.deltaTime;

        if(jumped){
            jumped=false;
            if(behaviorType==1){
                tornadoGrowthRate+=10f;
            }else if(behaviorType==2){
                float ratio=Mathf.Abs(period/avgPeriod);
                if(Mathf.Abs(ratio-1)<0.1){
                    incrementRate=incrementRate+incrementer*period;
                }else{
                    incrementRate=incrementRate*deincrementRate;
                    tornadoGrowthRate=tornadoGrowthRate-Mathf.Abs(ratio-1)+0.2f;
                }
                incrementRate=Mathf.Min(incrementRate,maxIncrementRate);
                tornadoGrowthRate+=incrementRate;
                avgPeriod=(period+avgPeriod)/2;
            }
            period=0f;
        }

        currentRadius=transform.localScale.x;
        currentRadius=currentRadius+tornadoGrowthRate*Time.deltaTime;
        currentRadius=Mathf.Clamp(currentRadius,minRadius,maxRadius);
        transform.localScale=new Vector3(currentRadius,currentRadius,currentRadius);
        if(behaviorType==1){
            tornadoGrowthRate-=tornadoDegrowthRate*Time.deltaTime;
            tornadoGrowthRate=Mathf.Clamp(tornadoGrowthRate,minGrowthRate,maxGrowthRate);
        }else if(behaviorType==2){

        }
        
        
    }

}