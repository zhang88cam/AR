using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class TurbineSettingData {

	public double latitude;
	public double longitude;
	public double altitude;
	public int modelType;
	public float modelHeight;
	
	
	public static List<TurbineSettingData> settingDataFromString(string settingString)
	{
		
		//create a new list
		List<TurbineSettingData> turbineList = new List<TurbineSettingData>();
		
		string[] parts = settingString.Split('|');
		
		int counts = parts.Length;
		
/*		//Log parser
		for (int i = 0; i < counts - 1; i++)
		{
			
			Debug.Log("String #" + i + " is " + parts[i]);
//			if(parts[i] == "(null)")
//				parts[i] = null;
			
		}
		
		*/
		
		int numbers = counts / 5;
		Debug.Log("Total setting data # is " + numbers);
		
		for (int i = 0; i < numbers; i++)
		{
			TurbineSettingData settingData = new TurbineSettingData();
			try
			{
				settingData.latitude = double.Parse(parts[i * 5 + 0]);
				settingData.longitude = double.Parse(parts[i * 5 + 1]);
				settingData.altitude = double.Parse(parts[i * 5 + 2]);
				settingData.modelType = int.Parse(parts[i * 5 + 3]);
				settingData.modelHeight = float.Parse(parts[i * 5 + 4]);
			}
			
			catch(ArgumentNullException e)
			{
				settingData.latitude = 0.0f;
				settingData.longitude = 0.0f;
				settingData.altitude = 0.0f;
				settingData.modelType = 1;
				settingData.modelHeight = 200.0f;
			}
			catch(FormatException e)
			{
				settingData.latitude = 0.0f;
				settingData.longitude = 0.0f;
				settingData.altitude = 0.0f;
				settingData.modelType = 1;
				settingData.modelHeight = 200.0f;
			}
			
			// add to a list
			turbineList.Add(settingData);
		}
		
//		Debug.Log(turbineList.Count);
//		
//		foreach (TurbineSettingData aTurbine in turbineList)
//		{
//			
//			Debug.Log("location information: " + aTurbine);
//			
//		}
//
		//return list;
		return turbineList;
		
	}
	
	public override string ToString ()
	{
		return string.Format ("[TurbineSettingData] latitude:" + latitude + " longitutde:" + longitude + " altitude:" + altitude + " model: " + modelType + " height: " + modelHeight);
	}
}


