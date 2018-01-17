package com.bookstore.util;

import java.util.Date;

import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomerUtils
{
	public static String getCustomerStatusClass(SessionInformation sess){
		String response = "";
		long mills = new Date().getTime() - sess.getLastRequest().getTime();
		if(mills < 1000*60){
			response = "bg-aqua";
		}else if(mills < 1000*60*5){
			response = "bg-orange";
		}
		
		return response;
	}
}
