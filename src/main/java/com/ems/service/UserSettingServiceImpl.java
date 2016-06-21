package com.ems.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.dao.UserSettingDao;
import com.ems.domain.UserSetting;

@Service
@Transactional
public class UserSettingServiceImpl implements UserSettingService
{
	@Autowired private UserSettingDao userSettingDao;
	
	public long addUserSetting(UserSetting setting) {
		return this.userSettingDao.addUserSetting(setting);
	}

	public boolean updateUserSetting(UserSetting setting) {
		return this.userSettingDao.updateUserSetting(setting);
	}

	public UserSetting getUserSetting(String userid) {
		return this.userSettingDao.getUserSetting(userid);
	}
	
}
