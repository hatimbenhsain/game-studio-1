using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class teleportScript : MonoBehaviour
{
    public Transform origin;
    public StarterAssets.FirstPersonController fpc;

    private Vector3 destination;

    private bool activated;
    private float timeSinceActivation;
    private float activationTime;
    private GameObject player;
    
    // Start is called before the first frame update
    void Start()
    {
        activated=false;
        timeSinceActivation=0f;
        activationTime=5f;
        player=GameObject.FindWithTag("Player");
        destination=origin.position;
    }

    // Update is called once per frame
    void Update()
    {
        if(activated && timeSinceActivation<activationTime){
            timeSinceActivation+=Time.deltaTime;
            Debug.Log(timeSinceActivation);
            if(timeSinceActivation>=activationTime){
                Debug.Log("teleport");
                SceneManager.LoadScene("SampleScene");
            }
        }
    }

    private void OnTriggerEnter(Collider other) {
        if(other.gameObject.tag=="Player" && !activated){
            activated=true;
            Debug.Log("activate");
        }
    }

    public IEnumerator TeleportCharacter(){
        fpc.enabled = false;
        player.transform.position = destination;
        yield return new WaitForEndOfFrame();
        fpc.enabled = true;
    }
}
