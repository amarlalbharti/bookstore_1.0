package com.ems.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="payroll")
public class Payroll implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6278858084638859534L;
	private int pid;
	private Registration registration; 
	private double basicSal;
	private double hrAllowance;
	private double transportAllowance;
	private double leaveTravelAllowance;
	private double specialAllowance;
	
	private double salaryAdvance;
	private double pfDeduction;
	private double tdsDeduction;
	private double otherDeduction;
	private double foodDeduction;
	private double rentDeduction;
	
	private double totelEarning;
	private double totelDeduction;
	private double netPay;
	private Date createDate;
	private Date deleteDate;
	private Date modifiedDate;
	
	private Date payMonth;
	private int noOfPresentDays;


	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	@Column(nullable=false)
	public double getBasicSal() {
		return basicSal;
	}

	public void setBasicSal(double basicSal) {
		this.basicSal = basicSal;
	}

	@Column
	public double getHrAllowance() {
		return hrAllowance;
	}

	public void setHrAllowance(double hrAllowance) {
		this.hrAllowance = hrAllowance;
	}

	@Column
	public double getTransportAllowance() {
		return transportAllowance;
	}

	public void setTransportAllowance(double transportAllowance) {
		this.transportAllowance = transportAllowance;
	}

	@Column
	public double getLeaveTravelAllowance() {
		return leaveTravelAllowance;
	}

	public void setLeaveTravelAllowance(double leaveTravelAllowance) {
		this.leaveTravelAllowance = leaveTravelAllowance;
	}

	@Column
	public double getSpecialAllowance() {
		return specialAllowance;
	}

	public void setSpecialAllowance(double specialAllowance) {
		this.specialAllowance = specialAllowance;
	}

	@Column
	public double getSalaryAdvance() {
		return salaryAdvance;
	}

	public void setSalaryAdvance(double salaryAdvance) {
		this.salaryAdvance = salaryAdvance;
	}

	@Column
	public double getPfDeduction() {
		return pfDeduction;
	}

	public void setPfDeduction(double pfDeduction) {
		this.pfDeduction = pfDeduction;
	}

	@Column
	public double getTdsDeduction() {
		return tdsDeduction;
	}

	public void setTdsDeduction(double tdsDeduction) {
		this.tdsDeduction = tdsDeduction;
	}

	@Column
	public double getOtherDeduction() {
		return otherDeduction;
	}

	public void setOtherDeduction(double otherDeduction) {
		this.otherDeduction = otherDeduction;
	}

	@Column
	public double getTotelEarning() {
		return totelEarning;
	}

	public void setTotelEarning(double totelEarning) {
		this.totelEarning = totelEarning;
	}

	@Column
	public double getTotelDeduction() {
		return totelDeduction;
	}

	public void setTotelDeduction(double totelDeduction) {
		this.totelDeduction = totelDeduction;
	}

	@Column
	public double getNetPay() {
		return netPay;
	}

	public void setNetPay(double netPay) {
		this.netPay = netPay;
	}

	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="reg_id", referencedColumnName="lid")
	public Registration getRegistration() {
		return registration;
	}

	public void setRegistration(Registration registration) {
		this.registration = registration;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getDeleteDate() {
		return deleteDate;
	}

	public void setDeleteDate(Date deleteDate) {
		this.deleteDate = deleteDate;
	}

	public Date getModifiedDate() {
		return modifiedDate;
	}

	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	
	@Column(nullable=false)
	public Date getPayMonth() {
		return payMonth;
	}

	public void setPayMonth(Date payMonth) {
		this.payMonth = payMonth;
	}
	
	@Column
	public double getFoodDeduction() {
		return foodDeduction;
	}

	public void setFoodDeduction(double foodDeduction) {
		this.foodDeduction = foodDeduction;
	}

	@Column
	public double getRentDeduction() {
		return rentDeduction;
	}

	public void setRentDeduction(double rentDeduction) {
		this.rentDeduction = rentDeduction;
	}
	
	@Column
	public int getNoOfPresentDays() {
		return noOfPresentDays;
	}

	public void setNoOfPresentDays(int noOfPresentDays) {
		this.noOfPresentDays = noOfPresentDays;
	}
}
