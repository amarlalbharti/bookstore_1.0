package com.ems.controller;

import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ems.config.DateFormats;
import com.ems.config.Util;
import com.ems.domain.Attendance;
import com.ems.domain.Notification;
import com.ems.domain.Registration;
import com.ems.service.AttendanceService;
import com.ems.service.MailService;
import com.ems.service.NotificationService;
import com.ems.service.RegistrationService;

@Controller
public class AttendanceController 
{
	@Autowired private NotificationService notificationService;
	@Autowired private RegistrationService registrationService; 
	@Autowired private AttendanceService attendanceService; 
	@Autowired private MailService mailservice;
	
	@RequestMapping(value = "/empCheckIn", method = RequestMethod.GET)
	public String userCheckIn(ModelMap map, HttpServletRequest request, Principal principal)
	{
		if(principal != null)
		{
			TimeZone timezone = (TimeZone)request.getSession(true).getAttribute("timezone");
			Registration reg = registrationService.getRegistrationByUserid(principal.getName());
			
			Date date = new Date();
			java.sql.Date inTime = new java.sql.Date(date.getTime());
			
			Attendance attendance = new Attendance();
			attendance.setInTime(inTime);
			attendance.setRegistration(reg);
			attendanceService.addAddtendance(attendance);
			String subject= reg.getName()+" : Login Alert "+DateFormats.ddMMyyyy(timezone).format(date);
			String content= "Dear Sir/Ma'am, <br><br> I Login at "+DateFormats.timeformat(timezone).format(date);
			mailservice.sendMail("saumya.srivastava@vasonomics.com", null, null, subject, content);
		}
		return "redirect:userHome";
	}
	
	@RequestMapping(value = "/empCheckOut", method = RequestMethod.GET)
	public String empCheckOut(ModelMap map, HttpServletRequest request, Principal principal)
	{
		if(principal != null)
		{
			TimeZone timezone = (TimeZone)request.getSession(true).getAttribute("timezone");
			Registration reg = registrationService.getRegistrationByUserid(principal.getName());
			List<Attendance> list = attendanceService.getTodaysAttendance(principal.getName());
			if(list != null && list.get(0).getOutTime() == null)
			{
				Date date = new Date();
				java.sql.Date dt = new java.sql.Date(date.getTime());
				Date outTime = new Date(date.getTime());
				Attendance attendance = list.get(0);
				String task=request.getParameter("task");
				attendance.setOutTime(dt);
				attendance.setTask(task);
				attendanceService.updateAddtendance(attendance);
				String subject=reg.getName()+" :Logout Alert "+DateFormats.ddMMyyyy(timezone).format(dt);
				String content="Dear Sir/Ma'am, <br><br> I Logout at "+DateFormats.timeformat(timezone).format(outTime)+"<br><br> "+task;
				mailservice.sendMail("saumya.srivastava@vasonomics.com","", "", subject, content);
			}
		}
		return "redirect:userHome";
	}
	
