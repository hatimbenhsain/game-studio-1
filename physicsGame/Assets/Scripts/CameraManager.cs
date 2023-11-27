using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraManager : MonoBehaviour
{
    InputManager inputManager;
    // Start is called before the first frame update
    public Transform targetTransform;
    public Transform cameraPivot;
    private Vector3 cameraFollowVelocity=Vector3.zero;

    public float cameraFollowSpeed=0.2f;
    public float cameraLookSpeed=2f;
    public float cameraPivotSpeed=2f;

    public float lookAngle;
    public float pivotAngle;

    public float minPivotAngle=-35f;
    public float maxPivotAngle=35f;

    private void Awake() {
        inputManager=FindObjectOfType<InputManager>();
        targetTransform=FindObjectOfType<butterflyScript>().transform;
        Debug.Log("logging");
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
        lookAngle=lookAngle+(inputManager.cameraInput.x*cameraLookSpeed);
        pivotAngle=pivotAngle-(inputManager.cameraInput.y*cameraPivotSpeed);
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
}
