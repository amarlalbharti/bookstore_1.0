package com.bookstore.service;

import java.util.List;

import com.bookstore.domain.Customer;

public interface CustomerService
{
	public List<Customer> getAllCustomers();

	public Customer getCustomerById(Integer customerId);

}
