package com.ems.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
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
import com.ems.domain.Notification;
import com.ems.domain.Registration;
import com.ems.domain.UserDetail;
import com.ems.model.BankDetailModel;
import com.ems.model.UserDetailModel;
import com.ems.service.AttendanceService;
import com.ems.service.BankDetailService;
import com.ems.service.LoginInfoService;
import com.ems.service.NotificationService;
import com.ems.service.RegistrationService;
import com.ems.service.UserDetailService;
import com.ems.service.UserRoleService;


@Controller
public class UserController {
	
	@Autowired private AttendanceService attendanceService; 
	@Autowired private LoginInfoService loginInfoService; 
	@Autowired private RegistrationService registrationService;
	@Autowired private UserDetailService userDetailService;
	@Autowired private BankDetailService bankDetailService;
	@Autowired private NotificationService notificationService;
	@Autowired private UserRoleService userRoleService;
	
	
	@RequestMapping(value = "/userDashboard", method = RequestMethod.GET)
	public String userdashboard(ModelMap map, HttpServletRequest request, Principal principal)
	{
		List<Attendance> atts = attendanceService.getTodaysAttendance(principal.getName());
		map.addAttribute("attsList", atts);
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);
	    calendar.set(Calendar.MINUTE, 0);
	    calendar.set(Calendar.SECOND, 0);
	    calendar.set(Calendar.MILLISECOND, 0);
	    calendar.set(Calendar.DATE, 1);
		System.out.println("start date of month : " + calendar.getTime());
		List<Attendance> lm_atts = attendanceService.getAttendanceBetweenTwoDates(principal.getName(), calendar.getTime(), new Date());
		map.addAttribute("lm_atts", lm_atts);
		System.out.println("from index page of userdashboard");
		return "userdashboard";
	}
	
		
	@RequestMapping(value = "/userchangepassword", method = RequestMethod.POST)
	public String changepassword(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String oldPassword=request.getParameter("j_password1");
		String newPassword=request.getParameter("j_password2");
		String confirmPassword=request.getParameter("j_password3");
		if(newPassword.equals(confirmPassword))
		{
			if(Validation.validatePassword(newPassword))
			{
				String status = loginInfoService.changeUserPassword(principal.getName(), oldPassword, newPassword);
				map.addAttribute("pwdstatus", status);
			}
			else
			{
				map.addAttribute("pwdstatus", "notvalid");
			}
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

	
	@RequestMapping(value = "/userAttendance", method = RequestMethod.GET)
	public String attendance( ModelMap map, HttpServletRequest request, Principal principal)
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
	    
	  	map.addAttribute("attList", attendanceService.getAttendanceBetweenTwoDates(principal.getName(),sdate, edate));
		map.addAttribute("sdate", sdate);
		return "userAttendance";
	}
	
	
	
	
	/*@RequestMapping(value = "/userViewDetail", method = RequestMethod.GET)*/
	@RequestMapping(value = "/userprofile", method = RequestMethod.GET)
	public String viewprofile(ModelMap map, HttpServletRequest request, Principal principal)
	{
		map.addAttribute("pwdstatus", request.getParameter("pwdstatus"));
		map.addAttribute("registration", registrationService.getRegistrationByUserid(principal.getName()));
		map.addAttribute("roles", userRoleService.getUserRolesByUserid(principal.getName()));
		return "userprofile";
	}
	
	
	@RequestMapping(value = "/userOtherDetail", method = RequestMethod.GET)
	public String otherdetail(ModelMap map, HttpServletRequest request, Principal principal)
	{
		map.addAttribute("odForm", new UserDetailModel());
		return "userotherdetail";
	}
	
	@RequestMapping(value = "/userOtherDetail", method = RequestMethod.POST)
	public String userotherdetail(@ModelAttribute(value = "odForm") @Valid UserDetailModel model,BindingResult result,
			                      @ModelAttribute(value = "user") UserDetail user, BindingResult regResult,
			                      ModelMap map, HttpServletRequest request,Principal principal)
	{
		if (result.hasErrors())
		{
			System.out.println("in validation");
			return "userotherdetail";
		} else
		{
			Date date = new Date();
			Date dt = new Date(date.getTime());
			user.setModifiedDate(dt);
			
			try 
			{
				Registration reg = registrationService.getRegistrationByUserid(principal.getName());	
				user.setRegistration(reg);
				int status=userDetailService.addOtherDetails(user);
				if(status>0){
					map.addAttribute("status", "success");
				}
				else{
					map.addAttribute("status", "error");
				}
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				return "userotherdetail";
			}
			return "redirect:userprofile";
		}
		
	}
	
	
	@RequestMapping(value = "/userEditDetail", method = RequestMethod.GET)
	public String editotherdetail(ModelMap map, HttpServletRequest request, Principal principal)
	{
		UserDetail userDetail=userDetailService.getUserId(principal.getName());
		if(userDetail != null)
		{
			UserDetailModel model = new UserDetailModel();
			model.setUserid(userDetail.getRegistration().getUserid());
			model.setParmanentAddress(userDetail.getParmanentAddress());
			model.setPresentAddress(userDetail.getPresentAddress());
			model.setEmergencyNo(userDetail.getEmergencyNo());
			model.setCity(userDetail.getCity());
			model.setState(userDetail.getState());
			model.setCountry(userDetail.getCountry());
			model.setMobileNo(userDetail.getMobileNo());
			model.setQualification(userDetail.getQualification());
			model.setBloodGroup(userDetail.getBloodGroup());
			model.setMaritalStatus(userDetail.getMaritalStatus());
			model.setAltEmailId(userDetail.getAltEmailId());
			model.setPassportNo(userDetail.getPassportNo());
			map.addAttribute("odForm", model);
			
		}
		
		return "userEditDetail";
	}
	
	@RequestMapping(value = "/userEditDetail", method = RequestMethod.POST)
	public String editdetail(@ModelAttribute(value = "odForm") @Valid UserDetailModel model,BindingResult result,
			                  ModelMap map, HttpServletRequest request,Principal principal)
	{
		if (result.hasErrors())
		{
	
			System.out.println("in validation");
			return "userEditDetail";
		} else
		{
	        boolean flag=false;
			UserDetail userDetail = userDetailService.getUserId(model.getUserid());
			if(userDetail!=null){
				Date date = new Date();
				Date dt = new Date(date.getTime());
				userDetail.setModifiedDate(dt);
				userDetail.setParmanentAddress(model.getParmanentAddress());
				userDetail.setPresentAddress(model.getPresentAddress());
				userDetail.setCity(model.getCity());
				userDetail.setState(model.getState());
				userDetail.setCountry(model.getCountry());
				userDetail.setEmergencyNo(model.getEmergencyNo());
				userDetail.setMobileNo(model.getMobileNo());
				userDetail.setQualification(model.getQualification());
				userDetail.setBloodGroup(model.getBloodGroup());
				userDetail.setMaritalStatus(model.getMaritalStatus());
				userDetail.setAltEmailId(model.getAltEmailId());
				userDetail.setPassportNo(model.getPassportNo());
				flag=userDetailService.editOtherDetails(userDetail);
				if(flag==true){
					map.addAttribute("status", "success");
				}
				else{
					map.addAttribute("status", "error");
				}
			}
		}
		return "redirect:userprofile";
	}
	
	
	/*@RequestMapping(value = "/userBankDetail", method = RequestMethod.GET)
	public String bankdetail(@RequestParam String Mode, ModelMap map, HttpServletRequest request, Principal principal)
	{
		Mode=request.getParameter("Mode");
		map.addAttribute("bdForm", new BankDetailModel());
		map.addAttribute("Mode", Mode);
		return "userbankdetail";
	}
	
	
	
	@RequestMapping(value = "/userBankDetail", method = RequestMethod.POST)
	public String addbankdetail(@ModelAttribute(value = "bdForm") @Valid BankDetailModel model,BindingResult result,
			                      @ModelAttribute(value = "bank") BankDetail bank, BindingResult regResult,
			                      ModelMap map, HttpServletRequest request,Principal principal)
	{
		if (result.hasErrors())
		{
			System.out.println("in validation");
			return "userbankdetail";
		} else
		{
			Date date = new Date();
			Date dt = new Date(date.getTime());
			bank.setModifiedDate(dt);
			
			try 
			{
				Registration reg = registrationService.getRegistrationByUserid(principal.getName());	
				bank.setRegistration(reg);
				int status=bankDetailService.addBankDetails(bank);
				if(status>0){
					map.addAttribute("status", "success");
				}
				else{
					map.addAttribute("status", "error");
				}
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				return "userbankdetail";
			}
			return "redirect:userprofile";
		}
		
	}
*/	
	
	/*@RequestMapping(value = "/userEditBankDetail", method = RequestMethod.GET)
	public String editbankdetail(@RequestParam String Mode,ModelMap map, HttpServletRequest request, Principal principal)
	{
		Mode=request.getParameter("Mode");
		BankDetail bankDetail=bankDetailService.getUserId(principal.getName());
		if(bankDetail != null)
		{
			BankDetailModel model = new BankDetailModel();
			model.setUserid(bankDetail.getRegistration().getUserid());
			model.setAccountNo(bankDetail.getAccountNo());
			model.setIfscCode(bankDetail.getIfscCode());
			model.setBankName(bankDetail.getBankName());
			model.setNameAsBankRecord(bankDetail.getNameAsBankRecord());
			map.addAttribute("bdForm", model);
			map.addAttribute("Mode", Mode);
		}
		
		return "userbankdetail";
	}
	
	@RequestMapping(value = "/userEditBankDetail", method = RequestMethod.POST)
	public String edituserbankdetail(@ModelAttribute(value = "bdForm") @Valid BankDetailModel model,BindingResult result,
			                  ModelMap map, HttpServletRequest request,Principal principal)
	{
		if (result.hasErrors())
		{
	
			System.out.println("in validation");
			return "userbankdetail";
		} else
		{
	       boolean flag=false;
	       BankDetail bankDetail = bankDetailService.getUserId(model.getUserid());
			if(bankDetail!=null){
				Date date = new Date();
				Date dt = new Date(date.getTime());
				bankDetail.setModifiedDate(dt);
				bankDetail.setAccountNo(model.getAccountNo());
				bankDetail.setIfscCode(model.getIfscCode());
				bankDetail.setBankName(model.getBankName());
				bankDetail.setNameAsBankRecord(model.getNameAsBankRecord());
				flag=bankDetailService.editBankDetails(bankDetail);
				if(flag==true){
					map.addAttribute("status", "success");
				}
				else{
					map.addAttribute("status", "error");
				}
			}
		}
		return "redirect:userprofile";
	}
	
	
*/
	@RequestMapping(value = "/profileImageUpld")
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
				File dl = new File (ProjectConfig.upload_path+"/"+principal.getName()+"/Profile_Photo/"+filename);
		    	String datafile="/ems_uploads/"+principal.getName()+"/Profile_Photo/"+filename;
		    	System.out.println("PATH="+datafile);
			    if(!dl.exists()){
			    	System.out.println("in not file"+dl.getAbsolutePath());
				    dl.mkdirs();
			    }
				Registration registration = registrationService.getRegistrationByUserid(principal.getName());
				registration.setProfileImage(filename);
				registrationService.updateRegistration(registration);
				request.getSession().setAttribute("registration", registration);
				mpf.transferTo(dl);
				System.out.println("multiple images uploaded");
				return datafile;
			}
		}
		return "failed";
    }
	
	
}
