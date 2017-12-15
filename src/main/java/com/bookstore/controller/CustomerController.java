package com.bookstore.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookstore.config.Util;
import com.bookstore.config.Validation;
import com.bookstore.domain.Basket;
import com.bookstore.domain.CustomerAddress;
import com.bookstore.service.RegistrationService;

/**
 * @author Saumya
 *
 */

@Controller
public class CustomerController
{
	@Autowired private RegistrationService registrationService; 
	
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
		map.addAttribute("customersList", registrationService.getRegistrationList(true, 0, 0));
		map.addAttribute("listcount", 0L);
		map.addAttribute("pn", pn);
		map.addAttribute("rpp", rpp);
		return "customersList";
	}
	
	@RequestMapping(value = "/viewCustomer", method = RequestMethod.GET)
	public String viewProduct(ModelMap map, HttpServletRequest request, Principal principal)
	{
		try{
			String customerId = request.getParameter("customerId");
			
			if(Validation.isNumeric(customerId)){
				System.out.println("from viewCustomer");
				return "customerView";	
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:customers";
	}
	
}
