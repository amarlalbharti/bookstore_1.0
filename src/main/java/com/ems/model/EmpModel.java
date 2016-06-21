package com.ems.model;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import com.ems.domain.Branch;
import com.ems.domain.Country;
import com.ems.domain.Department;
import com.ems.domain.Designation;

public class EmpModel 
{
	@NotEmpty(message="{NotEmpty.regForm.name}")
	private String name;
	
	private String userid;
	
	private MultipartFile userImage;
	
	public MultipartFile getUserImage() {
		return userImage;
	}

	public void setUserImage(MultipartFile userImage) {
		this.userImage = userImage;
	}

	public MultipartFile getUserPan() {
		return userPan;
	}

	public void setUserPan(MultipartFile userPan) {
		this.userPan = userPan;
	}

	private MultipartFile userPan;
	
	@NotEmpty(message="{NotEmpty.regForm.userrole}")
	private String userrole;
	
	@NotEmpty(message="{NotEmpty.regForm.dob}")
	private String dob;

	@NotNull(message="{NotNull.regForm.gender}")
	private String gender;
	
	private Department department;
	
	private Designation designation;
	
	private Branch branch;
	
	private Country country;
	
	public Country getCountry() {
		return country;
	}

	public void setCountry(Country country) {
		this.country = country;
	}

	@NotEmpty(message="{NotEmpty.regForm.joiningDate}")
	private String joiningDate;

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

	public String getJoiningDate() {
		return joiningDate;
	}

	public void setJoiningDate(String joiningDate) {
		this.joiningDate = joiningDate;
	} 
	
	
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getUserrole() {
		return userrole;
	}

	public void setUserrole(String userrole) {
		this.userrole = userrole;
	}

	public Branch getBranch() {
		return branch;
	}

	public void setBranch(Branch branch) {
		this.branch = branch;
	}
	
	
	private int weekOff;

	public int getWeekOff() {
		return weekOff;
	}

	public void setWeekOff(int weekOff) {
		this.weekOff = weekOff;
	}
	
	
}
