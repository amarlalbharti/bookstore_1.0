package com.ems.filter;

import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.ems.config.DateFormats;
import com.ems.config.Validation;
import com.ems.domain.Registration;
import com.ems.domain.UserSetting;
import com.ems.service.RegistrationService;
import com.ems.service.UserSettingService;

public class LoginInterceptor implements HandlerInterceptor
{
	@Autowired private RegistrationService registrationService;
	@Autowired private  UserSettingService userSettingService; 
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception 
	{
		
		Registration registration =  (Registration)request.getSession().getAttribute("registration");
		if(registration == null)
		{
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			if(authentication != null)
			{
				String userid = authentication.getName();
				if(Validation.validateEmail(userid))
				{
					registration = registrationService.getRegistrationByUserid(userid);
					if(registration != null)
					{
						request.getSession().setAttribute("registration", registration);
						
						UserSetting us = userSettingService.getUserSetting(userid);
						if(us != null)
						{
							request.getSession(true).setAttribute("timezone", TimeZone.getTimeZone(us.getTimezone()));
						}
						
					}
				}
			}
		}
		else
		{
			TimeZone timeZone = (TimeZone)request.getSession().getAttribute("timezone");
			if(timeZone == null)
			{
				UserSetting us = userSettingService.getUserSetting(registration.getUserid());
				if(us != null)
				{
					request.getSession(true).setAttribute("timezone", TimeZone.getTimeZone(us.getTimezone()));
				}
			}
			
		}
		return true;
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
	}

	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}

}
