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

}
