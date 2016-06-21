package com.ems.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.dao.UserRoleDao;
import com.ems.domain.UserRole;

@Service
@Transactional
public class UserRoleServiceImpl implements UserRoleService {

	@Autowired private UserRoleDao userRoleDao;
	
	public List<UserRole> getUserRolesByUserid(String userid) {
		return userRoleDao.getUserRolesByUserid(userid);
	}

}
