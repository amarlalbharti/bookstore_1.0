package com.bookstore.service;

import java.util.List;

import com.bookstore.domain.CustomerAddress;

public interface CustomerAddressService
{
	public int addCustomerAddress(CustomerAddress customerAddress);
	
	public boolean updateCustomerAddress(CustomerAddress customerAddress);
	
	public CustomerAddress getCustomerAddressById(int addressId);
	
	public CustomerAddress getActiveCustomerAddressById(int rid);
	
	public List<CustomerAddress> getCustomerAddressByCustomer(int rid);
}
