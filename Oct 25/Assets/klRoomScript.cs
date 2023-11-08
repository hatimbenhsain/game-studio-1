using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class klRoomScript : MonoBehaviour
{
    private float initialY;
    private Vector3 initialScale;
    public float maxScale=5f;
    private GameObject player;
    private bool inside=false;
    private float maxD;
    private float minD;
    // Start is called before the first frame update
    void Start()
    {
        initialY=transform.position.y;
        initialScale=transform.parent.localScale;
        player=GameObject.FindWithTag("Player");
        minD=1f;
        maxD=36f;
    }

    // Update is called once per frame
    void Update()
    {
        if(inside){
            float s=(Mathf.Clamp(Vector3.Distance(transform.position,player.transform.position),minD,maxD)-minD)/(maxD-minD);
            s=1-Mathf.Cos((s*Mathf.PI)/2);
            transform.parent.localScale=new Vector3(initialScale.x,initialScale.y+(maxScale-initialScale.y)*s,initialScale.z);
        }
        //Debug.Log(Vector3.Distance(transform.position,player.transform.position));
    }

    private void OnTriggerEnter(Collider other) {
        if(other.gameObject.tag=="Player"){
            inside=true;
        }
    }

    private void OnTriggerExit(Collider other) {
        if(other.gameObject.tag=="Player"){
            inside=false;
        }
    }
}
