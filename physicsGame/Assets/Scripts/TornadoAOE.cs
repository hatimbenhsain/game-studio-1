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
            ObjectScript os=other.GetComponent<ObjectScript>();
            os.EnterTornado(tornadoScript,tornadoScript.pullForce);
            Debug.Log("enter object");
        }
    }

    private void OnTriggerExit(Collider other) {
        if(other.tag=="Object"){
            ObjectScript os=other.GetComponent<ObjectScript>();
            os.ExitTornado();
        }
    }
}
