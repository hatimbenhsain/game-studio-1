using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor.ShaderGraph.Internal;
using UnityEngine;

public class TornadoScript : MonoBehaviour
{
    public Transform tornadoCenter;
    public float pullForce;
    public float refreshRate;
    public float pullResetSpeed=0.5f;

    public float radius=1f;
    public int behaviorType=1;

    public float cyclePeriod=2f;
    public float ringNumber=5f;

    [Header("Behavior Type 1")]
    public float tornadoGrowthRate=0f;
    public float tornadoDegrowthRate=1f;
    public float minRadius=1f;
    public float maxRadius=1000f;

    public float jumpIncrease=1f;

    public float currentRadius=1f;

    
    public float period;

    

    [Header("Behavior Type 2")]
    public float avgPeriod=0.9f;
    public float idealPeriod=0.9f;
    public float jumpIncrement=0.01f;
    public float periodTreshold1=0.1f;
    public float periodTreshold2=0.2f;
    public float degrowthIncrement=0.2f;
    public float minGrowthRate=0.8f;
    public float maxGrowthRate=1.1f;
    
    public float minGrowthRate2=0.8f;

    private bool jumped=false;

    [Range(0f,1f)]
    public float periodWeight=0.75f;
    
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

        tornadoGrowthRate-=tornadoDegrowthRate*Time.deltaTime;

        if(jumped){
            jumped=false;
            if(behaviorType==1){
                tornadoGrowthRate+=10f;
            }else if(behaviorType==2){
                float periodDifference=Mathf.Abs(period-avgPeriod);
                float mod=period;
                if(mod<idealPeriod){
                    mod=Mathf.Pow(period/idealPeriod,2f)*idealPeriod;
                }
                if(periodDifference<periodTreshold1){
                    float k=jumpIncrement*mod;
                    tornadoGrowthRate+=k;
                    if(tornadoGrowthRate<minGrowthRate2){
                        tornadoGrowthRate=minGrowthRate2;
                    }
                }else if(periodDifference<periodTreshold2){
                    float k=mod*(jumpIncrement*(periodTreshold2-periodDifference)-
                degrowthIncrement*(periodDifference-periodTreshold1))/(periodTreshold2-periodTreshold1);
                    tornadoGrowthRate+=k;
                }else{
                    tornadoGrowthRate-=degrowthIncrement;
                }
                avgPeriod=Mathf.Min(period,2f)*periodWeight+avgPeriod*(1-periodWeight);
            }
            period=0f;
        }

        currentRadius=transform.localScale.x;
        
        
        if(behaviorType==1){
            currentRadius=currentRadius+tornadoGrowthRate*Time.deltaTime;
            currentRadius=Mathf.Clamp(currentRadius,minRadius,maxRadius);
            tornadoGrowthRate-=10f*Time.deltaTime;
            tornadoGrowthRate=Mathf.Clamp(tornadoGrowthRate,-10f,10f);
        }else if(behaviorType==2){
            tornadoGrowthRate=Mathf.Clamp(tornadoGrowthRate,minGrowthRate,maxGrowthRate);
            currentRadius=currentRadius*(1+Time.deltaTime*(tornadoGrowthRate-1));
            currentRadius=Mathf.Clamp(currentRadius,minRadius,maxRadius);
        }

        transform.localScale=new Vector3(currentRadius,currentRadius,currentRadius);
        
        
    }

}