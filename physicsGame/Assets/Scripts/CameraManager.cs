using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.Rendering;

public class CameraManager : MonoBehaviour
{
    InputManager inputManager;
    // Start is called before the first frame update
    public Transform targetTransform;
    public Transform cameraPivot;
    private Vector3 cameraFollowVelocity;

    private TornadoScript tornadoScript;

    public float cameraFollowSpeed=0.2f;
    public float cameraLookSpeed=2f;
    public float cameraPivotSpeed=2f;

    public float lookAngle;
    public float pivotAngle;

    public float minPivotAngle=-35f;
    public float maxPivotAngle=35f;

    private Transform cameraTransform;
    private float initialDistance;
    public float minDistance=5f;

    public float maxRadius=10f;

    public float minDivider=2f;
    public float maxDivider=6f;

    private void Awake() {
        cameraFollowVelocity=Vector3.zero;
        inputManager=FindObjectOfType<InputManager>();
        targetTransform=FindObjectOfType<ButterflyScript>().transform;
        Debug.Log("logging");
        tornadoScript=FindObjectOfType<TornadoScript>();
        cameraTransform=cameraPivot.GetChild(0);
        initialDistance=Mathf.Abs(cameraTransform.localPosition.z);
    }

    public void HandleAllCameraMovement(){
        FollowTarget();
        RotateCamera();
    }

    private void FollowTarget(){
        Vector3 targetPosition=Vector3.SmoothDamp(transform.position,targetTransform.position,ref cameraFollowVelocity,cameraFollowSpeed);
        transform.position=targetPosition;
    }

    private void RotateCamera(){
        Vector2 cInput=inputManager.cameraMouseInput;
        if(cInput==Vector2.zero){
            cInput=(inputManager.cameraInput+inputManager.cameraInput2)*(60f/(1f/Time.deltaTime));
        }
        lookAngle=lookAngle+(cInput.x*cameraLookSpeed);
        pivotAngle=pivotAngle-(cInput.y*cameraPivotSpeed);
        pivotAngle=Mathf.Clamp(pivotAngle,minPivotAngle,maxPivotAngle);

        Vector3 rotation=Vector3.zero;
        rotation.y=lookAngle;
        Quaternion targetRotation=Quaternion.Euler(rotation);
        transform.rotation=targetRotation;

        rotation=Vector3.zero;
        rotation.x=pivotAngle;
        targetRotation=Quaternion.Euler(rotation);
        cameraPivot.localRotation=targetRotation;
    }

    private void Update() {
        Vector3 pos=cameraTransform.localPosition;
        float rad=tornadoScript.currentRadius;
        float val=minDivider;
        if(rad>minDistance && rad<maxRadius){
            val=minDivider+(maxDivider-minDivider)*(rad-minDistance)/(maxRadius-minDistance);
        }else if(rad>=maxRadius){
            val=maxDivider;
        }
        pos.z=-Mathf.Max(Mathf.Lerp(-pos.z,initialDistance*rad/val,1f),minDistance);
        cameraTransform.localPosition=Vector3.Lerp(cameraTransform.localPosition,pos,Time.deltaTime*4f);
    }
}
