package com.ems.service;

import com.ems.domain.UserSetting;

public interface UserSettingService
{
	public long addUserSetting(UserSetting setting);
	
	public boolean updateUserSetting(UserSetting setting);
	
	public UserSetting getUserSetting(String userid);

}
