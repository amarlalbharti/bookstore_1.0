package com.ems.model;

import java.io.Serializable;
import java.util.Date;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import com.ems.domain.Department;
import com.ems.domain.Designation;

public class UpdateModel implements Serializable 
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -173935304198026883L;
	
	private String name;
	
	@NotEmpty(message="{NotEmpty.updateForm.userid}")
	@Email(message="{Email.updateForm.email}")
	private String userid;
	
	@NotEmpty(message="{NotEmpty.updateForm.gender}")
	private String gender;
	
	@NotEmpty(message="{NotEmpty.updateForm.dob}")
	private String dob;
	
	@NotEmpty(message="{NotEmpty.updateForm.department}")
	private Department department;
	
	@NotEmpty(message="{NotEmpty.updateForm.designation}")
	private Designation designation;
	
	@NotEmpty(message="{NotEmpty.updateForm.joiningDate}")
	private Date joiningDate; 
	
	private String probMonths;
	
	@NotEmpty(message="{NotEmpty.updateForm.branch}")
	private String branch;
	
	@NotEmpty(message="{NotEmpty.updateForm.dob}")
	private String country;

	@NotEmpty(message="{NotEmpty.updateForm.dob}")
	private Date modification_date;

	//updateForm
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Designation getDesignation() {
		return designation;
	}

	public void setDesignation(Designation designation) {
		this.designation = designation;
	}

	public Date getJoiningDate() {
		return joiningDate;
	}

	public void setJoiningDate(Date joiningDate) {
		this.joiningDate = joiningDate;
	}

	public String getProbMonths() {
		return probMonths;
	}

	public void setProbMonths(String probMonths) {
		this.probMonths = probMonths;
	}

	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public Date getModification_date() {
		return modification_date;
	}

	public void setModification_date(Date modification_date) {
		this.modification_date = modification_date;
	}
	
}
