package com.ems.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ems.domain.UserSetting;

@Repository
public class UserSettingDaoImpl implements UserSettingDao
{
	@Autowired private SessionFactory sessionFactory;
	
	public long addUserSetting(UserSetting setting)
	{
		this.sessionFactory.getCurrentSession().save(setting);
		this.sessionFactory.getCurrentSession().flush();
		return setting.getSid();
	}
	
	public boolean updateUserSetting(UserSetting setting)
	{
		try 
		{
			this.sessionFactory.getCurrentSession().update(setting);
			this.sessionFactory.getCurrentSession().flush();
			return true;
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}
	
	@SuppressWarnings("unchecked")
	public UserSetting getUserSetting(String userid)
	{
		List<UserSetting> list = this.sessionFactory.getCurrentSession().createCriteria(UserSetting.class)
				.createAlias("registration", "regAlias")
				.createAlias("regAlias.log", "logAlias")
				.add(Restrictions.eq("logAlias.userid", userid))
				.setMaxResults(1)
				.list();
		if(!list.isEmpty())
		{
			return list.get(0);
		}
		return null;
	}

}
