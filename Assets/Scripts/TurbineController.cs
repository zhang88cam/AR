using UnityEngine;
using System.Collections;
using System.Collections.Generic;
public class TurbineController : MonoBehaviour {
	
	public static List<TurbineSettingData> lastSettingData;
	//public GameObject turbine1;
	//public Transform turbine;
	public GameObject turbineModel1;
	public GameObject turbineModel2;
	//private static int count = 0;
	
	enum TurbinesType 
	{ GE1_5 = 1, 
	  Siemems,
	  Other
	};
	
	// Use this for initialization
	void Start () {
		/*
		//test parser

		string returnString = "1356.356|246.245|246.357|(null)|(null)|(null)|175|2775|73775|" ;
		List<TurbineSettingData> settingData = TurbineSettingData.settingDataFromString(returnString);
		TurbineController.lastSettingData = settingData;
		foreach(TurbineSettingData aTurbine in lastSettingData)
		{
			Debug.Log("location information: " + aTurbine);
			
		}
		*/
		
		/*
		//create a list of turbines based on the GPS data list
		int i = 0;
		foreach(TurbineSettingData aTurbine in lastSettingData)
		//for(; i < 4; )
		{
			//Transform clonedTurbine;
			GameObject clonedTurbine;
			clonedTurbine = Instantiate(turbine, new Vector3(i*2000.0f,i*2000.0f,i*2000.0f), Quaternion.identity) as GameObject;
			clonedTurbine.SendMessage("init", aTurbine, SendMessageOptions.DontRequireReceiver); 
			
			//clonedTurbine.latitudeTarget = aTurbine.latitude;
			Debug.Log(i++);
		}
		
		*/
	
	}
	
	
	/*
	void Update () {
		
		
	}
	*/
	
	
	
	public void settingDataDidSend(string returnString)		
	{
		//Debug.Log("Did receive the data");
		//parse data from iOS string
		List<TurbineSettingData> settingData = TurbineSettingData.settingDataFromString(returnString);
		TurbineController.lastSettingData = settingData;
		
		/*
		// Avoid duplicated rendering
		if (settingData.Count != count)
		{
			// Test clone
		int i = 0;
		
		for (i = settingData.Count - 1; i >= count; i--)
			//foreach(TurbineSettingData aTurbine in lastSettingData)
		{
			
				TurbineSettingData aTurbine = lastSettingData[i];
				Debug.Log("location information: " + aTurbine);
	
			//Transform clonedTurbine;
			GameObject clonedTurbine;
			if(aTurbine.modelType == 1) {
		
				clonedTurbine = Instantiate(turbine, new Vector3(i*2000.0f,i*2000.0f,i*2000.0f), Quaternion.identity) as GameObject;
				}
				else
				{
					//turbineModel2.transform.localScale = new Vector3(0.001f, 0.001f, 0.001f);
					clonedTurbine = Instantiate(turbineModel2, new Vector3(i*2000.0f,i*2000.0f,i*2000.0f), Quaternion.identity) as GameObject;
				}	

			
				// Call method "init" and send message with "aTurbine" without any return
				//clonedTurbine.SendMessage("init", aTurbine, SendMessageOptions.DontRequireReceiver); 
			
			//clonedTurbine.latitudeTarget = aTurbine.latitude;
			Debug.Log(i);
			
		}
			count = settingData.Count;
			
		}
		*/
		
		// First destroy all turbines
		foreach (GameObject turbine in GameObject.FindGameObjectsWithTag("renderedTurbines")) 
		{
			//Debug.Log("Destroy a turbine");
			Destroy(turbine);
		}

		// According the turbine list to render all turbines
		foreach(TurbineSettingData aTurbine in lastSettingData)		
		{
			
			Debug.Log("location information: " + aTurbine);
			
			int i = lastSettingData.IndexOf(aTurbine);
			
			GameObject clonedTurbine;
			switch (aTurbine.modelType)
			{
			case (int)TurbinesType.GE1_5:
				clonedTurbine = Instantiate(turbineModel1, new Vector3(i*2000.0f,i*2000.0f,i*2000.0f), Quaternion.identity) as GameObject;
				break;
				
			case (int)TurbinesType.Siemems:
				clonedTurbine = Instantiate(turbineModel2, new Vector3(i*2000.0f,i*2000.0f,i*2000.0f), Quaternion.identity) as GameObject;
				break;
			default:
				clonedTurbine = Instantiate(turbineModel1, new Vector3(i*2000.0f,i*2000.0f,i*2000.0f), Quaternion.identity) as GameObject;
				break;
			}	
			clonedTurbine.gameObject.tag = "renderedTurbines";	
			
		}
		
		

	}
}
	



