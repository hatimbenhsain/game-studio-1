using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TornadoScript : MonoBehaviour
{
    public Transform tornadoCenter;
    public float pullForce;
    public float refreshRate;
    public float pullResetSpeed=0.5f;

    public float radius=1f;

    public float tornadoGrowthRate=0f;
    public float tornadoDegrowthRate=1f;
    public float minRadius=1f;
    public float maxRadius=1000f;

    public float jumpIncrease=10f;

    
    private void Awake() {
        radius=transform.localScale.x/2;
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
        tornadoGrowthRate+=10f;
    }

    private void Update() {
        float currentRadius=transform.localScale.x;
        currentRadius=currentRadius+tornadoGrowthRate*Time.deltaTime;
        currentRadius=Mathf.Clamp(currentRadius,minRadius,maxRadius);
        tornadoGrowthRate-=tornadoDegrowthRate*Time.deltaTime;
    }

}
