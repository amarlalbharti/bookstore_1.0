package com.ems.model;


import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;


public class UserDetailModel {
	
	@NotEmpty(message="{NotEmpty.odForm.parmanentAddress}")
	private String parmanentAddress;
	
	@NotEmpty(message="{NotEmpty.odForm.presentAddress}")
	private String presentAddress;
	
	@NotEmpty(message="{NotEmpty.odForm.city}")
	private String city;
	
	@NotEmpty(message="{NotEmpty.odForm.state}")
	private String state;
	
	@NotEmpty(message="{NotEmpty.odForm.country}")
	private String country;
	
	private String userid;
	
	private String bloodGroup;
	
	private String maritalStatus;
	
	@NotEmpty(message="{NotEmpty.odForm.qualification}")
	private String qualification;
	
		
	private String mobileNo;
	
	private String emergencyNo;
	
	private String altEmailId;
	
	private String passportNo;
		

	public String getParmanentAddress() {
		return parmanentAddress;
	}

	public void setParmanentAddress(String parmanentAddress) {
		this.parmanentAddress = parmanentAddress;
	}

	public String getPresentAddress() {
		return presentAddress;
	}

	public void setPresentAddress(String presentAddress) {
		this.presentAddress = presentAddress;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getBloodGroup() {
		return bloodGroup;
	}

	public void setBloodGroup(String bloodGroup) {
		this.bloodGroup = bloodGroup;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	
	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getEmergencyNo() {
		return emergencyNo;
	}

	public void setEmergencyNo(String emergencyNo) {
		this.emergencyNo = emergencyNo;
	}

	public String getAltEmailId() {
		return altEmailId;
	}

	public void setAltEmailId(String altEmailId) {
		this.altEmailId = altEmailId;
	}

	public String getPassportNo() {
		return passportNo;
	}

	public void setPassportNo(String passportNo) {
		this.passportNo = passportNo;
	}
	
	
	
}
