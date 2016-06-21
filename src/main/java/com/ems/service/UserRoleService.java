package com.ems.service;

import java.util.List;

import com.ems.domain.UserRole;

public interface UserRoleService {
	public List<UserRole> getUserRolesByUserid(String userid);
}
