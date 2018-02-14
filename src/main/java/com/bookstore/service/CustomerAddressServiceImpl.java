package com.bookstore.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.CustomerAddressDao;
import com.bookstore.domain.CustomerAddress;

@Service
@Transactional
public class CustomerAddressServiceImpl implements CustomerAddressService
{
	@Autowired
	private CustomerAddressDao customerAddressDao;
	public int addCustomerAddress(CustomerAddress customerAddress)
	{
		return this.customerAddressDao.addCustomerAddress(customerAddress);
	}

	public boolean updateCustomerAddress(CustomerAddress customerAddress)
	{
		return this.customerAddressDao.updateCustomerAddress(customerAddress);
	}

	public CustomerAddress getCustomerAddressById(int rid)
	{
		return this.customerAddressDao.getCustomerAddressById(rid);
	}

	public CustomerAddress getActiveCustomerAddressById(int rid)
	{
		return this.customerAddressDao.getActiveCustomerAddressById(rid);
	}

	public List<CustomerAddress> getCustomerAddressByCustomer(int rid)
	{
		return this.customerAddressDao.getCustomerAddressByCustomer(rid);
	}
	
}
