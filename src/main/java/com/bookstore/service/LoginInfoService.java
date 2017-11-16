package com.bookstore.service;

import com.bookstore.domain.LoginInfo;

public interface LoginInfoService {

	public boolean addLoginInfo(LoginInfo loginInfo);
	
	public LoginInfo getLoginInfoByUserid(String userid);
	
	public String changeUserPassword(String userid, String oldPassword, String newPassword);
	
	public boolean updateLoginInfo(LoginInfo loginInfo);
	
	public boolean resetPassword(String userid, String newPassword);

}
