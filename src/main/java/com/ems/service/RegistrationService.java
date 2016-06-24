package com.ems.service;

import java.util.List;

import com.ems.domain.Registration;

public interface RegistrationService 
{
	public Registration getRegistrationByUserid(String userid);
	
	/**
	 * Returns the list of object of registration class
	 * @return
	 */
	public List<Registration> getRegistrationList();
	
	public long countEmployees();
	
	public long countOnlyEmployees();
	
	public boolean updateRegistration(Registration registration);
	
	public List<Registration> getEmpRegistrationList();
	
	public List<Registration> getEmpRegistrationListByCountry(int countryId);
	
	public List<Registration> getEmpRegistrationListByBranch(int branchId);
	
	public List<Registration> searchEmp(String text);
	
	public Registration getRegistrationByEid(String eid);
	
	
}
