package com.ems.controller;

import java.security.Principal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ems.config.DateFormats;
import com.ems.config.Roles;
import com.ems.domain.Designation;
import com.ems.domain.Notification;
import com.ems.domain.Registration;
import com.ems.service.NotificationService;
import com.ems.service.RegistrationService;



@Controller
public class NotificationController {
	
	@Autowired private NotificationService notificationService;
	@Autowired private RegistrationService registrationService;
	
	
	DateFormats df = new DateFormats();
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getNotificationCount", method = RequestMethod.GET)
	@ResponseBody
	public String getNotificationCount(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject obj = new JSONObject();
		obj.put("count", notificationService.countNotification(principal.getName()));
		return obj.toJSONString();
	}
	
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getNotificationList", method = RequestMethod.GET)
	@ResponseBody
	public String getNotificationList(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject obj = new JSONObject();
		List<Notification> list = notificationService.getUnviewedNotificationByUserId(principal.getName()); 
		JSONArray array = new JSONArray();
		
		for(Notification noti : list)
		{
			JSONObject nt = new JSONObject();
			nt.put("msg", noti.getNotiMsg());
			nt.put("nid", noti.getnId());
			nt.put("type", noti.getType());
			array.add(nt);
			
		}
		obj.put("notiList", array);
		
		notificationService.updateNotificationByUserId(principal.getName());
       
		return obj.toJSONString();
	}
	
	

	/*@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updateNotification", method = RequestMethod.GET)
	@ResponseBody
	public String updateNotification(ModelMap map, HttpServletRequest request, Principal principal)
	{
		
		JSONObject obj = new JSONObject();
		Registration reg = registrationService.getRegistrationByUserid(principal.getName());
		Notification notification = notificationService.getNotificationByUserId(reg.getLid());
			try{
				
				notification.setIsViewed("true");
				notificationService.updateNotification(notification);
				obj.put("error", false);
				return obj.toJSONString();
				
			}catch(Exception e){
				obj.put("error", true);
				return obj.toJSONString();
			}
		
		
		
	}*/
	
	
	@RequestMapping(value = "/notifications", method = RequestMethod.GET)
	public String viewnotification(ModelMap map, HttpServletRequest request, Principal principal)
	{
        Date dt = new Date();
		
		String qm = request.getParameter("qm");
		if(qm != null)
		{
			try 
			{
				dt = DateFormats.monthformat().parse(qm);
				if(dt.after(new Date()))
				{
					dt = new Date();
				}
			}
			catch (Exception e) 
			{
				dt = new Date();
				e.printStackTrace();
			}
		}
		
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dt);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
	    calendar.set(Calendar.MINUTE, 0);
	    calendar.set(Calendar.SECOND, 0);
	    calendar.set(Calendar.MILLISECOND, 0);
	    calendar.set(Calendar.DATE, 1);
	    Date sdate = calendar.getTime();
	    
	    calendar.add(Calendar.MONTH, 1);
	    Date edate = calendar.getTime();
	    if(edate.after(new Date()))
		{
	    	edate = new Date();
		}
	    
	    System.out.println("Start And End : " + sdate + " && " + edate);

		Registration reg=registrationService.getRegistrationByUserid(principal.getName());
		List<Notification> list = notificationService.getNotificationBetweenTwoDates(reg.getUserid(), sdate, edate); 
		map.addAttribute("nt_list", list);
		map.addAttribute("sdate", sdate);
		if(request.isUserInRole(Roles.ROLE_ADMIN))
		{
			return "adminNotifications";
		}
		else if(request.isUserInRole(Roles.ROLE_MANAGER))
		{
			return "managerNotifications";
		}
		else if(request.isUserInRole(Roles.ROLE_USER))
		{
			return "userNotifications";
		}
		else
		{
			return "redirect:error";
		}
		
	}	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/deleteNotification", method = RequestMethod.GET)
	@ResponseBody
	public String deleteDesignation(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String nId = request.getParameter("nId");
		JSONObject object = new JSONObject();
		if(nId != null)
		{
			Notification notification = notificationService.getNotificationById(Long.parseLong(nId));
			if(notification != null)
			{
				Date date = new Date();
				Date dt = new Date(date.getTime());
				
				notification.setDeleteDate(dt);
				notificationService.updateNotification(notification);
				object.put("error", false);
				return object.toJSONString();
			}
		}
		object.put("error", true);
		return object.toJSONString();
	}

}
