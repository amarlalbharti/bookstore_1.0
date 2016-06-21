package com.ems.model;

import java.math.BigDecimal;

import org.hibernate.validator.constraints.NotEmpty;

public class BankDetailModel {
	
	
	private String userid;
	private int bankId;
	
	@NotEmpty(message="{NotEmpty.bdForm.bankName}")
	private String bankName;
	
	@NotEmpty(message="{NotEmpty.bdForm.accountNo}")
	private String accountNo;
	
	@NotEmpty(message="{NotEmpty.bdForm.ifscCode}")
	private String ifscCode;
	
	@NotEmpty(message="{NotEmpty.bdForm.nameAsBankRecord}")
	private String nameAsBankRecord;
	
	private double basicSalary;
	private double pli;
	private String panNo;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	
	public int getBankId() {
		return bankId;
	}
	public void setBankId(int bankId) {
		this.bankId = bankId;
	}
	
	
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	
	
	public String getAccountNo() {
		return accountNo;
	}
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	
	
	public String getIfscCode() {
		return ifscCode;
	}
	public void setIfscCode(String ifscCode) {
		this.ifscCode = ifscCode;
	}
	
	
	public String getNameAsBankRecord() {
		return nameAsBankRecord;
	}
	public void setNameAsBankRecord(String nameAsBankRecord) {
		this.nameAsBankRecord = nameAsBankRecord;
	}
	
	
	public double getBasicSalary() {
		return basicSalary;
	}
	public void setBasicSalary(double basicSalary) {
		this.basicSalary = basicSalary;
	}
	
	
	public double getPli() {
		return pli;
	}
	public void setPli(double pli) {
		this.pli = pli;
	}
	
	
	public String getPanNo() {
		return panNo;
	}
	public void setPanNo(String panNo) {
		this.panNo = panNo;
	}
	
	
	

}
