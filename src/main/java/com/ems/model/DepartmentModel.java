package com.ems.model;



import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class DepartmentModel {
	
    private int departmentId;

    @NotEmpty(message="{NotEmpty.depForm.department}")
    @Pattern(regexp="^[-a-zA-Z ]*$",message="{Pattern.depForm.department}")
	private String department;

	public int getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}
	
    
    

}
