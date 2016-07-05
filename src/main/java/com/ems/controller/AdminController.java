package com.ems.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TimeZone;

import javax.print.attribute.standard.DateTimeAtCompleted;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ems.config.DateFormats;
import com.ems.config.Validation;
import com.ems.domain.Attendance;
import com.ems.domain.Department;
import com.ems.domain.Designation;
import com.ems.domain.LeaveDetail;
import com.ems.domain.LoginInfo;
import com.ems.domain.Notification;
import com.ems.domain.Payroll;
import com.ems.domain.Registration;
import com.ems.domain.UserRole;
import com.ems.model.RegModel;
import com.ems.service.AttendanceService;
import com.ems.service.DepartmentService;
import com.ems.service.DesignationService;
import com.ems.service.LeaveService;
import com.ems.service.LoginInfoService;
import com.ems.service.NotificationService;
import com.ems.service.PayrollService;
import com.ems.service.RegistrationService;
import com.ems.service.UserRoleService;

@Controller
public class AdminController 
{
	@Autowired private AttendanceService attendanceService; 
	@Autowired private RegistrationService registrationService; 
	@Autowired private LoginInfoService loginInfoService;
	@Autowired private DepartmentService departmentService;
	@Autowired private DesignationService designationService;
	@Autowired private UserRoleService userRoleService;
	@Autowired private NotificationService notificationService;
	@Autowired private PayrollService payrollService;
	@Autowired private LeaveService leaveService;
	
	DateFormats df = new DateFormats();
	
