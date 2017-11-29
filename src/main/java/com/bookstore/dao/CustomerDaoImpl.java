package com.bookstore.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.Basket;
import com.bookstore.domain.Customer;
import com.bookstore.domain.CustomerAddress;

@Repository
public class CustomerDaoImpl implements CustomerDao
{
@Autowired private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public List<Customer> getAllCustomers()
	{
		try
		{
			return this.sessionFactory.getCurrentSession().createCriteria(Customer.class).
					addOrder(Order.asc("customerId")).list();
		} 
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("Error in all Customers");
		}
		return null;
	}

	public Customer getCustomerById(Integer customerId)
	{
		try
		{
			return (Customer) this.sessionFactory.getCurrentSession().get(Customer.class, customerId);
		
		} catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("Error in Customers Id : "+customerId);
		}	
		return null;	
	}

	@SuppressWarnings("unchecked")
	public List<CustomerAddress> getAddressByCustId(int customerId)
	{
		try
		{
			return this.sessionFactory.getCurrentSession().createCriteria(CustomerAddress.class)
					.add(Restrictions.eq("customer.customerId", customerId)).list();
		} catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("Error in Customer address Id : "+customerId);
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<Basket> getBasketByCustId(int customerId)
	{

		try
		{
			return this.sessionFactory.getCurrentSession().createCriteria(Basket.class)
					.add(Restrictions.eq("customer.customerId", customerId)).list();
		} catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("Error in Basket : "+customerId);
		}
		return null;
	}

}
