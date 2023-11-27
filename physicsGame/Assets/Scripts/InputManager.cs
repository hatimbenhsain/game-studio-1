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

    private void Awake() {
        playerLocomotion=FindObjectOfType<PlayerLocomotion>();
    }
    private void OnEnable() {
        if(playerControls==null){
            playerControls=new PlayerControls();
            playerControls.PlayerMovement.Movement.performed+=i => movementInput=i.ReadValue<Vector2>();
            playerControls.PlayerMovement.Camera.performed+=i => cameraInput=i.ReadValue<Vector2>();
        
            playerControls.PlayerActions.Jump.performed+=i => jumpInput=true;
        }
        playerControls.Enable();
    }

    private void OnDisable() {
        playerControls.Disable();
    }

    public void HandleAllInputs(){
        HandleMovementInput();
        HandleJumpingInput();
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
            playerLocomotion.HandleJumping();
        }
    }
}
