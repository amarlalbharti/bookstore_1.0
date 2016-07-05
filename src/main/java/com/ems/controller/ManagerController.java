package com.ems.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ems.config.DateFormats;
import com.ems.config.ProjectConfig;
import com.ems.config.Roles;
import com.ems.config.Validation;
import com.ems.domain.Attendance;
import com.ems.domain.BankDetail;
import com.ems.domain.Documents;
import com.ems.domain.LeaveDetail;
import com.ems.domain.LoginInfo;
import com.ems.domain.Notification;
import com.ems.domain.Payroll;
import com.ems.domain.Registration;
import com.ems.domain.UserRole;
import com.ems.service.AttendanceService;
import com.ems.service.BankDetailService;
import com.ems.service.DocumentsService;
import com.ems.service.LeaveService;
import com.ems.service.LoginInfoService;
import com.ems.service.MailService;
import com.ems.service.NotificationService;
import com.ems.service.PayrollService;
import com.ems.service.RegistrationService;
import com.ems.service.UserRoleService;

@Controller
public class ManagerController {
	@Autowired private AttendanceService attendanceService; 
	@Autowired private RegistrationService registrationService; 
	@Autowired private LoginInfoService loginInfoService;
	@Autowired private UserRoleService userRoleService;
	@Autowired private MailService mailservice;
	@Autowired private DocumentsService documentService;
	@Autowired private NotificationService notificationService;
	@Autowired private BankDetailService bankDetailService;
	@Autowired private PayrollService payrollService;
	@Autowired private LeaveService leaveService;
	
	DateFormats df = new DateFormats();
	
