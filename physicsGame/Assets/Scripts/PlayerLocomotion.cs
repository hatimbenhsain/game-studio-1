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
    ButterflyScript butterflyScript;
    Rigidbody playerRigidBody;

    public float movementSpeed=7f;
    public float rotationSpeed=15f;

    public bool isGrounded=true;

    public float rayCastHeightOffset=0.5f;

    private bool isFlying=true;
    public float jumpHeight=5f;

    public float sphereRad=0.1f;

    // Start is called before the first frame update 

    private void Awake(){
        inputManager=GetComponent<InputManager>();
        playerRigidBody=GetComponent<Rigidbody>();
        cameraObject=Camera.main.transform;
        butterflyScript=FindObjectOfType<ButterflyScript>();
    }

    public void HandleAllMovement(){
        HandleMovement();
        HandleRotation();
        HandleFalling();
    }

    private void HandleMovement(){
        if(!isGrounded){
            moveDirection=cameraObject.forward*inputManager.verticalInput;
            moveDirection=moveDirection+cameraObject.right*inputManager.horizontalInput;
            
            float mag=Mathf.Clamp(moveDirection.magnitude,0f,1f);

            moveDirection.Normalize();
            moveDirection.y=0;
            moveDirection=moveDirection*movementSpeed;

            Vector3 movementVelocity=playerRigidBody.velocity;
            movementVelocity.x=moveDirection.x*mag;
            movementVelocity.z=moveDirection.z*mag;
            playerRigidBody.velocity=movementVelocity;
        }

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
        
        if(Physics.SphereCast(rayCastOrigin,sphereRad,-Vector3.up,out hit,rayCastHeightOffset*2,groundLayer)){
            isGrounded=true;
        }else{
            isGrounded=false;
        }
    }

    private void OnDrawGizmosSelected() {
        // Vector3 rayCastOrigin=transform.position;
        // rayCastOrigin.y=rayCastOrigin.y+rayCastHeightOffset;
        // Gizmos.color=Color.red;
        // Gizmos.DrawSphere(rayCastOrigin,sphereRad);
        // Gizmos.DrawSphere(rayCastOrigin-rayCastHeightOffset*Vector3.up*2,sphereRad);
    }

    public void HandleJumping(){
         if(isGrounded || isFlying){
            Vector3 playerVelocity=playerRigidBody.velocity;
            playerVelocity.y=jumpHeight;
            playerRigidBody.velocity=playerVelocity;
            butterflyScript.Jump();
         }
    }
}
