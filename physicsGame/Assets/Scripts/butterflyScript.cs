using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class ButterflyScript : MonoBehaviour
{
    InputManager inputManager;
    CameraManager cameraManager;
    PlayerLocomotion playerLocomotion;
    TornadoScript tornadoScript;

    public Color dullColor;
    public Color baseColor;
    public Color glowColor;

    public Material wingMaterial;

    Animator animator;

    void Awake()
    {
        inputManager=GetComponent<InputManager>();
        playerLocomotion=GetComponent<PlayerLocomotion>();
        cameraManager=FindObjectOfType<CameraManager>();
        tornadoScript=FindObjectOfType<TornadoScript>();
        animator=GetComponentInChildren<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        inputManager.HandleAllInputs();
        animator.SetBool("diving",(playerLocomotion.diving && !playerLocomotion.jumping));

        float v=Mathf.Abs(tornadoScript.period-tornadoScript.avgPeriod);
        if(v<=tornadoScript.periodTreshold1){
            v=1f;
        }else if(v<=tornadoScript.periodTreshold2*2){
            v=1-(v-tornadoScript.periodTreshold1)/(tornadoScript.periodTreshold2*2-tornadoScript.periodTreshold1);
        }else{
            v=0f;
        }
        if(tornadoScript.avgPeriod<tornadoScript.idealPeriod/2){
            v=Mathf.Pow(v*2*(tornadoScript.idealPeriod/2-tornadoScript.avgPeriod)/tornadoScript.idealPeriod,2f);
        }
        Debug.Log(v);
        Color tColor=Color.Lerp(dullColor,baseColor,v);
        wingMaterial.color=Color.Lerp(wingMaterial.color,tColor,Time.deltaTime*10f);
    }

    private void FixedUpdate() {
        playerLocomotion.HandleAllMovement();
    }

    private void LateUpdate() {
        cameraManager.HandleAllCameraMovement();
    }

    public void Jump(float y){
        tornadoScript.Jumped(y);
        animator.SetTrigger("jump");
    }
}
