using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class minotaurScript : MonoBehaviour
{
    public GameObject[] thingsToHide;
    public GameObject[] thingsToShow;
    private bool activated;
    private float timeSinceActivation;
    private float activationTime;
    private GameObject player;
    // Start is called before the first frame update
    void Start()
    {
        activated=false;
        timeSinceActivation=0f;
        activationTime=2f;
        activated=false;
    }

    // Update is called once per frame
    void Update()
    {
        if(activated && timeSinceActivation<activationTime){
            timeSinceActivation+=Time.deltaTime;
            Debug.Log(timeSinceActivation);
            if(timeSinceActivation>=activationTime){
                foreach (var t in thingsToShow)
                {
                    t.SetActive(true);
                }
            }
        }
    }

    private void OnTriggerEnter(Collider other) {
        if(other.gameObject.tag=="Player" && !activated){
            foreach (var t in thingsToHide){
                t.SetActive(false);
            }
            activated=true;
        }
    }
}
