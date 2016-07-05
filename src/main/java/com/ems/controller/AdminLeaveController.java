package com.ems.controller;

import java.security.Principal;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ems.config.DateFormats;
import com.ems.domain.LeaveDetail;
import com.ems.domain.Notification;
import com.ems.domain.Registration;
import com.ems.service.LeaveService;
import com.ems.service.NotificationService;
import com.ems.service.RegistrationService;


@Controller
public class AdminLeaveController {
	
	@Autowired private RegistrationService registrationService; 
	@Autowired private LeaveService leaveService;
	@Autowired private NotificationService notificationService;
	
	@RequestMapping(value = "/secureleavesdash", method = RequestMethod.GET)
	public String secureleavesdash(ModelMap map, HttpServletRequest request, Principal principal)
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
		List<LeaveDetail> leaveList=leaveService.getLeaveList(sdate, edate);
		map.addAttribute("leaveList", leaveList);
		map.addAttribute("sdate", sdate);
		return "adminleavesdash";
	}
	
	@RequestMapping(value = "/secureViewLeave", method = RequestMethod.GET)
	public String secureviewleave(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String empid = request.getParameter("empid");
		if(empid != null && empid.length() > 0)
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
		    
		  	map.addAttribute("leaveList", leaveService.getLeaveBetweenTwoDates(empid,sdate, edate));
			map.addAttribute("sdate", sdate);
			Registration reg = registrationService.getRegistrationByUserid(empid);
				if(reg != null)
				{
					map.addAttribute("empReg", reg);
					return "adminViewLeave";
				}
			}
		return "adminleavesdash";  
	}

	@RequestMapping(value = "/secureApproveLeave", method = RequestMethod.GET)
	public String secureApproveLeave(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String leaveId = request.getParameter("leaveId");
		Registration reg = registrationService.getRegistrationByUserid(principal.getName());
		LeaveDetail leaveDetail=leaveService.getLeaveId(Integer.parseInt(leaveId));
		if(leaveDetail != null)
		{
			boolean flag=false;
			Date date = new Date();
			Date dt = new Date(date.getTime());
			leaveDetail.setApprovedDate(dt);
			leaveDetail.setApprovedBy(reg.getName());
			leaveDetail.setStatus("Approved");
			flag = leaveService.updateLeaveDetail(leaveDetail);
			Notification notification=new Notification();
			notification.setType("leave");
			notification.setNotiId(Integer.parseInt(leaveId));
			notification.setNotiMsg("Leave has been Approved by "+reg.getName());
			String user=leaveDetail.getRegistration().getUserid();
			notification.setNotiTo(user);
			notificationService.addNotification(notification);
		
			if(flag==true){
				map.addAttribute("status", "success");
			}
			else{
				map.addAttribute("status", "error");
			}
			System.out.println("update"+flag);
		}
		return "redirect:secureleavesdash";
	}
	
	
	@RequestMapping(value = "/secureDisapproveLeave", method = RequestMethod.GET)
	public String secureDisapproveLeave(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String leaveId = request.getParameter("leaveId");
		LeaveDetail leaveDetail=leaveService.getLeaveId(Integer.parseInt(leaveId));
		Registration reg = registrationService.getRegistrationByUserid(principal.getName());
		if(leaveDetail != null)
		{
			boolean flag=false;
			Date date = new Date();
			Date dt = new Date(date.getTime());
			leaveDetail.setApprovedDate(dt);
			leaveDetail.setApprovedBy(reg.getName());
			leaveDetail.setStatus("Reject");
			
			flag = leaveService.updateLeaveDetail(leaveDetail);
			
			Notification notification=new Notification();
			notification.setType("leave");
			notification.setNotiId(Integer.parseInt(leaveId));
			notification.setNotiMsg("Leave has been Rejected by "+reg.getName());
			
			String user=leaveDetail.getRegistration().getUserid();
			notification.setNotiTo(user);
			
			notificationService.addNotification(notification);
			
			if(flag==true){
				map.addAttribute("status", "success");
			}
			else{
				map.addAttribute("status", "error");
			}
			System.out.println("update"+flag);
		}
		return "redirect:secureleavesdash";
	}
	
	@RequestMapping(value = "/secureViewLv", method = RequestMethod.GET)
	public String userviewleave(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String leaveId = request.getParameter("leaveId");
		if(leaveId != null && leaveId.trim().length() > 0)
		{
			LeaveDetail leaveDetail=leaveService.getLeaveId(Integer.parseInt(leaveId));
			if(leaveDetail != null)
			{
				map.addAttribute("leaveDetail", leaveDetail);
				map.addAttribute("Mode", "view");
				System.out.println("from index page of userviewleave");
				return "leaveApplication";
			}
			
		}
		return "redirect:error";
	}
	
}
