package com.bookstore.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.Customer;

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

}
