package com.ems.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ems.domain.Department;

@Repository
public class DepartmentDaoImpl implements DepartmentDao
{
	@Autowired private SessionFactory sessionFactory;
	
	public Department getDepartmentById(int departmentId)
	{
		return (Department)this.sessionFactory.getCurrentSession().get(Department.class, departmentId);
	}
	
	@SuppressWarnings("unchecked")
	public List<Department> getDepartmentList()
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Department.class)
				.add(Restrictions.isNull("deleteDate")).list();
	}

	public int addDepartment(Department department) {
	
		this.sessionFactory.getCurrentSession().save(department);
		this.sessionFactory.getCurrentSession().flush();
		return department.getDepartmentId();
	}

	public boolean updateDepartment(Department department) {
		try
		{
			this.sessionFactory.getCurrentSession().update(department);
			this.sessionFactory.getCurrentSession().flush();
			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
		
	}
}
