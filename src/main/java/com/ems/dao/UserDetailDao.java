package com.ems.dao;

import com.ems.domain.UserDetail;

public interface UserDetailDao {
	
	public int addOtherDetails(UserDetail userDetail);
	
	public UserDetail getUserId(String id);
	
    public boolean editOtherDetails(UserDetail userDetail);
	
	public UserDetail getId(int id);

}
