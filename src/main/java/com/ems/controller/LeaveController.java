package com.ems.controller;

import java.security.Principal;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.ems.config.DateFormats;
import com.ems.domain.LeaveDetail;
import com.ems.domain.Notification;
import com.ems.domain.Registration;
import com.ems.model.LeaveDetailModel;
import com.ems.service.LeaveService;
import com.ems.service.MailService;
import com.ems.service.NotificationService;
import com.ems.service.RegistrationService;

@Controller
public class LeaveController {
	
	@Autowired private MailService mailservice;
	@Autowired private RegistrationService registrationService;
	@Autowired private LeaveService leaveService;
	@Autowired private NotificationService notificationService;
	
	@RequestMapping(value = "/userleaveapplication", method = RequestMethod.GET)
	public String userleave(ModelMap map, HttpServletRequest request, Principal principal)
	{
		
		map.addAttribute("leave", new LeaveDetailModel());
		map.addAttribute("Mode", "add");
		System.out.println("from index page of userleaveapplication");
		return "userleaveapplication";
	}

	
	@RequestMapping(value = "/useraddleave", method = RequestMethod.POST)
	public String addleavedetail(@ModelAttribute(value = "leave") @Valid LeaveDetailModel model,BindingResult result,
			                      @ModelAttribute(value = "user") LeaveDetail leave, BindingResult regResult,
			                      ModelMap map, HttpServletRequest request,Principal principal)
	{
		
		
		if (result.hasErrors())
		{
			System.out.println("in validation");
			return "userleaveapplication";
		} else
		{
			Date date = new Date();
			Date dt = new Date(date.getTime());
			leave.setRequestDate(dt);
			
			try 
			{   
				Registration reg = registrationService.getRegistrationByUserid(principal.getName());
				
				String subject=reg.getName()+": "+request.getParameter("subject");
			    String content=request.getParameter("reason");
			    String recepients=request.getParameter("cc");
			    //String[] cc = recepients.split(",");
			    String sendTo=request.getParameter("sendTo");
				leave.setRegistration(reg);
				leave.setFromDate(DateFormats.ddMMyyyy().parse(model.getFromDate()));
				leave.setToDate(DateFormats.ddMMyyyy().parse(model.getToDate()));
				leave.setStatus("pending");
				int status=leaveService.addLeaveDetail(leave);
				Notification notification=new Notification();
				notification.setType("leave");
				notification.setNotiId(status);
				notification.setNotiMsg("Leave has been applied by "+reg.getName());
				notification.setNotiTo(registrationService.getRegistrationByUserid(sendTo));
				notificationService.addNotification(notification);
				
				if(status>0){
					map.addAttribute("status", "success");
				}
				else{
					map.addAttribute("status", "error");
				}
				mailservice.sendMail(sendTo, recepients, "", subject, content);
				
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				return "userleaveapplication";
			}
			return "redirect:userleavedetail";
		}
		
	}
	
	@RequestMapping(value = "/usereditleave", method = RequestMethod.GET)
	public String editleavedetail(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String leaveId = (String)request.getParameter("leaveId");
		LeaveDetail leaveDetail=leaveService.getLeaveId(Integer.parseInt(leaveId));
		if(leaveDetail != null)
		{
			LeaveDetailModel model = new LeaveDetailModel();
			model.setLeaveId(leaveDetail.getLeaveId());		
	        model.setSendTo(leaveDetail.getSendTo());
	        model.setCc(leaveDetail.getCc());
	        model.setFromDate(DateFormats.ddMMyyyy().format(leaveDetail.getFromDate()));
	        model.setToDate(DateFormats.ddMMyyyy().format(leaveDetail.getToDate()));
	        model.setLeaveType(leaveDetail.getLeaveType());
	        model.setSubject(leaveDetail.getSubject());
	        model.setReason(leaveDetail.getReason());
			map.addAttribute("Mode", "edit");
			map.addAttribute("leave", model);
		}
		return "userleaveapplication";
	}
	
	
	@RequestMapping(value = "/usereditleave", method = RequestMethod.POST)
	public String editleave(@ModelAttribute(value = "leave") @Valid LeaveDetailModel model,BindingResult result,
			                ModelMap map, HttpServletRequest request, Principal principal)
	{
		if (result.hasErrors())
		{
	
			System.out.println("in validation");
			return "userleaveapplication";
		} else
		{
		String leaveId = (String)request.getParameter("leaveId");
		Registration reg = registrationService.getRegistrationByUserid(principal.getName());
		LeaveDetail leaveDetail=leaveService.getLeaveId(Integer.parseInt(leaveId));
		if(leaveDetail != null)
		{
			boolean flag=false;
			Date date = new Date();
			Date dt = new Date(date.getTime());
			leaveDetail.setModifiedDate(dt);
			leaveDetail.setSendTo(model.getSendTo());
			leaveDetail.setCc(model.getCc());
			try
			{
				leaveDetail.setFromDate(DateFormats.ddMMyyyy().parse(model.getFromDate()));
				leaveDetail.setToDate(DateFormats.ddMMyyyy().parse(model.getToDate()));
			} 
			catch (ParseException e) {
				e.printStackTrace();
			}
			leaveDetail.setLeaveType(model.getLeaveType());
			leaveDetail.setSubject(model.getSubject());
			leaveDetail.setReason(model.getReason());
			String subject=reg.getName()+": "+request.getParameter("subject");
		    String content=request.getParameter("reason");
		    String sendTo=request.getParameter("sendTo");
		    String cc=request.getParameter("cc");
		    //String[] cc = recepients.split(",");
			flag = leaveService.updateLeaveDetail(leaveDetail);
			Notification notification=new Notification();
			notification.setType("leave");
			notification.setNotiMsg("Leave has been updated by "+reg.getName());
			notification.setNotiId(Integer.parseInt(leaveId));
			notification.setNotiTo(registrationService.getRegistrationByUserid(sendTo));
			notificationService.addNotification(notification);
			if(flag==true){
				map.addAttribute("status", "success");
			}
			else{
				map.addAttribute("status", "error");
			}
			mailservice.sendMail(sendTo, cc, "", subject, content);
			System.out.println("update"+flag);
		}
		}
		return "redirect:userleavedetail";
	}
	
	
	@RequestMapping(value = "/userviewleave", method = RequestMethod.GET)
	public String userviewleave(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String leaveId = (String)request.getParameter("leaveId");
		LeaveDetail leaveDetail=leaveService.getLeaveId(Integer.parseInt(leaveId));
		map.addAttribute("leaveDetail", leaveDetail);
		map.addAttribute("Mode", "view");
		System.out.println("from index page of userviewleave");
		return "userleaveapplication";
	}
	
	@RequestMapping(value = "/userleavedetail", method = RequestMethod.GET)
	public String userleavedetail(ModelMap map, HttpServletRequest request, Principal principal)
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
	    
	  	map.addAttribute("leaveList", leaveService.getLeaveBetweenTwoDates(principal.getName(),sdate, edate));
		map.addAttribute("sdate", sdate);
		return "userleavedetail";
	}
	
	
	@RequestMapping(value = "/userprintleave", method = RequestMethod.GET)
	public String managerPrint(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String leaveId = (String)request.getParameter("leaveId");
		LeaveDetail leaveDetail=leaveService.getLeaveId(Integer.parseInt(leaveId));
		map.addAttribute("leaveDetail", leaveDetail);
		return "userprintleave";
			
	}

	@RequestMapping(value = "/demo", method = RequestMethod.GET)
	public String demo(ModelMap map, HttpServletRequest request, Principal principal)
	{
		return "demo";
	}
	
}
