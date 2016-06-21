package com.ems.config;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validation {
	private static Pattern emailNamePtrn = Pattern.compile("^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
		     
	private static Pattern PASSWORD_PATTERN = Pattern.compile("((?=.*\\d)(?=.*[a-z]).{4,20})");
    
	public static boolean validateEmail(String userName){
         
        Matcher mtch = emailNamePtrn.matcher(userName);
        if(mtch.matches()){
            return true;
        }
        return false;
    }
    
    public static boolean validatePassword(String password){
        
        Matcher mtch = PASSWORD_PATTERN.matcher(password);
        if(mtch.matches()){
            return true;
        }
        return false;
    }
}
