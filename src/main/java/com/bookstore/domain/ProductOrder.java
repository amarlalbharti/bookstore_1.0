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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="productorder")
public class ProductOrder
{
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int productOrderId;
	
	@Column(nullable=false)
	private Double finalPrice;
	
	@Column(nullable=false)
	private int totalItems;
	
	@Column(nullable=false)
	private Date createDate;
	
	@Column
	private Date modifyDate;
	
	@Column
	private Date cancelDate;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="customerId", referencedColumnName="customerId")
	private Customer customer;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="customerAddressId", referencedColumnName="customerAddressId")
	private CustomerAddress customerAddress;
	
	@OneToMany(mappedBy="productOrder", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	private Set<OrderItem> orderItems = new HashSet();

	public int getProductOrderId()
	{
		return productOrderId;
	}

	public void setProductOrderId(int productOrderId)
	{
		this.productOrderId = productOrderId;
	}

	public Double getFinalPrice()
	{
		return finalPrice;
	}

	public void setFinalPrice(Double finalPrice)
	{
		this.finalPrice = finalPrice;
	}

	public int getTotalItems()
	{
		return totalItems;
	}

	public void setTotalItems(int totalItems)
	{
		this.totalItems = totalItems;
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

	public Date getCancelDate()
	{
		return cancelDate;
	}

	public void setCancelDate(Date cancelDate)
	{
		this.cancelDate = cancelDate;
	}

	public Customer getCustomer()
	{
		return customer;
	}

	public void setCustomer(Customer customer)
	{
		this.customer = customer;
	}

	public CustomerAddress getCustomerAddress()
	{
		return customerAddress;
	}

	public void setCustomerAddress(CustomerAddress customerAddress)
	{
		this.customerAddress = customerAddress;
	}

	public Set<OrderItem> getOrderItems()
	{
		return orderItems;
	}

	public void setOrderItems(Set<OrderItem> orderItems)
	{
		this.orderItems = orderItems;
	}
	
	
	
}
