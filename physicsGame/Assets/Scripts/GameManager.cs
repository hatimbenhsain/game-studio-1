using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.UI;


public class GameManager : MonoBehaviour
{
    // Start is called before the first frame update
    public float currentScore;
    private ObjectScript[] objects;

    public TMP_Text UIScoreText;
    public TMP_Text timeLimitText;
    public TMP_Text yourScoreText;
    public TMP_Text bigScoreText;
    public TMP_Text timeLimitBigText;

    public float timer;
    private float prevTimer;
    public float timeLimit=60f;
    public int timeLimitBarLength=20;
    void Start()
    {
        currentScore=0f;   
        objects=FindObjectsOfType<ObjectScript>();
        bigScoreText.gameObject.SetActive(false);
        yourScoreText.gameObject.SetActive(false);
        timeLimitBigText.gameObject.SetActive(false);
    }

    // Update is called once per frame
    void Update()
    {
        timer+=Time.deltaTime;
        timer=Mathf.Clamp(timer,0f,timeLimit);


        String t="[";
        for(int i=0;i<timeLimitBarLength;i+=1){
            if(timer>=timeLimit*i/timeLimitBarLength){
                t+="=";
            }else{
                t+="-";
            }
        }
        t+="]";
        timeLimitText.text=t;



        currentScore=0f;
        foreach(ObjectScript o in objects){
            currentScore+=o.score;
        }
        String scoreString=Mathf.Round(currentScore).ToString("n0");


        if(timer>=timeLimit && prevTimer<timeLimit){
            bigScoreText.gameObject.SetActive(true);
            yourScoreText.gameObject.SetActive(true);
            timeLimitBigText.gameObject.SetActive(true);
            UIScoreText.gameObject.SetActive(false);
            timeLimitText.gameObject.SetActive(false);
        }

        if(timer>=timeLimit){
            float h,s,v;
            Color.RGBToHSV(bigScoreText.color,out h,out s,out v);
            h+=Time.deltaTime*0.2f;
            bigScoreText.color=Color.HSVToRGB(h,s,v);
            bigScoreText.text=scoreString;
        }else{
            UIScoreText.text=scoreString;
        }

        prevTimer=timer;
    }
}
