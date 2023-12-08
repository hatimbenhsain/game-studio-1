using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class RhythmUIScript : MonoBehaviour
{
    private Canvas canvas;
    private RectTransform canvasRect;

    public RectTransform bgRect;
    public RectTransform centerRect;
    public RectTransform timezoneRect;
    public RectTransform sweetspotRect;

    private TornadoScript tornadoScript;

    private float prevPeriod;

    private Image[] images;
    private Image[] prevImages;
    private RectTransform[] prevRects;
    // Start is called before the first frame update
    void Start()
    {
        canvas=GetComponent<Canvas>();
        images=GetComponentsInChildren<Image>();
        canvasRect=canvas.GetComponent<RectTransform>();

        tornadoScript=FindObjectOfType<TornadoScript>();

        prevImages=new Image[0];
        prevRects=new RectTransform[] {};
    }

    // Update is called once per frame
    void Update()
    {
        float canvasWidth=canvasRect.rect.width;
        float p=tornadoScript.period;
        float ap=tornadoScript.avgPeriod;

        if(p<prevPeriod){
            prevImages=new Image[2];
            prevImages[0]=timezoneRect.gameObject.GetComponent<Image>();
            prevImages[1]=sweetspotRect.gameObject.GetComponent<Image>();
            foreach(RectTransform r in prevRects){
                Destroy(r.gameObject);
            }
            prevRects=new RectTransform[] {timezoneRect,sweetspotRect};
            timezoneRect=Instantiate(timezoneRect,timezoneRect.transform.parent);
            timezoneRect.transform.SetSiblingIndex(1);
            Image i=timezoneRect.gameObject.GetComponent<Image>();
            Color c=i.color;
            c.a=Mathf.Min(ap/tornadoScript.idealPeriod,1f);
            i.color=c;
            sweetspotRect=Instantiate(sweetspotRect,timezoneRect.transform.parent);
            sweetspotRect.transform.SetSiblingIndex(2);
            i=sweetspotRect.gameObject.GetComponent<Image>();
            c=i.color;
            c.a=Mathf.Min(ap/tornadoScript.idealPeriod,1f);
            i.color=c;
        }

        foreach(Image i in prevImages){
            Color c=i.color;
            c.a=c.a-Time.deltaTime/0.2f;
            i.color=c;
        }

        float ratio=0.6f;
        Vector2 newPos=centerRect.anchoredPosition;
        newPos.x=canvasWidth*ratio*(1-(p/ap));
        timezoneRect.anchoredPosition=newPos;
        sweetspotRect.anchoredPosition=newPos;

        timezoneRect.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal,tornadoScript.periodTreshold2*2f*ratio*canvasWidth/ap);
        sweetspotRect.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal,tornadoScript.periodTreshold1*2f*ratio*canvasWidth/ap);

        Debug.Log(timezoneRect.rect.width);
        Debug.Log(canvasWidth);

        prevPeriod=p;
    }
}
