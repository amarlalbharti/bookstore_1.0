package com.ems.model;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class CountryModel {
	
	private int countryId;
	
	@NotEmpty(message="{NotEmpty.countryForm.countryName}")
	@Pattern(regexp="^[-a-zA-Z ]*$",message="{Pattern.countryForm.countryName}")
	private String countryName;
	
	
	public int getCountryId() {
		return countryId;
	}
	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}
	
	
	
	public String getCountryName() {
		return countryName;
	}
	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}
	
	
	
	

}
