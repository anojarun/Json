package com.aalto.core;

import com.aalto.domain.Activity;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;









public class JsonImplementation
{
  private static Logger LOGGER = Logger.getLogger("JsonImplementation");
  
  public JsonImplementation() {}
  
  public static void main(String[] args) { LOGGER.info(" ********* In Main() - start ********* ");
    
    String completionMessage = "";
    

    Activity updateActivity = new Activity();
    updateActivity.setId(1);
    updateActivity.setName("Test activity name");
    updateActivity.setStartdate("Sun 01/06/08");
    updateActivity.setFinishdate("Sun 01/06/08");
    updateActivity.setDuration("0 days");
    updateActivity.setStatus("Late");
    updateActivity.setPredecessors("20");
    updateActivity.setSuccessors("33,34,35");
    
    List<Activity> updateActivityList = new ArrayList();
    updateActivityList.add(updateActivity);
    
    ActivityToJson actToJson = new ActivityToJson();
    completionMessage = actToJson.updateActivityData(updateActivityList);
    
    LOGGER.info("Completion Status: " + completionMessage);
    
    LOGGER.info(" ********* In Main() - end ********* ");
  }
}
