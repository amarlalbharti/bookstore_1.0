package com.ems.service;

import com.ems.domain.UserDetail;

public interface UserDetailService {
	public int addOtherDetails(UserDetail userDetail);
	public UserDetail getUserId(String id);
    public boolean editOtherDetails(UserDetail userDetail);
	public UserDetail getId(int id);
}
