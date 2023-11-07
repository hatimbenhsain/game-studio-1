using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class snakeEaterScript2 : MonoBehaviour
{
    public snakeEaterScript snakeEater;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    
    void OnTriggerEnter(Collider other) {
        snakeEater.exited=true;
    }
}
