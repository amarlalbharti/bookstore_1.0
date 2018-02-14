package com.bookstore.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.CustomerAddress;

import scala.collection.generic.GenTraversableFactory.ReusableCBF;

@Repository
public class CustomerAddressDaoImpl implements CustomerAddressDao
{
	@Autowired
	private SessionFactory sessionFactory;
	
	public int addCustomerAddress(CustomerAddress customerAddress){
		try {
			this.sessionFactory.getCurrentSession().save(customerAddress);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return customerAddress.getCustomerAddressId();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public boolean updateCustomerAddress(CustomerAddress customerAddress){
		try {
			this.sessionFactory.getCurrentSession().update(customerAddress);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public CustomerAddress getCustomerAddressById(int addressId){
		try {
			return (CustomerAddress)this.sessionFactory.getCurrentSession().get(CustomerAddress.class, addressId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public CustomerAddress getActiveCustomerAddressById(int rid){
		try {
			List<CustomerAddress> list = this.sessionFactory.getCurrentSession().createCriteria(CustomerAddress.class)
					.createAlias("registration", "regAlias")
					.add(Restrictions.eq("regAlias.rid", rid))
					.add(Restrictions.eq("active", Boolean.TRUE))
					.add(Restrictions.isNull("deletedDate"))
					.list();
			if(!list.isEmpty()){
				return list.get(0);
			}
		} catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<CustomerAddress> getCustomerAddressByCustomer(int rid){
		try{
			return this.sessionFactory.getCurrentSession().createCriteria(CustomerAddress.class)
					.createAlias("registration", "regAlias")
					.add(Restrictions.eq("regAlias.rid", rid))
					.add(Restrictions.isNull("deletedDate"))
					.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
