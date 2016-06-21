package com.ems.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ems.domain.UserRole;

@Repository
public class UserRoleDaoImpl implements UserRoleDao {

	@Autowired private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public List<UserRole> getUserRolesByUserid(String userid) {
		
		return this.sessionFactory.getCurrentSession().createCriteria(UserRole.class)
				.add(Restrictions.eq("log.userid", userid)).list();
	}

}
