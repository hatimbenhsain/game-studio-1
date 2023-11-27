using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerLocomotion : MonoBehaviour
{
    public LayerMask groundLayer;
    Vector3 moveDirection;
    Transform cameraObject;

    InputManager inputManager;

    Rigidbody playerRigidBody;

    public float movementSpeed=7f;
    public float rotationSpeed=15f;

    public bool isGrounded=true;

    public float rayCastHeightOffset=0.5f;

    private bool isFlying=true;
    public float jumpHeight=5f;

    // Start is called before the first frame update 

    private void Awake(){
        inputManager=GetComponent<InputManager>();
        playerRigidBody=GetComponent<Rigidbody>();
        cameraObject=Camera.main.transform;
    }

    public void HandleAllMovement(){
        HandleMovement();
        HandleRotation();
        HandleFalling();
    }

    private void HandleMovement(){
        moveDirection=cameraObject.forward*inputManager.verticalInput;
        moveDirection=moveDirection+cameraObject.right*inputManager.horizontalInput;
        moveDirection.Normalize();
        moveDirection.y=0;
        moveDirection=moveDirection*movementSpeed;

        Vector3 movementVelocity=new Vector3(moveDirection.x,playerRigidBody.velocity.y,moveDirection.z);
        playerRigidBody.velocity=movementVelocity;

    }

    private void HandleRotation(){
        Vector3 targetDirection=Vector3.zero;
        targetDirection=cameraObject.forward*inputManager.verticalInput;
        targetDirection=targetDirection+cameraObject.right*inputManager.horizontalInput;
        targetDirection.Normalize();
        targetDirection.y=0;

        if(targetDirection==Vector3.zero){
            targetDirection=transform.forward;
        }

        Quaternion targetRotation=Quaternion.LookRotation(targetDirection);
        Quaternion playerRotation=Quaternion.Slerp(transform.rotation,targetRotation,rotationSpeed*Time.deltaTime);

        transform.rotation=playerRotation;
    }

    private void HandleFalling(){
        RaycastHit hit;
        Vector3 rayCastOrigin=transform.position;
        rayCastOrigin.y=rayCastOrigin.y+rayCastHeightOffset;

        if(Physics.SphereCast(rayCastOrigin,0.2f,-Vector3.up,out hit,groundLayer)){
            isGrounded=true;
        }else{
            isGrounded=false;
        }
    }

    public void HandleJumping(){
         if(isGrounded || isFlying){
            Debug.Log("jump");
            Vector3 playerVelocity=playerRigidBody.velocity;
            playerVelocity.y=jumpHeight;
            playerRigidBody.velocity=playerVelocity;
         }
    }
}
