package com.bookstore.config;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;

public class Validation {
	private static Pattern emailNamePtrn = Pattern.compile("^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
		     
	private static Pattern PASSWORD_PATTERN = Pattern.compile("((?=.*\\d)(?=.*[a-z]).{4,20})");
    
	private static List<String> imageExtensions = new ArrayList<String>();
	static{
		imageExtensions.add("jpeg");
		imageExtensions.add("JPEG");
		imageExtensions.add("png");
		imageExtensions.add("PNG");
		imageExtensions.add("JPG");
		imageExtensions.add("jpg");
	}
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
    
    public static boolean isNotNullNotEmpty(String value){
		if(value != null){
			return !StringUtils.isEmpty(value.trim());
		}
		return false;
	}
    public static boolean isNumeric(String value){
		if(isNotNullNotEmpty(value)){
			return StringUtils.isNumeric(value.trim());
		}
		return false;
	}
    public static boolean isImageExtention(String filename){
    	if(filename  != null) {
        	String ext = FilenameUtils.getExtension(filename);
        	return imageExtensions.contains(ext);
    	}
    	return false;
    }
    
}
