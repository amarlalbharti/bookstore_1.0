package com.bookstore.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import org.springframework.util.StringUtils;

import com.bookstore.config.Validation;

public class Util 
{
	public static int RPP = 10;
	
	public static Integer getNumeric(String value){
		if(Validation.isNumeric(value)){
			return Integer.parseInt(value);
		}
		return 0;
	}
	
	public static Integer getNumericPositive(String value){
		if(Validation.isNumeric(value)){
			if(Integer.parseInt(value) > 0) {
				return Integer.parseInt(value);
			}
		}
		return 0;
	}
}
