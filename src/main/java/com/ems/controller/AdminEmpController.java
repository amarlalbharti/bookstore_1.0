package com.ems.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.Access;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ems.config.DateFormats;
import com.ems.config.ProjectConfig;
import com.ems.domain.Attendance;
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
import com.ems.service.AttendanceService;
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
import com.ibm.wsdl.util.IOUtils;

@Controller
public class AdminEmpController 
{
	@Value(value="NotEmpty.regForm.name") private String abc; 
	
	@Autowired private AttendanceService attendanceService; 
	@Autowired private RegistrationService registrationService; 
	@Autowired private LoginInfoService loginInfoService;
	@Autowired private DepartmentService departmentService;
	@Autowired private DesignationService designationService;
	@Autowired private UserDetailService userDetailService;;
	@Autowired private UserRoleService userRoleService;;
	@Autowired private BranchService branchService;
	@Autowired private CountryService countryService;
	@Autowired private UserSettingService userSettingService;
	@Autowired private NotificationService notificationService;

	
	@RequestMapping(value = "/adminEmployees", method = RequestMethod.GET)
	public String employees(ModelMap map, HttpServletRequest request, Principal principal)
	{
		List<Registration> regList = registrationService.getRegistrationList();
		Map<String, UserRole> roles = new HashMap<String, UserRole>();
		for(Registration reg : regList)
		{
			roles.put(reg.getUserid(), userRoleService.getUserRolesByUserid(reg.getUserid()).get(0));
		}
		
		map.addAttribute("regList", regList);
		map.addAttribute("roles", roles);
		return "adminemployees";
	}
	
	@RequestMapping(value = "/adminAddEmployee", method = RequestMethod.GET)
	public String adminAddEmployee(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("NotEmpty.regForm.name : " + abc);
		map.addAttribute("dpList", departmentService.getDepartmentList());
		map.addAttribute("dsList", designationService.getDesignationList());
		map.addAttribute("cList", countryService.getCountryList());
		map.addAttribute("regForm", new RegModel());
		return "adminAddEmployee";
	}
	
	@RequestMapping(value = "/adminAddEmployee", method = RequestMethod.POST)
	public String adminNewEmployee(@ModelAttribute(value = "regForm") @Valid RegModel model,
			BindingResult result, @ModelAttribute(value = "reg") Registration reg, BindingResult regResult,
			@ModelAttribute(value = "login") LoginInfo login, BindingResult loginResult,
			@ModelAttribute(value = "urole") UserRole urole, BindingResult userroleResult,
			@RequestParam("userid") String userid, ModelMap map, HttpServletRequest request)
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
		
