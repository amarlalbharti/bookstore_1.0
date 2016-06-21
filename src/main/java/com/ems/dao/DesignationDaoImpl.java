package com.ems.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ems.domain.Designation;

@Repository
public class DesignationDaoImpl implements DesignationDao
{
	@Autowired private SessionFactory sessionFactory;
	
	public Designation getDesignationById(int designationId)
	{
		return (Designation)this.sessionFactory.getCurrentSession().get(Designation.class, designationId);
	}
	
	@SuppressWarnings("unchecked")
	public List<Designation> getDesignationList()
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Designation.class)
				.add(Restrictions.isNull("deleteDate") ).list();
	}

	public int addDesignation(Designation designation) {
		
		this.sessionFactory.getCurrentSession().save(designation);
		this.sessionFactory.getCurrentSession().flush();
		return designation.getDesignationId();
	}

	public boolean updateDesignation(Designation designation) {
		
	try{
		this.sessionFactory.getCurrentSession().update(designation);
		this.sessionFactory.getCurrentSession().flush();
		return true;
		
	}catch(Exception e){
		e.printStackTrace();
		return false;
	}
		
	}
}
