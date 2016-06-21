package com.ems.dao;

import java.util.List;

import com.ems.domain.Designation;

public interface DesignationDao 
{
	public Designation getDesignationById(int designationId);
	
	public List<Designation> getDesignationList();
	
	public int addDesignation(Designation designation);
	
	public boolean updateDesignation(Designation designation);
}
