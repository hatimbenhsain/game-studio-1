using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ButterflyScript : MonoBehaviour
{
    InputManager inputManager;
    CameraManager cameraManager;
    PlayerLocomotion playerLocomotion;
    TornadoScript tornadoScript;

    void Awake()
    {
        inputManager=GetComponent<InputManager>();
        playerLocomotion=GetComponent<PlayerLocomotion>();
        cameraManager=FindObjectOfType<CameraManager>();
        tornadoScript=FindObjectOfType<TornadoScript>();
    }

    // Update is called once per frame
    void Update()
    {
        inputManager.HandleAllInputs();
    }

    private void FixedUpdate() {
        playerLocomotion.HandleAllMovement();
    }

    private void LateUpdate() {
        cameraManager.HandleAllCameraMovement();
    }

    public void Jump(){
        tornadoScript.Jumped();
    }
}
