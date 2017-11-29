package com.bookstore.service;

import java.util.List;

import com.bookstore.domain.Basket;
import com.bookstore.domain.Customer;
import com.bookstore.domain.CustomerAddress;

public interface CustomerService
{
	public List<Customer> getAllCustomers();

	public Customer getCustomerById(Integer customerId);
	
	public List<CustomerAddress> getAddressByCustId(int customerId);
	
	public List<Basket> getBasketByCustId(int customerId);

}