	@RequestMapping(value = "/empCheckOut", method = RequestMethod.POST)
	public String userCheckOut(ModelMap map, HttpServletRequest request, Principal principal)
	{
		if(principal != null)
		{
			TimeZone timezone = (TimeZone)request.getSession(true).getAttribute("timezone");
			Registration reg = registrationService.getRegistrationByUserid(principal.getName());
			List<Attendance> list = attendanceService.getTodaysAttendance(principal.getName());
			if(list != null && list.get(0).getOutTime() == null)
			{
				Date date = new Date();
				java.sql.Date dt = new java.sql.Date(date.getTime());
				Date outTime = new Date(date.getTime());
				Attendance attendance = list.get(0);
				String task=request.getParameter("task");
				attendance.setOutTime(dt);
				attendance.setTask(task);
				attendanceService.updateAddtendance(attendance);
				
				String subject=reg.getName()+" :Logout Alert "+DateFormats.ddMMyyyy(timezone).format(dt);
				
				String content="Dear Sir/Ma'am, <br><br> I Logout at "+DateFormats.timeformat(timezone).format(outTime)+"<br><br> "+task;
				
				mailservice.sendMail("saumya.srivastava@vasonomics.com", "", "", subject, content);
		
			}
		}
		return "redirect:userHome";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/editAttendance", method = RequestMethod.GET)
	@ResponseBody
	public String editAttendance(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject object = new JSONObject();
		TimeZone timezone = (TimeZone)request.getSession(true).getAttribute("timezone");
		
		String aid = (String)request.getParameter("aid");
		System.out.println("aid : " + aid);
		if(aid != null && aid.length() > 0)
		{
			Attendance att = attendanceService.getAttendanceById(Integer.parseInt(aid));
			if(att != null)
			{
				JSONObject at = new JSONObject();
				at.put("date", DateFormats.ddMMMyyyy(timezone).format(att.getInTime()));
				at.put("inTime", DateFormats.timeformat(timezone).format(att.getInTime()));
				if(att.getOutTime() != null)
				{
					at.put("outTime", DateFormats.timeformat(timezone).format(att.getOutTime()));
				}
				else
				{
					at.put("outTime", "");
				}
				at.put("wh", DateFormats.getWorkingHours(att.getInTime(), att.getOutTime()));
				if(att.getTask() != null)
				{
					at.put("task", att.getTask());
				}
				else
				{
					at.put("task", "");
				}
				object.put("error", false);
				object.put("att", at);
				return object.toJSONString();
			}
			object.put("error", true);
		}
		object.put("error", true);
		return object.toJSONString();
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updateAttendance", method = RequestMethod.GET)
	@ResponseBody
	public String updateAttendance(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject object = new JSONObject();
		TimeZone timezone = (TimeZone)request.getSession(true).getAttribute("timezone");
		
		String aid = (String)request.getParameter("aid");
		if(aid != null && aid.length() > 0)
		{
			Attendance att = attendanceService.getAttendanceById(Integer.parseInt(aid));
			if(att == null)
			{
				object.put("success", false);
				return object.toJSONString();
			}

			String inTime = request.getParameter("inTime");
			String outTime = request.getParameter("outTime");
			String task = request.getParameter("task");
			if(inTime != null && inTime.length() > 0)
			{
				try 
				{
					String st_in = DateFormats.ddMMyyyy(timezone).format(att.getInTime())+" "+inTime.trim();
					Date intime = DateFormats.fullformat2(timezone).parse(st_in);
					att.setInTime(intime);
					object.put("in_success", true);
					
					if(outTime != null && outTime.length() > 0){
						
						String st_out =  DateFormats.ddMMyyyy(timezone).format(att.getInTime())+" "+outTime.trim();
						Date outtime = DateFormats.fullformat2(timezone).parse(st_out);
						att.setOutTime(outtime);
						object.put("out_success", true);
					}
					
					att.setTask(task);
					attendanceService.updateAddtendance(att);
					
					String aa=att.getRegistration().getUserid();
					Registration reg = registrationService.getRegistrationByUserid(aa);
					Registration registration = registrationService.getRegistrationByUserid(principal.getName());
					
					Notification notification=new Notification();
					notification.setType("attendance");
					notification.setNotiId(Integer.parseInt(aid));
					notification.setNotiMsg("Attendance has been Updated by "+registration.getName());
					
					notification.setNotiTo(reg.getUserid());
					
					notificationService.addNotification(notification);
					
				}
				catch (Exception e) 
				{
					e.printStackTrace();
					object.put("success", false);
					return object.toJSONString();
				}
			}
			
			JSONObject at = new JSONObject();
			at.put("date", DateFormats.ddMMMyyyy(timezone).format(att.getInTime()));
			at.put("inTime", DateFormats.timeformat(timezone).format(att.getInTime()));
			if(att.getOutTime() != null)
			{
				at.put("outTime", DateFormats.timeformat(timezone).format(att.getOutTime()));
			}
			else
			{
				at.put("outTime", "");
			}
			at.put("wh", DateFormats.getWorkingHours(att.getInTime(), att.getOutTime()));
			if(att.getTask() != null)
			{
				at.put("task", att.getTask());
			}
			else
			{
				at.put("task", "");
			}
			object.put("att", at);
			object.put("success", true);
			return object.toJSONString();
		}
		object.put("success", false);
		return object.toJSONString();
	}
	
}
