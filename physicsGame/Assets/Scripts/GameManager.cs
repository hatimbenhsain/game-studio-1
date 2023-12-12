using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    // Start is called before the first frame update
    public float currentScore;
    private ObjectScript[] objects;
    void Start()
    {
        currentScore=0f;   
        objects=FindObjectsOfType<ObjectScript>();
    }

    // Update is called once per frame
    void Update()
    {
        currentScore=0f;
        foreach(ObjectScript o in objects){
            currentScore+=o.score;
        }
    }
}
