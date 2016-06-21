package com.ems.controller;

import java.security.Principal;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.ems.service.PayrollService;

@Controller

public class UserPayrollController {
	
	@Autowired private PayrollService payrollService;
	
	@RequestMapping(value = "/userPayroll", method = RequestMethod.GET)
	public String userpayroll(ModelMap map, HttpServletRequest request, Principal principal)
	{
 		map.addAttribute("payrollList", payrollService.getPayrollByEmpId(principal.getName())); 
		String pid = request.getParameter("pid");
        if(pid != null){
			
        	map.addAttribute("payroll", payrollService.getPayrollById(Integer.parseInt(pid)));
        	map.addAttribute("mode", "view");
        	
		}
		return "userPayroll";
		
	}

}
