package com.bookstore.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookstore.constraints.Roles;
import com.bookstore.domain.LoginInfo;
import com.bookstore.enums.AttributeType;
import com.bookstore.service.LoginInfoService;

/**
 * @author A. L. Bharti
 *
 */
@Controller
public class AdminController
{
	
//	@Autowired private LoginInfoService loginInfoService;
//	/**
//	 * @param map
//	 * @param request 
//	 * @param principal is the object for detail of loged in user
//	 * @return   name of view mapped in tiles for index page
//	 */
//	@RequestMapping(value = "admin/dashboard", method = RequestMethod.GET)
//	public String dashboard(ModelMap map, HttpServletRequest request, Principal principal)
//	{
//		System.out.println("from admin dashboard : " + principal);
//		
//		return "dashboard";
//	}
	
	
/*	private boolean changePassword() {
		loginInfoService.resetPassword("amarlalbharti@gmail.com", "12345");
		return true;
	}
	
	private boolean checkPassword() {
		try {
			System.out.println("result +++++++++++++++++++++++++");
			LoginInfo info = loginInfoService.getLoginInfoByUserid("amarlalbharti@gmail.com");
			System.out.println("result " +BCrypt.checkpw("12345", info.getPassword()));
			System.out.println("result ===========================");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	*/
}
