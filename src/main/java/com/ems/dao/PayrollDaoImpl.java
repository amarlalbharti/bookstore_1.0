package com.ems.dao;

import java.util.Date;
import java.util.List;

import org.hibernate.FetchMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ems.domain.Payroll;

@Repository
public class PayrollDaoImpl implements PayrollDao {
	
	@Autowired private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<Payroll> getPayrollByEmpId(String empId)
	{
		return this.sessionFactory.getCurrentSession()
				.createCriteria(Payroll.class)
				.createAlias("registration", "regAlias")
				.createAlias("regAlias.log", "logAlias")
				.add(Restrictions.eq("logAlias.userid", empId))
				.list();
	}

	@SuppressWarnings("unchecked")
	public List<Payroll> getPayrollList() 
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Payroll.class)
				.add(Restrictions.isNull("deleteDate"))
				.addOrder(Order.desc("payMonth"))
				.setFetchMode("registration", FetchMode.JOIN)
				.list();
	}

	public boolean addPayroll(Payroll payroll) {
		try
		{
			this.sessionFactory.getCurrentSession().save(payroll);
			return true;
		}
		catch(Exception ee)
		{
			ee.printStackTrace();
			return false;
		}
	}

	public boolean updatePayroll(Payroll payroll) {
		try
		{
			this.sessionFactory.getCurrentSession().update(payroll);
			return true;
		}
		catch(Exception ee)
		{
			ee.printStackTrace();
			return false;
		}
	}

	public Payroll getPayrollById(int pid) {
		return (Payroll)this.sessionFactory.getCurrentSession().get(Payroll.class, pid);
	}

	@SuppressWarnings("unchecked")
	public List<Payroll> getOneMonthPayroll(Date sDate, Date eDate) {
		try
		{
			List<Payroll> list = this.sessionFactory.getCurrentSession()
					.createCriteria(Payroll.class)
					.add(Restrictions.isNull("deleteDate"))
					.add(Restrictions.between("payMonth", sDate, eDate))
					.list();
			
			return list;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<Payroll> getOneMonthPayroll(String userId, Date sDate, Date eDate) {
		try
		{
			List<Payroll> list = this.sessionFactory.getCurrentSession()
					.createCriteria(Payroll.class)
					.createAlias("registration", "regAlias")
					.createAlias("regAlias.log", "logAlias")
					.add(Restrictions.eq("logAlias.userid", userId))
					.add(Restrictions.isNull("deleteDate"))
					.add(Restrictions.between("payMonth", sDate, eDate))
					.addOrder(Order.desc("payMonth"))
					.list();
			
			return list;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return null;
	}

}
