package com.bookstore.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookstore.config.Roles;

/**
 * @author A. L. Bharti
 *
 */
@Controller
public class AdminController
{
	/**
	 * @param map
	 * @param request 
	 * @param principal is the object for detail of loged in user
	 * @return   name of view mapped in tiles for index page
	 */
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from admin dashboard");
		return "dashboard";
	}
	
}
