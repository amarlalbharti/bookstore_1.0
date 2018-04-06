package com.bookstore.util;

import java.util.Date;

import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.userdetails.UserDetails;

import com.bookstore.domain.CustomerAddress;

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
	
	public static boolean isValidCheckoutStep(String step){
		boolean valid = false;
		if(step == null){
			valid = true;
		}else if(step.equalsIgnoreCase(CheckoutSteps.LOGIN.name())){
			valid = true;
		}else if(step.equalsIgnoreCase(CheckoutSteps.SHIPPINGINFO.name())){
			valid = true;
		}else if(step.equalsIgnoreCase(CheckoutSteps.PAYMENTINFO.name())){
			valid = true;
		}else if(step.equalsIgnoreCase(CheckoutSteps.PRODUCTREVIEW.name())){
			valid = true;
		}
		return valid;
	}
	
	
	public static String getCustomerAddressValue(CustomerAddress address){
		StringBuilder sb = new StringBuilder(); 
		if(address != null){
			if(address.getCustomerStreet() != null){
				sb.append(address.getCustomerStreet() +", ");
			}
			if(address.getLandmark() != null){
				sb.append(address.getLandmark()  +", ");
			}
			if(address.getCustomerCity() != null){
				sb.append(address.getCustomerCity() +", ");
			}
			if(address.getCustomerPinCode() != null){
				sb.append(address.getCustomerPinCode() +", ");
			}
			
			if(address.getRegistration() != null){
				sb.append("Name : "+address.getRegistration().getFirstName() + " " + address.getRegistration().getLastName());
			}
		}
		
		return sb.toString();
		
	}
	
	public static String getShippingAddressValue(CustomerAddress address){
		StringBuilder sb = new StringBuilder(); 
		if(address != null){
			if(address.getCustomerStreet() != null){
				sb.append(address.getCustomerStreet() +", ");
			}
			if(address.getLandmark() != null){
				sb.append(address.getLandmark()  +", ");
			}
			if(address.getCustomerCity() != null){
				sb.append(address.getCustomerCity().getCityName() +", ");
				if(address.getCustomerCity().getState() != null) {
					sb.append(address.getCustomerCity().getState().getStateName() +", ");
					if(address.getCustomerCity().getState().getCountry() != null) {
						sb.append(address.getCustomerCity().getState().getCountry().getCountryName() +", ");
					}
				}
			}
			if(address.getCustomerPinCode() != null){
				sb.append(address.getCustomerPinCode());
			}
		}
		
		return sb.toString();
		
	}
}
