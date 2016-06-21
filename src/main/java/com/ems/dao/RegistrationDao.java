package com.ems.dao;

import java.util.List;

import com.ems.domain.Registration;

/**
 * Use for database interaction for registration table (Entity).
 * @author Bharti
 *
 */
public interface RegistrationDao 
{
	/**
	 * Returns the object of registration class for specific userid
	 * @param userid
	 * @return
	 */
	public Registration getRegistrationByUserid(String userid);
	
	/**
	 * Returns the list of object of registration class
	 * @return
	 */
	public List<Registration> getRegistrationList();
	
	public List<Registration> getEmpRegistrationList();
	
	public long countEmployees();
	
	public long countUserEmployees();
	
	public boolean updateRegistration(Registration registration);
	
	public List<Registration> getEmpRegistrationListByCountry(int countryId);
	
	public List<Registration> getEmpRegistrationListByBranch(int branchId);
	
	public List<Registration> searchEmp(String text);
	
}
