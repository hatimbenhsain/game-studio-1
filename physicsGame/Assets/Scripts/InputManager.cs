using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InputManager : MonoBehaviour
{
    PlayerControls playerControls;
    PlayerLocomotion playerLocomotion;
    public Vector2 movementInput;
    public Vector2 cameraInput;

    public float cameraInputX;
    public float cameraInputY;


    public float verticalInput;
    public float horizontalInput;

    public bool jumpInput;
    public bool jumpCancel;
    public bool diveInput;
    public bool diveStart;
    public bool diveCancel;

    private void Awake() {
        playerLocomotion=FindObjectOfType<PlayerLocomotion>();
    }
    private void OnEnable() {
        if(playerControls==null){
            playerControls=new PlayerControls();
            playerControls.PlayerMovement.Movement.performed+=i => movementInput=i.ReadValue<Vector2>();
            playerControls.PlayerMovement.Camera.performed+=i => cameraInput=i.ReadValue<Vector2>();
        
            playerControls.PlayerActions.Jump.performed+=i => jumpInput=true;
            playerControls.PlayerActions.Jump.canceled+=i => jumpCancel=true;
            playerControls.PlayerActions.Dive.performed+=i => diveInput=true;
            playerControls.PlayerActions.Dive.started+=i => diveStart=true;
            playerControls.PlayerActions.Dive.canceled+=i => diveCancel=true;
        }
        playerControls.Enable();
    }

    private void OnDisable() {
        playerControls.Disable();
    }

    public void HandleAllInputs(){
        HandleMovementInput();
        HandleJumpingInput();
        HandleDiveInput();
    }

    private void HandleMovementInput(){
        verticalInput=movementInput.y;
        horizontalInput=movementInput.x;

        cameraInputX=cameraInput.x;
        cameraInputY=cameraInput.y;
    }

    private void HandleJumpingInput(){
        if(jumpInput){
            jumpInput=false;
            playerLocomotion.HandleJumping(true);
        }
        if(jumpCancel){
            jumpCancel=false;
            playerLocomotion.HandleJumping(false);
        }
    }

    private void HandleDiveInput(){
        if(diveInput){
            diveInput=false;
            Debug.Log("dive input");
        }
        if(diveStart){
            diveStart=false;
            Debug.Log("dive start");
            playerLocomotion.HandleDiving(true);
        }
        if(diveCancel){
            diveCancel=false;
            Debug.Log("dive end");
            playerLocomotion.HandleDiving(false);
        }
    }
}
