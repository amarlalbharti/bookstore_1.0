package com.bookstore.dao;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.CustomerAddress;


@Repository
public class CustomerAddressDaoImpl implements CustomerAddressDao
{
	private static final Logger LOGGER = Logger.getLogger(CustomerAddressDaoImpl.class);
	@Autowired
	private SessionFactory sessionFactory;
	
	public int addCustomerAddress(CustomerAddress customerAddress){
		try {
			this.sessionFactory.getCurrentSession().save(customerAddress);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return customerAddress.getCustomerAddressId();
		} catch (Exception e) {
			LOGGER.error("Error in addCustomerAddress(CustomerAddress customerAddress) >> customerAddress: "+customerAddress.getAddress(), e);
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
			LOGGER.error("Error in updateCustomerAddress(CustomerAddress customerAddress) >> customerAddress: "+customerAddress.getAddress(), e);
		}
		return false;
	}
	
	public CustomerAddress getCustomerAddressById(int addressId){
		try {
			return (CustomerAddress)this.sessionFactory.getCurrentSession().get(CustomerAddress.class, addressId);
		} catch (Exception e) {
			LOGGER.error("Error in getCustomerAddressById(int addressId) >> addressId: "+addressId, e);
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public CustomerAddress getCustomerAddress(int rid, int addressId){
		try {
			List<CustomerAddress> list = this.sessionFactory.getCurrentSession().createCriteria(CustomerAddress.class)
					.createAlias("registration", "regAlias")
					.add(Restrictions.eq("regAlias.rid", rid))
					.add(Restrictions.eq("customerAddressId", addressId))
					.add(Restrictions.isNull("deletedDate"))
					.list();
			if(!list.isEmpty()){
				return list.get(0);
			}
		} catch (Exception e){
			LOGGER.error("Error in getActiveCustomerAddressById(int rid) >> rid: "+rid, e);
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public CustomerAddress getActiveCustomerAddressByRid(int rid){
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
			LOGGER.error("Error in getActiveCustomerAddressById(int rid) >> rid: "+rid, e);
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
			LOGGER.error("Error in getCustomerAddressByCustomer(int rid) >> rid: "+rid, e);
		}
		return null;
	}
	
	public boolean deactivateCustomerAddresses(Integer rid , Integer addressId) {
		try{
			Query query = this.sessionFactory.getCurrentSession().createSQLQuery("UPDATE customer_address SET active = 0 WHERE user_id = :userid");
			query.setParameter("userid", rid);
			query.executeUpdate();
			if(addressId != null && addressId > 0) {
				query = this.sessionFactory.getCurrentSession().createSQLQuery("UPDATE customer_address SET active = 1 WHERE customer_address_id = :address_id");
				query.setParameter("address_id", addressId);
				query.executeUpdate();
			}
			return true;
		} catch (Exception e) {
			LOGGER.error("Error in deactivateCustomerAddresses(Integer rid , Integer addressId) >> rid: "+rid, e);
		}
		return false;
	}
	
}
