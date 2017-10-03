package com.aalto.core;

import com.aalto.domain.Activity;
import com.google.gson.Gson;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Type;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.logging.Logger;














public class ActivityToJson
{
  private static Logger LOGGER = Logger.getLogger("ActivityToJson");
  
  public ActivityToJson() {}
  
  public String updateActivityData(List<Activity> updateActivity) { LOGGER.info(" ********* In updateActivityData() - start ********* ");
    
    List<Activity> activities = null;
    String jsonFullName = "";
    Gson gson = new Gson();
    String completionMessage = "";
    try
    {
      Properties prop = new Properties();
      
      String propFileName = "config.properties";
      
      InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);
      prop.load(inputStream);
      
      if (inputStream == null) {
        throw new FileNotFoundException("Property file '" + propFileName + "' not found in the classpath");
      }
      

      String jsonFileDirectory = prop.getProperty("activityfilepath");
      String jsonFilename = prop.getProperty("activityfilename");
      jsonFullName = jsonFileDirectory + jsonFilename;
      
      File file = new File(jsonFullName);
      BufferedReader bufferedReader = new BufferedReader(new FileReader(file));
      Type type = new ActivityToJson.1(this).getType();
      
      activities = (List)gson.fromJson(bufferedReader, type);
      bufferedReader.close();
      

      Iterator<Activity> iterator = activities.iterator();
      

      for (Activity selectedInfo : updateActivity) {
        while (iterator.hasNext()) {
          Activity itrActivity = (Activity)iterator.next();
          LOGGER.info("itrActivity.getName() ======> " + itrActivity.getName());
          LOGGER.info("selectedInfo.getName() ======> " + selectedInfo.getName());
          if (itrActivity.getId() == selectedInfo.getId()) {
            iterator.remove();
            LOGGER.info("Equal ids.");
            break;
          }
        }
      }
      activities.addAll(updateActivity);
    } catch (Exception e) {
      LOGGER.info("Json file updating failed");
      completionMessage = "Json file updating failed";
      e.printStackTrace();
    }
    

    try
    {
      File gsonFile = new File(jsonFullName);
      FileWriter writer = new FileWriter(gsonFile);
      String activitiesJson = gson.toJson(activities);
      writer = new FileWriter(gsonFile);
      writer.write(activitiesJson);
      writer.flush();
      LOGGER.info("Json file updating completed successfully");
      completionMessage = "Json file updating completed successfully";
    } catch (IOException e) {
      LOGGER.info("Json file updating failed");
      completionMessage = "Json file updating failed";
      e.printStackTrace();
    }
    
    LOGGER.info(" ********* In updateActivityData() - end ********* ");
    
    return completionMessage;
  }
}
