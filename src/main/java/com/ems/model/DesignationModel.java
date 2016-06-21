package com.ems.model;



import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class DesignationModel {
	
    private int designationId;

    @NotEmpty(message="{NotEmpty.desgForm.designation}")
    @Pattern(regexp="^[-a-zA-Z ]*$",message="{Pattern.desgForm.designation}")
	private String designation;

    
    
	public int getDesignationId() {
		return designationId;
	}

	public void setDesignationId(int designationId) {
		this.designationId = designationId;
	}
 
	
	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

    
    
}
