using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Unity.VisualScripting;
using UnityEngine;



public class snakeEaterScript : MonoBehaviour
{
    public AudioSource audioSource;
    public BoxCollider trigger1;
    public Transform trigger2;
    public bool exited=false;

    private bool playingMusic=false;
    private float d;
    private Transform player;
    // Start is called before the first frame update
    void Start()
    {
        Debug.Log("hi");
        d=Vector3.Distance(trigger2.position,transform.position);
        player=GameObject.FindWithTag("Player").transform;
    }

    // Update is called once per frame
    void Update()
    {
        if(playingMusic && !exited){
            audioSource.pitch=0.5f+0.5f*(1f-Vector3.Distance(player.position,transform.position)/Vector3.Distance(trigger2.position,transform.position));
        }
        if(exited){
            audioSource.Stop();
        }
    }

    void OnTriggerEnter(Collider other){
        Debug.Log(other.gameObject.tag);
        if(other.gameObject.tag=="Player"){
            Debug.Log("collided player");
            if(!playingMusic){
                audioSource.Play(0);
                playingMusic=true;
            }
        }
    }
}
