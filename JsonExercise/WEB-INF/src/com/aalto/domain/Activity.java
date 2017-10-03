package com.aalto.domain;

import com.google.gson.annotations.SerializedName;








public class Activity
{
  @SerializedName("ID")
  private int id;
  @SerializedName("Name")
  private String name;
  @SerializedName("Start_Date")
  private String startdate;
  @SerializedName("Finish_Date")
  private String finishdate;
  @SerializedName("Duration")
  private String duration;
  @SerializedName("Status")
  private String status;
  @SerializedName("Predecessors")
  private String predecessors;
  @SerializedName("Successors")
  private String successors;
  
  public Activity() {}
  
  public int getId()
  {
    return id;
  }
  

  public void setId(int id)
  {
    this.id = id;
  }
  

  public String getName()
  {
    return name;
  }
  

  public void setName(String name)
  {
    this.name = name;
  }
  

  public String getStartdate()
  {
    return startdate;
  }
  

  public void setStartdate(String startdate)
  {
    this.startdate = startdate;
  }
  

  public String getFinishdate()
  {
    return finishdate;
  }
  

  public void setFinishdate(String finishdate)
  {
    this.finishdate = finishdate;
  }
  

  public String getDuration()
  {
    return duration;
  }
  

  public void setDuration(String duration)
  {
    this.duration = duration;
  }
  

  public String getStatus()
  {
    return status;
  }
  

  public void setStatus(String status)
  {
    this.status = status;
  }
  

  public String getPredecessors()
  {
    return predecessors;
  }
  

  public void setPredecessors(String predecessors)
  {
    this.predecessors = predecessors;
  }
  

  public String getSuccessors()
  {
    return successors;
  }
  

  public void setSuccessors(String successors)
  {
    this.successors = successors;
  }
  
  public String toString()
  {
    return 
    





      "ID: " + id + ", Name: " + name + ", Start Date: " + startdate + ", Finish Date: " + finishdate + ", Duration: " + duration + ", Status: " + status + ", Predecessors: " + predecessors + ", Successors: " + successors;
  }
}
