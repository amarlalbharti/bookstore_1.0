package com.bookstore.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.CustomerDao;
import com.bookstore.domain.Customer;

@Service
@Transactional
public class CustomerServiceImpl implements CustomerService
{
@Autowired private CustomerDao customerDao;

	public List<Customer> getAllCustomers()
	{
		return this.customerDao.getAllCustomers();
	}

	public Customer getCustomerById(Integer customerId)
	{
		return this.customerDao.getCustomerById(customerId);
	}

}
