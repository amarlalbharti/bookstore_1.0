package com.bookstore.dao;

import java.util.List;

import com.bookstore.domain.Customer;

public interface CustomerDao
{
	public List<Customer> getAllCustomers();
	
	public Customer getCustomerById(Integer customerId);

}
