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
@Table(name="product_order")
public class ProductOrder
{
	@Id
	@Column(name = "product_order_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int productOrderId;
	
	@Column(name = "final_price", nullable=false)
	private Double finalPrice;
	
	@Column(name = "total_items", nullable=false)
	private int totalItems;
	
	@Column(name = "create_date", nullable=false)
	private Date createDate;
	
	@Column(name = "modify_date")
	private Date modifyDate;
	
	@Column(name = "cancel_date")
	private Date cancelDate;
	
	@Column(name = "shipping_address")
	private String shippingAddress;
	
	@Column(name = "customer_phone", nullable=false)
	private String customerPhone;
	
	@ManyToOne
	@JoinColumn(name="user_id", referencedColumnName="rid")
	private Registration registration;
	
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
	
	public String getShippingAddress()
	{
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress)
	{
		this.shippingAddress = shippingAddress;
	}
	
	public String getCustomerPhone()
	{
		return customerPhone;
	}

	public void setCustomerPhone(String customerPhone)
	{
		this.customerPhone = customerPhone;
	}

	public Registration getRegistration()
	{
		return registration;
	}

	public void setRegistration(Registration registration)
	{
		this.registration = registration;
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
