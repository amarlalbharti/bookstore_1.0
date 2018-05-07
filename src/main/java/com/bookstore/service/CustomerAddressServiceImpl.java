package com.bookstore.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.CustomerAddressDao;
import com.bookstore.dao.RegistrationDao;
import com.bookstore.domain.CustomerAddress;
import com.bookstore.domain.Registration;

@Service
@Transactional
public class CustomerAddressServiceImpl implements CustomerAddressService
{
	@Autowired
	private CustomerAddressDao customerAddressDao;
	@Autowired
	private RegistrationDao registrationDao;
	
	
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
	
	public CustomerAddress getCustomerAddress(int rid, int addressId) {
		return this.customerAddressDao.getCustomerAddress(rid, addressId);
	}
	
	public CustomerAddress getCustomerAddress(String userid, int addressId) {
		Registration reg = registrationDao.getRegistrationByUserid(userid);
		if(reg != null ) {
			return getCustomerAddress(reg.getRid(), addressId);
		}
		return null;
	}

	public CustomerAddress getActiveCustomerAddressByRid(int rid)
	{
		return this.customerAddressDao.getActiveCustomerAddressByRid(rid);
	}

	public List<CustomerAddress> getCustomerAddressByCustomer(int rid)
	{
		return this.customerAddressDao.getCustomerAddressByCustomer(rid);
	}
	
	public boolean deactivateCustomerAddresses(Integer rid , Integer addressId) {
		return this.customerAddressDao.deactivateCustomerAddresses(rid, addressId);
	}
	
}
