package com.bookstore.service;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.bookstore.dao.LoginInfoDao;
import com.bookstore.domain.LoginInfo;

@Service
@Transactional
public class LoginInfoServiceImpl implements LoginInfoService{
	
	@Autowired private LoginInfoDao loginInfoDao;
	
	public boolean addLoginInfo(LoginInfo loginInfo)
	{
		return this.loginInfoDao.addLoginInfo(loginInfo);
	}
	
	public LoginInfo getLoginInfoByUserid(String userid) {
		
		return this.loginInfoDao.getLoginInfoByUserid(userid);
	}

	public String changeUserPassword(String userid, String oldPassword, String newPassword) {
		
		return this.loginInfoDao.changeUserPassword(userid, oldPassword, newPassword);
	}

	public boolean updateLoginInfo(LoginInfo loginInfo) {
		
		return this.loginInfoDao.updateLoginInfo(loginInfo);
	}

	public boolean resetPassword(String userid, String newPassword)
	{
		return this.loginInfoDao.resetPassword(userid, newPassword);
	}
}
