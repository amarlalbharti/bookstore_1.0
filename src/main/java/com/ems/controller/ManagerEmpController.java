package com.ems.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.ParseException;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ems.config.DateFormats;
import com.ems.config.ProjectConfig;
import com.ems.domain.Branch;
import com.ems.domain.Department;
import com.ems.domain.Designation;
import com.ems.domain.LoginInfo;
import com.ems.domain.Notification;
import com.ems.domain.Registration;
import com.ems.domain.UserDetail;
import com.ems.domain.UserRole;
import com.ems.domain.UserSetting;
import com.ems.model.EmpModel;
import com.ems.model.RegModel;
import com.ems.model.UserDetailModel;
import com.ems.service.BranchService;
import com.ems.service.CountryService;
import com.ems.service.DepartmentService;
import com.ems.service.DesignationService;
import com.ems.service.LoginInfoService;
import com.ems.service.NotificationService;
import com.ems.service.RegistrationService;
import com.ems.service.UserDetailService;
import com.ems.service.UserRoleService;
import com.ems.service.UserSettingService;

@Controller
public class ManagerEmpController {
	
	@Autowired private RegistrationService registrationService; 
	@Autowired private LoginInfoService loginInfoService;
	@Autowired private DepartmentService departmentService;
	@Autowired private DesignationService designationService;
	@Autowired private UserDetailService userDetailService;
	@Autowired private UserRoleService userRoleService;
	@Autowired private BranchService branchService;
	@Autowired private CountryService countryService;
	@Autowired private UserSettingService userSettingService;
	@Autowired private NotificationService notificationService;
	
	
	@RequestMapping(value = "/managerAddEmployee", method = RequestMethod.GET)
	public String managerAddEmployee(ModelMap map, HttpServletRequest request, Principal principal)
	{
		map.addAttribute("dpList", departmentService.getDepartmentList());
		map.addAttribute("dsList", designationService.getDesignationList());
		map.addAttribute("cList", countryService.getCountryList());
//		map.addAttribute("bList", branchService.getBranchList());
		map.addAttribute("regForm", new RegModel());
		return "managerAddEmployee";
	}
	
