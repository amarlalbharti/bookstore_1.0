package com.bookstore.dao;

import com.bookstore.domain.LoginInfo;

public interface LoginInfoDao 
{
	public boolean addLoginInfo(LoginInfo loginInfo);
	
	public LoginInfo getLoginInfoByUserid(String userid);
	
	public String changeUserPassword(String userid, String oldPassword, String newPassword);
	
	public boolean updateLoginInfo(LoginInfo loginInfo);
	
	public boolean resetPassword(String userid, String newPassword);
}
