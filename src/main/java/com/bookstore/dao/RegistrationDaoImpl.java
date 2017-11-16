package com.bookstore.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.config.Roles;
import com.bookstore.domain.Registration;
import com.bookstore.domain.UserRole;

@Repository
public class RegistrationDaoImpl implements RegistrationDao
{
	@Autowired private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public Registration getRegistrationByUserid(String userid)
	{
		List<Registration> list = this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
				.createAlias("loginInfo", "logAlias")
				.add(Restrictions.eq("logAlias.userid", userid))
				.setFetchMode("loginInfo", FetchMode.JOIN)
				.list();
		if(!list.isEmpty())
		{
			return list.get(0);
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Registration> getRegistrationList()
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
				.addOrder(Order.desc("createDate"))
				.setFetchMode("loginInfo", FetchMode.JOIN)
				.list();
	}
	
	public boolean updateRegistration(Registration registration)
	{
		try 
		{
			this.sessionFactory.getCurrentSession().update(registration);
			this.sessionFactory.getCurrentSession().flush();
			return true;
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}
	
	
}
