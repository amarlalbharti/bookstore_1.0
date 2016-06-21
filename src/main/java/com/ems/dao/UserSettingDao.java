package com.ems.dao;

import com.ems.domain.UserSetting;

public interface UserSettingDao 
{
	public long addUserSetting(UserSetting setting);
	
	public boolean updateUserSetting(UserSetting setting);
	
	public UserSetting getUserSetting(String userid);
}
