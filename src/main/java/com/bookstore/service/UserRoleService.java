package com.bookstore.service;

import java.util.List;

import com.bookstore.domain.UserRole;

public interface UserRoleService {
	public List<UserRole> getUserRolesByUserid(String userid);
	
	public boolean deleteUserRole(UserRole role);
	
	public boolean deleteUserRole(List<UserRole> roles);
	
}
