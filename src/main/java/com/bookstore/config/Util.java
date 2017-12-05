package com.bookstore.config;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import org.springframework.util.StringUtils;

public class Util 
{
	public static int RPP = 2;
	
	public static Integer getNumeric(String value){
		if(Validation.isNumeric(value)){
			return Integer.parseInt(value);
		}
		return 0;
	}
}
