using System;
using System.Collections;
using System.Collections.Generic;
using PSXShaderKit;
using TMPro;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;
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
    public TMP_Text yourRatingText;
    public TMP_Text bigRatingText;
    public TMP_Text timeLimitBigText;

    public float timer;
    private float prevTimer;
    public float timeLimit=60f;
    public int timeLimitBarLength=20;

    public Canvas pauseCanvas;
    public bool paused;

    private PSXPostProcessEffect psxPostProcessEffect;
    private float pixelationFactor;
    private String[] butterflyTerms;

    private float timer2;
    void Start()
    {
        currentScore=0f;   
        objects=FindObjectsOfType<ObjectScript>();
        bigScoreText.gameObject.SetActive(false);
        yourScoreText.gameObject.SetActive(false);
        bigRatingText.gameObject.SetActive(false);
        yourRatingText.gameObject.SetActive(false);
        timeLimitBigText.gameObject.SetActive(false);
        psxPostProcessEffect=FindObjectOfType<PSXPostProcessEffect>();
        paused=false;
        Time.timeScale=1;
        butterflyTerms=new String[] {"LARVA","CATERPILLAR","BUTTERFLY","WINGSPAN","CHRYSALIS","METAMORPHOSIS","EGG",
        "ALLELE","MONARCH","COLONIST","CREPUSCULAR","DIMORPHISM","DORSAL","EXTINCT","HIBERNATION","LEPIDOPTERA",
        "WEEDY","STIGMA","MIMICRY"};
        timer2=0f;
    }

    // Update is called once per frame
    void Update()
    {
        if(!paused){
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
                bigRatingText.gameObject.SetActive(true);
                yourRatingText.gameObject.SetActive(true);
                timeLimitBigText.gameObject.SetActive(true);
                UIScoreText.gameObject.SetActive(false);
                timeLimitText.gameObject.SetActive(false);
                bigScoreText.text=scoreString;
            }

            if(timer>=timeLimit){
                float h,s,v;
                Color.RGBToHSV(bigScoreText.color,out h,out s,out v);
                h+=Time.deltaTime*0.2f;
                bigScoreText.color=Color.HSVToRGB(h,s,v);
                bigRatingText.color=Color.HSVToRGB(h,s,v);
                timer2+=Time.deltaTime;
                if(timer2<1f){
                    bigRatingText.text=butterflyTerms[(int)Mathf.Ceil(UnityEngine.Random.Range(0f,(float)butterflyTerms.Length-1))];
                }
            }else{
                UIScoreText.text=scoreString;
                
            }

            prevTimer=timer;
        }
    }

    public void Pause(){
        if(timer<timeLimit){
            paused=!paused;
            pauseCanvas.gameObject.SetActive(paused);
            pauseCanvas.GetComponentInChildren<Toggle>().Select();
            if(paused) Time.timeScale=0;
            else Time.timeScale=1;
        }else{
            RestartGame();
        }
    }

    public void RestartGame(){

        string currentSceneName = SceneManager.GetActiveScene().name;
        SceneManager.LoadScene(currentSceneName);
    }

    public void Pixellate(bool b){
        psxPostProcessEffect.enabled=b;
    }
}
