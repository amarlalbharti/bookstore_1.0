package com.ems.dao;

import java.util.List;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.ems.domain.UserDetail;
import com.ems.domain.UserRole;

@Repository
public class UserDetailDaoImpl implements UserDetailDao{

	@Autowired private SessionFactory sessionFactory;
	public int addOtherDetails(UserDetail userDetail) {
		this.sessionFactory.getCurrentSession().save(userDetail);
		this.sessionFactory.getCurrentSession().flush();
		return userDetail.getUserId();
	}
	public UserDetail getUserId(String userid) {
		@SuppressWarnings("unchecked")
		List<UserDetail> list = this.sessionFactory.getCurrentSession().createCriteria(UserDetail.class)
					.createAlias("registration", "regAlias")			
					.add(Restrictions.eq("regAlias.userid", userid))
					.list();
								
			System.out.println("list....."+list.size());	
		if(!list.isEmpty())
		{
			return list.get(0);
		}
		return null;
	}
	public boolean editOtherDetails(UserDetail userDetail) {
		
		try 
		{
			this.sessionFactory.getCurrentSession().update(userDetail);
			this.sessionFactory.getCurrentSession().flush();
			return true;
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			return false;
		}
	}
	public UserDetail getId(int id) {
		
		return (UserDetail) this.sessionFactory.getCurrentSession().get(UserDetail.class,id);
	}

}
