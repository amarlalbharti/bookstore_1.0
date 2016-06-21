package com.ems.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 * Used for employee Bank Detail 
 * 
 * @author Saumya
 *
 */

@Entity
@Table(name="bankdetail")
public class BankDetail implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 815846041447307277L;
	private Registration registration;
	private int bankId;
	private String bankName;
	private String accountNo;
	private String ifscCode;
	private String nameAsBankRecord;
	private double basicSalary;
	private double pli;
	private String panNo;
	
	private Date modifiedDate;
	private Date createDate;
	
		
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int getBankId() {
		return bankId;
	}
	public void setBankId(int bankId) {
		this.bankId = bankId;
	}
	
	@Column
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	@Column
	public String getAccountNo() {
		return accountNo;
	}
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	
	@Column
	public Date getModifiedDate() {
		return modifiedDate;
	}
	
	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	
		
	@Column
	public String getIfscCode() {
		return ifscCode;
	}
	public void setIfscCode(String ifscCode) {
		this.ifscCode = ifscCode;
	}
	
	
	@Column
	public String getNameAsBankRecord() {
		return nameAsBankRecord;
	}
	public void setNameAsBankRecord(String nameAsBankRecord) {
		this.nameAsBankRecord = nameAsBankRecord;
	}
	
	
	@Column
	public double getBasicSalary() {
		return basicSalary;
	}
	public void setBasicSalary(double basicSalary) {
		this.basicSalary = basicSalary;
	}
	
	@Column
	public double getPli() {
		return pli;
	}
	public void setPli(double pli) {
		this.pli = pli;
	}
	
	
	@OneToOne(cascade=CascadeType.ALL)
	@JoinColumn(name="Employee_id", referencedColumnName="lid",unique=true, nullable = false)
	public Registration getRegistration() {
		return registration;
	}
	
	public void setRegistration(Registration registration) {
		this.registration = registration;
	}
	
	@Column
	public String getPanNo() {
		return panNo;
	}
	public void setPanNo(String panNo) {
		this.panNo = panNo;
	}
	
	@Column(nullable=false)
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	

}