		if (result.hasErrors() || st || model.getDepartment().getDepartmentId() <= 0 || model.getDesignation().getDesignationId() <= 0 || model.getCountry().getCountryId() <=0 || model.getBranch().getBranchId()<=0)
		{
			if(model.getDepartment().getDepartmentId() <= 0)
			{
				result.addError(new FieldError("regForm", "department", model.getDepartment() , false, new String[1],new String[1], "Please select department"));
			}
			if(model.getDesignation().getDesignationId() <= 0)
			{
				result.addError(new FieldError("postForm", "designation", model.getDesignation() , false, new String[1],new String[1], "Please select designation"));
			}
			if(model.getCountry().getCountryId() <= 0)
			{
				result.addError(new FieldError("postForm", "country", model.getCountry() , false, new String[1],new String[1], "Please select country"));
			}
			if(model.getBranch().getBranchId() <= 0)
			{
				result.addError(new FieldError("postForm", "branch", model.getBranch() , false, new String[1],new String[1], "Please select branch"));
			}
			map.addAttribute("dpList", departmentService.getDepartmentList());
			map.addAttribute("dsList", designationService.getDesignationList());
			map.addAttribute("cList", countryService.getCountryList());
			if(model.getCountry().getCountryId() > 0)
			{
				map.addAttribute("bList",branchService.getBranchByCountryId(model.getBranch().getCountry().getCountryId()));
			}
			System.out.println("in validation");
			return "adminAddEmployee";
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
		            map.addAttribute("status", "success");
		            return "redirect:adminViewEmployee?empid="+userid;
				}
				
				
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				return "adminAddEmployee";
			}
			map.addAttribute("status", "failed");
			return "redirect:adminViewEmployee?empid="+userid;
		}
		
	}
	
	@RequestMapping(value = "/adminEditEmployee", method = RequestMethod.GET)
	public String adminEditEmployee(ModelMap map, HttpServletRequest request, Principal principal)
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
				List<UserRole> roles =  userRoleService.getUserRolesByUserid(empid);
				if(roles != null && !roles.isEmpty())
				{
					model.setUserrole(roles.get(0).getUserrole());
				}
				model.setDepartment(reg.getDepartment());
				model.setDesignation(reg.getDesignation());
				model.setCountry(reg.getBranch().getCountry());
				model.setBranch(reg.getBranch());
				model.setWeekOff(reg.getWeekOff());
				map.addAttribute("empForm", model);
				map.addAttribute("dpList", departmentService.getDepartmentList());
				map.addAttribute("dsList", designationService.getDesignationList());
				map.addAttribute("cList", countryService.getCountryList());
				map.addAttribute("bList",branchService.getBranchByCountryId(reg.getBranch().getCountry().getCountryId()));
				map.addAttribute("empReg", reg);
				return "adminEditEmployee";
			}
			
		}
		return "redirect:adminEmployees";
	}
	
	@RequestMapping(value = "/adminEditEmployee", method = RequestMethod.POST)
	public String adminEditEmployee(@ModelAttribute(value = "empForm") @Valid EmpModel model,BindingResult result, ModelMap map, HttpServletRequest request, Principal principal)
	{
		if(model.getUserid() == null)
		{
			return "redirect:adminEmployees";
		}
		if (result.hasErrors()|| model.getDepartment().getDepartmentId() <= 0 || model.getDesignation().getDesignationId() <= 0 || model.getBranch().getBranchId() <= 0)
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
				result.addError(new FieldError("postForm", "branch", model.getBranch() , false, new String[1],new String[1], "Please select branch"));
			}
			map.addAttribute("empReg", registrationService.getRegistrationByUserid(model.getUserid()));
			map.addAttribute("dpList", departmentService.getDepartmentList());
			map.addAttribute("dsList", designationService.getDesignationList());
			map.addAttribute("cList", countryService.getCountryList());
			if(model.getCountry().getCountryId() > 0)
			{
				map.addAttribute("bList",branchService.getBranchByCountryId(model.getBranch().getCountry().getCountryId()));
			}
			System.out.println("in validation");
			return "adminEditEmployee";
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
					
					Branch branch = branchService.getBranchById(model.getBranch().getBranchId());
					reg.setBranch(branch);
					reg.setWeekOff(model.getWeekOff());
					
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
					reg.setModification_date(new java.sql.Date(new Date().getTime()));
					registrationService.updateRegistration(reg);
					
					LoginInfo info = loginInfoService.getLoginInfoByUserid(model.getUserid());
					if(info != null)
					{
						List<UserRole> rList = userRoleService.getUserRolesByUserid(model.getUserid());
						if(rList != null && !rList.isEmpty())
						{
							UserRole role = rList.get(0);
							if(!role.getUserrole().equals(model.getUserrole()))
							{
								
							}
						}
								
					}
					map.addAttribute("status", "success");
					return "redirect:adminViewEmployee?empid="+model.getUserid();
				}
				catch (ParseException e) 
				{
					e.printStackTrace();
				}
			}
			map.addAttribute("status", "failed");
			return "redirect:adminEmployees";
		}
	}
	
	
	@RequestMapping(value = "/adminAddOtherInfo", method = RequestMethod.GET)
	public String adminAddOtherInfo(ModelMap map, HttpServletRequest request, Principal principal)
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
					model.setAltEmailId(ud.getAltEmailId());
					model.setPassportNo(ud.getPassportNo());
				}
				map.addAttribute("odForm", model);
				map.addAttribute("empReg", reg);
				
				return "adminAddOtherInfo";
			}
		}
				
		return "redirect:adminEmployees";
	}
	
	@RequestMapping(value = "/adminAddOtherInfo", method = RequestMethod.POST)
	public String adminAddOtherInfo(@ModelAttribute(value = "odForm") @Valid UserDetailModel model,BindingResult result,
			@ModelAttribute(value = "user") UserDetail user, BindingResult regResult,
			ModelMap map, HttpServletRequest request,Principal principal)
	{
		if (result.hasErrors())
		{
			if(model.getUserid() != null)
			{
				map.addAttribute("empReg", registrationService.getRegistrationByUserid(model.getUserid()));
				System.out.println("in validation");
				return "adminAddOtherInfo";
			}
			return "redirect:adminEmployees";
		}
		else
		{
			Date date = new Date();
			Date dt = new Date(date.getTime());
			
			Registration reg = registrationService.getRegistrationByUserid(model.getUserid());
			Registration registration = registrationService.getRegistrationByUserid(principal.getName());	
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
					ud.setAltEmailId(model.getAltEmailId());
					ud.setPassportNo(model.getPassportNo());
					userDetailService.editOtherDetails(ud);
					
					
					Notification notification=new Notification();
					notification.setType("other_detail");
					notification.setNotiMsg("Other Detail has been updated by "+registration.getName());
					notification.setNotiId(ud.getUserId());
					notification.setNotiTo(reg.getUserid());
					notificationService.addNotification(notification);
					map.addAttribute("oif_success", "updated");
				}
				else
				{
					map.addAttribute("oif_success", "added");
					user.setRegistration(reg);
					userDetailService.addOtherDetails(user);
				}
				return "redirect:adminViewEmployee?empid="+model.getUserid();
				
			}
			map.addAttribute("oif_success", "failed");
			return "redirect:adminViewEmployee?empid="+model.getUserid();
		}
		
	}
	@RequestMapping(value = "/adminViewEmployee", method = RequestMethod.GET)
	public String adminViewEmployee(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String empid = request.getParameter("empid");
		if(empid != null && empid.length() > 0)
		{
			Registration reg = registrationService.getRegistrationByUserid(empid);
			if(reg != null)
			{
				map.addAttribute("roles", userRoleService.getUserRolesByUserid(empid));
				map.addAttribute("pwdstatus", request.getParameter("pwdstatus"));
				map.addAttribute("empReg", reg);
				return "adminViewEmployee";
			}
		}
		return "return:adminEmployees";
	}
	
	@RequestMapping(value = "/adminEmpAttendanceExport", method = RequestMethod.GET)
	public void adminExport(ModelMap map, HttpServletRequest request, HttpServletResponse response, Principal principal)
	{
		String empid = request.getParameter("empid");
		if(empid != null && empid.length() > 0)
		{
			Date dt = new Date();
			Calendar calendar = Calendar.getInstance();
			Date sdate = calendar.getTime();
			Date edate = calendar.getTime();
			
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
					calendar.setTime(dt);
					calendar.set(Calendar.HOUR_OF_DAY, 0);
					calendar.set(Calendar.MINUTE, 0);
					calendar.set(Calendar.SECOND, 0);
					calendar.set(Calendar.MILLISECOND, 0);
					calendar.set(Calendar.DATE, 1);
					sdate = calendar.getTime();
					
					calendar.add(Calendar.MONTH, 1);
					edate = calendar.getTime();
					if(edate.after(new Date()))
					{
						edate = new Date();
					}
				}
				catch (Exception e) 
				{
					dt = new Date();
					e.printStackTrace();
				}
			}
			String s_date = request.getParameter("sdate");
			String e_date = request.getParameter("edate");
			if(s_date != null && s_date.length() > 0 && e_date != null && e_date.length() > 0)
			{
				try 
				{
					sdate = DateFormats.ddMMyyyy().parse(s_date);
					edate = DateFormats.ddMMyyyy().parse(e_date);
					calendar.setTime(sdate);
					calendar.set(Calendar.HOUR_OF_DAY, 0);
					calendar.set(Calendar.MINUTE, 0);
					calendar.set(Calendar.SECOND, 0);
					calendar.set(Calendar.MILLISECOND, 0);
					sdate = calendar.getTime();
					
					calendar.setTime(edate);
					calendar.set(Calendar.HOUR_OF_DAY, 23);
					calendar.set(Calendar.MINUTE, 59);
					calendar.set(Calendar.SECOND, 0);
					calendar.set(Calendar.MILLISECOND, 0);
					edate = calendar.getTime();
					
				}
				catch (Exception e) 
				{
					e.printStackTrace();
				}
			}
			Registration reg = registrationService.getRegistrationByUserid(empid);
			if(reg != null)
			{
				List<Attendance> attList = attendanceService.getAttendanceBetweenTwoDates(empid, sdate, edate);
				Collections.reverse(attList);
					
					XSSFWorkbook workbook = new XSSFWorkbook();
					// Create a blank sheet
					XSSFSheet sheet = workbook.createSheet("Attendance ");
					// Create row object
					
					XSSFFont font = workbook.createFont();
					font.setFontHeightInPoints((short) 14);
					font.setBold(true);
					XSSFCellStyle style = workbook.createCellStyle();
					style.setFont(font);
					style.setAlignment(HorizontalAlignment.CENTER);
					style.setWrapText(true);
					XSSFRow row = sheet.createRow(0);
					Cell cell1 = row.createCell(0);
					if(qm != null)
					{
						cell1.setCellValue(reg.getName() +" ( Attendance Report for "+DateFormats.MMMformat().format(sdate)+" )");
					}
					else if(s_date != null && e_date != null)
					{
						cell1.setCellValue(reg.getName() +" ( Attendance Report for "+DateFormats.ddMMMyyyy().format(sdate)+" to "+DateFormats.ddMMMyyyy().format(edate)+")");
					}
					cell1.setCellStyle(style);
					
					// Write the workbook in file system
					font = workbook.createFont();
					font.setBold(true);
					font.setFontHeightInPoints((short) 12);
					XSSFCellStyle style1 = workbook.createCellStyle();
					style1.setFont(font);
					
					
					XSSFRow row1 = sheet.createRow(1);
					
					Cell c1 = row1.createCell(0);
					c1.setCellValue("Date");
					c1.setCellStyle(style1);
					
					c1 = row1.createCell(1);
					c1.setCellValue("Check In Time");
					c1.setCellStyle(style1);
					
					c1 = row1.createCell(2);
					c1.setCellValue("Check Out Time");
					c1.setCellStyle(style1);
					
					c1 = row1.createCell(3);
					c1.setCellValue("Working Hours");
					c1.setCellStyle(style1);
					
					c1 = row1.createCell(4);
					c1.setCellValue("Task");
					c1.setCellStyle(style1);
					
					sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 4 ));
					
					int i = 2;
					
					if(attList != null && !attList.isEmpty())
					{
						for(Attendance at : attList)
						{
							row = sheet.createRow(i++);
							Cell dt_cell = row.createCell(0);
							dt_cell.setCellValue(DateFormats.ddMMMyyyy().format(at.getInTime()));
							
							Cell in_cell = row.createCell(1);
							in_cell.setCellValue(DateFormats.timeformat().format(at.getInTime()));
							
							Cell out_cell = row.createCell(2);
							if(at.getOutTime() != null)
							{
								out_cell.setCellValue(DateFormats.timeformat().format(at.getOutTime()));
							}
							else
							{
								out_cell.setCellValue("NA");
							}
							
							Cell wh_cell = row.createCell(3);
							wh_cell.setCellValue(DateFormats.getWorkingHours(at.getInTime(), at.getOutTime()));
							
							Cell task_cell = row.createCell(4);
							if(at.getTask() != null)
							{
								task_cell.setCellValue(at.getTask());
							}
							else
							{
								task_cell.setCellValue("NA");
							}
							
						}
						
					}
					else
					{
						row = sheet.createRow(i++);
						Cell dt_cell = row.createCell(0);
						dt_cell.setCellValue("No data in the data source.");
						
					}
					
					sheet.autoSizeColumn(0);
					sheet.autoSizeColumn(1);
					sheet.autoSizeColumn(2);
					sheet.autoSizeColumn(3);
					
					String filename = reg.getUserid()+"attendance_";
					if(qm != null)
					{
						filename = reg.getUserid()+"attendance_" + DateFormats.monthformat().format(sdate)+".xlsx";
					}
					else if(s_date != null && e_date != null)
					{
						filename = reg.getUserid()+"attendance_" + DateFormats.ddMMyyyy().format(sdate)+"_"+DateFormats.ddMMyyyy().format(edate)+".xlsx";
					}

					FileOutputStream out;
					try {
						File file = File.createTempFile("attendance_" + DateFormats.monthformat().format(sdate), ".xlsx");
						out = new FileOutputStream(file);
						workbook.write(out);
						out.close();
						System.out.println("Writesheet.xlsx written successfully");
						
						try 
						{
					        InputStream inputStream = new FileInputStream(file);
					        response.setContentType("application/vnd.ms-excel");
					        response.setHeader("Content-Disposition", "attachment; filename="+filename); 
					        FileCopyUtils.copy(inputStream, response.getOutputStream());
					        response.flushBuffer();
					        inputStream.close();
					    }
						catch (Exception e){
					        e.printStackTrace();
					    }
						
						return ;
					}
					catch (FileNotFoundException e) 
					{
						e.printStackTrace();
					}
					catch (IOException e) 
					{
						e.printStackTrace();
					}
				
				
			}
			
			map.addAttribute("errorMsg", "Employee not found");
			return ;
		}
		
		return ;
	}
	
	
	@RequestMapping(value = "/adminEmpListExport", method = RequestMethod.GET)
	public void adminEmpListExport(ModelMap map, HttpServletRequest request, HttpServletResponse response, Principal principal)
	{
		List<Registration> regList = registrationService.getRegistrationList();
		
		XSSFWorkbook workbook = new XSSFWorkbook();
		// Create a blank sheet
		XSSFSheet sheet = workbook.createSheet("Attendance ");
		// Create row object
		
		XSSFFont font = workbook.createFont();
		font.setFontHeightInPoints((short) 14);
		font.setBold(true);
		XSSFCellStyle style = workbook.createCellStyle();
		style.setFont(font);
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setWrapText(true);
		XSSFRow row = sheet.createRow(0);
		Cell cell1 = row.createCell(0);
		
		cell1.setCellValue(" Employees List");
		cell1.setCellStyle(style);
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 10));
		
		// Write the workbook in file system
		font = workbook.createFont();
		font.setBold(true);
		font.setFontHeightInPoints((short) 12);
		XSSFCellStyle style1 = workbook.createCellStyle();
		style1.setFont(font);
		
		
		XSSFRow row1 = sheet.createRow(1);
		
		int cn = 0;
		
		Cell c1 = row1.createCell(cn++);
		c1.setCellValue("S.No.");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Employee Name");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Employee Id");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Employee Role");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Status");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Department");
		c1.setCellStyle(style1);
		
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Designation");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Gender");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Date of Birth");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Joining Date");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Registration Date");
		c1.setCellStyle(style1);
		
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Parmanent Address");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Present Address");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("City");
		c1.setCellStyle(style1);

		c1 = row1.createCell(cn++);
		c1.setCellValue("State");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Country");
		c1.setCellStyle(style1);

		c1 = row1.createCell(cn++);
		c1.setCellValue("Mobile No");
		c1.setCellStyle(style1);

		c1 = row1.createCell(cn++);
		c1.setCellValue("Emergency No");
		c1.setCellStyle(style1);

		c1 = row1.createCell(cn++);
		c1.setCellValue("Qualification");
		c1.setCellStyle(style1);

		c1 = row1.createCell(cn++);
		c1.setCellValue("Marital Status");
		c1.setCellStyle(style1);

		c1 = row1.createCell(cn++);
		c1.setCellValue("Blood Group");
		c1.setCellStyle(style1);

		c1 = row1.createCell(cn++);
		c1.setCellValue("Pan Card No");
		c1.setCellStyle(style1);
		
		c1 = row1.createCell(cn++);
		c1.setCellValue("Account No");
		c1.setCellStyle(style1);

		int totalColumn = cn;
		cn = 0;
		int i = 1;
		if(regList != null && !regList.isEmpty())
		{
			int rn = 2;
			XSSFRow row_reg = sheet.createRow(rn);
			for(Registration reg : regList)
			{
				cn = 0;
				Cell cr = row_reg.createCell(cn++);
				cr.setCellValue(i++);
				
				cr = row_reg.createCell(cn++);
				cr.setCellValue(reg.getName());
				
				
				cr = row_reg.createCell(cn++);
				cr.setCellValue(reg.getUserid());
				
				
				List<UserRole> rList = userRoleService.getUserRolesByUserid(reg.getUserid());
				
				cr = row_reg.createCell(cn++);
				
				
				if(rList != null && !rList.isEmpty())
				{
					cr.setCellValue(rList.get(0).getUserrole());
				}
				else
				{
					cr.setCellValue("ROLE_USER");
				}
				
				cr = row_reg.createCell(cn++);
				
				if(reg.getLog() != null && reg.getLog().getIsactive().equals("true"))
				{
					cr.setCellValue("Active");
				}
				else
				{
					cr.setCellValue("Inactive");
				}
				
				cr = row_reg.createCell(cn++);
				cr.setCellValue(reg.getDepartment().getDepartment());
				
				
				cr = row_reg.createCell(cn++);
				cr.setCellValue(reg.getDesignation().getDesignation());
				
				
				cr = row_reg.createCell(cn++);
				cr.setCellValue(reg.getDesignation().getDesignation());
				
				
				cr = row_reg.createCell(cn++);
				cr.setCellValue(reg.getDob());
				
				
				cr = row_reg.createCell(cn++);
				if(reg.getJoiningDate() != null)
				{
					cr.setCellValue(DateFormats.ddMMMyyyy().format(reg.getJoiningDate()));
				}
				else
				{
					cr.setCellValue("NA");
				}
				
				
				cr = row_reg.createCell(cn++);
				cr.setCellValue(DateFormats.ddMMMyyyy().format(reg.getRegdate()));
				
				if(reg.getUserDetail() != null)
				{
					UserDetail ud = reg.getUserDetail(); 
					
					cr = row_reg.createCell(cn++);
					cr.setCellValue(ud.getParmanentAddress());
					
					cr = row_reg.createCell(cn++);
					cr.setCellValue(ud.getPresentAddress());
					
					cr = row_reg.createCell(cn++);
					cr.setCellValue(ud.getCity());
					
					cr = row_reg.createCell(cn++);
					cr.setCellValue(ud.getState());
					
					cr = row_reg.createCell(cn++);
					cr.setCellValue(ud.getCountry());
					
					cr = row_reg.createCell(cn++);
					cr.setCellValue(ud.getMobileNo());
					
					cr = row_reg.createCell(cn++);
					cr.setCellValue(ud.getEmergencyNo());
					
					cr = row_reg.createCell(cn++);
					cr.setCellValue(ud.getQualification());
					
					cr = row_reg.createCell(cn++);
					cr.setCellValue(ud.getMaritalStatus());
					
					cr = row_reg.createCell(cn++);
					cr.setCellValue(ud.getBloodGroup());
					
					}
				row_reg = sheet.createRow(++rn);
			}
		}
		else
		{
			XSSFRow row_reg = sheet.createRow(2);
			
			Cell cr = row_reg.createCell(0);
			cr.setCellValue("No data in the data source.");
			
		}
		
		for(int j = 0; j <totalColumn ; j++)
		{
			sheet.autoSizeColumn(j);
		}

		String filename = "Employees_List.xlsx";

		FileOutputStream out;
		try {
			File file = File.createTempFile("Employees_List", ".xlsx");
			out = new FileOutputStream(file);
			workbook.write(out);
			out.close();
			System.out.println("Writesheet.xlsx written successfully");
			
			try 
			{
		        InputStream inputStream = new FileInputStream(file);
		        response.setContentType("application/vnd.ms-excel");
		        response.setHeader("Content-Disposition", "attachment; filename="+filename); 
		        FileCopyUtils.copy(inputStream, response.getOutputStream());
		        response.flushBuffer();
		        inputStream.close();
		    }
			catch (Exception e){
		        e.printStackTrace();
		    }
			
			return ;
		}
		catch (FileNotFoundException e) 
		{
			e.printStackTrace();
		}
		catch (IOException e) 
		{
			e.printStackTrace();
		}
	
		
	}
	
}
