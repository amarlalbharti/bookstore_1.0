package com.bookstore.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="customer")
public class Customer
{
	@Id
	@Column(name="customer_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int customerId;
	
	@Column(name="first_name", nullable=false)
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	@Column(name="gender", nullable=false)
	private String gender;
	
	@Column(name="dob")
	private Date dob;
	
	@Column(name="contact", nullable=false)
	private String contact;
	
	@Column(name="email", nullable=false, unique=true)
	private String email;
	
	@Column(name="password", nullable=false)
	private String password;

	@OneToMany(mappedBy="customer", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	private Set<Basket> baskets = new HashSet();
	
	@OneToMany(mappedBy="customer", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	private Set<CustomerAddress> customerAddresses = new HashSet();
	
	public int getCustomerId()
	{
		return customerId;
	}

	public void setCustomerId(int customerId)
	{
		this.customerId = customerId;
	}

	public String getFirstName()
	{
		return firstName;
	}

	public void setFirstName(String firstName)
	{
		this.firstName = firstName;
	}

	public String getLastName()
	{
		return lastName;
	}

	public void setLastName(String lastName)
	{
		this.lastName = lastName;
	}

	public String getGender()
	{
		return gender;
	}

	public void setGender(String gender)
	{
		this.gender = gender;
	}

	public Date getDob()
	{
		return dob;
	}

	public void setDob(Date dob)
	{
		this.dob = dob;
	}

	public String getContact()
	{
		return contact;
	}

	public void setContact(String contact)
	{
		this.contact = contact;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public Set<Basket> getBaskets()
	{
		return baskets;
	}

	public void setBaskets(Set<Basket> baskets)
	{
		this.baskets = baskets;
	}

	public Set<CustomerAddress> getCustomerAddresses()
	{
		return customerAddresses;
	}

	public void setCustomerAddresses(Set<CustomerAddress> customerAddresses)
	{
		this.customerAddresses = customerAddresses;
	}
	
}
