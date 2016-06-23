package com.ems.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.security.Principal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TimeZone;

import javax.imageio.spi.RegisterableService;
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
import com.ems.domain.Attendance;
import com.ems.domain.Branch;
import com.ems.domain.Notification;
import com.ems.domain.Payroll;
import com.ems.domain.Registration;
import com.ems.service.AttendanceService;
import com.ems.service.NotificationService;
import com.ems.service.PayrollService;
import com.ems.service.RegistrationService;

@Controller
public class PayrollController {
	@Autowired private PayrollService payrollService;
	@Autowired private RegistrationService registrationService;
	@Autowired private AttendanceService attendanceService;
	@Autowired private NotificationService notificationService; 
	
	DateFormats df = new DateFormats();
	
	@RequestMapping(value = "/securePayrollList", method = RequestMethod.GET)
	public String securePayrollList(ModelMap map, HttpServletRequest request, Principal principal)
	{
		map.addAttribute("pList", payrollService.getPayrollList());
		return "viewPayroll";
	}
	
	@RequestMapping(value = "/secureAddPayroll", method = RequestMethod.GET)
	public String secureAddPayroll(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String pid = (String) request.getParameter("pid");
		if(pid != null && !pid.isEmpty())
		{
			Payroll payroll = payrollService.getPayrollById(Integer.parseInt(pid));
			if(payroll != null)
			{
				map.addAttribute("payroll", payroll);
			}
		}
		return "addPayroll";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/secureAddPayrollSubmit", method = RequestMethod.GET)
	@ResponseBody
	public String secure_AddPayroll(ModelMap map, HttpServletRequest request, Principal principal)
	{
		TimeZone timeZone = (TimeZone)request.getSession(true).getAttribute("timezone");
		
		String pId, eId, bSal, hrAlwnc, trnspAlwnc, lveTrvlAlwnc, splAlwnc, salAdv, pf, tds, otDed, tlEr, tlDd, ntPay, payMonth, food, rent;
		pId = (String) request.getParameter("pId");
		eId = (String) request.getParameter("eId");
		bSal = (String) request.getParameter("bSal");
		hrAlwnc = (String) request.getParameter("hrAlwnc");
		trnspAlwnc = (String) request.getParameter("trnspAlwnc");
		lveTrvlAlwnc = (String) request.getParameter("lveTrvlAlwnc");
		splAlwnc = (String) request.getParameter("splAlwnc");
		
		salAdv = (String) request.getParameter("salAdv");
		pf = (String) request.getParameter("pf");
		tds = (String) request.getParameter("tds");
		otDed = (String) request.getParameter("otDed");
		
		food = (String) request.getParameter("food");
		rent = (String) request.getParameter("rent");
		
		tlEr = (String) request.getParameter("tlEr");
		tlDd = (String) request.getParameter("tlDd");
		ntPay = (String) request.getParameter("ntPay");
		payMonth =(String) request.getParameter("payMonth");
		
		JSONObject object = new JSONObject();
		
		if(eId != null && bSal != null && hrAlwnc != null && trnspAlwnc != null && lveTrvlAlwnc != null && splAlwnc != null && salAdv != null && pf != null && tds != null && otDed != null && tlEr != null && tlDd != null && ntPay != null && payMonth != null && food != null && rent != null)
		{
			//***********************
			Date dt = df.getDate(timeZone);
			Date datetime = new Date();
			if(payMonth != null)
			{
				try 
				{
					dt = DateFormats.monthformat(timeZone).parse(payMonth);
				}
				catch (Exception e) 
				{
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
		    calendar.add(Calendar.SECOND, -1);
		    
		    Date edate = calendar.getTime();
			
			
		    List<Payroll> chkList = payrollService.getOneMonthPayroll(eId, sdate, edate);
		    //if(chkList != null )
		    if(chkList == null || chkList.isEmpty() || chkList.get(0).getDeleteDate() != null)
		    {
				Registration reg = registrationService.getRegistrationByUserid(eId);
				Registration registration = registrationService.getRegistrationByUserid(principal.getName());
				
				if(reg != null)
				{
				    List<Attendance> attList = attendanceService.getAttendanceBetweenTwoDates(eId, sdate, edate);
					Set<Date> set = new HashSet();
					int presentDay = 0;
					if(attList != null && !attList.isEmpty())
					{
						for(Attendance at : attList)
						{
							try {
								set.add(DateFormats.ddMMyyyy().parse(DateFormats.ddMMyyyy(timeZone).format(at.getInTime())));
							} catch (ParseException e) {
								e.printStackTrace();
							}
						}
						presentDay = set.size();
					}
						
					if(pId == null)
					{
						Payroll payroll = new Payroll();
						try
						{
							payroll.setRegistration(reg);
							payroll.setBasicSal(Double.parseDouble(bSal));
							payroll.setCreateDate(datetime);
							payroll.setHrAllowance(Double.parseDouble(hrAlwnc));
							payroll.setTransportAllowance(Double.parseDouble(trnspAlwnc));
							payroll.setLeaveTravelAllowance(Double.parseDouble(lveTrvlAlwnc));
							payroll.setSpecialAllowance(Double.parseDouble(splAlwnc));
							payroll.setSalaryAdvance(Double.parseDouble(salAdv));
							payroll.setPfDeduction(Double.parseDouble(pf));
							payroll.setTdsDeduction(Double.parseDouble(tds));
							payroll.setOtherDeduction(Double.parseDouble(otDed));
							payroll.setTotelEarning(Double.parseDouble(tlEr));
							payroll.setTotelDeduction(Double.parseDouble(tlDd));
							payroll.setNetPay(Double.parseDouble(ntPay));
							payroll.setPayMonth(DateFormats.monthformat().parse(payMonth));
							payroll.setFoodDeduction(Double.parseDouble(food));
							payroll.setRentDeduction(Double.parseDouble(rent));
							payroll.setNoOfPresentDays(presentDay);
							payrollService.addPayroll(payroll);
							
							
							Notification notification=new Notification();
							notification.setType("payroll");
							notification.setNotiId(payroll.getPid());
							notification.setNotiMsg("Payroll has been Generated by "+registration.getName());
							notification.setNotiTo(reg.getUserid());
							notificationService.addNotification(notification);
							
							object.put("error", false);
							return object.toJSONString();
						}
						catch(Exception e)
						{
							object.put("error", true);
							return object.toJSONString();
						}
					}
					else
					{
						Payroll payroll = payrollService.getPayrollById(Integer.parseInt(pId));
						try
						{
							payroll.setBasicSal(Double.parseDouble(bSal));
							payroll.setModifiedDate(datetime);
							payroll.setHrAllowance(Double.parseDouble(hrAlwnc));
							payroll.setTransportAllowance(Double.parseDouble(trnspAlwnc));
							payroll.setLeaveTravelAllowance(Double.parseDouble(lveTrvlAlwnc));
							payroll.setSpecialAllowance(Double.parseDouble(splAlwnc));
							payroll.setSalaryAdvance(Double.parseDouble(salAdv));
							payroll.setPfDeduction(Double.parseDouble(pf));
							payroll.setTdsDeduction(Double.parseDouble(tds));
							payroll.setOtherDeduction(Double.parseDouble(otDed));
							payroll.setTotelEarning(Double.parseDouble(tlEr));
							payroll.setTotelDeduction(Double.parseDouble(tlDd));
							payroll.setNetPay(Double.parseDouble(ntPay));
							payroll.setFoodDeduction(Double.parseDouble(food));
							payroll.setRentDeduction(Double.parseDouble(rent));
							payrollService.updatePayroll(payroll);
							
							Notification notification=new Notification();
							notification.setType("payroll");
							notification.setNotiId(Integer.parseInt(pId));
							notification.setNotiMsg("Payroll has been Updated by "+registration.getName());
							notification.setNotiTo(reg.getUserid());
							notificationService.addNotification(notification);

							
							object.put("msg", "edit");
							object.put("error", false);
							return object.toJSONString();
						}
						catch(Exception e)
						{
							object.put("error", true);
							return object.toJSONString();
						}
					}
				}
				object.put("msg", "reg_error");
				object.put("error", true);
				return object.toJSONString();
		    }
		    object.put("msg", "val_exists");
			object.put("error", true);
			return object.toJSONString();
		}
		object.put("msg", "val_error");
		object.put("error", true);
		return object.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getEmpData", method = RequestMethod.GET)
	@ResponseBody
	public String getEmpDate(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String eId = request.getParameter("eId");
		JSONObject object = new JSONObject();
		if(eId != null)
		{
			Registration reg = registrationService.getRegistrationByUserid(eId);
			if(reg != null)
			{
				if(reg.getBankDetail() != null)
				{
					JSONObject at = new JSONObject();
					at.put("name", reg.getName());
					at.put("desg", reg.getDesignation().getDesignation());
					at.put("bSal", reg.getBankDetail().getBasicSalary());
					object.put("reg", at);
					object.put("error", false);
					return object.toJSONString();
				}
				else
				{
					object.put("msg", "NA");
					object.put("error", true);
					return object.toJSONString();
				}
			}
			object.put("msg", "regNull");
			object.put("error", true);
			return object.toJSONString();
		}
		object.put("error", true);
		return object.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/adminDeletePayroll", method = RequestMethod.GET)
	@ResponseBody
	public String deleteBranch(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String pid = request.getParameter("pid");
		JSONObject object = new JSONObject();
		if(pid != null)
		{
			Payroll pr = payrollService.getPayrollById(Integer.parseInt(pid));
			if(pr != null)
			{
				Date date = new Date();
				java.sql.Date dt = new java.sql.Date(date.getTime());
				pr.setModifiedDate(dt);
				pr.setDeleteDate(dt);
				payrollService.updatePayroll(pr);
				object.put("error", false);
				return object.toJSONString();
			}
		}
		object.put("error", true);
		return object.toJSONString();
	}
	
	@RequestMapping(value = "/viewPayrollReport", method = RequestMethod.GET)
	public String viewPayrollReport(ModelMap map, HttpServletRequest request, Principal principal)
	{
//		map.addAttribute("eList", registrationService.getRegistrationList());
		return "viewPayrollReport";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getEmpName", method = RequestMethod.GET)
	@ResponseBody
	public String getEmpName(ModelMap map, HttpServletRequest request, Principal principal)
	{
		TimeZone timeZone = (TimeZone)request.getSession(true).getAttribute("timezone");
		Date dt = df.getDate(timeZone);
		String qm = request.getParameter("month");
		System.out.println(qm);
		JSONObject object = new JSONObject();
		if(qm != null)
		{
			try 
			{
				dt = DateFormats.monthformat().parse(qm);
			}
			catch (Exception e) 
			{
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
	    calendar.add(Calendar.SECOND, -1);
	    Date edate = calendar.getTime();
//	    if(edate.after(df.getDate(timeZone)))
//		{
//	    	edate = df.getDate(timeZone);
//		}
		System.out.println(sdate);
		System.out.println(edate);
		List<Payroll> payrollList = payrollService.getOneMonthPayroll(sdate, edate);
		if(payrollList != null && !payrollList.isEmpty())
		{
			JSONArray arr = new JSONArray();
			for(Payroll pp : payrollList)
			{
				JSONObject at = new JSONObject();
				at.put("name", pp.getRegistration().getName());
				at.put("userId", pp.getRegistration().getUserid());
				arr.add(at);
			}
			object.put("empList", arr);
			object.put("error", false);
			return object.toJSONString();
		}
		object.put("msg", "listEmpty");
		object.put("error", true);
		return object.toJSONString();
	}
	
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/securePayrollReport", method = RequestMethod.GET)
	public String securePayrollReport(ModelMap map, HttpServletRequest request, Principal principal)
	{
		TimeZone timeZone = (TimeZone)request.getSession(true).getAttribute("timezone");
		String eNames = request.getParameter("E_Names");
		String qm = request.getParameter("month");
		if(eNames != null && !eNames.isEmpty() && !eNames.equals("null") && qm != null && !qm.isEmpty())
		{
			try 
			{
			String st = URLDecoder.decode(eNames, "UTF-8");
			eNames = st;
			Date dt = df.getDate(timeZone);
			if(qm != null)
			{
				try 
				{
					dt = DateFormats.monthformat().parse(qm);
				}
				catch (Exception e) 
				{
					map.addAttribute("status", "error_F");
					e.printStackTrace();
					return "showPayrollReport";
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
		    calendar.add(Calendar.SECOND, -1);
		    Date edate = calendar.getTime();
		    
			    List<Payroll> payrollList = new ArrayList<Payroll>();
				ArrayList list= new ArrayList(Arrays.asList(eNames.split(",")));
				if(list != null && !list.isEmpty())
				{
					for (int i=0;i<list.size();i++) 
					{
						String userId = list.get(i).toString();
						if(userId.equals("1"))
							{continue;}
						List<Payroll> tmpPayrollList = payrollService.getOneMonthPayroll(userId, sdate, edate);
						if(tmpPayrollList != null)
						{
							payrollList.add(tmpPayrollList.get(0));
						}
					}
					map.addAttribute("payList", payrollList);
					return "showPayrollReport";
				}
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
		}
		map.addAttribute("status", "error");
		return "showPayrollReport";
	}
	
}
