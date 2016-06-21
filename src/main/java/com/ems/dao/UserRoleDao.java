package com.ems.dao;

import java.util.List;

import com.ems.domain.UserRole;

public interface UserRoleDao {
	
	public List<UserRole> getUserRolesByUserid(String userid);
	
}
