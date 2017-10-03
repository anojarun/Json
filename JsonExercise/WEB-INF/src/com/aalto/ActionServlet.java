package com.aalto;

import com.aalto.core.ActivityToJson;
import com.aalto.domain.Activity;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;













public class ActionServlet
  extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  private static Logger LOGGER = Logger.getLogger("JsonImplementation");
  

  public ActionServlet() {}
  
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    LOGGER.info(" ********* In doGet() - start ********* ");
    
    String completionMessage = "";
    completionMessage = "Begin to write Json data!";
    
    LOGGER.info("actid:" + request.getParameter("actid"));
    LOGGER.info("actname:" + request.getParameter("actname"));
    LOGGER.info("actstartdate:" + request.getParameter("actstartdate"));
    LOGGER.info("actfinishdate:" + request.getParameter("actfinishdate"));
    LOGGER.info("actduration:" + request.getParameter("actduration"));
    LOGGER.info("actstatus:" + request.getParameter("actstatus"));
    LOGGER.info("actpredecessors:" + request.getParameter("actpredecessors"));
    LOGGER.info("actsuccessors:" + request.getParameter("actsuccessors"));
    
    Activity updateActivity = new Activity();
    updateActivity.setId(Integer.parseInt(request.getParameter("actid")));
    updateActivity.setName(request.getParameter("actname"));
    updateActivity.setStartdate(request.getParameter("actstartdate"));
    updateActivity.setFinishdate(request.getParameter("actfinishdate"));
    updateActivity.setDuration(request.getParameter("actduration"));
    updateActivity.setStatus(request.getParameter("actstatus"));
    updateActivity.setPredecessors(request.getParameter("actpredecessors"));
    updateActivity.setSuccessors(request.getParameter("actsuccessors"));
    
    List<Activity> updateActivityList = new ArrayList();
    updateActivityList.add(updateActivity);
    
    ActivityToJson actToJson = new ActivityToJson();
    completionMessage = actToJson.updateActivityData(updateActivityList);
    
    LOGGER.info(" ********* In doGet() - end ********* ");
    
    response.setContentType("text/plain");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(completionMessage);
  }
  
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {}
}
