package com.ems.controller;

import java.security.Principal;
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

import com.ems.config.Roles;
import com.ems.domain.BankDetail;
import com.ems.domain.Notification;
import com.ems.domain.Registration;
import com.ems.model.BankDetailModel;
import com.ems.service.AttendanceService;
import com.ems.service.BankDetailService;
import com.ems.service.NotificationService;
import com.ems.service.RegistrationService;
import com.ems.service.UserDetailService;

@Controller
public class BankDetailController
{	
	@Autowired private AttendanceService attendanceService; 
	@Autowired private NotificationService notificationService; 
	@Autowired private RegistrationService registrationService;
	@Autowired private UserDetailService userDetailService;
	@Autowired private BankDetailService bankDetailService;
	
	@RequestMapping(value = "/empBankDetail", method = RequestMethod.GET)
	public String bankdetail(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String empid = request.getParameter("empid");
		if(empid != null && empid.trim().length() > 0)
		{
			Registration empReg = registrationService.getRegistrationByUserid(empid);
			if(empReg != null && empReg.getBankDetail() == null)
			{
				map.addAttribute("bdForm", new BankDetailModel());
				map.addAttribute("Mode", "add");
				map.addAttribute("empReg", empReg);
				
				return "adminBankDetail";
			}
			else if(empReg != null && empReg.getBankDetail() != null)
			{
				map.addAttribute("empid", empid);
				return "redirect:empEditBankDetail";
			}
		}
		return "redirect:adminEmployees";
	}
	
	@RequestMapping(value = "/empBankDetail", method = RequestMethod.POST)
	public String addbankdetail(@ModelAttribute(value = "bdForm") @Valid BankDetailModel model,BindingResult result,
			                      @ModelAttribute(value = "bank") BankDetail bank, BindingResult regResult,
			                      ModelMap map, HttpServletRequest request,Principal principal)
	{
		String empid = request.getParameter("empid");
		if(empid == null || empid.trim().length() == 0)
		{
			return "redirect:adminEmployees";
		}
		if (result.hasErrors())
		{
			System.out.println("in validation");
			Registration reg = registrationService.getRegistrationByUserid(empid);
			map.addAttribute("empReg", reg);
			map.addAttribute("Mode", "add");
			return "adminBankDetail";
		} else
		{
			Registration reg = registrationService.getRegistrationByUserid(empid);
			Registration registration = registrationService.getRegistrationByUserid(principal.getName());
			
			map.addAttribute("empReg", reg);
			
			if(reg!= null )
			{
				Date date = new Date();
				Date dt = new Date(date.getTime());
				bank.setCreateDate(dt);
				
				try 
				{
					bank.setRegistration(reg);
					int status=bankDetailService.addBankDetails(bank);
					
					Notification notification=new Notification();
					notification.setType("bank_detail");
					notification.setNotiId(status);
					notification.setNotiMsg("Bank Detail has been Added by "+registration.getName());
					notification.setNotiTo(reg);
					notificationService.addNotification(notification);
					
					
					if(status>0)
					{
						map.addAttribute("status", "success");
						map.addAttribute("empid", empid);
						if(request.isUserInRole(Roles.ROLE_ADMIN))
						{
							return "redirect:adminViewEmployee";
						}
						else if(request.isUserInRole(Roles.ROLE_MANAGER))
						{
							return "redirect:managerViewEmployee";
						}
						else
						{
							return "redirect:error";
						}
					}
				}
				catch (Exception e) 
				{
					e.printStackTrace();
				}
				map.addAttribute("status", "error");
				return "adminBankDetail";
			}
			return "redirect:adminEmployees";
		}
		
	}
	
	
	@RequestMapping(value = "/empEditBankDetail", method = RequestMethod.GET)
	public String editbankdetail(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String empid = request.getParameter("empid");
		if(empid != null && empid.trim().length() > 0)
		{
			Registration empReg = registrationService.getRegistrationByUserid(empid);
			if(empReg != null && empReg.getBankDetail() != null)
			{
				BankDetail bankDetail=bankDetailService.getUserId(empid);
				if(bankDetail != null)
				{
					BankDetailModel model = new BankDetailModel();
					model.setUserid(bankDetail.getRegistration().getUserid());
					model.setAccountNo(bankDetail.getAccountNo());
					model.setIfscCode(bankDetail.getIfscCode());
					model.setBankName(bankDetail.getBankName());
					model.setBasicSalary(bankDetail.getBasicSalary());
					model.setPli(bankDetail.getPli());
					model.setPanNo(bankDetail.getPanNo());
					model.setNameAsBankRecord(bankDetail.getNameAsBankRecord());
					map.addAttribute("bdForm", model);
					map.addAttribute("Mode", "edit");
					map.addAttribute("empReg", empReg);
					return "adminBankDetail";
				}
				
			}
		}
		map.addAttribute("empid", empid);
		return "redirect:adminViewEmployee";
	}
	
	@RequestMapping(value = "/empEditBankDetail", method = RequestMethod.POST)
	public String edituserbankdetail(@ModelAttribute(value = "bdForm") @Valid BankDetailModel model,BindingResult result,
			                  ModelMap map, HttpServletRequest request,Principal principal)
	{
		String empid = request.getParameter("empid");
		if(empid == null || empid.trim().length() == 0)
		{
			return "redirect:adminEmployees";
		}
		if (result.hasErrors())
		{
			System.out.println("in validation");
			Registration reg = registrationService.getRegistrationByUserid(empid);
			if(reg != null)
			{
				map.addAttribute("empReg", reg);
				map.addAttribute("Mode", "edit");
				return "adminBankDetail";
				
			}
			return "redirect:adminEmployees";
		} 
		else
		{
	       boolean flag=false;
	       Registration reg = registrationService.getRegistrationByUserid(empid);
	       Registration registration = registrationService.getRegistrationByUserid(principal.getName());
			
	       BankDetail bankDetail = bankDetailService.getUserId(model.getUserid());
			if(reg != null && bankDetail!=null)
			{
				Date date = new Date();
				Date dt = new Date(date.getTime());
				bankDetail.setModifiedDate(dt);
				bankDetail.setAccountNo(model.getAccountNo());
				bankDetail.setIfscCode(model.getIfscCode());
				bankDetail.setBankName(model.getBankName());
				bankDetail.setNameAsBankRecord(model.getNameAsBankRecord());
				bankDetail.setBasicSalary(model.getBasicSalary());
				bankDetail.setPli(model.getPli());
				bankDetail.setPanNo(model.getPanNo());
				
				flag=bankDetailService.editBankDetails(bankDetail);
				
				
				Notification notification=new Notification();
				notification.setType("bank_detail");
				notification.setNotiId(bankDetail.getBankId());
				notification.setNotiMsg("Bank Detail has been Updated by "+registration.getName());
				notification.setNotiTo(reg);
				notificationService.addNotification(notification);
				
				
				if(flag==true)
				{
					map.addAttribute("status", "success");
				}
				else{
					map.addAttribute("status", "error");
				}
				map.addAttribute("empid", empid);
				return "redirect:adminViewEmployee";
			}
			return "redirect:adminEmployees";
		}
	}
	
}
