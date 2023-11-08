using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class gameManagerScript : MonoBehaviour
{
    public static gameManagerScript instance;

    public GameObject[] thingsToHide;
    public GameObject[] thingsToShow;

    private void Awake()
    {
        CreateSingleton();
    }

    void CreateSingleton()
    {
        if (instance == null){
            instance = this;
        }else{
            foreach (var t in thingsToShow)
            {
                t.SetActive(true);
            }
            foreach (var t in thingsToHide)
            {
                t.SetActive(false);
            }
            Destroy(gameObject);
        }

        DontDestroyOnLoad(gameObject);
    }
}