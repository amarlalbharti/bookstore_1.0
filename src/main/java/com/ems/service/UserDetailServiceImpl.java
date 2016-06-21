package com.ems.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.dao.UserDetailDao;
import com.ems.domain.UserDetail;

@Service
@Transactional
public class UserDetailServiceImpl implements UserDetailService{

	@Autowired private UserDetailDao userDetailDao;
	public int addOtherDetails(UserDetail userDetail) {
		
		return this.userDetailDao.addOtherDetails(userDetail);
	}
	public UserDetail getUserId(String id) {
		
		return this.userDetailDao.getUserId(id);
	}
	public boolean editOtherDetails(UserDetail userDetail) {
		
		return this.userDetailDao.editOtherDetails(userDetail);
	}
	public UserDetail getId(int id) {
		
		return this.userDetailDao.getId(id);
	}

}
