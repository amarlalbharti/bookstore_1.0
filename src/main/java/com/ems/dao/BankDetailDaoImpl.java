package com.ems.dao;

import java.util.List;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.ems.domain.BankDetail;



@Repository
public class BankDetailDaoImpl implements BankDetailDao{

	
	@Autowired private SessionFactory sessionFactory;
	
	public int addBankDetails(BankDetail bankDetail) {
		this.sessionFactory.getCurrentSession().save(bankDetail);
		this.sessionFactory.getCurrentSession().flush();
		return bankDetail.getBankId();
	}

	public BankDetail getUserId(String userid) {
		@SuppressWarnings("unchecked")
		List<BankDetail> list = this.sessionFactory.getCurrentSession().createCriteria(BankDetail.class)
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

	public boolean editBankDetails(BankDetail bankDetail) {
		try 
		{
			this.sessionFactory.getCurrentSession().update(bankDetail);
			this.sessionFactory.getCurrentSession().flush();
			return true;
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}

}
