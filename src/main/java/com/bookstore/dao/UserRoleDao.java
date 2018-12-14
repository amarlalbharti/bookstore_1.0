package com.bookstore.dao;

import java.util.List;

import com.bookstore.domain.UserRole;

public interface UserRoleDao {
	
	public List<UserRole> getUserRolesByUserid(String userid);
	
	
	public boolean deleteUserRoles(UserRole role);
	
}
