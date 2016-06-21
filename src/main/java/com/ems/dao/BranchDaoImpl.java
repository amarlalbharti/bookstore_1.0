package com.ems.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ems.domain.Branch;
import com.ems.domain.Department;

@Repository
public class BranchDaoImpl implements BranchDao
{
	@Autowired private SessionFactory sessionFactory;
	
	public Branch getBranchById(int branchId)
	{
		return (Branch)this.sessionFactory.getCurrentSession().get(Branch.class, branchId);
	}
	
	@SuppressWarnings("unchecked")
	public List<Branch> getBranchList()
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Branch.class)
				.add(Restrictions.isNull("deleteDate"))
				.list();
	}

	@SuppressWarnings("unchecked")
	public List<Branch> getBranchByCountryId(int countryId) {
		return this.sessionFactory.getCurrentSession().createCriteria(Branch.class)
				.add(Restrictions.eq("country.countryId", countryId))
				.addOrder(Order.asc("branchName")).list();
	}

	public int addBranch(Branch branch) {
		this.sessionFactory.getCurrentSession().save(branch);
		this.sessionFactory.getCurrentSession().flush();
		return branch.getBranchId();
	}

	public int updateBranch(Branch branch) {
		this.sessionFactory.getCurrentSession().update(branch);
		this.sessionFactory.getCurrentSession().flush();
		return branch.getBranchId();
	}

	public boolean deleteBranch(int branchId) {
		return false;
	}

	
}
