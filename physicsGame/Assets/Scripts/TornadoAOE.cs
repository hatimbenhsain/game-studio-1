using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TornadoAOE : MonoBehaviour
{
    // Start is called before the first frame update

    private TornadoScript tornadoScript;
    void Start()
    {
        tornadoScript=FindObjectOfType<TornadoScript>();
    }

    private void OnTriggerEnter(Collider other) {
        if(other.tag=="Object"){
            ObjectScript os=other.GetComponentInParent<ObjectScript>();
            os.EnterTornado(tornadoScript,tornadoScript.pullForce);
        }
    }

    private void OnTriggerExit(Collider other) {
        if(other.tag=="Object"){
            ObjectScript os=other.GetComponentInParent<ObjectScript>();
            os.ExitTornado();
        }
    }
}
