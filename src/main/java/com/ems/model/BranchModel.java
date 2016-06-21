package com.ems.model;

import javax.persistence.Column;

import org.hibernate.validator.constraints.NotEmpty;

import com.ems.domain.Country;

public class BranchModel {

	private int branchId;

	@NotEmpty(message="{NotEmpty.branchForm.branchName}")
	private String branchName;

	@NotEmpty(message="{NotEmpty.branchForm.phoneNo}")
	private String phoneNo;

	@NotEmpty(message="{NotEmpty.branchForm.address}")
	private String address;
	
	private String pinCode;
	
	private Country country;
	
	private String timeZone;
	
	@Column(nullable=false)
	public String getTimeZone() {
		return timeZone;
	}
	public void setTimeZone(String timeZone) {
		this.timeZone = timeZone;
	}
	public int getBranchId() {
		return branchId;
	}
	public void setBranchId(int branchId) {
		this.branchId = branchId;
	}
	
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getPinCode() {
		return pinCode;
	}
	public void setPinCode(String pinCode) {
		this.pinCode = pinCode;
	}
	
	public Country getCountry() {
		return country;
	}
	public void setCountry(Country country) {
		this.country = country;
	}
	
}
