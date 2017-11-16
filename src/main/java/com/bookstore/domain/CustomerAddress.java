package com.bookstore.domain;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="customeraddress")
public class CustomerAddress
{
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int customerAddressId;
	
	@Column(nullable=false)
	private String landmark;
	
	@Column(nullable=false)
	private String customersStreet;
	
	@Column(nullable=false)
	private String customersCity;
	
	@Column(nullable=false)
	private int customersPinCode;
	
	@Column(nullable=false)
	private String customersPhone;
	
	@Column(nullable=false)
	private Date createDate;
	
	@Column
	private Date modifyDate;
	
	@Column
	private Date deletedDate;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="customerId", referencedColumnName="customerId")
	private Customer customer;

	public int getCustomerAddressId()
	{
		return customerAddressId;
	}

	public void setCustomerAddressId(int customerAddressId)
	{
		this.customerAddressId = customerAddressId;
	}

	public String getLandmark()
	{
		return landmark;
	}

	public void setLandmark(String landmark)
	{
		this.landmark = landmark;
	}

	public String getCustomersStreet()
	{
		return customersStreet;
	}

	public void setCustomersStreet(String customersStreet)
	{
		this.customersStreet = customersStreet;
	}

	public String getCustomersCity()
	{
		return customersCity;
	}

	public void setCustomersCity(String customersCity)
	{
		this.customersCity = customersCity;
	}

	public int getCustomersPinCode()
	{
		return customersPinCode;
	}

	public void setCustomersPinCode(int customersPinCode)
	{
		this.customersPinCode = customersPinCode;
	}

	public String getCustomersPhone()
	{
		return customersPhone;
	}

	public void setCustomersPhone(String customersPhone)
	{
		this.customersPhone = customersPhone;
	}

	public Date getCreateDate()
	{
		return createDate;
	}

	public void setCreateDate(Date createDate)
	{
		this.createDate = createDate;
	}

	public Date getModifyDate()
	{
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate)
	{
		this.modifyDate = modifyDate;
	}

	public Date getDeletedDate()
	{
		return deletedDate;
	}

	public void setDeletedDate(Date deletedDate)
	{
		this.deletedDate = deletedDate;
	}

	public Customer getCustomer()
	{
		return customer;
	}

	public void setCustomer(Customer customer)
	{
		this.customer = customer;
	}
	
	
	
}
