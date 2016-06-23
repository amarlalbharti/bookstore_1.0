package com.ems.model;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import com.ems.domain.Branch;
import com.ems.domain.Country;
import com.ems.domain.Department;
import com.ems.domain.Designation;

public class RegModel implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1560501278799670875L;

	@NotEmpty(message="{NotEmpty.regForm.name}")
	private String name;
	
	@NotEmpty(message="{NotEmpty.regForm.userid}")
	@Email(message="{Email.regForm.email}")
	private String userid;
	
	@NotEmpty(message="{NotEmpty.regForm.password}")
	@Pattern(regexp="(?=.*\\d)(?=.*[a-z]).{4,20}",message="{Pattern.regForm.password}")
	private String password;
	
	@NotNull(message="{NotNull.regForm.repassword}")
	private String repassword;
	
	@NotEmpty(message="{NotEmpty.regForm.userrole}")
	private String userrole;
	
	@NotEmpty(message="{NotEmpty.regForm.dob}")
	private String dob;

	private String gender;
	
	private Department department;
	
	private Designation designation;
	
	private Branch branch;
	
	private MultipartFile userImage;
	
	private MultipartFile userPan;
	
	private Country country;
	
	@NotEmpty(message="{NotEmpty.regForm.eId}")
	private String eId;
	
	public String geteId() {
		return eId;
	}

	public void seteId(String eId) {
		this.eId = eId;
	}

	public Country getCountry() {
		return country;
	}

	public void setCountry(Country country) {
		this.country = country;
	}

	public MultipartFile getUserPan() {
		return userPan;
	}

	public void setUserPan(MultipartFile userPan) {
		this.userPan = userPan;
	}

	public MultipartFile getUserImage() {
		return userImage;
	}

	public void setUserImage(MultipartFile userImage) {
		this.userImage = userImage;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRepassword() {
		return repassword;
	}

	public void setRepassword(String repassword) {
		this.repassword = repassword;
		matchPassword();
	}

	public String getUserrole() {
		return userrole;
	}

	public void setUserrole(String userrole) {
		this.userrole = userrole;
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
	
	private void matchPassword() {
	    if(this.password == null || this.repassword == null){
	        return;
	    }else if(!(this.password.equals(this.repassword))){
	    	System.out.println("in checkpassword");
	        this.repassword = null;
	    }
	}

	@NotNull(message="{NotNull.regForm.gender}")
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
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