	@RequestMapping(value = "/managerAddEmployee", method = RequestMethod.POST)
	public String managerNewEmployee(@ModelAttribute(value = "regForm") @Valid RegModel model,
			BindingResult result, @ModelAttribute(value = "reg") Registration reg, BindingResult regResult,
			@ModelAttribute(value = "login") LoginInfo login, BindingResult loginResult,
			@ModelAttribute(value = "urole") UserRole urole, BindingResult userroleResult,
			@RequestParam("userid") String userid, ModelMap map, HttpServletRequest request, Principal principal)
	{
		
		System.out.println("userid in controller" + userid);
		boolean st = false;
		try
		{
			Registration user = registrationService.getRegistrationByUserid(userid);
			if (user != null)
			{
				result.addError(new FieldError("regForm", "userid", model.getUserid() , false, new String[1],new String[1], "Email id already registered "));
				st = true;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		if (result.hasErrors() || st || model.getDepartment().getDepartmentId() <= 0 || model.getDesignation().getDesignationId() <= 0 || model.getBranch().getBranchId() <= 0)
		{
			if(model.getDepartment().getDepartmentId() <= 0)
			{
				result.addError(new FieldError("regForm", "department", model.getDepartment() , false, new String[1],new String[1], "Please select department"));
			}
			if(model.getDesignation().getDesignationId() <= 0)
			{
				result.addError(new FieldError("postForm", "designation", model.getDesignation() , false, new String[1],new String[1], "Please select designation"));
			}
			if(model.getBranch().getBranchId() <= 0)
			{
				result.addError(new FieldError("regForm", "branch", model.getBranch() , false, new String[1],new String[1], "Please select branch"));
			}
			
			map.addAttribute("dpList", departmentService.getDepartmentList());
			map.addAttribute("dsList", designationService.getDesignationList());
			map.addAttribute("cList", countryService.getCountryList());
			
			System.out.println("in validation"+result.getFieldError().getField());
			System.out.println("in validation"+result.getFieldError().getDefaultMessage());
			return "managerAddEmployee";
		} 
		else
		{
			Date date = new Date();
			Date dt = new Date(date.getTime());
			reg.setRegdate(dt);
			
			try 
			{
				reg.setJoiningDate(DateFormats.ddMMyyyy().parse(model.getJoiningDate()));
				
				login.setIsactive("true");
				
				Department department = departmentService.getDepartmentById(reg.getDepartment().getDepartmentId());
				reg.setDepartment(department);
				
				Designation designation = designationService.getDesignationById(reg.getDesignation().getDesignationId());
				reg.setDesignation(designation);
				
				Branch branch = branchService.getBranchById(reg.getBranch().getBranchId());
				reg.setBranch(branch);
				
				login.setRegistration(reg);
				urole.setLog(login);
				Set<UserRole> roles = new HashSet<UserRole>();
				roles.add(urole);
				login.setRoles(roles);
				boolean success = loginInfoService.addLoginInfo(login);
				map.addAttribute("status", "success");
				Registration reg1 = registrationService.getRegistrationByUserid(userid);
				if(reg1 != null)
				{
					if(success)
					{
						UserSetting us = new UserSetting();
						us.setTimezone(branch.getTimeZone());
						us.setRegistration(reg1);
						userSettingService.addUserSetting(us);
					}
					
					
		            MultipartFile userImage = model.getUserImage();
		            MultipartFile userPan = model.getUserPan();
		            if(userImage != null)
		            {
			            String oldUserImage=userImage.getOriginalFilename();
			            
			            String newUserImage=null;
			            try
			            {
			                if(!(oldUserImage.equals("")))
			                {
			                	newUserImage=oldUserImage.replace(" ", "-");
			                	
	
			                    reg1.setProfileImage(newUserImage);
			                    
			                    
			                    File img = new File (ProjectConfig.upload_path+"/"+userid+"/Profile_Photo/"+newUserImage);
			                    
			                    if(!img.exists())
			                    {
			                        img.mkdirs();
			                    }
			                    userImage.transferTo(img);  
			                }
			            }
			            catch (IOException ie)
			                    {
			                ie.printStackTrace();
			            }
					}
		            if(userPan != null)
		            {
			            String oldPanImage=userPan.getOriginalFilename();
			            
			            String newUserPan=null;
			            try
			            {
			                if(!(oldPanImage.equals("")))
			                {
			                	newUserPan=oldPanImage.replace(" ", "-");
			                	
	
			                    reg1.setPanImage(newUserPan);
			                    
			                    
			                    File img1 = new File (ProjectConfig.upload_path+"/"+userid+"/Pan_Scan/"+newUserPan);
			                    
			                    if(!img1.exists())
			                    {
			                        img1.mkdirs();
			                    }
			                    userPan.transferTo(img1); 
			                }
			             }
			            catch (IOException ie)
			                    {
			                ie.printStackTrace();
			            }
					}
		            if(userImage != null || userPan != null)
		            {
		            	registrationService.updateRegistration(reg1);
		            }
				}
				
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				return "managerAddEmployee";
			}
			map.addAttribute("status", "success");
			return "redirect:manageremployees";
		}
	}
	
	@RequestMapping(value = "/managerAddOtherInfo", method = RequestMethod.GET)
	public String managerAddOtherInfo(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String empid = request.getParameter("empid");
		if(empid != null && empid.length() > 0)
		{
			Registration reg = registrationService.getRegistrationByUserid(empid);
			if(reg != null)
			{
				UserDetailModel model = new UserDetailModel();
				model.setUserid(reg.getUserid());
				
				if(reg.getUserDetail() != null)
				{
					UserDetail ud = reg.getUserDetail();
					model.setBloodGroup(ud.getBloodGroup());
					model.setCity(ud.getCity());
					model.setState(ud.getState());
					model.setCountry(ud.getCountry());
					model.setEmergencyNo(ud.getEmergencyNo());
					model.setMaritalStatus(ud.getMaritalStatus());
					model.setMobileNo(ud.getMobileNo());
					model.setParmanentAddress(ud.getParmanentAddress());
					model.setPresentAddress(ud.getPresentAddress());
					model.setQualification(ud.getQualification());
					map.addAttribute("odForm", model);
				}
				else
				{
					map.addAttribute("odForm", model);
				}
				return "managerAddOtherInfo";
			}
		}		
		return "redirect:manageremployees";
	}
	
	@RequestMapping(value = "/managerAddOtherInfo", method = RequestMethod.POST)
	public String managerAddOtherInfo(@ModelAttribute(value = "odForm") @Valid UserDetailModel model,BindingResult result,
			@ModelAttribute(value = "user") UserDetail user, BindingResult regResult,
			ModelMap map, HttpServletRequest request,Principal principal)
	{
		if (result.hasErrors())
		{
			System.out.println("in validation");
			return "managerAddOtherInfo";
		}
		else
		{
			Date date = new Date();
			Date dt = new Date(date.getTime());
			
			Registration reg = registrationService.getRegistrationByUserid(model.getUserid());	
			Registration registration = registrationService.getRegistrationByUserid(model.getUserid());	
			if(reg != null)
			{
				user.setModifiedDate(dt);
				
				if(reg.getUserDetail() != null)
				{
					UserDetail ud = reg.getUserDetail();
					
					
					ud.setBloodGroup(model.getBloodGroup());
					ud.setCity(model.getCity());
					ud.setState(model.getState());
					ud.setCountry(model.getCountry());
					ud.setEmergencyNo(model.getEmergencyNo());
					ud.setMaritalStatus(model.getMaritalStatus());
					ud.setMobileNo(model.getMobileNo());
				
					ud.setParmanentAddress(model.getParmanentAddress());
					ud.setPresentAddress(model.getPresentAddress());
					ud.setQualification(model.getQualification());
					userDetailService.editOtherDetails(ud);
					
					Notification notification=new Notification();
					notification.setType("other_detail");
					notification.setNotiMsg("Other Detail has been updated by "+registration.getName());
					notification.setNotiId(ud.getUserId());
					notification.setNotiTo(reg);
					notificationService.addNotification(notification);
				}
				else
				{
					user.setRegistration(reg);
					userDetailService.addOtherDetails(user);
				}
			}
			map.addAttribute("eStatus", "success");
			return "redirect:managerViewEmployee?empid="+model.getUserid();
			//return "redirect:manageremployees";
		}	
	}
	
	@RequestMapping(value = "/managerEditEmployee", method = RequestMethod.GET)
	public String managerEditEmployee(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String empid = request.getParameter("empid");
		if(empid != null && empid.length() > 0)
		{
			Registration reg = registrationService.getRegistrationByUserid(empid);
			if(reg != null)
			{
				EmpModel model = new EmpModel();
				model.setUserid(empid);
				model.setName(reg.getName());
				if(reg.getJoiningDate() != null)
				{
					model.setJoiningDate(DateFormats.ddMMyyyy().format(reg.getJoiningDate()));
				}
				model.setGender(reg.getGender());
				model.setDob(reg.getDob());
				model.setDepartment(reg.getDepartment());
				model.setDesignation(reg.getDesignation());
				model.setUserrole("USER_ROLE");
				
				model.setCountry(reg.getBranch().getCountry());
				model.setBranch(reg.getBranch());
				
				map.addAttribute("empForm", model);
				map.addAttribute("dpList", departmentService.getDepartmentList());
				map.addAttribute("dsList", designationService.getDesignationList());
				map.addAttribute("cList", countryService.getCountryList());
				map.addAttribute("bList",branchService.getBranchByCountryId(reg.getBranch().getCountry().getCountryId()));
				if(reg.getUserDetail() != null)
				{
					map.addAttribute("odForm", reg.getUserDetail());
				}
				else
				{
					map.addAttribute("odForm", new UserDetailModel());
				}
				map.addAttribute("empReg", reg);
				return "managerEditEmployee";
			}
			
		}
		return "redirect:manageremployees";
	}
	
	@RequestMapping(value = "/managerEditEmployee", method = RequestMethod.POST)
	public String managerEditEmployee(@ModelAttribute(value = "empForm") @Valid EmpModel model, BindingResult result, ModelMap map, HttpServletRequest request, Principal principal)
	{
		if(model.getUserid() == null)
		{
			return "redirect:manageremployees";
		}
		if (result.hasErrors())
		{
			map.addAttribute("dpList", departmentService.getDepartmentList());
			map.addAttribute("dsList", designationService.getDesignationList());
			map.addAttribute("cList", countryService.getCountryList());
			
			System.out.println("in validation");
			return "managerEditEmployee";
		} else
		{
			Registration reg = registrationService.getRegistrationByUserid(model.getUserid());
			if(reg != null)
			{
				try 
				{
					reg.setName(model.getName());
					if(reg.getJoiningDate() != null)
					{
							reg.setJoiningDate(DateFormats.ddMMyyyy().parse(model.getJoiningDate()));
					}
					reg.setGender(model.getGender());
					reg.setDob(model.getDob());
					Department department = departmentService.getDepartmentById(model.getDepartment().getDepartmentId());
					reg.setDepartment(department);
					
					Designation designation = designationService.getDesignationById(model.getDesignation().getDesignationId());
					reg.setDesignation(designation);
//					Image code Start
					Branch branch = branchService.getBranchById(model.getBranch().getBranchId());
					reg.setBranch(branch);
					
					
					if(reg != null)
					{
			            MultipartFile userImage = model.getUserImage();
			            MultipartFile userPan = model.getUserPan();
			            if(userImage != null)
			            {
				            String oldUserImage=userImage.getOriginalFilename();				            
				            String newUserImage=null;
				            try
				            {
				                if(!(oldUserImage.equals("")))
				                {
				                	newUserImage=oldUserImage.replace(" ", "-");

				                    reg.setProfileImage(newUserImage);
				                    
				                    File img = new File (ProjectConfig.upload_path+"/"+reg.getUserid()+"/Profile_Photo/"+newUserImage);
				                    
				                    if(!img.exists())
				                    {
				                        img.mkdirs();
				                    }
				                    userImage.transferTo(img);  
				                }              
				            }
							catch (IOException ie) {
								ie.printStackTrace();
							}
					  }
			          if(userPan != null)
			          {
				            String oldPanImage=userPan.getOriginalFilename();
				            
				            String newUserPan=null;
				            try
				            {
				                if(!(oldPanImage.equals("")))
				                {
				                	newUserPan=oldPanImage.replace(" ", "-");
				                	
				                    reg.setPanImage(newUserPan);
				                    
				                    File img1 = new File (ProjectConfig.upload_path+"/"+reg.getUserid()+"/Pan_Scan/"+newUserPan);
				                    
				                    if(!img1.exists())
				                    {
				                        img1.mkdirs();
				                    }
				                    userPan.transferTo(img1); 
				                }              
				            }
			            catch (IOException ie)
			                    {
			                ie.printStackTrace();
			            }
					  }  
					}
//					Image code End
					
					registrationService.updateRegistration(reg);
					map.addAttribute("eStatus", "success");
					return "redirect:managerViewEmployee?empid="+model.getUserid();
				}
				catch (ParseException e) 
				{
					e.printStackTrace();
				}
			}

			return "redirect:manageremployees";
		}
	}
	
	@RequestMapping(value = "/managerPrint", method = RequestMethod.GET)
	public String managerPrint(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String empid = request.getParameter("empid");
		
		if(empid != null && empid.length() > 0)
		{
			Registration reg = registrationService.getRegistrationByUserid(empid);
			if(reg != null)
			{
				map.addAttribute("roles", userRoleService.getUserRolesByUserid(empid) );
				map.addAttribute("empReg", reg);
				return "managerPrint";
			}
		}
		return "redirect:managerViewEmployee";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getBranchNames", method = RequestMethod.GET)
	@ResponseBody
	public String editAttendance(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject object = new JSONObject();

		String cid = (String)request.getParameter("cid");
		System.out.println("cid : " + cid);
		if(cid != null && cid.length() > 0)
		{
			List<Branch> branch = (List<Branch>)branchService.getBranchByCountryId(Integer.parseInt(cid));
			JSONArray array = new  JSONArray();
			if(branch != null && !branch.isEmpty())
			{
				for(Branch br : branch)
				{
					JSONObject at = new JSONObject();
					at.put("id", br.getBranchId());
					at.put("name", br.getBranchName());
					array.add(at);
				}
			}
			object.put("bList", array);
			object.put("error", false);
			return object.toJSONString();
		}
		object.put("error", true);
		return object.toJSONString();
	}
	
}