	@RequestMapping(value = "/managerDashboard", method = RequestMethod.GET)
	public String managerdashboard(ModelMap map, HttpServletRequest request, Principal principal)
	{
		TimeZone timeZone = (TimeZone)request.getSession(true).getAttribute("timezone");

		List<Attendance> atts = attendanceService.getTodaysAttendance(principal.getName());
		map.addAttribute("attsList", atts);
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);
	    calendar.set(Calendar.MINUTE, 0);
	    calendar.set(Calendar.SECOND, 0);
	    calendar.set(Calendar.MILLISECOND, 0);
	    calendar.set(Calendar.DATE, 1);
		List<LeaveDetail> leave = leaveService.getLeaveList(calendar.getTime(), new Date());
		calendar.add(Calendar.MONTH, -1);
		Date sDate = calendar.getTime();
		calendar.add(Calendar.MONTH, 1);
		calendar.add(Calendar.SECOND, -1);
		Date eDate = calendar.getTime();
		List<Payroll> payroll = payrollService.getOneMonthPayroll(sDate, eDate);
		map.addAttribute("emp_count", registrationService.countOnlyEmployees());
		map.addAttribute("emp_in_count", attendanceService.countTodaysUserAttendance());
		map.addAttribute("payList", payroll.size());
		map.addAttribute("leaveList", leave.size());
		return "managerDashboard";
	}
	
	@RequestMapping(value = "/managerEmpChangePassword", method = RequestMethod.POST)
	public String managerEmpChangePassword(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String empid = request.getParameter("empid");
		if(empid != null)
		{
			String newPassword = request.getParameter("newPassword");
			String confPassword = request.getParameter("confPassword");
			if(newPassword != null && confPassword != null && newPassword.equals(confPassword) && Validation.validatePassword(newPassword))
			{
				Registration registration = registrationService.getRegistrationByUserid(principal.getName());
				Registration reg = registrationService.getRegistrationByUserid(empid);
				LoginInfo info = loginInfoService.getLoginInfoByUserid(empid);
				if(reg != null && info != null)
				{
					loginInfoService.resetPassword(empid, newPassword);
					map.addAttribute("pwdstatus", "success");
					
					
					Notification notification=new Notification();
					notification.setType("password");
					notification.setNotiMsg("Password has been Changed by "+registration.getName());
					notification.setNotiId(info.getLid());
					notification.setNotiTo(reg.getUserid());
					notificationService.addNotification(notification);
					
					
					
					return "redirect:managerViewEmployee?empid="+empid;
				}
				map.addAttribute("pwdstatus", "notfound");
				return "redirect:managerViewEmployee?empid="+empid;
			}
			map.addAttribute("pwdstatus", "notsame");
			return "redirect:managerViewEmployee?empid="+empid;
		}
		map.addAttribute("pwdstatus", "error");
		return "redirect:managerViewEmployee?empid="+empid;
	}
	
	@RequestMapping(value = "/managerCheckInOut", method = RequestMethod.GET)
	public String attendance(ModelMap map, HttpServletRequest request, Principal principal)
	{
		TimeZone timeZone = (TimeZone)request.getSession(true).getAttribute("timezone");
		
		String qdate = request.getParameter("qdate");
		Date dt = df.getDate(timeZone);
		if(qdate != null)
		{
			try 
			{
				dt = DateFormats.ddMMyyyy().parse(qdate);
				if(dt.after(df.getDate(timeZone)))
				{
					dt = df.getDate(timeZone);
				}
			}
			catch (Exception e) 
			{
				dt = df.getDate(timeZone);
				e.printStackTrace();
			}
		}
		List<Attendance> atts = attendanceService.getUserAttendanceByDate(dt);
		map.addAttribute("attsList", atts);
		map.addAttribute("qdate", dt);
		return "managerattendance";
	}
	
	@RequestMapping(value = "/manageremployees", method = RequestMethod.GET)
	public String employees(ModelMap map, HttpServletRequest request, Principal principal)
	{
		List<Registration> regList = registrationService.getEmpRegistrationList();
		Map<String, List<UserRole>> roles = new HashMap<String, List<UserRole>>();
		for(Registration reg : regList)
		{
			roles.put(reg.getUserid(), this.userRoleService.getUserRolesByUserid(reg.getUserid()));
		}
		
		map.addAttribute("regList", regList);
		map.addAttribute("roleList", roles);
		return "manageremployees";
	}
	
	@RequestMapping(value = "/managerViewEmpAttendence", method = RequestMethod.GET)
	public String managerviewEmpAttendence(@RequestParam(value="empid")String empid, ModelMap map, HttpServletRequest request, Principal principal)
	{
		TimeZone timeZone = (TimeZone)request.getSession(true).getAttribute("timezone");
		
		
		Date dt = df.getDate(timeZone);
		String qm = request.getParameter("qm");
		if(qm != null)
		{
			try 
			{
				dt = DateFormats.monthformat().parse(qm);
				if(dt.after(df.getDate(timeZone)))
				{
					dt = df.getDate(timeZone);
				}
			}
			catch (Exception e) 
			{
				dt = df.getDate(timeZone);
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
	    if(edate.after(df.getDate(timeZone)))
		{
	    	edate = df.getDate(timeZone);
		}
	    
	    map.addAttribute("empReg", registrationService.getRegistrationByUserid(empid));
		map.addAttribute("attList", attendanceService.getAttendanceBetweenTwoDates(empid,sdate, edate));
		map.addAttribute("sdate", sdate);
		return "managerviewEmpAttendence";
	}
	
	@RequestMapping(value = "/managerProfile", method = RequestMethod.GET)
	public String viewProfile(ModelMap map, HttpServletRequest request, Principal principal)
	{
		map.addAttribute("pwdstatus", request.getParameter("pwdstatus"));
		map.addAttribute("registration", registrationService.getRegistrationByUserid(principal.getName()));
		System.out.println("from index page of managerprofile");
		return "managerProfile";
	}
	
	@RequestMapping(value = "/managerViewEmployee", method = RequestMethod.GET)
	public String adminViewEmployee(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String empid = request.getParameter("empid");
		map.addAttribute("pwdstatus", request.getParameter("pwdstatus"));
		
		if(empid != null && empid.length() > 0)
		{
			Registration reg = registrationService.getRegistrationByUserid(empid);
			if(reg != null)
			{
				map.addAttribute("roles", userRoleService.getUserRolesByUserid(empid) );
				map.addAttribute("empReg", reg);
				return "managerViewEmployee";
			}
		}
		return "redirect:manageremployees";
	}
	
	@RequestMapping(value = "/managerchangepassword", method = RequestMethod.GET)
	public String managerchangepassword(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String oldPassword=request.getParameter("j_password1");
		String newPassword=request.getParameter("j_password2");
		String confirmPassword=request.getParameter("j_password3");
		if(newPassword.equals(confirmPassword))
		{
			String status = loginInfoService.changeUserPassword(principal.getName(), oldPassword, newPassword);
			map.addAttribute("pwdstatus", status);
		}
		else
		{
			map.addAttribute("pwdstatus", "notsame");
		}
		
		if(request.isUserInRole(Roles.ROLE_ADMIN))
		{
			return "redirect:adminProfile";
		}
		else if(request.isUserInRole(Roles.ROLE_MANAGER))
		{
			return "redirect:managerProfile";
		}
		else if(request.isUserInRole(Roles.ROLE_USER))
		{
			return "redirect:userprofile";
		}
		else
		{
			return "redirect:error";
		}
		
	}
	
	@RequestMapping(value = "/profileImageUpload")
    public @ResponseBody String ajaxFileUpload(MultipartHttpServletRequest request, HttpServletRequest req, Principal principal)throws ServletException, IOException
    {   
		if(principal != null)
		{
			MultipartFile mpf = null;
			int flag=0;
			Iterator<String> itr=request.getFileNames();
			while(itr.hasNext()){
			mpf=request.getFile(itr.next());
			flag++;
	        boolean isMultipart=ServletFileUpload.isMultipartContent(request);
	        System.out.println("is file " + isMultipart + " file name " + mpf.getOriginalFilename());
			}
			if(flag > 0 && mpf != null && mpf.getOriginalFilename() != null && mpf.getOriginalFilename() != "")
			{
				String filename=null;
				filename=mpf.getOriginalFilename().replace(" ", "-");
				File dl = new File (ProjectConfig.upload_path+"/"+filename);
		    	String datafile= ProjectConfig.upload_path+"/"+filename;
		    	System.out.println("PATH="+datafile);
			    if(!dl.exists()){
			    	System.out.println("in not file"+dl.getAbsolutePath());
				    dl.mkdirs();
			    }
				Registration registration = registrationService.getRegistrationByUserid(principal.getName());
				registration.setProfileImage(filename);
				registrationService.updateRegistration(registration);
				mpf.transferTo(dl);
				//ImageResizer.resizedUpload(dl.getAbsolutePath());
				System.out.println("multiple images uploaded");
				return filename;
			}
		}
		return "failed";
    }
	
	@RequestMapping(value = "/managerSendMessage", method = RequestMethod.GET)
	public String managerSendMessage(ModelMap map, HttpServletRequest request, Principal principal)
	{
		return "managerSendMessage";
	}
	
	@RequestMapping(value = "/managerSendMessage", method = RequestMethod.POST)
	public String managerSendMessages(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String emails = request.getParameter("email");
		String msg = request.getParameter("msg");
		String sub = request.getParameter("sub");
		if(emails != null && !msg.isEmpty() && !sub.isEmpty())
		{
			try{
			String subject = sub;
			String content = msg;
			mailservice.sendMail("bhuwaneshwar.chaudhary@vasonomics.com", emails, "", subject, content);
			map.addAttribute("mail", "success");
			return "redirect:manageremployees";
			}
			catch (Exception e) {
				e.printStackTrace();
				map.addAttribute("mail", "excp");
				return "redirect:manageremployees";
			}
		}
		else
		{
			map.addAttribute("mail", "blank");
			return "redirect:manageremployees";
		}
	}
	
	@RequestMapping(value = "/managerFullReport", method = RequestMethod.GET)
	public String managerFullReport(ModelMap map, HttpServletRequest request, Principal principal)
	{
		return "managerFullReport";
	}
	@RequestMapping(value = "/managerFullReport", method = RequestMethod.POST)
	public String managerFullReportSubmit(ModelMap map, HttpServletRequest request, Principal principal)
	{
		TimeZone timeZone = (TimeZone)request.getSession(true).getAttribute("timezone");
		
		
		Calendar calendar = Calendar.getInstance();
		
		String empid=(String) request.getParameter("empid");
		String doc = (String) request.getParameter("doc");
		String attdn = (String) request.getParameter("attdn");

		if(empid != null && !empid .isEmpty())
		{
			Registration empReg = registrationService.getRegistrationByUserid(empid);
			map.addAttribute("empReg", empReg);
		
			if(doc != null && !doc .isEmpty())
			{
				List<Documents> docList = documentService.getDocumentsByUserId(empid);
				map.addAttribute("docList", docList);
			}
			if(attdn != null && !attdn .isEmpty())
			{
				String attdns = (String) request.getParameter("attdns");
				if((attdns != null && !attdns.isEmpty()) && attdns.equals("all"))
				{
					List<Attendance> attList = attendanceService.getAttendanceBetweenTwoDates(empid, empReg.getJoiningDate(), calendar.getTime());
					Collections.reverse(attList);
					map.addAttribute("attList", attList);
				}
				if((attdns != null && !attdns.isEmpty()) && attdns.equals("filter"))
				{
					String sdat = (String) request.getParameter("sdate");
					String edat = (String) request.getParameter("edate");
					try
					{
						Date sdate = DateFormats.ddMMyyyy(timeZone).parse(sdat);
						Date edate = DateFormats.ddMMyyyy(timeZone).parse(edat);
						if(sdate != null && edate != null)
						{
							List<Attendance> attList = attendanceService.getAttendanceBetweenTwoDates(empid, sdate, edate);
							Collections.reverse(attList);
							map.addAttribute("attList", attList);
						}
					}
					catch (Exception e) {
						// TODO: handle exception
					}
				}
			}
			return "managerFullReportPrint";
		}
		return "redirect:managerFullReport";
	}
}
