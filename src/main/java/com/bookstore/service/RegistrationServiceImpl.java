package com.bookstore.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.RegistrationDao;
import com.bookstore.domain.Registration;

@Service
@Transactional
public class RegistrationServiceImpl implements RegistrationService
{
	@Autowired private RegistrationDao registrationDao;
	
	public Registration getRegistrationByUserid(String userid)
	{
		return this.registrationDao.getRegistrationByUserid(userid);
	}
	
	public List<Registration> getRegistrationList()
	{
		return this.registrationDao.getRegistrationList();
	}
	
	public boolean updateRegistration(Registration registration)
	{
		return this.registrationDao.updateRegistration(registration);
	}

}
