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
@Table(name="customer_address")
public class CustomerAddress
{
	@Id
	@Column(name = "customer_address_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int customerAddressId;
	
	@Column(name = "landmark")
	private String landmark;
	
	@Column(name = "customer_street", nullable=false)
	private String customerStreet;
	
	@Column(name = "customer_cCity", nullable=false)
	private String customerCity;
	
	@Column(name = "customer_pincode", nullable=false)
	private int customerPinCode;
	
	@Column(name = "customer_phone", nullable=false)
	private String customerPhone;
	
	@Column(name = "create_date", nullable=false)
	private Date createDate;
	
	@Column(name = "modify_date")
	private Date modifyDate;
	
	@Column(name = "deleted_date")
	private Date deletedDate;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="user_id", referencedColumnName="rid")
	private Registration registration;

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

	public String getCustomerStreet()
	{
		return customerStreet;
	}

	public void setCustomerStreet(String customerStreet)
	{
		this.customerStreet = customerStreet;
	}

	public String getCustomerCity()
	{
		return customerCity;
	}

	public void setCustomerCity(String customerCity)
	{
		this.customerCity = customerCity;
	}

	public int getCustomerPinCode()
	{
		return customerPinCode;
	}

	public void setCustomerPinCode(int customerPinCode)
	{
		this.customerPinCode = customerPinCode;
	}

	public String getCustomerPhone()
	{
		return customerPhone;
	}

	public void setCustomerPhone(String customerPhone)
	{
		this.customerPhone = customerPhone;
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

	public Registration getRegistration()
	{
		return registration;
	}

	public void setRegistration(Registration registration)
	{
		this.registration = registration;
	}

	
	
}
