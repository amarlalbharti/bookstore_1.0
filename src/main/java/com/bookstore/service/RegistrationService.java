package com.bookstore.service;

import java.util.List;

import com.bookstore.domain.Registration;

public interface RegistrationService 
{
	public Registration getRegistrationByUserid(String userid);
	
	/**
	 * Returns the list of object of registration class
	 * @return
	 */
	public List<Registration> getRegistrationList();
	
	
	public boolean updateRegistration(Registration registration);
	
	
	
}
