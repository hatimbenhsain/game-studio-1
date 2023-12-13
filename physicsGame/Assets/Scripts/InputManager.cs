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
    public Vector2 cameraMouseInput;
    public bool cameraLeftStart;
    public bool cameraLeftCancel;
    public bool cameraLeftInput;
    public bool cameraRightStart;
    public bool cameraRightCancel;
    public bool cameraRightInput;

    public float cameraInputX;
    public float cameraInputY;

    public Vector2 cameraInput2;


    public float verticalInput;
    public float horizontalInput;

    public bool jumpInput;
    public bool jumpCancel;
    public bool diveInput;
    public bool diveStart;
    public bool diveCancel;

    public bool pauseInput;

    private GameManager gameManager;

    private void Awake() {
        playerLocomotion=FindObjectOfType<PlayerLocomotion>();
        gameManager=FindObjectOfType<GameManager>();
    }
    private void OnEnable() {
        if(playerControls==null){
            playerControls=new PlayerControls();
            playerControls.PlayerMovement.Movement.performed+=i => movementInput=i.ReadValue<Vector2>();
            playerControls.PlayerMovement.Camera.performed+=i => cameraInput=i.ReadValue<Vector2>();
            playerControls.PlayerMovement.CameraMouse.performed+=i => cameraMouseInput=i.ReadValue<Vector2>();

            playerControls.PlayerMovement.CameraLeft.started+=i => cameraLeftStart=true;
            playerControls.PlayerMovement.CameraRight.started+=i => cameraRightStart=true;
            playerControls.PlayerMovement.CameraLeft.canceled+=i => cameraLeftCancel=true;
            playerControls.PlayerMovement.CameraRight.canceled+=i => cameraRightCancel=true;

        
            playerControls.PlayerActions.Jump.performed+=i => jumpInput=true;
            playerControls.PlayerActions.Jump.canceled+=i => jumpCancel=true;
            playerControls.PlayerActions.Dive.performed+=i => diveInput=true;
            playerControls.PlayerActions.Dive.started+=i => diveStart=true;
            playerControls.PlayerActions.Dive.canceled+=i => diveCancel=true;

            playerControls.PlayerActions.Pause.performed+=i => pauseInput=true;

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
        HandlePauseInput();
    }

    private void HandleMovementInput(){
        verticalInput=movementInput.y;
        horizontalInput=movementInput.x;

        cameraInput2=Vector2.zero;

        if(cameraRightStart){
            cameraRightStart=false;
            cameraRightInput=true;
        }else if(cameraRightCancel){
            cameraRightCancel=false;
            cameraRightInput=false;
        }

        if(cameraLeftStart){
            cameraLeftStart=false;
            cameraLeftInput=true;
        }else if(cameraLeftCancel){
            cameraLeftCancel=false;
            cameraLeftInput=false;
        }

        if(cameraLeftInput){
            cameraInput2+=Vector2.left;
        }

        if(cameraRightInput){
            cameraInput2+=Vector2.right;
        }

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

    public void HandlePauseInput(){
        if(pauseInput){
            pauseInput=false;
            gameManager.Pause();
        }
    }

    private void HandleDiveInput(){
        if(diveInput){
            diveInput=false;
        }
        if(diveStart){
            diveStart=false;
            playerLocomotion.HandleDiving(true);
        }
        if(diveCancel){
            diveCancel=false;
            playerLocomotion.HandleDiving(false);
        }
    }
}
