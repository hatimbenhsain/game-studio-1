using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class footSteps : MonoBehaviour
{
    private AudioSource audioSource;
    private StarterAssets.StarterAssetsInputs sai;
    private StarterAssets.FirstPersonController fpc;

    public float walkInterval=0.7f;
    public float sprintInterval=0.5f;
    private float time;
    private bool walking;
    private bool sprinting;

    public AudioClip[] clips;
    // Start is called before the first frame update
    void Start()
    {
        audioSource=gameObject.GetComponent<AudioSource>();
        sai=gameObject.GetComponent<StarterAssets.StarterAssetsInputs>();
        fpc=gameObject.GetComponent<StarterAssets.FirstPersonController>();
        time=0f;
        walking=false;
    }

    // Update is called once per frame
    void Update()
    {
        if((sai.move.x!=0 || sai.move.y!=0) && fpc.Grounded){
            if(walking==false){
                time=sprintInterval;
            }
            walking=true;
            if(sai.sprint){
                sprinting=true;
            }else{
                sprinting=false;
            }
        }else{
            walking=false;
            sprinting=false;
        }
        if(walking){
            float inter=walkInterval;
            if(sprinting){
                inter=sprintInterval;
            }
            time+=Time.deltaTime;
            if(time>=inter){
                time=0f;
                audioSource.clip=clips[Random.Range(0,clips.Length)];
                //audioSource.Stop();
                audioSource.Play();
            }
        }else{
            time=0f;
        }
    }
}
