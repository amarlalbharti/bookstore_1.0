package com.bookstore.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.FetchMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.Registration;

@Repository
public class RegistrationDaoImpl implements RegistrationDao
{
	@Autowired private SessionFactory sessionFactory;
	
	
	public int addRegistration(Registration registration) {
		try {
			this.sessionFactory.getCurrentSession().save(registration);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return registration.getRid();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
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
	
	public Registration getRegistrationByRid(int rid) {
		try 
		{
			return (Registration)this.sessionFactory.getCurrentSession().get(Registration.class, rid);
			
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public Registration getRegistrationByUserid(String userid)
	{
		List<Registration> list = this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
				.createAlias("loginInfo", "logAlias")
				.add(Restrictions.eq("logAlias.userid", userid))
				.list();
		if(!list.isEmpty())
		{
			return list.get(0);
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Registration> getRegistrationList(List<String> userids){
		List<Registration> list = null;
		try {
			if(userids != null && !userids.isEmpty()){
				list = this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
						.createAlias("loginInfo", "logAlias")
						.add(Restrictions.in("logAlias.userid", userids))
						.list();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<Registration> getRegistrationList(boolean all , int first, int max){
		List<Registration> list = null;
		try {
			if(all) {
				list = this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
						.addOrder(Order.desc("createDate"))
						.list();	
			}else {
				list = this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
						.addOrder(Order.desc("createDate"))
						.setFirstResult(first)
						.setMaxResults(max)
						.list();				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<Registration> getRegistrationListByRoles(List<String> roles, boolean all , int first, int max){
		try {
			if(all) {
				return this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
						.createAlias("loginInfo", "logAlias")
						.createAlias("logAlias.roles", "rolesAlias")
						.add(Restrictions.in("rolesAlias.userrole", roles))
						.addOrder(Order.desc("createDate"))
						.list();
			}else {
				return this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
						.createAlias("loginInfo", "logAlias")
						.createAlias("logAlias.roles", "rolesAlias")
						.add(Restrictions.in("rolesAlias.userrole", roles))
						.addOrder(Order.desc("createDate"))
						.setFirstResult(first)
						.setMaxResults(max)
						.list();				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public long countRegistrationList() {
		return (Long)this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
				.setProjection(Projections.rowCount())
				.uniqueResult();
	}
	
	public long countRegistrationListByRoles(List<String> roles) {
		return (Long)this.sessionFactory.getCurrentSession().createCriteria(Registration.class)
				.createAlias("loginInfo", "logAlias")
				.createAlias("loginInfo.roles", "rolesAlias")
				.add(Restrictions.in("rolesAlias.userrole", roles))
				.setProjection(Projections.rowCount())
				.uniqueResult();
	}
	
	
	
}
