package com.bookstore.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookstore.config.Util;
import com.bookstore.config.Validation;
import com.bookstore.service.CustomerService;

/**
 * @author Saumya
 *
 */

@Controller
public class CustomerController
{
	@Autowired private CustomerService customerService; 
	
	@RequestMapping(value = "/customers", method = RequestMethod.GET)
	public String categories(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from customers");
		
		map.addAttribute("customerList", customerService.getAllCustomers());
		
		return "customers";
	}
	
	@RequestMapping(value = "/viewCustomer", method = RequestMethod.GET)
	public String viewProduct(ModelMap map, HttpServletRequest request, Principal principal)
	{
		try{
			String customerId = request.getParameter("customerId");
			if(Validation.isNumeric(customerId)){
				map.addAttribute("viewmode", "view");
				map.addAttribute("customer", customerService.getCustomerById(Util.getNumeric(customerId)));
				System.out.println("from viewCustomer");
				return "customerView";	
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:customers";
	}
	
}
