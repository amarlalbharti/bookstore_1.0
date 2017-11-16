package com.bookstore.dao;

import java.util.List;

import com.bookstore.domain.Registration;

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
	
	public boolean updateRegistration(Registration registration);
	
	
	
	
}