	@RequestMapping(value = "/adminDashboard", method = RequestMethod.GET)
	public String admindashboard(ModelMap map, HttpServletRequest request, Principal principal)
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
		map.addAttribute("emp_count", registrationService.countEmployees());
		map.addAttribute("emp_in_count", attendanceService.countTodaysAttendance());
		map.addAttribute("payList", payroll.size());
		map.addAttribute("leaveList", leave.size());
		System.out.println("my Time : " + df.getDate(timeZone));
		return "admindashboard";
	}
	
	@RequestMapping(value = "/adminCheckInOut", method = RequestMethod.GET)
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
					dt = df.getDate(timeZone);;
				}
			}
			catch (Exception e) 
			{
				dt = df.getDate(timeZone);;
				e.printStackTrace();
			}
		}
		List<Attendance> atts = attendanceService.getAttendanceByDate(dt);
		map.addAttribute("attsList", atts);
		map.addAttribute("qdate", dt);
		return "adminattendance";
	}
	
	
	@RequestMapping(value = "/adminViewEmpAttendence", method = RequestMethod.GET)
	public String viewEmpAttendence(@RequestParam(value="empid")String empid, ModelMap map, HttpServletRequest request, Principal principal)
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
	    
	    System.out.println("Start And End : " + sdate + " && " + edate);
	    
	    map.addAttribute("empReg", registrationService.getRegistrationByUserid(empid));
		map.addAttribute("attList", attendanceService.getAttendanceBetweenTwoDates(empid,sdate, edate));
		map.addAttribute("sdate", sdate);
		return "viewEmpAttendence";
	}
	
	@RequestMapping(value = "/adminProfile", method = RequestMethod.GET)
	public String userprofile(ModelMap map, HttpServletRequest request, Principal principal)
	{
		TimeZone timeZone = (TimeZone)request.getSession(true).getAttribute("timezone");
		
		map.addAttribute("pwdstatus", request.getParameter("pwdstatus"));
		map.addAttribute("registration", registrationService.getRegistrationByUserid(principal.getName()));
		map.addAttribute("roles", userRoleService.getUserRolesByUserid(principal.getName()));
		System.out.println("from index page of userprofile");
		return "adminProfile";
	}
	@RequestMapping(value = "/adminEmpChangePassword", method = RequestMethod.POST)
	public String adminEmpChangePassword(ModelMap map, HttpServletRequest request, Principal principal)
	{
		TimeZone timeZone = (TimeZone)request.getSession(true).getAttribute("timezone");
		
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
					
					return "redirect:adminViewEmployee?empid="+empid;
				}
				map.addAttribute("pwdstatus", "notfound");
				return "redirect:adminViewEmployee?empid="+empid;
			}
			map.addAttribute("pwdstatus", "notsame");
			return "redirect:adminViewEmployee?empid="+empid;
		}
		map.addAttribute("pwdstatus", "error");
		return "redirect:adminViewEmployee?empid="+empid;
	}
	
	
	@RequestMapping(value = "/myCalendar", method = RequestMethod.GET)
	public String myCalendar(ModelMap map, HttpServletRequest request, Principal principal)
	{
		return "myCalendar";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/searchEmployees", method = RequestMethod.GET)
	@ResponseBody
	public String searchEmployees(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String search_text = request.getParameter("q");
		JSONArray array = new JSONArray();
		System.out.println("search_text : " + search_text);
		if(search_text != null && search_text.trim().length() > 2)
		{
			List<Registration> list = registrationService.searchEmp(search_text);
			if(list != null && !list.isEmpty())
			{
				for(Registration reg : list)
				{
					JSONObject r = new JSONObject();
					r.put("userid", reg.getUserid());
					r.put("name", reg.getName());
					array.add(r);
				}
				
			}
		}
		System.out.println("JSON : " + array.toJSONString());
		return array.toJSONString();
	}
	
	@SuppressWarnings({ "unchecked", "null" })
	@RequestMapping(value = "/searchEmployeeEvent", method = RequestMethod.GET)
	@ResponseBody
	public String searchEmployeeEvent(ModelMap map, HttpServletRequest request, Principal principal)
	{
		TimeZone timeZone = (TimeZone)request.getSession(true).getAttribute("timezone");
		Registration registration = (Registration)request.getSession().getAttribute("registration");
		List<Registration> regList = registrationService.getEmpRegistrationList();
		JSONObject obj = new JSONObject();
		if(registration != null)
		{
			String empid = registration.getUserid();
			Date dt = df.getDate(timeZone);
			dt = registration.getJoiningDate();
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(dt);
			calendar.set(Calendar.HOUR_OF_DAY, 0);
		    calendar.set(Calendar.MINUTE, 0);
		    calendar.set(Calendar.SECOND, 0);
		    calendar.set(Calendar.MILLISECOND, 0);
		    Date sdate = calendar.getTime();
		    
		    Date edate = df.getDate(timeZone);
		    
			List<Attendance> attList = attendanceService.getAttendanceBetweenTwoDates(empid,sdate, edate);
			
			List<LeaveDetail> lveList = leaveService.getLeaveBetweenTwoDates(empid, sdate, edate);
			List<String> absentList = new ArrayList<String>();
			JSONArray array = new JSONArray();
			try{
//    Attendence Notification
				if(attList != null && !attList.isEmpty())
				{
					for(Attendance at : attList)
					{
						absentList.add(DateFormats.ddMMyyyy(timeZone).format(at.getInTime()));
						
						String inTime = DateFormats.timeformat(timeZone).format(at.getInTime());
						String outTime;
						if(at.getOutTime() != null)
						{
							outTime = DateFormats.timeformat(timeZone).format(at.getOutTime());
						}
						else
						{
							outTime = "NA";
						}
						JSONObject r = new JSONObject();
						r.put("title", inTime + " - " + outTime);
						r.put("start", DateFormats.yyyyMMdd(timeZone).format(at.getInTime()));
						array.add(r);
					}
				}
				
// Leave Notification
				if(lveList != null && !lveList.isEmpty())
				{
					for(LeaveDetail lv : lveList)
					{
						absentList.add(DateFormats.ddMMyyyy(timeZone).format(lv.getFromDate()));
						
						JSONObject r = new JSONObject();
						r.put("title", "On Leave");
						r.put("start", DateFormats.yyyyMMdd(timeZone).format(lv.getFromDate()));
						r.put("end", DateFormats.yyyyMMdd(timeZone).format(lv.getToDate()));
						array.add(r);
					}
				}
				
// Absent Notification
				Calendar start = Calendar.getInstance();
				start.setTime(sdate);
				Calendar end = Calendar.getInstance();
				end.setTime(edate);
				for (Date date = start.getTime(); start.before(end); start.add(Calendar.DATE, 1), date = start.getTime()) 
				{
					Calendar cal = Calendar.getInstance();
					cal.setTime(date);
				    // Do your job here with `date`.
					String newDate = DateFormats.ddMMyyyy(timeZone).format(date);
				    if(absentList.contains(newDate))
				    	continue;
				    else if(cal.getTime().getDay() == registration.getWeekOff()-1)
				    	continue;
				    else
				    {
				    	JSONObject r = new JSONObject();
						r.put("title", "Absent");
						r.put("start", DateFormats.yyyyMMdd(timeZone).format(date));
						array.add(r);
				    }
				}
				
//		DOB Events
				
				if(regList != null && !regList.isEmpty())
				{
					for(Registration reg : regList)
					{
						int bday = DateFormats.ddMMyyyy().parse(reg.getDob()).getDate();
						int bmonth = DateFormats.ddMMyyyy().parse(reg.getDob()).getMonth() + 1;
						int byear = edate.getYear() + 1900;
						
						String DOB = byear + "-" + bmonth + "-" + bday;
						
						JSONObject r = new JSONObject();
						r.put("title", "BirthDay : "+reg.getName());
						r.put("start", DOB);
						array.add(r);
					}
				}
				
			}
			catch(Exception ee) 
			{
				ee.printStackTrace();
				obj.put("error", true);
				return obj.toJSONString();
			}
			obj.put("att", array);
			obj.put("weekOff", registration.getWeekOff());
			obj.put("error", false);
			return obj.toJSONString();
		}
		obj.put("error", true);
		return obj.toJSONString();
	}
}