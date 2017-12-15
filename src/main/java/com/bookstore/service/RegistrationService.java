package com.bookstore.service;

import java.util.List;

import com.bookstore.domain.Registration;

public interface RegistrationService 
{
public int addRegistration(Registration registration);
	
	public boolean updateRegistration(Registration registration);
	
	public Registration getRegistrationByRid(int rid);
	
	public Registration getRegistrationByUserid(String userid);
	
	public List<Registration> getRegistrationList(boolean all , int first, int max);
	
	public List<Registration> getRegistrationListByRoles(List<String> roles, boolean all , int first, int max);
	
	public long countRegistrationList();
	
	public long countRegistrationListByRoles(List<String> roles);
}
