package com.bookstore.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookstore.config.DateUtils;
import com.bookstore.config.Roles;
import com.bookstore.config.Util;
import com.bookstore.config.Validation;
import com.bookstore.domain.Basket;
import com.bookstore.domain.Category;
import com.bookstore.domain.CustomerAddress;
import com.bookstore.domain.LoginInfo;
import com.bookstore.domain.Product;
import com.bookstore.domain.Registration;
import com.bookstore.domain.UserRole;
import com.bookstore.model.CustomerModel;
import com.bookstore.model.ProductModel;
import com.bookstore.service.LoginInfoService;
import com.bookstore.service.RegistrationService;

/**
 * @author Saumya
 *
 */

@Controller
public class CustomerController
{
	@Autowired 
	private RegistrationService registrationService; 
	@Autowired 
	private LoginInfoService loginInfoService; 
	
	@Autowired
	private SessionRegistry sessionRegistry;
	
	
	@RequestMapping(value = "admin/customers", method = RequestMethod.GET)
	public String categories(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from customers");
		return "customers";
	}
	
	@RequestMapping(value = "admin/customers/list/{pn}", method = RequestMethod.GET)
	public String customerslist(@PathVariable(value="pn" ) String pageno, ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from customers");
		int pn = Validation.isNumeric(pageno) ? Util.getNumeric(pageno) : 1;
		int rpp = Validation.isNumeric(request.getParameter("rpp")) ? Util.getNumeric(request.getParameter("rpp")) : Util.RPP;
		List<String> roles = new ArrayList<String>();
		roles.add(Roles.ROLE_MANAGER);
		map.addAttribute("customersList", registrationService.getRegistrationList(true, 0, 0));
		map.addAttribute("listcount",registrationService.countRegistrationList());
		map.addAttribute("pn", pn);
		map.addAttribute("rpp", rpp);
		return "customersList";
	}
	
	@RequestMapping(value = "admin/customers/add", method = RequestMethod.GET)
	public String addCustomer(ModelMap map, HttpServletRequest request, Principal principal)
	{
		map.addAttribute("customerForm", new CustomerModel());
		return "customerView";
	}
	
	@RequestMapping(value = "admin/customers/edit/{rid}", method = RequestMethod.GET)
	public String editCustomer(@PathVariable(value="rid" ) String rid, ModelMap map, HttpServletRequest request, Principal principal)
	{
		CustomerModel model = new CustomerModel();
		if(Validation.isNumeric(rid)){
			Registration reg = registrationService.getRegistrationByRid(Util.getNumeric(rid));
			if(reg != null ){
				model.setRid(reg.getRid());
				model.setUserid(reg.getLoginInfo().getUserid());
				model.setFirstName(reg.getFirstName());
				model.setLastName(reg.getLastName());
				model.setContactno(reg.getContactno());
				model.setDob(reg.getDob()  != null ? DateUtils.df.format(reg.getDob()) :"");
				model.setGender(reg.getGender());
				model.setModifyDate(reg.getModifyDate());
				model.setCreateDate(reg.getCreateDate());
				
				List<String> roles = new ArrayList();
				Iterator<UserRole> it = reg.getLoginInfo().getRoles().iterator();
				while(it.hasNext()){
					roles.add(it.next().getUserrole());
				}
				model.setRoles(roles);
				
				map.addAttribute("customerForm", model);
				return "customerView";
			}
		}
		return "redirect:/admin/customers";
	}
	
	
	@RequestMapping(value = "admin/customers/add", method = RequestMethod.POST)
	public String addCustomer(@ModelAttribute(value = "customerForm") @Valid CustomerModel model,BindingResult result,
			                  ModelMap map, HttpServletRequest request,Principal principal)
	{
		String submit = request.getParameter("submit");
		if (result.hasErrors()) {
			System.out.println("Product Validation failed with error(s) : " + result.getTarget());
			return "customerView";
		} else {
			try {
				if (model.getRid() > 0) {
					Registration reg = registrationService.getRegistrationByRid(model.getRid());
					if(reg != null) {
						reg.setFirstName(model.getFirstName());
						reg.setLastName(model.getLastName());
						reg.setContactno(model.getContactno());
						reg.setGender(model.getGender());
						reg.setDob(DateUtils.df.parse(model.getDob()));
						reg.setModifyDate(new Date());
						
						if(model.getRoles() != null){
							UserRole ur = null;
							for(String role : model.getRoles()){
								ur = new UserRole();
								ur.setLoginInfo(reg.getLoginInfo());
								if(Roles.ROLE_ADMIN.equals(role)){
									ur.setUserrole(Roles.ROLE_ADMIN);
								}else if(Roles.ROLE_MANAGER.equals(role)){
									ur.setUserrole(Roles.ROLE_MANAGER);
								} else{
									ur.setUserrole(Roles.ROLE_USER);
								}
								
								reg.getLoginInfo().getRoles().add(ur);
							}
						}
						reg.getLoginInfo().setRegistration(reg);
						loginInfoService.updateLoginInfo(reg.getLoginInfo());
						
						if(submit != null && submit.equals("continue")) {
							return "redirect:/admin/customers/edit/" + reg.getRid();
						}
					}
				} else {
					
					BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
					String hashedPassword = passwordEncoder.encode(model.getPwd());
					
					
					LoginInfo info = new LoginInfo();
					
					info.setUserid(model.getUserid());
					info.setIsActive("true");
					info.setPassword(hashedPassword);
					
					Set<UserRole> roles = new HashSet();
					if(model.getRoles() != null){
						UserRole ur = null;
						for(String role : model.getRoles()){
							ur = new UserRole();
							ur.setLoginInfo(info);
							if(Roles.ROLE_ADMIN.equals(role)){
								ur.setUserrole(Roles.ROLE_ADMIN);
							}else if(Roles.ROLE_MANAGER.equals(role)){
								ur.setUserrole(Roles.ROLE_MANAGER);
							} else{
								ur.setUserrole(Roles.ROLE_USER);
							}
							
							roles.add(ur);
						}
					}
					info.setRoles(roles);
					
					Registration reg = new Registration();
					
					reg.setLoginInfo(info);
					reg.setFirstName(model.getFirstName());
					reg.setLastName(model.getLastName());
					reg.setContactno(model.getContactno());
					reg.setGender(model.getGender());
					reg.setDob(DateUtils.df.parse(model.getDob()));
					
					
					reg.setCreateDate(new Date());
					reg.setModifyDate(new Date());
//					int rid = registrationService.addRegistration(reg);
					info.setRegistration(reg);
					loginInfoService.addLoginInfo(info);
					
					if(submit.equals("continue")) {
						return "redirect:/admin/customers/edit/" + reg.getRid();
					}
				}

				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "redirect:/admin/customers";
	}
	
	@RequestMapping(value = "admin/customers/online", method = RequestMethod.GET)
	public String viewProduct(ModelMap map, HttpServletRequest request, Principal principal)
	{
		List<Object> proincipals = sessionRegistry.getAllPrincipals();
		System.out.println("proincipals :   " + proincipals);
		List<String> userids  = new ArrayList();
		List<SessionInformation> ss  = new ArrayList();
		Map<String, SessionInformation> sessonInfos= new HashMap();
		
		for(Object pri : proincipals) {
			UserDetails pri1 = (UserDetails)pri;
			userids.add(pri1.getUsername());
			
			List<SessionInformation> sessions = sessionRegistry.getAllSessions(pri, false);
			for(SessionInformation si : sessions) {
				ss.add(si);
			}
			
		}
		
		
		map.addAttribute("sessionsList", ss);
		
		return "onileCustomers";
	}
	
}
