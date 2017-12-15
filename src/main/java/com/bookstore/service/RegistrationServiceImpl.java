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
	
	public int addRegistration(Registration registration) {
		return this.registrationDao.addRegistration(registration);
	}
	
	public boolean updateRegistration(Registration registration) {
		return this.registrationDao.updateRegistration(registration);
	}
	
	public Registration getRegistrationByRid(int rid) {
		return this.registrationDao.getRegistrationByRid(rid);
	}
	
	public Registration getRegistrationByUserid(String userid) {
		return this.registrationDao.getRegistrationByUserid(userid);
	}
	
	public List<Registration> getRegistrationList(boolean all , int first, int max){
		return this.registrationDao.getRegistrationList(all, first, max);
	}
	
	public List<Registration> getRegistrationListByRoles(List<String> roles, boolean all , int first, int max){
		return this.registrationDao.getRegistrationListByRoles(roles, all, first, max);
	}
	
	public long countRegistrationList() {
		return this.registrationDao.countRegistrationList();
	}
	
	public long countRegistrationListByRoles(List<String> roles) {
		return this.registrationDao.countRegistrationListByRoles(roles);
	}
}
