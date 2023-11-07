using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Unity.VisualScripting;
using UnityEngine;



public class snakeEaterScript : MonoBehaviour
{
    public AudioSource audioSource;
    public BoxCollider trigger1;
    public BoxCollider trigger2;

    private bool playingMusic=false;
    // Start is called before the first frame update
    void Start()
    {
        Debug.Log("hi");
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnTriggerEnter(Collider other){
        Debug.Log(other.gameObject.tag);
        if(other.gameObject.tag=="Player"){
            Debug.Log("collided player");
            if(!playingMusic){
                audioSource.Play(0);
            }
        }
    }
}
